import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:communitary_service_app/config/services/contracts/download_charts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class DownloadChartsServiceImpl implements DownloadChartsService {
  @override
  Future<void> downloadChartsPdf(
    DownloadChartModel downloadChartModel,
  ) async {
    final chartKey = downloadChartModel.chartKey;

    final pdf = pw.Document();

    final chartImage = await _captureChart(
      chartKey,
    );
    if (chartImage == null) return;

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Header(
                level: 0,
                child: pw.Text(downloadChartModel.reportTitle),
              ),
              pw.Paragraph(
                text: downloadChartModel.reportDescription,
              ),
              pw.Paragraph(
                text: downloadChartModel.reportDate,
              ),
              pw.Center(
                child: pw.Image(pw.MemoryImage(chartImage)),
              )
            ],
          );
        },
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final filePath =
        '${directory.path}/${downloadChartModel.reportDate}-${downloadChartModel.reportTitle}.pdf';
    final file = File(filePath);

    // Save the PDF
    await file.writeAsBytes(await pdf.save());

    await OpenFilex.open(filePath);
  }

  Future<Uint8List?> _captureChart(
      GlobalKey<State<StatefulWidget>> chartKey) async {
    RenderRepaintBoundary? boundary =
        chartKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    if (boundary == null) return null;

    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }
}
