import 'dart:convert';

class TypePatientModel {
  String typepatientId;
  String typeName;
  TypePatientModel({
    required this.typepatientId,
    required this.typeName,
  });

  TypePatientModel copyWith({
    String? typepatientId,
    String? typeName,
  }) {
    return TypePatientModel(
      typepatientId: typepatientId ?? this.typepatientId,
      typeName: typeName ?? this.typeName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'typepatientId': typepatientId,
      'typeName': typeName,
    };
  }

  factory TypePatientModel.fromMap(Map<String, dynamic> map) {
    return TypePatientModel(
      typepatientId: map['typepatientId'],
      typeName: map['typeName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TypePatientModel.fromJson(String source) => TypePatientModel.fromMap(json.decode(source));

  @override
  String toString() => 'TypePatientModel(typepatientId: $typepatientId, typeName: $typeName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TypePatientModel &&
      other.typepatientId == typepatientId &&
      other.typeName == typeName;
  }

  @override
  int get hashCode => typepatientId.hashCode ^ typeName.hashCode;
}
