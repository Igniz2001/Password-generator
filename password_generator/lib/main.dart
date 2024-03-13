import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

void main() {
  runApp(FlutterPasswordGenerator()); //Correr la app
}

class FlutterPasswordGenerator extends StatelessWidget {
  @override //Este stateless widget es para el titulo unicamente
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Generator',
      home: PasswordGenerator(),
    );
  }
}

class PasswordGenerator extends StatefulWidget {
  @override
  _PasswordGeneratorState createState() => _PasswordGeneratorState();
}

class _PasswordGeneratorState extends State<PasswordGenerator> {
  String generatedPassword = '';
  int passwordLength = 10;
  bool includeUppercase = true;
  bool includeLowercase = true;
  bool includeSymbols = true;
  bool includeNumbers = true;

  void generatePassword() { //Para generar la contraseña se chequean que checkboxes estan true y se procede a crear un string charSet del que se sacarán los recursos para la contraseña generada
    String charSet = ''; 
    if (includeUppercase) charSet += 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    if (includeLowercase) charSet += 'abcdefghijklmnopqrstuvwxyz';
    if (includeSymbols) charSet += '!@#\$%^&*()_+';
    if (includeNumbers) charSet += '0123456789';

    String password = '';
    final random = Random();
    for (int i = 0; i < passwordLength; i++) {
      password += charSet[random.nextInt(charSet.length)];
    }

    setState(() { 
      generatedPassword = password;
    });
  }

  void copyToClipboard() { //Esto es para que la contrseña se pueda copiar al portapapeles
    Clipboard.setData(ClipboardData(text: generatedPassword));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied to clipboard!'),
      ),
    );
  }

//Parte visual, widget, columnas, textos, checkboxes, etc.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Password Generator',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Password:',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 10.0),
              SelectableText(
                generatedPassword,
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Slider(
                    value: passwordLength.toDouble(),
                    min: 0,
                    max: 20,
                    divisions: 20,
                    onChanged: (newValue) {
                      setState(() {
                        passwordLength = newValue.round();
                      });
                    },
                  ),
                  Text(
                    'Password length: $passwordLength',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              CheckboxListTile(
                title: Text('Include uppercase letters'),
                value: includeUppercase,
                onChanged: (newValue) {
                  setState(() {
                    includeUppercase = newValue!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Include lowercase letters'),
                value: includeLowercase,
                onChanged: (newValue) {
                  setState(() {
                    includeLowercase = newValue!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Include symbols'),
                value: includeSymbols,
                onChanged: (newValue) {
                  setState(() {
                    includeSymbols = newValue!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Include numbers'),
                value: includeNumbers,
                onChanged: (newValue) {
                  setState(() {
                    includeNumbers = newValue!;
                  });
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  generatePassword();
                },
                child: Text('Generate password'),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  copyToClipboard();
                },
                child: Text('Copy to clipboard'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
