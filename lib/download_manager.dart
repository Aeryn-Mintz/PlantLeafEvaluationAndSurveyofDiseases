import 'dart:io';
import 'package:dio/dio.dart';  
import 'package:path_provider/path_provider.dart';
import 'crop_config.dart';

class DownloadManager {
  final Dio _dio = Dio();

  Future<void> downloadModel(CropConfig crop, Function(double) onProgress) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/${crop.fileName}';
      final file = File(filePath);

      // Se já baixou antes, não baixa de novo
      if (await file.exists()) {
        onProgress(1.0); // 100% concluído
        return;
      }

      await _dio.download(
        crop.downloadUrl,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            onProgress(received / total); // Atualiza a barra de progresso
          }
        },
      );
    } catch (e) {
      print('Erro ao baixar ${crop.fileName}: $e');
      throw Exception('Falha no download');
    }
  }
}