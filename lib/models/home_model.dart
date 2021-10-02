import 'dart:convert';

class HomeModel {
  final String homeId;
  final String staffId;
  final String hostNameTitle;
  final String hostFname;
  final String hostLname;
  final String houseNo;
  final String villageNo;
  final String village;
  final String subDistrictId;
  final String districtId;
  final String provinceId;
  final String quantity;
  final String area;
  final String dateTime;


  HomeModel({
    required this.homeId,
    required this.staffId,
    required this.hostNameTitle,
    required this.hostFname,
    required this.hostLname,
    required this.houseNo,
    required this.villageNo,
    required this.village,
    required this.subDistrictId,
    required this.districtId,
    required this.provinceId,
    required this.quantity,
    required this.area,
    required this.dateTime,
  });

  HomeModel copyWith({
    String? homeId,
    String? staffId,
    String? hostNameTitle,
    String? hostFname,
    String? hostLname,
    String? houseNo,
    String? villageNo,
    String? village,
    String? subDistrictId,
    String? districtId,
    String? provinceId,
    String? quantity,
    String? area,
    String? dateTime,
  }) {
    return HomeModel(
      homeId: homeId ?? this.homeId,
      staffId: staffId ?? this.staffId,
      hostNameTitle: hostNameTitle ?? this.hostNameTitle,
      hostFname: hostFname ?? this.hostFname,
      hostLname: hostLname ?? this.hostLname,
      houseNo: houseNo ?? this.houseNo,
      villageNo: villageNo ?? this.villageNo,
      village: village ?? this.village,
      subDistrictId: subDistrictId ?? this.subDistrictId,
      districtId: districtId ?? this.districtId,
      provinceId: provinceId ?? this.provinceId,
      quantity: quantity ?? this.quantity,
      area: area ?? this.area,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'homeId': homeId,
      'staffId': staffId,
      'hostNameTitle': hostNameTitle,
      'hostFname': hostFname,
      'hostLname': hostLname,
      'houseNo': houseNo,
      'villageNo': villageNo,
      'village': village,
      'subDistrictId': subDistrictId,
      'districtId': districtId,
      'provinceId': provinceId,
      'quantity': quantity,
      'area': area,
      'dateTime': dateTime,
    };
  }

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      homeId: map['homeId'],
      staffId: map['staffId'],
      hostNameTitle: map['hostNameTitle'],
      hostFname: map['hostFname'],
      hostLname: map['hostLname'],
      houseNo: map['houseNo'],
      villageNo: map['villageNo'],
      village: map['village'],
      subDistrictId: map['subDistrictId'],
      districtId: map['districtId'],
      provinceId: map['provinceId'],
      quantity: map['quantity'],
      area: map['area'],
      dateTime: map['dateTime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeModel.fromJson(String source) =>
      HomeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HomeModel(homeId: $homeId, staffId: $staffId, hostNameTitle: $hostNameTitle, hostFname: $hostFname, hostLname: $hostLname, houseNo: $houseNo, villageNo: $villageNo, village: $village, subDistrictId: $subDistrictId, districtId: $districtId, provinceId: $provinceId, quantity: $quantity, area: $area, dateTime: $dateTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is HomeModel &&
      other.homeId == homeId &&
      other.staffId == staffId &&
      other.hostNameTitle == hostNameTitle &&
      other.hostFname == hostFname &&
      other.hostLname == hostLname &&
      other.houseNo == houseNo &&
      other.villageNo == villageNo &&
      other.village == village &&
      other.subDistrictId == subDistrictId &&
      other.districtId == districtId &&
      other.provinceId == provinceId &&
      other.quantity == quantity &&
      other.area == area &&
      other.dateTime == dateTime;
  }

  @override
  int get hashCode {
    return homeId.hashCode ^
      staffId.hashCode ^
      hostNameTitle.hashCode ^
      hostFname.hashCode ^
      hostLname.hashCode ^
      houseNo.hashCode ^
      villageNo.hashCode ^
      village.hashCode ^
      subDistrictId.hashCode ^
      districtId.hashCode ^
      provinceId.hashCode ^
      quantity.hashCode ^
      area.hashCode ^
      dateTime.hashCode;
  }
}
