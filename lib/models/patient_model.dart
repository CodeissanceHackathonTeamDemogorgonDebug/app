class Patient {
  final String uid;
  final String name;
  final int age;
  final String userType;
  final String gender;
  final String? profilePic;
  final int phoneNumber;
  final String email;
  final String? bloodGroup;
  final List<String?>? allergies;
  final List<String?>? medications;
  final String? emergencyContact;
  final bool isSmoker;
  final double height;
  final double weight;
  final String? fcmToken;


  Patient({required this.uid, required this.name, required this.age, required this.userType, this.profilePic, required this.gender
  , required this.phoneNumber, required this.email, this.bloodGroup, this.allergies, this.medications, this.emergencyContact, required this.isSmoker, required this.height, required this.weight
  , this.fcmToken});

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      uid: json['uid'],
      name: json['name'],
      age: json['age'],
      userType: json['userType'],
      profilePic: json['profilePic'],
      gender: json['gender'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      bloodGroup: json['bloodGroup'],
      allergies: json['allergies'],
      medications: json['medications'],
      emergencyContact: json['emergencyContact'],
      isSmoker: json['isSmoker'],
      height: json['height'],
      weight: json['weight'],
      fcmToken: json['fcmToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'age': age,
      'userType': userType,
      'profilePic': profilePic,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'email': email,
      'bloodGroup': bloodGroup,
      'allergies': allergies,
      'medications': medications,
      'emergencyContact': emergencyContact,
      'isSmoker': isSmoker,
      'height': height,
      'weight': weight,
      'fcmToken': fcmToken,
    };
  }
}