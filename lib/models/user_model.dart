import 'dart:convert';

class UserModel {
  String userId;
  String nameTitles;
  String firstname;
  String lastname;
  String usertell;
  String usernames;
  String passwords;
  String address;
  String imageUser;
  String type;
  UserModel({
    required this.userId,
    required this.nameTitles,
    required this.firstname,
    required this.lastname,
    required this.usertell,
    required this.usernames,
    required this.passwords,
    required this.address,
    required this.imageUser,
    required this.type,
  });

  UserModel copyWith({
    String? userId,
    String? nameTitles,
    String? firstname,
    String? lastname,
    String? usertell,
    String? usernames,
    String? passwords,
    String? address,
    String? imageUser,
    String? type,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      nameTitles: nameTitles ?? this.nameTitles,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      usertell: usertell ?? this.usertell,
      usernames: usernames ?? this.usernames,
      passwords: passwords ?? this.passwords,
      address: address ?? this.address,
      imageUser: imageUser ?? this.imageUser,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'nameTitles': nameTitles,
      'firstname': firstname,
      'lastname': lastname,
      'usertell': usertell,
      'usernames': usernames,
      'passwords': passwords,
      'address': address,
      'imageUser': imageUser,
      'type': type,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'],
      nameTitles: map['nameTitles'],
      firstname: map['firstname'],
      lastname: map['lastname'],
      usertell: map['usertell'],
      usernames: map['usernames'],
      passwords: map['passwords'],
      address: map['address'],
      imageUser: map['imageUser'],
      type: map['type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(userId: $userId, nameTitles: $nameTitles, firstname: $firstname, lastname: $lastname, usertell: $usertell, usernames: $usernames, passwords: $passwords, address: $address, imageUser: $imageUser, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.userId == userId &&
      other.nameTitles == nameTitles &&
      other.firstname == firstname &&
      other.lastname == lastname &&
      other.usertell == usertell &&
      other.usernames == usernames &&
      other.passwords == passwords &&
      other.address == address &&
      other.imageUser == imageUser &&
      other.type == type;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
      nameTitles.hashCode ^
      firstname.hashCode ^
      lastname.hashCode ^
      usertell.hashCode ^
      usernames.hashCode ^
      passwords.hashCode ^
      address.hashCode ^
      imageUser.hashCode ^
      type.hashCode;
  }
}
