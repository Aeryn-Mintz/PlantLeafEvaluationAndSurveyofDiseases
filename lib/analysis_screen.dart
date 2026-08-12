import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'crop_config.dart';
import 'disease_database.dart';

class AnalysisScreen extends StatefulWidget {
  final String imagePath;
  final CropConfig crop;

  const AnalysisScreen({
    Key? key,
    required this.imagePath,
    required this.crop,
  }) : super(key: key);

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  bool _isAnalyzing = true;
  String _resultText = '';
  double _confidence = 0.0;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _runModel();
  }

  Future<void> _runModel() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final modelPath = '${dir.path}/${widget.crop.fileName}';
      final modelFile = File(modelPath);

      if (!await modelFile.exists()) {
        throw Exception('Modelo não encontrado no celular. Tente baixar novamente.');
      }

      final interpreter = await Interpreter.fromFile(modelFile);

      const int inputSize = 224;
      final imageBytes = await File(widget.imagePath).readAsBytes();
      img.Image? originalImage = img.decodeImage(imageBytes);
      
      if (originalImage == null) {
        throw Exception('Não foi possível ler a imagem.');
      }
      
      img.Image resizedImage = img.copyResize(originalImage, width: inputSize, height: inputSize);

      var input = List.generate(
        1,
        (i) => List.generate(
          inputSize,
          (y) => List.generate(
            inputSize,
            (x) => List.filled(3, 0.0),
          ),
        ),
      );

      for (int y = 0; y < inputSize; y++) {
        for (int x = 0; x < inputSize; x++) {
          img.Pixel pixel = resizedImage.getPixel(x, y);
          input[0][y][x][0] = (pixel.r / 127.5) - 1.0;
          input[0][y][x][1] = (pixel.g / 127.5) - 1.0;
          input[0][y][x][2] = (pixel.b / 127.5) - 1.0;
        }
      }

      int numLabels = widget.crop.labels.length;
      var output = List.generate(1, (i) => List.filled(numLabels, 0.0));

      interpreter.run(input, output);

      List<double> probabilities = output[0];
      double maxProb = 0.0;
      int maxIndex = 0;

      for (int i = 0; i < probabilities.length; i++) {
        if (probabilities[i] > maxProb) {
          maxProb = probabilities[i];
          maxIndex = i;
        }
      }

      interpreter.close();

      if (mounted) {
        setState(() {
          _isAnalyzing = false;
          _resultText = widget.crop.labels[maxIndex];
          _confidence = maxProb;
        });
      }

    } catch (e) {
      if (mounted) {
        setState(() {
          _isAnalyzing = false;
          _errorMessage = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    DiseaseDetails details = diseaseDatabase[_resultText] ?? diseaseDatabase['Default']!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Analisando ${widget.crop.displayName}'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    File(widget.imagePath),
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 30),
                
                if (_isAnalyzing) ...[
                  const CircularProgressIndicator(color: Colors.green),
                  const SizedBox(height: 20),
                  const Text(
                    'Executando rede neural offline...',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ] else if (_errorMessage.isNotEmpty) ...[
                  const Icon(Icons.error_outline, color: Colors.red, size: 60),
                  const SizedBox(height: 10),
                  Text(
                    'Erro na análise:\n$_errorMessage',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.red),
                  ),
                ] else ...[
                  const Text(
                    'Diagnóstico PLEASED:',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _resultText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Confiança da IA: ${(_confidence * 100).toStringAsFixed(1)}%',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 24),
                  
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.search, color: Colors.orange),
                              SizedBox(width: 8),
                              Text('Sintomas:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.orange)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(details.symptoms, style: const TextStyle(fontSize: 16)),
                          
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Divider(),
                          ),
                          
                          const Row(
                            children: [
                              Icon(Icons.healing, color: Colors.green),
                              SizedBox(width: 8),
                              Text('Tratamento:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(details.treatment, style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}