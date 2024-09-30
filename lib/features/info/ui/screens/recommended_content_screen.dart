import 'package:emotional_app/features/info/domain/entities/recommended_content.dart';
import 'package:emotional_app/features/info/ui/providers/recommended_content_provider.dart';
import 'package:emotional_app/shared/ui/widgets/our_hive_app_bar.dart';
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
      appBar: OurHiveAppBar(
        title: "Recomendaciones",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: state.recommendedContentList.isNotEmpty
            ? ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final content = state.recommendedContentList[index];
                  return RecommendedContentCard(content: content);
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
      ),
    );
  }
}

class RecommendedContentCard extends StatelessWidget {
  const RecommendedContentCard({
    super.key,
    required this.content,
  });

  final RecommendedContent content;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () async => await launchUrl(Uri.parse(content.url)),
      child: Container(
        decoration: BoxDecoration(
          // todo: configure color card
          color: const Color(0xffDEADCC),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 250,
                      child: Text(
                        content.title,
                        style: textTheme.titleLarge!.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.open_in_new,
                      color: Colors.black,
                      size: 20,
                    ),
                  ],
                ),
              ),
              const Divider(),
              Text(
                content.description,
                style: textTheme.bodyMedium!.copyWith(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
