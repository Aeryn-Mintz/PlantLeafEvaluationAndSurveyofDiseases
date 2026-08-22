import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

import 'crop_selection_screen.dart';
import 'crop_config.dart';
import 'analysis_screen.dart';
import 'model_sync_service.dart';

void main() async {
  // Garante que os componentes do Flutter estejam prontos antes de ler a memória
  WidgetsFlutterBinding.ensureInitialized();
  
  final prefs = await SharedPreferences.getInstance();
  final hasSetupCompleted = prefs.getBool('has_setup_completed') ?? false;

  runApp(PleasedApp(showSetup: !hasSetupCompleted));
}

class PleasedApp extends StatelessWidget {
  final bool showSetup;
  
  const PleasedApp({Key? key, required this.showSetup}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PLEASED',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      // Decide qual tela mostrar com base na variável showSetup
      home: showSetup ? const CropSelectionScreen() : const HomeScreen(),
    );
  }
}

// TELA PRINCIPAL (Painel de Diagnóstico)
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CropConfig> myCrops = [];

  @override
  void initState() {
    super.initState();
    _loadMyCrops();
    
    // Dispara a checagem em segundo plano sem travar a tela do usuário
    ModelSyncService.checkAndDownloadModels();
  }

  Future<void> _loadMyCrops() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIds = prefs.getStringList('selected_crops') ?? [];
    
    setState(() {
      myCrops = availableCrops.where((c) => savedIds.contains(c.id)).toList();
    });
  }

  // --- Função: Puxa a imagem da Câmera ou Galeria ---
  Future<void> _pickImage(ImageSource source, CropConfig crop) async {
    final picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: source);

    if (photo != null && mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AnalysisScreen(
            imagePath: photo.path,
            crop: crop,
          ),
        ),
      );
    }
  }

  // --- Função: Mostra o menu de escolha ---
  void _showPickerOptions(BuildContext context, CropConfig crop) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Escolha a origem da imagem:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.green),
                title: const Text('Galeria de Fotos'),
                onTap: () {
                  Navigator.of(context).pop(); // Fecha o menu
                  _pickImage(ImageSource.gallery, crop); // Abre a Galeria
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera, color: Colors.green),
                title: const Text('Câmera'),
                onTap: () {
                  Navigator.of(context).pop(); // Fecha o menu
                  _pickImage(ImageSource.camera, crop); // Abre a Câmera
                },
              ),
              const SizedBox(height: 20), // Um espacinho extra no fundo
            ],
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Cultivos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const CropSelectionScreen()));
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: myCrops.length,
        itemBuilder: (context, index) {
          final crop = myCrops[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.local_florist, color: Colors.green, size: 40),
              title: Text(crop.displayName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              subtitle: const Text('Modelo pronto para diagnóstico offline.'),
              trailing: const Icon(Icons.camera_alt),
              onTap: () {
                _showPickerOptions(context, crop);
              },
            ),
          );
        },
      ),
    );
  }
}
