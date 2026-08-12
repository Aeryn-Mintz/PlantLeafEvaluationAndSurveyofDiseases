import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'crop_config.dart';
import 'download_manager.dart';
import 'main.dart';

class CropSelectionScreen extends StatefulWidget {
  const CropSelectionScreen({Key? key}) : super(key: key);

  @override
  _CropSelectionScreenState createState() => _CropSelectionScreenState();
}

class _CropSelectionScreenState extends State<CropSelectionScreen> {
  final Set<String> _selectedCrops = {};
  bool _isDownloading = false;
  String _downloadStatus = '';
  double _currentProgress = 0.0;

  Future<void> _startDownloadAndSave() async {
    if (_selectedCrops.isEmpty) return;

    setState(() {
      _isDownloading = true;
    });

    final downloadManager = DownloadManager();
    
    // Filtra apenas as plantas que o usuário marcou
    final cropsToDownload = availableCrops.where((c) => _selectedCrops.contains(c.id)).toList();

    for (var crop in cropsToDownload) {
      setState(() {
        _downloadStatus = 'Baixando IA: ${crop.displayName}...';
        _currentProgress = 0.0;
      });

      await downloadManager.downloadModel(crop, (progress) {
        setState(() {
          _currentProgress = progress;
        });
      });
    }

    // Salva as escolhas na memória do celular
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('selected_crops', _selectedCrops.toList());
    await prefs.setBool('has_setup_completed', true);

    // Navega para a tela principal
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bem-vindo ao PLEASED')),
      body: _isDownloading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(value: _currentProgress),
                  const SizedBox(height: 20),
                  Text(_downloadStatus, style: const TextStyle(fontSize: 16)),
                  Text('${(_currentProgress * 100).toInt()}%'),
                ],
              ),
            )
          : Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Selecione quais culturas você cultiva. O aplicativo baixará a Inteligência Artificial apenas para elas.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: availableCrops.length,
                    itemBuilder: (context, index) {
                      final crop = availableCrops[index];
                      final isSelected = _selectedCrops.contains(crop.id);
                      return CheckboxListTile(
                        title: Text(crop.displayName),
                        value: isSelected,
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              _selectedCrops.add(crop.id);
                            } else {
                              _selectedCrops.remove(crop.id);
                            }
                          });
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _selectedCrops.isEmpty ? null : _startDownloadAndSave,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Baixar e Começar', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
    );
  }
}