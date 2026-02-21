import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ArchiveDocumentItem extends StatefulWidget {
  const ArchiveDocumentItem({
    super.key,
    required this.dateString,
  });

  final String dateString;

  @override
  State<ArchiveDocumentItem> createState() => _ArchiveDocumentItemState();
}

class _ArchiveDocumentItemState extends State<ArchiveDocumentItem> {
  String _size = "-";

  // void _getSize() async {
  //   try {
  //     final response = await http.head(Uri.parse(widget.dokumen.attachmentUrl));

  //     if (response.statusCode == 200) {
  //       final contentLength = response.headers['content-length'];
  //       if (contentLength != null) {
  //         final bytes = int.parse(contentLength);
  //         final sizeString = (bytes / (1024 * 1024)).toStringAsFixed(0);
  //         setState(() => _size = sizeString);
  //       }
  //     }
  //   } catch (e, stacktrace) {
  //     log(e.toString(), stackTrace: stacktrace);
  //   }
  // }

  // void _unduh() async {
  //   final uri = Uri.parse(widget.dokumen.attachmentUrl);
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri, mode: LaunchMode.externalApplication);
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _getSize();
  // }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset("assets/images/svg/arsip/pdf.svg"),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Budi Pratama",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Text(
                "$_size MB . Diunggah ${widget.dateString}",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            // final uri = Uri.parse(widget.dokumen.attachmentUrl);
            // await launchUrl(uri, mode: LaunchMode.externalApplication);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade700,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(6),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 18,
            ),
            minimumSize: Size(0, 0),
          ),
          child: Text(
            "Unduh",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
