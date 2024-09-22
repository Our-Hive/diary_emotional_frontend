import 'package:emotional_app/config/router/app_routes_name.dart';
import 'package:emotional_app/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContactLinesCard extends StatelessWidget {
  const ContactLinesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appText = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => context.pushNamed(AppRoutesName.contactLinesScreen),
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
                'Lineas de Contacto',
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
                  Icon(
                    Icons.phone,
                    color: Colors.black,
                    size: 40,
                  ),
                  Icon(
                    Icons.email,
                    color: Colors.black,
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
