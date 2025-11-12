# my_widgets

Un set de widgets reutilizables para Flutter.

## Uso rápido

```dart
import 'package:flutter/material.dart';
import 'package:my_widgets/my_widgets.dart';

class DemoPage extends StatelessWidget {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo my_widgets')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LibTextField(
          labelText: 'Email',
          hintText: 'tu@email.com',
          keyboardType: TextInputType.emailAddress,
          prefixIcon: const Icon(Icons.email),
          showPasswordToggle: false,
          onChanged: (v) => debugPrint(v),
        ),
      ),
    );
  }
}
