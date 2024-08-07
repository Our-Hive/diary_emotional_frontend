import 'package:flutter/material.dart';

class DiaryFormScreen extends StatelessWidget {
  const DiaryFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diario Emocional'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Column(
                children: [
                  Text(
                    'Emoción Primaria',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      // todo: color of emotions
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Emoción Secundaria',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      // todo: color of emotions
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const TextField(
                maxLines: 8,
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Exprésate Aquí :D',
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Guardar\nRegistro',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
