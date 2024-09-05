import 'package:flutter/material.dart';
enum ReportType {
  bmi('bmi'),
  weight('weight'),
  height('height');

  final String displayName;

  const ReportType(this.displayName);
}

class ReportsQueryModel {
  final ReportType reportType;
  final bool isYearly;
  final List<String>? userIds;

    ReportsQueryModel({
    required this.reportType,
    required this.isYearly,
    this.userIds
  });


  Map<String, dynamic> toJson() {
    return {
      'type': reportType.displayName,
      'isYearly': isYearly.toString(),
      'beneficiariesIds': userIds?.join(','),
    };
  }
  ReportsQueryModel copyWith({
    ReportType? reportType,
    bool? isYearly,
    ValueGetter<List<String>?>? userIds    
  }) {
    return ReportsQueryModel(
          reportType: reportType ?? this.reportType,
      isYearly: isYearly ?? this.isYearly,
      userIds: userIds != null ? userIds() : this.userIds
    );
  }

  factory ReportsQueryModel.initial() {
    return ReportsQueryModel(
      reportType: ReportType.bmi,
      isYearly: false,
      userIds: null
    );
  }
}
