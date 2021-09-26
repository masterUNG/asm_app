import 'dart:convert';

class PatientModel {
  String patientId;
  String staffId;
  String nameTitle;
  String fname;
  String lname;
  String gender;
  String birthday;
  String weight;
  String height;
  String tell;
  String address;
  String congenital;
  String typepatient;
  String dateTime;
  PatientModel({
    required this.patientId,
    required this.staffId,
    required this.nameTitle,
    required this.fname,
    required this.lname,
    required this.gender,
    required this.birthday,
    required this.weight,
    required this.height,
    required this.tell,
    required this.address,
    required this.congenital,
    required this.typepatient,
    required this.dateTime,
  });

  PatientModel copyWith({
    String? patientId,
    String? staffId,
    String? nameTitle,
    String? fname,
    String? lname,
    String? gender,
    String? birthday,
    String? weight,
    String? height,
    String? tell,
    String? address,
    String? congenital,
    String? typepatient,
    String? dateTime,
  }) {
    return PatientModel(
      patientId: patientId ?? this.patientId,
      staffId: staffId ?? this.staffId,
      nameTitle: nameTitle ?? this.nameTitle,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      tell: tell ?? this.tell,
      address: address ?? this.address,
      congenital: congenital ?? this.congenital,
      typepatient: typepatient ?? this.typepatient,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'patientId': patientId,
      'staffId': staffId,
      'nameTitle': nameTitle,
      'fname': fname,
      'lname': lname,
      'gender': gender,
      'birthday': birthday,
      'weight': weight,
      'height': height,
      'tell': tell,
      'address': address,
      'congenital': congenital,
      'typepatient': typepatient,
      'dateTime': dateTime,
    };
  }

  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      patientId: map['patientId'],
      staffId: map['staffId'],
      nameTitle: map['nameTitle'],
      fname: map['fname'],
      lname: map['lname'],
      gender: map['gender'],
      birthday: map['birthday'],
      weight: map['weight'],
      height: map['height'],
      tell: map['tell'],
      address: map['address'],
      congenital: map['congenital'],
      typepatient: map['typepatient'],
      dateTime: map['dateTime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientModel.fromJson(String source) =>
      PatientModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PatientModel(patientId: $patientId, staffId: $staffId, nameTitle: $nameTitle, fname: $fname, lname: $lname, gender: $gender, birthday: $birthday, weight: $weight, height: $height, tell: $tell, address: $address, congenital: $congenital, typepatient: $typepatient, dateTime: $dateTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PatientModel &&
        other.patientId == patientId &&
        other.staffId == staffId &&
        other.nameTitle == nameTitle &&
        other.fname == fname &&
        other.lname == lname &&
        other.gender == gender &&
        other.birthday == birthday &&
        other.weight == weight &&
        other.height == height &&
        other.tell == tell &&
        other.address == address &&
        other.congenital == congenital &&
        other.typepatient == typepatient &&
        other.dateTime == dateTime;
  }

  @override
  int get hashCode {
    return patientId.hashCode ^
        staffId.hashCode ^
        nameTitle.hashCode ^
        fname.hashCode ^
        lname.hashCode ^
        gender.hashCode ^
        birthday.hashCode ^
        weight.hashCode ^
        height.hashCode ^
        tell.hashCode ^
        address.hashCode ^
        congenital.hashCode ^
        typepatient.hashCode ^
        dateTime.hashCode;
  }
}
