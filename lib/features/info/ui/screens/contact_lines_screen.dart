import 'package:flutter/material.dart';

class ContactLinesScreen extends StatelessWidget {
  const ContactLinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lineas de Contacto'),
      ),
      body: Text("data"),

      /*  ListView.separated(
        itemBuilder: itemBuilder,
        separatorBuilder: separatorBuilder,
        itemCount: itemCount,
      ), */
    );
  }
}
