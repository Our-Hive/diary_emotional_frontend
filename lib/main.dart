import 'package:emotional_app/config/env/app_environment.dart';
import 'package:emotional_app/config/router/app_router.dart';
import 'package:emotional_app/config/theme/app_theme.dart';
import 'package:emotional_app/config/db/hive/hive_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppEnvironment.init();
  await HiveSetUp.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      title: 'OurHive - Emotional Diary',
      theme: AppTheme.dark(),
      routerConfig: appRouter,
    );
  }
}
