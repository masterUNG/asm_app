import 'dart:convert';

class ReportMonth {
  String reportMonthId;
  String staffId;
  String HealthPromotion1_1;
  String HealthPromotion1_1_1;
  String HealthPromotion1_2;
  String HealthPromotion1_2_1;
  String HealthPromotion1_3;
  String HealthPromotion1_3_1;
  String HealthPromotion1_4;
  String Surveillance2_1;
  String Surveillance2_2;
  String Surveillance2_3;
  String Surveillance2_4;
  String Surveillance2_5;
  String HealthRestoration3_1;
  String ConsumerProtection4_1;
  String CommunityHealth5_1;
  String CommunityHealth5_2;
  String OtherActivities6_1;
  String OtherActivities6_2;
  String statusReportMonth;
  String dateTime;
  ReportMonth({
    required this.reportMonthId,
    required this.staffId,
    required this.HealthPromotion1_1,
    required this.HealthPromotion1_1_1,
    required this.HealthPromotion1_2,
    required this.HealthPromotion1_2_1,
    required this.HealthPromotion1_3,
    required this.HealthPromotion1_3_1,
    required this.HealthPromotion1_4,
    required this.Surveillance2_1,
    required this.Surveillance2_2,
    required this.Surveillance2_3,
    required this.Surveillance2_4,
    required this.Surveillance2_5,
    required this.HealthRestoration3_1,
    required this.ConsumerProtection4_1,
    required this.CommunityHealth5_1,
    required this.CommunityHealth5_2,
    required this.OtherActivities6_1,
    required this.OtherActivities6_2,
    required this.statusReportMonth,
    required this.dateTime,
  });

  ReportMonth copyWith({
    String? reportMonthId,
    String? staffId,
    String? HealthPromotion1_1,
    String? HealthPromotion1_1_1,
    String? HealthPromotion1_2,
    String? HealthPromotion1_2_1,
    String? HealthPromotion1_3,
    String? HealthPromotion1_3_1,
    String? HealthPromotion1_4,
    String? Surveillance2_1,
    String? Surveillance2_2,
    String? Surveillance2_3,
    String? Surveillance2_4,
    String? Surveillance2_5,
    String? HealthRestoration3_1,
    String? ConsumerProtection4_1,
    String? CommunityHealth5_1,
    String? CommunityHealth5_2,
    String? OtherActivities6_1,
    String? OtherActivities6_2,
    String? statusReportMonth,
    String? dateTime,
  }) {
    return ReportMonth(
      reportMonthId: reportMonthId ?? this.reportMonthId,
      staffId: staffId ?? this.staffId,
      HealthPromotion1_1: HealthPromotion1_1 ?? this.HealthPromotion1_1,
      HealthPromotion1_1_1: HealthPromotion1_1_1 ?? this.HealthPromotion1_1_1,
      HealthPromotion1_2: HealthPromotion1_2 ?? this.HealthPromotion1_2,
      HealthPromotion1_2_1: HealthPromotion1_2_1 ?? this.HealthPromotion1_2_1,
      HealthPromotion1_3: HealthPromotion1_3 ?? this.HealthPromotion1_3,
      HealthPromotion1_3_1: HealthPromotion1_3_1 ?? this.HealthPromotion1_3_1,
      HealthPromotion1_4: HealthPromotion1_4 ?? this.HealthPromotion1_4,
      Surveillance2_1: Surveillance2_1 ?? this.Surveillance2_1,
      Surveillance2_2: Surveillance2_2 ?? this.Surveillance2_2,
      Surveillance2_3: Surveillance2_3 ?? this.Surveillance2_3,
      Surveillance2_4: Surveillance2_4 ?? this.Surveillance2_4,
      Surveillance2_5: Surveillance2_5 ?? this.Surveillance2_5,
      HealthRestoration3_1: HealthRestoration3_1 ?? this.HealthRestoration3_1,
      ConsumerProtection4_1: ConsumerProtection4_1 ?? this.ConsumerProtection4_1,
      CommunityHealth5_1: CommunityHealth5_1 ?? this.CommunityHealth5_1,
      CommunityHealth5_2: CommunityHealth5_2 ?? this.CommunityHealth5_2,
      OtherActivities6_1: OtherActivities6_1 ?? this.OtherActivities6_1,
      OtherActivities6_2: OtherActivities6_2 ?? this.OtherActivities6_2,
      statusReportMonth: statusReportMonth ?? this.statusReportMonth,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reportMonthId': reportMonthId,
      'staffId': staffId,
      'HealthPromotion1_1': HealthPromotion1_1,
      'HealthPromotion1_1_1': HealthPromotion1_1_1,
      'HealthPromotion1_2': HealthPromotion1_2,
      'HealthPromotion1_2_1': HealthPromotion1_2_1,
      'HealthPromotion1_3': HealthPromotion1_3,
      'HealthPromotion1_3_1': HealthPromotion1_3_1,
      'HealthPromotion1_4': HealthPromotion1_4,
      'Surveillance2_1': Surveillance2_1,
      'Surveillance2_2': Surveillance2_2,
      'Surveillance2_3': Surveillance2_3,
      'Surveillance2_4': Surveillance2_4,
      'Surveillance2_5': Surveillance2_5,
      'HealthRestoration3_1': HealthRestoration3_1,
      'ConsumerProtection4_1': ConsumerProtection4_1,
      'CommunityHealth5_1': CommunityHealth5_1,
      'CommunityHealth5_2': CommunityHealth5_2,
      'OtherActivities6_1': OtherActivities6_1,
      'OtherActivities6_2': OtherActivities6_2,
      'statusReportMonth': statusReportMonth,
      'dateTime': dateTime,
    };
  }

  factory ReportMonth.fromMap(Map<String, dynamic> map) {
    return ReportMonth(
      reportMonthId: map['reportMonthId'],
      staffId: map['staffId'],
      HealthPromotion1_1: map['HealthPromotion1_1'],
      HealthPromotion1_1_1: map['HealthPromotion1_1_1'],
      HealthPromotion1_2: map['HealthPromotion1_2'],
      HealthPromotion1_2_1: map['HealthPromotion1_2_1'],
      HealthPromotion1_3: map['HealthPromotion1_3'],
      HealthPromotion1_3_1: map['HealthPromotion1_3_1'],
      HealthPromotion1_4: map['HealthPromotion1_4'],
      Surveillance2_1: map['Surveillance2_1'],
      Surveillance2_2: map['Surveillance2_2'],
      Surveillance2_3: map['Surveillance2_3'],
      Surveillance2_4: map['Surveillance2_4'],
      Surveillance2_5: map['Surveillance2_5'],
      HealthRestoration3_1: map['HealthRestoration3_1'],
      ConsumerProtection4_1: map['ConsumerProtection4_1'],
      CommunityHealth5_1: map['CommunityHealth5_1'],
      CommunityHealth5_2: map['CommunityHealth5_2'],
      OtherActivities6_1: map['OtherActivities6_1'],
      OtherActivities6_2: map['OtherActivities6_2'],
      statusReportMonth: map['statusReportMonth'],
      dateTime: map['dateTime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportMonth.fromJson(String source) =>
      ReportMonth.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReportMonth(reportMonthId: $reportMonthId, staffId: $staffId, HealthPromotion1_1: $HealthPromotion1_1, HealthPromotion1_1_1: $HealthPromotion1_1_1, HealthPromotion1_2: $HealthPromotion1_2, HealthPromotion1_2_1: $HealthPromotion1_2_1, HealthPromotion1_3: $HealthPromotion1_3, HealthPromotion1_3_1: $HealthPromotion1_3_1, HealthPromotion1_4: $HealthPromotion1_4, Surveillance2_1: $Surveillance2_1, Surveillance2_2: $Surveillance2_2, Surveillance2_3: $Surveillance2_3, Surveillance2_4: $Surveillance2_4, Surveillance2_5: $Surveillance2_5, HealthRestoration3_1: $HealthRestoration3_1, ConsumerProtection4_1: $ConsumerProtection4_1, CommunityHealth5_1: $CommunityHealth5_1, CommunityHealth5_2: $CommunityHealth5_2, OtherActivities6_1: $OtherActivities6_1, OtherActivities6_2: $OtherActivities6_2, statusReportMonth: $statusReportMonth, dateTime: $dateTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ReportMonth &&
      other.reportMonthId == reportMonthId &&
      other.staffId == staffId &&
      other.HealthPromotion1_1 == HealthPromotion1_1 &&
      other.HealthPromotion1_1_1 == HealthPromotion1_1_1 &&
      other.HealthPromotion1_2 == HealthPromotion1_2 &&
      other.HealthPromotion1_2_1 == HealthPromotion1_2_1 &&
      other.HealthPromotion1_3 == HealthPromotion1_3 &&
      other.HealthPromotion1_3_1 == HealthPromotion1_3_1 &&
      other.HealthPromotion1_4 == HealthPromotion1_4 &&
      other.Surveillance2_1 == Surveillance2_1 &&
      other.Surveillance2_2 == Surveillance2_2 &&
      other.Surveillance2_3 == Surveillance2_3 &&
      other.Surveillance2_4 == Surveillance2_4 &&
      other.Surveillance2_5 == Surveillance2_5 &&
      other.HealthRestoration3_1 == HealthRestoration3_1 &&
      other.ConsumerProtection4_1 == ConsumerProtection4_1 &&
      other.CommunityHealth5_1 == CommunityHealth5_1 &&
      other.CommunityHealth5_2 == CommunityHealth5_2 &&
      other.OtherActivities6_1 == OtherActivities6_1 &&
      other.OtherActivities6_2 == OtherActivities6_2 &&
      other.statusReportMonth == statusReportMonth &&
      other.dateTime == dateTime;
  }

  @override
  int get hashCode {
    return reportMonthId.hashCode ^
      staffId.hashCode ^
      HealthPromotion1_1.hashCode ^
      HealthPromotion1_1_1.hashCode ^
      HealthPromotion1_2.hashCode ^
      HealthPromotion1_2_1.hashCode ^
      HealthPromotion1_3.hashCode ^
      HealthPromotion1_3_1.hashCode ^
      HealthPromotion1_4.hashCode ^
      Surveillance2_1.hashCode ^
      Surveillance2_2.hashCode ^
      Surveillance2_3.hashCode ^
      Surveillance2_4.hashCode ^
      Surveillance2_5.hashCode ^
      HealthRestoration3_1.hashCode ^
      ConsumerProtection4_1.hashCode ^
      CommunityHealth5_1.hashCode ^
      CommunityHealth5_2.hashCode ^
      OtherActivities6_1.hashCode ^
      OtherActivities6_2.hashCode ^
      statusReportMonth.hashCode ^
      dateTime.hashCode;
  }
}
