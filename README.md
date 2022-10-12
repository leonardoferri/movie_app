# movie_app

Aplicativo para inclusão de notas e reviews de filmes, assim como imagem para representá-lo(s) na listagem da página inicial

Desenvolvido para a matéria de Mobile Engineering da MBA de Engenharia de Software da FIAP.

Responsáveis:
Leonardo Novaes Ferri
Lyon Souza de Arruda
Rendrick Duarte Amorim
Wallace Ferreira
Turma 87AOJ

Link para o vídeo com a demonstração do app em funcionamento:
https://www.youtube.com/watch?v=6pRED-WHMn0

## Getting Started

```bash
$ flutter pub get
```

```bash
$ flutter run
```

## Desenvolvimento

Desenvolvido com:
Flutter 3.3.4
Dart 2.18.2

Durante o desenvolvimento, testes e vídeo de demonstração do app foi utilizado um emulador de Android com as seguintes configurações:

Android Studio Dolphin | 2021.3.1
Build #AI-213.7172.25.2113.9014738, built on August 31, 2022
Runtime version: 11.0.13+0-b1751.21-8125866 amd64
VM: OpenJDK 64-Bit Server VM by JetBrains s.r.o.
Windows 10 10.0

Virtual device
Pixel 5
Android 12.0 (S) x86_64
RAM: 1536 MB
VM heap: 228 MB
Internal Storage: 1024 MB
SD Card -> Studio-managed: 1024 MB

## Database

Instância de um Realtime Database no Firebase
Configurações já programadas no código para as ações de CRUD.
A base configurada e utilizada para desenvolvimento, testes e demonstração do app ficará aberta para leitura e escrita até a data de 08/11/2022.
Após essa data, serão necessárias alterações nas regras da base.

## Dependencies

Dependências incluídas no arquivo pubspec.yaml para correto funcionamento do app:
'provider' para manipulação de eventos de CRUD;
'flutter_rating_bar' para utilização do widget de nota para o filme (tela de listagem e tela de inclusão);
'uuid: ^3.0.6' para geração de UUID randomicos;
'firebase_core' para integração da aplicação com o banco de dados realtime do FireBase.
