import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui' as ui;

class InfoBookingRoom extends StatefulWidget {
  const InfoBookingRoom({super.key});

  @override
  State<InfoBookingRoom> createState() => _InfoBookingRoomState();
}

class _InfoBookingRoomState extends State<InfoBookingRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TicketCard(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await _createPdf(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Ticket downloaded successfully!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 20.0),
                  child: Text('Download Ticket'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _createPdf(BuildContext context) async {
    final pdf = pw.Document();
    final qrCodeImage = await _generateQrCode('Your QR Data Here');

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Royale President Hotel',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 10),
            pw.Image(pw.MemoryImage(qrCodeImage)),
            pw.Divider(),
            buildPdfInfoRow('Name', 'Daniel Austin'),
            buildPdfInfoRow('Phone Number', '+1 111 467 378 399'),
            buildPdfInfoRow('Check in Date', 'Dec 16, 2024'),
            buildPdfInfoRow('Check out Date', 'Dec 20, 2024'),
            buildPdfInfoRow('Check in Time', '12:30 pm'),
            buildPdfInfoRow('Check out Time', '6:00 pm'),
            buildPdfInfoRow('Hotel', 'Royale President'),
            buildPdfInfoRow('Adult', '3'),
            buildPdfInfoRow('Children', '3'),
          ],
        ),
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/ticket.pdf");
    await file.writeAsBytes(await pdf.save());

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  Future<Uint8List> _generateQrCode(String data) async {
    final qrImage = await QrPainter(
      data: data,
      version: QrVersions.auto,
      gapless: false,
    ).toImage(200);
    
    final byteData = await qrImage.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  pw.Row buildPdfInfoRow(String label, String value) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text('$label:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Text(value),
      ],
    );
  }
}

class TicketCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Royale President Hotel',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            QrImageView(
              data: 'Your QR Data Here',
              version: QrVersions.auto,
              size: 200,
              gapless: false,
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildInfoColumn('Name', 'Daniel Austin'),
                  buildInfoColumn('Phone Number', '+1 111 467 378 399'),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildInfoColumn('Check in Date', 'Dec 16, 2024'),
                buildInfoColumn('Check out Date', 'Dec 20, 2024'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildInfoColumn('Check in Time', '12:30 pm'),
                buildInfoColumn('Check out Time', '6:00 pm'),
              ],
            ),
            buildInfoColumn('Hotel', 'Royale President'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildInfoColumn('Adult', '3'),
                buildInfoColumn('Children', '3'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column buildInfoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
