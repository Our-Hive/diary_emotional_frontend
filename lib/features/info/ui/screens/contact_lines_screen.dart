import 'package:emotional_app/features/info/domain/entities/contact_line.dart';
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
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20,
                ),
                itemBuilder: (context, index) {
                  final line = state.contactLines[index];
                  return ContactLinesDetailCard(line: line);
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

class ContactLinesDetailCard extends StatelessWidget {
  const ContactLinesDetailCard({
    super.key,
    required this.line,
  });

  final ContactLine line;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.phone,
                  size: 60,
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: constraints.maxWidth * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        line.title,
                        style: textTheme.titleLarge!,
                      ),
                      Text(
                        line.description,
                        style: textTheme.bodyLarge!,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
