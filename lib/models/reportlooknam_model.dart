import 'dart:convert';

class ReportLooknam {
  String reportLooknamId;
  String staffId;
  String homeId;
  String watertotal;
  String waterfound;
  String drinktotal;
  String drinkfound;
  String containerholdertotal;
  String containerholderfound;
  String placemattotal;
  String placematfound;
  String vasetotal;
  String vasefound;
  String tiretotal;
  String tirefound;
  String othercontainertotal;
  String othercontainerfound;
  String total;
  String amount;
  String sum;
  String statusReportLooknam;

  String dateTime;
  ReportLooknam({
    required this.reportLooknamId,
    required this.staffId,
    required this.homeId,
    required this.watertotal,
    required this.waterfound,
    required this.drinktotal,
    required this.drinkfound,
    required this.containerholdertotal,
    required this.containerholderfound,
    required this.placemattotal,
    required this.placematfound,
    required this.vasetotal,
    required this.vasefound,
    required this.tiretotal,
    required this.tirefound,
    required this.othercontainertotal,
    required this.othercontainerfound,
    required this.total,
    required this.amount,
    required this.sum,
    required this.statusReportLooknam,
    required this.dateTime,
  });

  ReportLooknam copyWith({
    String? reportLooknamId,
    String? staffId,
    String? homeId,
    String? watertotal,
    String? waterfound,
    String? drinktotal,
    String? drinkfound,
    String? containerholdertotal,
    String? containerholderfound,
    String? placemattotal,
    String? placematfound,
    String? vasetotal,
    String? vasefound,
    String? tiretotal,
    String? tirefound,
    String? othercontainertotal,
    String? othercontainerfound,
    String? total,
    String? amount,
    String? sum,
    String? statusReportLooknam,
    String? dateTime,
  }) {
    return ReportLooknam(
      reportLooknamId: reportLooknamId ?? this.reportLooknamId,
      staffId: staffId ?? this.staffId,
      homeId: homeId ?? this.homeId,
      watertotal: watertotal ?? this.watertotal,
      waterfound: waterfound ?? this.waterfound,
      drinktotal: drinktotal ?? this.drinktotal,
      drinkfound: drinkfound ?? this.drinkfound,
      containerholdertotal: containerholdertotal ?? this.containerholdertotal,
      containerholderfound: containerholderfound ?? this.containerholderfound,
      placemattotal: placemattotal ?? this.placemattotal,
      placematfound: placematfound ?? this.placematfound,
      vasetotal: vasetotal ?? this.vasetotal,
      vasefound: vasefound ?? this.vasefound,
      tiretotal: tiretotal ?? this.tiretotal,
      tirefound: tirefound ?? this.tirefound,
      othercontainertotal: othercontainertotal ?? this.othercontainertotal,
      othercontainerfound: othercontainerfound ?? this.othercontainerfound,
      total: total ?? this.total,
      amount: amount ?? this.amount,
      sum: sum ?? this.sum,
      statusReportLooknam: statusReportLooknam ?? this.statusReportLooknam,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reportLooknamId': reportLooknamId,
      'staffId': staffId,
      'homeId': homeId,
      'watertotal': watertotal,
      'waterfound': waterfound,
      'drinktotal': drinktotal,
      'drinkfound': drinkfound,
      'containerholdertotal': containerholdertotal,
      'containerholderfound': containerholderfound,
      'placemattotal': placemattotal,
      'placematfound': placematfound,
      'vasetotal': vasetotal,
      'vasefound': vasefound,
      'tiretotal': tiretotal,
      'tirefound': tirefound,
      'othercontainertotal': othercontainertotal,
      'othercontainerfound': othercontainerfound,
      'total': total,
      'amount': amount,
      'sum': sum,
      'statusReportLooknam': statusReportLooknam,
      'dateTime': dateTime,
    };
  }

  factory ReportLooknam.fromMap(Map<String, dynamic> map) {
    return ReportLooknam(
      reportLooknamId: map['reportLooknamId'],
      staffId: map['staffId'],
      homeId: map['homeId'],
      watertotal: map['watertotal'],
      waterfound: map['waterfound'],
      drinktotal: map['drinktotal'],
      drinkfound: map['drinkfound'],
      containerholdertotal: map['containerholdertotal'],
      containerholderfound: map['containerholderfound'],
      placemattotal: map['placemattotal'],
      placematfound: map['placematfound'],
      vasetotal: map['vasetotal'],
      vasefound: map['vasefound'],
      tiretotal: map['tiretotal'],
      tirefound: map['tirefound'],
      othercontainertotal: map['othercontainertotal'],
      othercontainerfound: map['othercontainerfound'],
      total: map['total'],
      amount: map['amount'],
      sum: map['sum'],
      statusReportLooknam: map['statusReportLooknam'],
      dateTime: map['dateTime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportLooknam.fromJson(String source) =>
      ReportLooknam.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReportLooknam(reportLooknamId: $reportLooknamId, staffId: $staffId, homeId: $homeId, watertotal: $watertotal, waterfound: $waterfound, drinktotal: $drinktotal, drinkfound: $drinkfound, containerholdertotal: $containerholdertotal, containerholderfound: $containerholderfound, placemattotal: $placemattotal, placematfound: $placematfound, vasetotal: $vasetotal, vasefound: $vasefound, tiretotal: $tiretotal, tirefound: $tirefound, othercontainertotal: $othercontainertotal, othercontainerfound: $othercontainerfound, total: $total, amount: $amount, sum: $sum, statusReportLooknam: $statusReportLooknam, dateTime: $dateTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ReportLooknam &&
      other.reportLooknamId == reportLooknamId &&
      other.staffId == staffId &&
      other.homeId == homeId &&
      other.watertotal == watertotal &&
      other.waterfound == waterfound &&
      other.drinktotal == drinktotal &&
      other.drinkfound == drinkfound &&
      other.containerholdertotal == containerholdertotal &&
      other.containerholderfound == containerholderfound &&
      other.placemattotal == placemattotal &&
      other.placematfound == placematfound &&
      other.vasetotal == vasetotal &&
      other.vasefound == vasefound &&
      other.tiretotal == tiretotal &&
      other.tirefound == tirefound &&
      other.othercontainertotal == othercontainertotal &&
      other.othercontainerfound == othercontainerfound &&
      other.total == total &&
      other.amount == amount &&
      other.sum == sum &&
      other.statusReportLooknam == statusReportLooknam &&
      other.dateTime == dateTime;
  }

  @override
  int get hashCode {
    return reportLooknamId.hashCode ^
      staffId.hashCode ^
      homeId.hashCode ^
      watertotal.hashCode ^
      waterfound.hashCode ^
      drinktotal.hashCode ^
      drinkfound.hashCode ^
      containerholdertotal.hashCode ^
      containerholderfound.hashCode ^
      placemattotal.hashCode ^
      placematfound.hashCode ^
      vasetotal.hashCode ^
      vasefound.hashCode ^
      tiretotal.hashCode ^
      tirefound.hashCode ^
      othercontainertotal.hashCode ^
      othercontainerfound.hashCode ^
      total.hashCode ^
      amount.hashCode ^
      sum.hashCode ^
      statusReportLooknam.hashCode ^
      dateTime.hashCode;
  }
}
