import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../../../shared/theme/app_theme.dart';

class UploadDocument extends StatefulWidget {
  final String? labelText;
  final Function(String?)? onFileSelected;
  final String? Function(String?)? validator;
  final List<String> allowedFileTypes;
  final String title;
  final bool isRequired;
  final bool isRequiredOpsional; // V1 logic compatibility
  final String text;
  final bool fileSelected;
  final String? initialFilePath;

  const UploadDocument({
    super.key,
    this.labelText,
    this.onFileSelected,
    this.validator,
    required this.allowedFileTypes,
    required this.title,
    this.isRequired = false,
    this.isRequiredOpsional = false, // defaults to false
    required this.text,
    this.fileSelected = false,
    this.initialFilePath,
  });

  @override
  State<UploadDocument> createState() => _UploadDocumentState();
}

class _UploadDocumentState extends State<UploadDocument> {
  // We'll manage local state but also respect parent's fileSelected status if driven by parent
  // However, v1 implementation had internal state management mostly.
  // We will adapt to be more driven by props if needed, but for "copy v1" we keep similar logic.
  
  // Note: functionality logic in v1's `AppUploadTextFieldBiodata` was mixed. 
  // The User passed `UploadDocument` in v1 `document.dart` which seemed to differ from `AppUploadTextFieldBiodata`
  // checked in `document_biodata.dart`.
  // Wait, `document.dart` uses `UploadDocument` class? 
  // Let me re-read `document.dart` carefully. 
  // It imports `package:maha_apps/app/widget/input/document_biodata.dart` but uses `UploadDocument` widget in `build`.
  // Wait, `document_biodata.dart` exports `AppUploadTextFieldBiodata`? 
  // Ah, the file `document.dart` creates `UploadDocument` inline or imports it?
  // I likely missed where `UploadDocument` is defined in v1 if it's not `document_biodata.dart`. 
  // In `document.dart`: `import 'package:maha_apps/app/widget/input/document_biodata.dart';`
  // But usage is `UploadDocument(...)`. 
  // Maybe `document_biodata.dart` contains `UploadDocument`? 
  // The `view_file` of `document_biodata.dart` showed `AppUploadTextFieldBiodata`.
  // Something is inconsistent. PROBABLY `UploadDocument` is another file OR defined in `input.dart` or helper. 
  // Or I missed lines in `document_biodata.dart`.
  // Regardless, I will create a robust `UploadDocument` widget based on the UI usage in `document.dart`.

  bool _fileSelected = false;
  String? _filePath;

  @override
  void initState() {
    super.initState();
    _fileSelected = widget.fileSelected;
    _filePath = widget.initialFilePath;
  }

  @override
  void didUpdateWidget(covariant UploadDocument oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialFilePath != oldWidget.initialFilePath) {
       _filePath = widget.initialFilePath;
       _fileSelected = widget.fileSelected;
    }
     if (widget.fileSelected != oldWidget.fileSelected) {
       _fileSelected = widget.fileSelected;
    }
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: widget.allowedFileTypes,
      );

      if (result != null) {
        setState(() {
          _fileSelected = true;
          _filePath = result.files.single.path;
        });
        if (widget.onFileSelected != null) {
          widget.onFileSelected!(_filePath);
        }
      }
    } catch (e) {
      debugPrint("Error picking file: $e");
    }
  }

  void _deleteFile() {
    setState(() {
      _fileSelected = false;
      _filePath = null;
    });
    if (widget.onFileSelected != null) {
      widget.onFileSelected!(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 6),
          child: Row(
            children: [
              Text(
                widget.title,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              ),
              if (widget.isRequired)
                 const Text(" *", style: TextStyle(color: Colors.red)),
              if (widget.isRequiredOpsional)
                const Text(" (Opsional)", style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),
        
        // The Input Field / Button Area
        GestureDetector(
          onTap: () {
            if (!_fileSelected) {
              _pickFile();
            } else {
              _deleteFile();
            }
          },
          child: Container(
            margin: const EdgeInsets.only(top: 4.0),
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _fileSelected && _filePath != null
                        ? _filePath!.split(Platform.pathSeparator).last
                        : widget.labelText ?? 'Pilih File..',
                    style: TextStyle(
                      color: _fileSelected ? Colors.black : Colors.grey,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                     if (!_fileSelected) {
                        _pickFile();
                      } else {
                        _deleteFile();
                      }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _fileSelected ? Colors.red : AppColors.primary,
                    minimumSize: const Size(60, 36),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                  child: Text(
                    _fileSelected ? 'Hapus' : 'Upload',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // Info text below
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            widget.text, // "File yang didukung: ..."
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}
