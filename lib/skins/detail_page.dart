import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';

class DetailScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  const DetailScreen({super.key, required this.data});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String? _downloadedFilePath; // Lưu đường dẫn file sau khi tải

  Future<void> _downloadImage(BuildContext context, String url) async {
    try {
      Directory dir = await getApplicationDocumentsDirectory();
      String savePath =
          "${dir.path}/${DateTime.now().millisecondsSinceEpoch}.png";

      await Dio().download(url, savePath);

      setState(() {
        _downloadedFilePath = savePath;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("✅ Ảnh đã được tải về: $savePath")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Lỗi khi tải ảnh: $e")),
      );
    }
  }

  Future<void> _openDownloadedFile() async {
    if (_downloadedFilePath != null) {
      await OpenFilex.open(_downloadedFilePath!);
    }
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("📋 Đã copy vào clipboard")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          data['name'] ?? 'Detail',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (data['image'] != null)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width,       // max theo chiều rộng màn hình
                    maxHeight: MediaQuery.of(context).size.height,     // max theo chiều cao màn hình
                  ),
                  child: FittedBox(
                    fit: BoxFit.contain,         // giữ nguyên tỉ lệ ảnh, không bị cắt
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(data['image'],),
                    ),
                  ),
                )
              ),
            ),
          const SizedBox(height: 20),

          // Nút Download
          Container(
            width: MediaQuery.of(context).size.width - 48,
            child: ElevatedButton.icon(
              onPressed: () {
                if (data['image'] != null) {
                  _downloadImage(context, data['image']);
                }
              },
              icon: const Icon(Icons.download, color: Colors.white),
              label: const Text("Watch Ad to Download",
                  style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Nếu đã tải xong thì hiện thêm nút mở thư mục
          if (_downloadedFilePath != null)
            Container(
              width: MediaQuery.of(context).size.width - 48,
              child: ElevatedButton.icon(
                onPressed: _openDownloadedFile,
                icon: const Icon(Icons.folder_open, color: Colors.white),
                label: const Text("Show Skin",
                    style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

          const SizedBox(height: 20),

        ],
      ),
    );
  }
}
