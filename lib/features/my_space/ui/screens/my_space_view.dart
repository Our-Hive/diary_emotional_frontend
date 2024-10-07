import 'package:emotional_app/features/my_space/domain/entities/my_space.dart';
import 'package:emotional_app/features/my_space/ui/providers/my_space_provider.dart';
import 'package:emotional_app/shared/domain/utils/date_time_formatter.dart';
import 'package:emotional_app/shared/domain/utils/random_color.dart';
import 'package:emotional_app/shared/ui/widgets/our_hive_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (state.isLoading || state.spaces.isEmpty)
              const CircularProgressIndicator(),
            if (state.error.isNotEmpty) Text(state.error),
            if (state.spaces.isNotEmpty) _MySpaceList(spaceList: state.spaces),
          ],
        ),
      ),
    );
  }
}

class _MySpaceList extends StatelessWidget {
  final List<MySpace> spaceList;
  const _MySpaceList({
    required this.spaceList,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final randomColor = RandomColor.generateByList([
      Color(0xFFeb0a64),
      Color(0xFFf7b801),
      Color(0xFF903bb9),
      Color(0xFFc02d7e),
      Color(0xFFaf1f66),
      Color(0xFFf18701),
    ]);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: PageView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: spaceList.length,
          itemBuilder: (context, index) {
            final space = spaceList[index];
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: space.type == MySpaceType.image
                        ? randomColor
                        : Colors.transparent,
                  ),
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: space.type == MySpaceType.image
                        ? Image.network(
                            space.url,
                            fit: BoxFit.cover,
                          )
                        : _MySpaceVideoPlayer(
                            space: space,
                          ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.black.withOpacity(0.1),
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        space.name,
                        style: textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${space.type.name} - ${DateTimeFormatter.getFormattedDate(
                          space.createdAt,
                        )}',
                        style: textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ), /*  
                todo Implementar descarga de archivos
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: _DownLoadButton(),
                ), */
              ],
            );
          },
        ),
      ),
    );
  }
}

class _DownLoadButton extends StatelessWidget {
  const _DownLoadButton();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: Column(
            children: [
              const Icon(
                Icons.download,
                size: 30,
              ),
              const Text(
                "Descargar",
              ),
            ],
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}

class _MySpaceVideoPlayer extends StatefulWidget {
  const _MySpaceVideoPlayer({
    required this.space,
  });

  final MySpace space;

  @override
  State<_MySpaceVideoPlayer> createState() => _MySpaceVideoPlayerState();
}

class _MySpaceVideoPlayerState extends State<_MySpaceVideoPlayer> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        widget.space.url,
      ),
    )..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : const CircularProgressIndicator();
  }
}
