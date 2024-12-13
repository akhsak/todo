class UserModel {
  String? uid;
  String? fullname;
  String? email;
  String? profilepicUrl;
  String? profilepicPath;
  final String? password;

  UserModel({
    this.uid,
    this.fullname,
    this.password,
    this.email,
    this.profilepicUrl,
    this.profilepicPath,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'fullname': fullname,
      'email': email,
      'profilepicUrl': profilepicUrl,
      'profilepicPath': profilepicPath,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      fullname: json['fullname'] ?? '',
      email: json['email'] ?? '',
      profilepicUrl: json['profilepicUrl'] ?? '',
      profilepicPath: json['profilepicPath'] ?? '',
    );
  }
}
