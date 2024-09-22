import 'package:emotional_app/features/info/ui/providers/recommended_content_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class RecommendedContentScreen extends ConsumerStatefulWidget {
  const RecommendedContentScreen({super.key});

  @override
  ConsumerState<RecommendedContentScreen> createState() =>
      _RecommendedContentScreenState();
}

class _RecommendedContentScreenState
    extends ConsumerState<RecommendedContentScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(recommendedContentProvider.notifier).getRecommendedContent();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(recommendedContentProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recomendaciones'),
      ),
      body: state.recommendedContentList.isNotEmpty
          ? ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final content = state.recommendedContentList[index];
                return ListTile(
                  title: Text(content.title),
                  subtitle: Text(content.description),
                  onTap: () async => await launchUrl(Uri.parse(content.url)),
                );
              },
              itemCount: state.recommendedContentList.length,
            )
          : state.error.isNotEmpty
              ? Center(
                  child: Text(state.error),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
    );
  }
}
