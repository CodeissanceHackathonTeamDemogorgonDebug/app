import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'authentication_state.dart';

final firebaseAuthProvider =
Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

// register others providers

final firebaseFirestoreProvider =
Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final firebaseStorageProvider =
Provider<FirebaseStorage>((ref) => FirebaseStorage.instance);

final authDataSourceProvider = Provider<AuthClass>(
      (ref) => AuthClass(ref, ref.read(firebaseAuthProvider)),
);

class AuthClass {
  final Ref _ref;
  final FirebaseAuth _firebaseAuth;
  AuthClass(this._ref, this._firebaseAuth);

  Future<Either<String, User>> continueWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final response = await _firebaseAuth.signInWithCredential(credential);
        final user = response.user;

        if (user != null) {
          // Check if the user document exists
          final firestore = _ref.read(firebaseFirestoreProvider);
          final userDoc = await firestore.collection('Users').doc(user.uid).get();

          if (!userDoc.exists) {
            // Create a new document for the user
            await firestore.collection('Patients').doc(user.uid).set({
              'uid': user.uid,
              'name': user.displayName,
              'email': user.email,
              'createdAt': FieldValue.serverTimestamp(),
              'profilePic': user.photoURL,
            });
          }

          return right(user);
        } else {
          return left('Unknown Error');
        }
      } else {
        return left('Unknown Error');
      }
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Unknown Error');
    }
  }

  //logout
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}


class AuthNotifier extends StateNotifier<AuthenticationState> {
  AuthNotifier(this._firebaseAuth, this._dataSource) : super(const AuthenticationState.initial()) {
    _firebaseAuth.authStateChanges().listen((user) {
      if (user != null) {
        state = AuthenticationState.authenticated(user: user);
      } else {
        state = const AuthenticationState.unauthenticated();
      }
    });
  }

  final AuthClass _dataSource;
  final FirebaseAuth _firebaseAuth;
  Future<void> continueWithGoogle() async {
    state = const AuthenticationState.loading();
    final response = await _dataSource.continueWithGoogle();
    state = response.fold(
          (error) {
            print(error.toString());
            return AuthenticationState.unauthenticated(message: error);
          },
          (response) {
            print(response.toString());
            return AuthenticationState.authenticated(user: response);
          },
    );
  }

  //logout
  Future<void> signOut() async {
    await _dataSource.signOut();
    state = const AuthenticationState.unauthenticated();
  }
}

final authNotifierProvider =
StateNotifierProvider<AuthNotifier, AuthenticationState>(
      (ref) => AuthNotifier(
    ref.read(firebaseAuthProvider),
    ref.read(authDataSourceProvider),
  ),
);