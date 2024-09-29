import 'package:emotional_app/features/my_space/ui/providers/my_space_provider.dart';
import 'package:emotional_app/shared/ui/widgets/our_hive_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MySpaceView extends ConsumerStatefulWidget {
  static const name = 'ProfileView';

  const MySpaceView({super.key});

  @override
  ConsumerState<MySpaceView> createState() => _MySpaceViewState();
}

class _MySpaceViewState extends ConsumerState<MySpaceView> {
  @override
  void initState() {
    super.initState();
    ref.read(mySpaceProvider.notifier).getMySpaces();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mySpaceProvider);
    return Scaffold(
      appBar: OurHiveAppBar(title: 'Mi Espacio'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (state.isLoading) const CircularProgressIndicator(),
            if (state.error.isNotEmpty) Text(state.error),
            if (state.spaces.isNotEmpty)
              ListView.builder(
                itemCount: state.spaces.length,
                itemBuilder: (context, index) {
                  final space = state.spaces[index];
                  return ListTile(
                    title: Text(space.name),
                    subtitle: Text(space.url),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
