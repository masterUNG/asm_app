import 'dart:convert';

class CongenitalModel {
  String congenitalId;
  String congenitalName;
  CongenitalModel({
    required this.congenitalId,
    required this.congenitalName,
  });

  CongenitalModel copyWith({
    String? congenitalId,
    String? congenitalName,
  }) {
    return CongenitalModel(
      congenitalId: congenitalId ?? this.congenitalId,
      congenitalName: congenitalName ?? this.congenitalName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'congenitalId': congenitalId,
      'congenitalName': congenitalName,
    };
  }

  factory CongenitalModel.fromMap(Map<String, dynamic> map) {
    return CongenitalModel(
      congenitalId: map['congenitalId'],
      congenitalName: map['congenitalName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CongenitalModel.fromJson(String source) =>
      CongenitalModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'CongenitalModel(congenitalId: $congenitalId, congenitalName: $congenitalName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CongenitalModel &&
        other.congenitalId == congenitalId &&
        other.congenitalName == congenitalName;
  }

  @override
  int get hashCode => congenitalId.hashCode ^ congenitalName.hashCode;
}
