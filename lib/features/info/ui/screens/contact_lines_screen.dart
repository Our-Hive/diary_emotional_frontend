import 'package:emotional_app/features/info/ui/providers/contact_line_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactLinesScreen extends ConsumerStatefulWidget {
  const ContactLinesScreen({super.key});

  @override
  ConsumerState<ContactLinesScreen> createState() => _ContactLinesScreenState();
}

class _ContactLinesScreenState extends ConsumerState<ContactLinesScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(contactLineProvider.notifier).getContactLines();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(contactLineProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lineas de Contacto'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: state.contactLines.isNotEmpty
            ? ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final content = state.contactLines[index];
                  return ListTile(
                    title: Text(content.title),
                    subtitle: Text(content.description),
                  );
                },
                itemCount: state.contactLines.length,
              )
            : state.error.isNotEmpty
                ? Center(
                    child: Text(state.error),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
      ),
    );
  }
}
