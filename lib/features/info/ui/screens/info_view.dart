import 'package:flutter/material.dart';
import 'package:emotional_app/features/info/ui/widgets/contact_lines_card.dart';
import 'package:emotional_app/features/info/ui/widgets/recommended_content_card.dart';

class InfoView extends StatelessWidget {
  const InfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ContactLinesCard(),
                  SizedBox(height: 40),
                  RecommendedContentCard(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
