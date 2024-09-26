import 'package:flutter/material.dart';

abstract class DownloadChartsService {
  Future<void> downloadChartsPdf(
    DownloadChartModel downloadChartModel,
  );
}

class DownloadChartModel {
  final GlobalKey chartKey;
  final String reportTitle;
  final String reportDescription;
  final String reportDate;

  const DownloadChartModel({
    required this.chartKey,
    required this.reportTitle,
    required this.reportDescription,
    required this.reportDate,
  });
}
