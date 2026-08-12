class CropConfig {
  final String id;
  final String displayName;
  final String downloadUrl;
  final String fileName;
  final List<String> labels;

  CropConfig({
    required this.id,
    required this.displayName,
    required this.downloadUrl,
    required this.fileName,
    required this.labels,
  });
}

// Sua lista completa de modelos hospedados no GitHub
final List<CropConfig> availableCrops = [
  CropConfig(
    id: 'apple',
    displayName: 'Maçã',
    downloadUrl: 'https://github.com/monokuma-code/Models/releases/download/models/modelo_apple.tflite',
    fileName: 'modelo_apple.tflite',
    labels: ['Apple Scab', 'Black Rot', 'Cedar Apple Rust', 'Healthy'],
  ),
  
  CropConfig(
    id: 'cherry',
    displayName: 'Cereja',
    downloadUrl: 'https://github.com/monokuma-code/Models/releases/download/models/modelo_cherry_.including_sour.tflite',
    fileName: 'modelo_cherry_.including_sour.tflite',
    labels: ['Healthy', 'Powdery Mildew'],
  ),
  
  CropConfig(
    id: 'corn',
    displayName: 'Milho',
    downloadUrl: 'https://github.com/monokuma-code/Models/releases/download/models/modelo_corn_.maize.tflite',
    fileName: 'modelo_corn_.maize.tflite',
    labels: ['Cercospora Leaf Spot / Gray Leaf Spot', 'Common Rust', 'Healthy', 'Northern Leaf Blight'],
  ),
  
  CropConfig(
    id: 'grape',
    displayName: 'Uva',
    downloadUrl: 'https://github.com/monokuma-code/Models/releases/download/models/modelo_grape.tflite',
    fileName: 'modelo_grape.tflite',
    labels: ['Black Rot', 'Esca (Black Measles)', 'Healthy', 'Leaf Blight (Isariopsis Leaf Spot)'],
  ),
  
  CropConfig(
    id: 'peach',
    displayName: 'Pêssego',
    downloadUrl: 'https://github.com/monokuma-code/Models/releases/download/models/modelo_peach.tflite',
    fileName: 'modelo_peach.tflite',
    labels: ['Bacterial Spot', 'Healthy'],
  ),
  
  CropConfig(
    id: 'pepper',
    displayName: 'Pimentão',
    downloadUrl: 'https://github.com/monokuma-code/Models/releases/download/models/modelo_pepper._bell.tflite',
    fileName: 'modelo_pepper._bell.tflite',
    labels: ['Bacterial Spot', 'Healthy'],
  ),
  
  CropConfig(
    id: 'potato',
    displayName: 'Batata',
    downloadUrl: 'https://github.com/monokuma-code/Models/releases/download/models/modelo_potato.tflite',
    fileName: 'modelo_potato.tflite',
    labels: ['Early Blight', 'Healthy', 'Late Blight'],
  ),
  
  /* 
  // SOJA: Deixei comentado caso você queira ativar no futuro.
  CropConfig(
    id: 'soybean',
    displayName: 'Soja',
    downloadUrl: 'https://github.com/monokuma-code/Models/releases/download/models/modelo_soybean.tflite',
    fileName: 'modelo_soybean.tflite',
    labels: ['Healthy'],
  ),
  */
  
  CropConfig(
    id: 'strawberry',
    displayName: 'Morango',
    downloadUrl: 'https://github.com/monokuma-code/Models/releases/download/models/modelo_strawberry.tflite',
    fileName: 'modelo_strawberry.tflite',
    labels: ['Healthy', 'Leaf Scorch'],
  ),
  
  CropConfig(
    id: 'tomato',
    displayName: 'Tomate',
    downloadUrl: 'https://github.com/monokuma-code/Models/releases/download/models/modelo_tomato.tflite',
    fileName: 'modelo_tomato.tflite',
    labels: [
      'Bacterial Spot', 
      'Early Blight', 
      'Healthy', 
      'Late Blight', 
      'Leaf Mold', 
      'Septoria Leaf Spot', 
      'Spider Mites (Two-Spotted)', 
      'Target Spot', 
      'Tomato Mosaic Virus', 
      'Tomato Yellow Leaf Curl Virus'
    ],
  ),
];