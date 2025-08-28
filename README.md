# Projeto de Listar Produtos.
## 📌 Sobre

Aplicação desenvolvida em Flutter para listar e favoritar produtos.

### ⚙️ Tecnologias Utilizadas
- **Flutter** –  Web, Android e IOS

### ⚙️ Api Utilizada
- **fakestoreapi** –  https://fakestoreapi.com/docs

### ⚙️ Gerenciamento de Estado
- **ValueNotifier** –  Gerencia o estado estre as telas de Listar produtos, Detalhes do Produto e Favoritos.

### ⚙️ Armazenamento Local
- **shared_preferences** –  Armazena os id dos produtos favoritos.


## ⚠️ Dependências

- Instale as dependências do Flutter:
```bash
flutter pub get
``` 

- Certifique-se de que a dependência go_router está listada no pubspec.yaml. Se não estiver, adicione:
```bash
flutter pub add go_router
``` 

## 🚀 Como executar

#### Abrir no VSCODE e rodar os seguintes comandos:

#### Para IOS 

- No Mac, abra o Xcode → Menu Xcode → Open Developer Tool → Simulator

- no terminal do vscode:
```bash
open -a Simulator
```
- Para ver os IDs disponíveis:
```bash
flutter devices
```

```bash
flutter run -d <device_id>
```

#### Para Android

- Abrir um emulador no Android Studio
- Certifique-se que tem o Android SDK instalado.
- Instale também o Android SDK Platform para a versão que quer testar.
- Abra o Android Studio → Tools → AVD Manager
- Crie um emulador: Create Virtual Device (por exemplo, Pixel 6 com Android 13).

- No terminal do vscode:
- Para ver os IDs disponíveis:
```bash
flutter devices
```

- Id do emulador android - exemplo: emulator-5554
```bash
flutter run -d emulator-5554
```

#### Para WEB
- no terminal do vscode:
- Verifique os navegadores disponíveis:
```bash
flutter devices
```

- Verifique os navegadores disponíveis:

```bash
flutter devices
```

```bash
flutter run -d <navegador>
```

```bash
flutter run -d chrome
```



