import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModelSyncService {
  // O link RAW direto para o seu arquivo JSON no GitHub
  static const String _jsonUrl = 'https://raw.githubusercontent.com/Aeryn-Mintz/Models_pleased/main/model_versions.json';

  static Future<void> checkAndDownloadModels() async {
    try {
      print('🔄 Checando atualizações de modelos no GitHub...');
      
      // 1. Baixa o JSON
      final response = await http.get(Uri.parse(_jsonUrl));
      if (response.statusCode != 200) {
        print('⚠️ Falha ao ler o JSON no GitHub. Código: ${response.statusCode}');
        return;
      }

      // 2. Converte o texto para um Mapa
      Map<String, dynamic> remoteData = json.decode(response.body);
      final prefs = await SharedPreferences.getInstance();
      final dir = await getApplicationDocumentsDirectory();

      // 3. Varre cada planta listada no JSON
      for (String cropKey in remoteData.keys) {
        var cropInfo = remoteData[cropKey];
        int remoteVersion = cropInfo['version'];
        String downloadUrl = cropInfo['url'];
        
        // Pega a versão que está instalada no celular (se não tiver, é 0)
        int localVersion = prefs.getInt('version_$cropKey') ?? 0;
        
        // Define o nome e o local onde o arquivo será salvo no celular
        String fileName = 'modelo_$cropKey.tflite';
        File localFile = File('${dir.path}/$fileName');

        // 4. A Lógica: Baixa se a versão for nova OU se o arquivo ainda não existir
        if (remoteVersion > localVersion || !await localFile.exists()) {
          print('📥 Baixando nova versão para $cropKey (Versão $remoteVersion)...');
          
          final downloadResponse = await http.get(Uri.parse(downloadUrl));
          
          if (downloadResponse.statusCode == 200) {
            // Salva o arquivo .tflite fisicamente no celular
            await localFile.writeAsBytes(downloadResponse.bodyBytes);
            
            // Atualiza o número da versão na memória do app
            await prefs.setInt('version_$cropKey', remoteVersion);
            print('✅ $cropKey atualizado com sucesso para a versão $remoteVersion!');
          } else {
            print('❌ Erro ao baixar o arquivo .tflite para $cropKey.');
          }
        } else {
          print('✔️ $cropKey já está na versão mais recente ($localVersion).');
        }
      }
    } catch (e) {
      print('⚠️ Erro de conexão ao sincronizar modelos (modo offline): $e');
    }
  }
}
