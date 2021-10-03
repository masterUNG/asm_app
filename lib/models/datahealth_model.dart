import 'dart:convert';

class DataHealth {
  String reportHealthId;
  String staffId;
  String patientId;
  String pressure;
  String bloodsugar;
  String details;
  String note;
  String imgReportHealth;
  String status;
  String dateTime;
  DataHealth({
    required this.reportHealthId,
    required this.staffId,
    required this.patientId,
    required this.pressure,
    required this.bloodsugar,
    required this.details,
    required this.note,
    required this.imgReportHealth,
    required this.status,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'reportHealthId': reportHealthId,
      'staffId': staffId,
      'patientId': patientId,
      'pressure': pressure,
      'bloodsugar': bloodsugar,
      'details': details,
      'note': note,
      'imgReportHealth': imgReportHealth,
      'status': status,
      'dateTime': dateTime,
    };
  }

  factory DataHealth.fromMap(Map<String, dynamic> map) {
    return DataHealth(
      reportHealthId: map['reportHealthId'],
      staffId: map['staffId'],
      patientId: map['patientId'],
      pressure: map['pressure'],
      bloodsugar: map['bloodsugar'],
      details: map['details'],
      note: map['note'],
      imgReportHealth: map['imgReportHealth'],
      status: map['status'],
      dateTime: map['dateTime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DataHealth.fromJson(String source) => DataHealth.fromMap(json.decode(source));

  DataHealth copyWith({
    String? reportHealthId,
    String? staffId,
    String? patientId,
    String? pressure,
    String? bloodsugar,
    String? details,
    String? note,
    String? imgReportHealth,
    String? status,
    String? dateTime,
  }) {
    return DataHealth(
      reportHealthId: reportHealthId ?? this.reportHealthId,
      staffId: staffId ?? this.staffId,
      patientId: patientId ?? this.patientId,
      pressure: pressure ?? this.pressure,
      bloodsugar: bloodsugar ?? this.bloodsugar,
      details: details ?? this.details,
      note: note ?? this.note,
      imgReportHealth: imgReportHealth ?? this.imgReportHealth,
      status: status ?? this.status,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  @override
  String toString() {
    return 'DataHealth(reportHealthId: $reportHealthId, staffId: $staffId, patientId: $patientId, pressure: $pressure, bloodsugar: $bloodsugar, details: $details, note: $note, imgReportHealth: $imgReportHealth, status: $status, dateTime: $dateTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is DataHealth &&
      other.reportHealthId == reportHealthId &&
      other.staffId == staffId &&
      other.patientId == patientId &&
      other.pressure == pressure &&
      other.bloodsugar == bloodsugar &&
      other.details == details &&
      other.note == note &&
      other.imgReportHealth == imgReportHealth &&
      other.status == status &&
      other.dateTime == dateTime;
  }

  @override
  int get hashCode {
    return reportHealthId.hashCode ^
      staffId.hashCode ^
      patientId.hashCode ^
      pressure.hashCode ^
      bloodsugar.hashCode ^
      details.hashCode ^
      note.hashCode ^
      imgReportHealth.hashCode ^
      status.hashCode ^
      dateTime.hashCode;
  }
}
