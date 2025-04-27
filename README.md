-> Confeitaria Marketplace:
    Esse é um aplicativo Flutter que eu desenvolvi para gerenciar confeitarias e seus produtos, mostrando tudo em um mapa interativo.
    Usei ObjectBox para salvar os dados localmente e o Google Maps para exibir as confeitarias no mapa.

-> Funcionalidades
   - Cadastro de confeitarias com:
        Nome, telefone, CEP, endereço completo
        Localização automática (latitude/longitude a partir do endereço);
   - Cadastro de produtos para cada confeitaria:
        Nome, descrição, preço e imagens;
   - Exibição das confeitarias no mapa;
   - Visualização dos detalhes da confeitaria e dos produtos;
   - Edição e exclusão de confeitarias e produtos;
   - Tudo funcionando offline depois do primeiro uso.

-> Como rodar o projeto:

    1. Clonar o repositório
        git clone https://github.com/seu-usuario/seu-repositorio.git
        cd seu-repositorio
    2. Instalar as dependências
        flutter pub get
    3. Gerar o código do ObjectBox
        flutter pub run build_runner build
        - Se der conflito de arquivos, roda:
        flutter pub run build_runner build --delete-conflicting-outputs
    4. Rodar o app
        flutter run

->  Algumas configurações:

    Android

    - No arquivo AndroidManifest.xml, eu adicionei essas permissões:
        <uses-permission android:name="android.permission.INTERNET"/>
        <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
        <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>

    - Também coloquei minha chave da API do Google Maps:
        <meta-data
            android:name="com.google.android.geo.API_KEY"
            android:value="SUA_CHAVE_AQUI"/>

    iOS

    - No Info.plist adicionei:
        <key>NSLocationWhenInUseUsageDescription</key>
        <string>O app precisa acessar sua localização para mostrar as confeitarias no mapa.</string>
        <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
        <string>O app precisa acessar sua localização para mostrar as confeitarias no mapa.</string>

-> Organização das pastas

        lib/
        ├── main.dart                 // Inicializa ObjectBox e define rotas
        ├── objectbox_store.dart       // Store do banco de dados
        ├── models/                    // Modelos de Confeitaria e Produto
        ├── screens/                   // Todas as telas do app
        └── objectbox.g.dart            // Arquivo gerado (não precisa editar)
