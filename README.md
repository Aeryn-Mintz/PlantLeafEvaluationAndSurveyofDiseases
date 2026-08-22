🌿 PLEASED

Photographic Leaf Evaluation and Survey Environmental Diagnostics

O PLEASED é um aplicativo móvel desenvolvido em Flutter que utiliza Inteligência Artificial offline para diagnosticar doenças em plantas e cultivos agrícolas através de fotografias. Ao analisar uma folha, o aplicativo identifica a doença, exibe o grau de confiança da IA e fornece recomendações imediatas de sintomas e tratamentos.
✨ Principais Funcionalidades

    🤖 Diagnóstico Offline: Após o download inicial dos modelos, a inferência (análise da imagem) é feita 100% localmente no dispositivo usando TensorFlow Lite, sem necessidade de internet em campo.

    🔄 Sincronização Dinâmica: O aplicativo verifica silenciosamente um arquivo JSON hospedado no GitHub durante a inicialização. Se houver uma nova versão do modelo .tflite para alguma cultura, o download é feito de forma transparente.

    📸 Captura Flexível: Suporte para análise de imagens capturadas na hora via Câmera ou importadas da Galeria.

    📚 Banco de Dados de Doenças: Fornece detalhes precisos sobre sintomas e tratamentos para diversas pragas e fungos, auxiliando o produtor rural na tomada de decisão.

    ⚙️ Otimização de Armazenamento: O usuário escolhe apenas as culturas que deseja monitorar, baixando exclusivamente os modelos necessários.

🌱 Culturas Suportadas

Atualmente, o modelo de Machine Learning suporta o diagnóstico de doenças para as seguintes culturas:

    Maçã (Apple)

    Cereja (Cherry)

    Milho (Corn)

    Uva (Grape)

    Pêssego (Peach)

    Pimentão (Pepper)

    Batata (Potato)

    Morango (Strawberry)

    Tomate (Tomato)

🛠️ Tecnologias Utilizadas
Aplicativo (Mobile)

    Flutter / Dart: Framework principal para interface e lógica de negócios.

    tflite_flutter: Execução dos modelos de redes neurais no dispositivo.

    dio & http: Gerenciamento de downloads e requisições de rede.

    image_picker: Interface com a câmera e galeria do sistema operacional.

Treinamento da IA (Python)

    TensorFlow / Keras: Construção e treinamento da rede neural baseada na arquitetura MobileNetV2.

    DirectML / CUDA: Aceleração de hardware para treinamento rápido em GPUs no Windows.

    TFLite Converter: Compressão e conversão do modelo .h5 para inferência mobile (.tflite).

🚀 Como Executar o Projeto
Pré-requisitos

    Flutter SDK instalado e configurado.

    Android SDK (via Android Studio ou Command Line Tools).

    Dispositivo físico Android ou Emulador configurado.

Passos para Compilação

    Clone o repositório:
    Bash

    git clone https://github.com/SEU_USUARIO/pleased.git
    cd pleased

    Instale as dependências do Flutter:
    Bash

    flutter pub get

    Execute o aplicativo em modo de depuração:
    Bash

    flutter run

    Para gerar o APK final otimizado para produção:
    Bash

    flutter build apk --release

    O arquivo será gerado em build/app/outputs/flutter-apk/app-release.apk.

🧠 Sobre o Treinamento dos Modelos

Os modelos TFLite foram treinados individualmente para cada cultura visando máxima precisão e menor uso de memória RAM no dispositivo. O script de treinamento (treinar_todos.py) utiliza:

    Transfer Learning (MobileNetV2) para identificar características complexas das folhas.

    Early Stopping & ReduceLROnPlateau para evitar overfitting e otimizar a taxa de aprendizado.

    Validação de Integridade para remover imagens corrompidas do dataset antes do processamento.

📄 Licença

Este projeto é de uso educacional/pessoal. Os direitos das imagens de dataset e bibliotecas de terceiros pertencem aos seus respectivos criadores.
