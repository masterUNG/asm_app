import 'dart:convert';

class SubDistrictsModel {
  String id;
  String code;
  String name_in_thai;
  String district_id;
  String zip_code;
  SubDistrictsModel({
    required this.id,
    required this.code,
    required this.name_in_thai,
    required this.district_id,
    required this.zip_code,
  });

  SubDistrictsModel copyWith({
    String? id,
    String? code,
    String? name_in_thai,
    String? district_id,
    String? zip_code,
  }) {
    return SubDistrictsModel(
      id: id ?? this.id,
      code: code ?? this.code,
      name_in_thai: name_in_thai ?? this.name_in_thai,
      district_id: district_id ?? this.district_id,
      zip_code: zip_code ?? this.zip_code,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'name_in_thai': name_in_thai,
      'district_id': district_id,
      'zip_code': zip_code,
    };
  }

  factory SubDistrictsModel.fromMap(Map<String, dynamic> map) {
    return SubDistrictsModel(
      id: map['id'],
      code: map['code'],
      name_in_thai: map['name_in_thai'],
      district_id: map['district_id'],
      zip_code: map['zip_code'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SubDistrictsModel.fromJson(String source) => SubDistrictsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SubDistrictsModel(id: $id, code: $code, name_in_thai: $name_in_thai, district_id: $district_id, zip_code: $zip_code)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SubDistrictsModel &&
      other.id == id &&
      other.code == code &&
      other.name_in_thai == name_in_thai &&
      other.district_id == district_id &&
      other.zip_code == zip_code;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      code.hashCode ^
      name_in_thai.hashCode ^
      district_id.hashCode ^
      zip_code.hashCode;
  }
}
