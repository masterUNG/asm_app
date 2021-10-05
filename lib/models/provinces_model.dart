import 'dart:convert';

class ProvinceModel {
  String id;
  String code;
  String name_thai;

  ProvinceModel({
    required this.id,
    required this.code,
    required this.name_thai,
  });

  ProvinceModel copyWith({
    String? id,
    String? code,
    String? name_thai,
  }) {
    return ProvinceModel(
      id: id ?? this.id,
      code: code ?? this.code,
      name_thai: name_thai ?? this.name_thai,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'name_thai': name_thai,
    };
  }

  factory ProvinceModel.fromMap(Map<String, dynamic> map) {
    return ProvinceModel(
      id: map['id'] == null ? '' : map['id'],
      code: map['code'] == null ? '' : map['code'],
      name_thai: map['name_thai'] == null ? '' : map['name_thai'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProvinceModel.fromJson(String source) =>
      ProvinceModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ProvinceModel(id: $id, code: $code, name_thai: $name_thai)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProvinceModel &&
        other.id == id &&
        other.code == code &&
        other.name_thai == name_thai;
  }

  @override
  int get hashCode => id.hashCode ^ code.hashCode ^ name_thai.hashCode;
}
