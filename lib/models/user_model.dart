class User {
  final String uid;
  final String name;
  final int age;
  final String userType;
  final String? profilePic;
  User({required this.uid, required this.name, required this.age, required this.userType, this.profilePic});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      name: json['name'],
      age: json['age'],
      userType: json['userType'],
      profilePic: json['profilePic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'age': age,
      'userType': userType,
      'profilePic': profilePic,
    };
  }
}