import 'dart:convert';

class DistricsModel {
  String id;
  String code;
  String name_thai;
  String province_id;
  DistricsModel({
    required this.id,
    required this.code,
    required this.name_thai,
    required this.province_id,
  });

  DistricsModel copyWith({
    String? id,
    String? code,
    String? name_thai,
    String? province_id,
  }) {
    return DistricsModel(
      id: id ?? this.id,
      code: code ?? this.code,
      name_thai: name_thai ?? this.name_thai,
      province_id: province_id ?? this.province_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'name_thai': name_thai,
      'province_id': province_id,
    };
  }

  factory DistricsModel.fromMap(Map<String, dynamic> map) {
    return DistricsModel(
      id: map['id'] == null ? '' : map['id'],
      code: map['code'] == null ? '' : map['code'],
      name_thai: map['name_thai'] == null ? '' : map['name_thai'],
      province_id: map['province_id'] == null ? '' : map['province_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DistricsModel.fromJson(String source) =>
      DistricsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProvinceModel(id: $id, code: $code, name_thai: $name_thai, province_id: $province_id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DistricsModel &&
        other.id == id &&
        other.code == code &&
        other.name_thai == name_thai &&
        other.province_id == province_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        code.hashCode ^
        name_thai.hashCode ^
        province_id.hashCode;
  }
}
