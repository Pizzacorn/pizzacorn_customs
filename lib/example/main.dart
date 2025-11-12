
import 'package:flutter/material.dart';
import 'package:pizzacorn_widgets/src/textfield_custom.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'my_widgets example',
      theme: ThemeData(colorSchemeSeed: Colors.deepPurple, useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('my_widgets example')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: TextFieldCustom(
            labelText: 'Contraseña',
            hintText: '••••••••',
            obscureText: true,
            showPasswordToggle: true,
            prefixIcon: const Icon(Icons.lock),
          ),
        ),
      ),
    );
  }
}
