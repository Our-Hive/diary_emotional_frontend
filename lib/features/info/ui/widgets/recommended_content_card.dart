import 'package:emotional_app/config/router/app_routes_name.dart';
import 'package:emotional_app/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class RecommendedContentCard extends StatelessWidget {
  const RecommendedContentCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appText = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => context.pushNamed(AppRoutesName.recommendedContentScreen),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.yellowPale,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.9),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Contenido Recomendado',
                style: TextStyle(
                  fontSize: appText.titleLarge?.fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FaIcon(
                    FontAwesomeIcons.spotify,
                    color: Color(0xff1ED760),
                    size: 40,
                  ),
                  FaIcon(
                    FontAwesomeIcons.youtube,
                    color: Color(0xffFF0000),
                    size: 40,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
