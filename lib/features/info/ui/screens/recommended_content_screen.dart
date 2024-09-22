import 'package:flutter/material.dart';

class RecommendedContentScreen extends StatelessWidget {
  const RecommendedContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recomendaciones'),
      ),
      body: const Text("data"),

      /*  ListView.separated(
        itemBuilder: itemBuilder,
        separatorBuilder: separatorBuilder,
        itemCount: itemCount,
      ), */
    );
  }
}
