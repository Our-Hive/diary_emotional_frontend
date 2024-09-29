import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String description;
  final double height;
  final String imagePath;
  final void Function() onTap;

  const HomeCard({
    super.key,
    required this.title,
    required this.description,
    required this.height,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: onTap,
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Theme.of(context).colorScheme.onPrimary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(
                imagePath,
                width: double.infinity,
                height: height - 80,
                fit: BoxFit.cover,
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.center,
                        child: IconButton(
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(title),
                              content: Text(description),
                              actions: <TextButton>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Entiendo'),
                                ),
                              ],
                            ),
                          ),
                          icon: const Icon(
                            Icons.info_outline,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
