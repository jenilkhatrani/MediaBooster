import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({super.key});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  int currentvideo = 0;
  List<Map<String, dynamic>> Videos = [
    {'Name': 'video 1', 'video': 'assets/video/video1.mp4'},
    {'Name': 'video 2', 'video': 'assets/video/video2.mp4'},
    {'Name': 'video 3', 'video': 'assets/video/video3.mp4'},
    {'Name': 'video 4', 'video': 'assets/video/video4.mp4'},
    {'Name': 'video 5', 'video': 'assets/video/video5.mp4'},
    {'Name': 'video 6', 'video': 'assets/video/video6.mp4'},
    {'Name': 'video 7', 'video': 'assets/video/video7.mp4'},
    {'Name': 'video 8', 'video': 'assets/video/video8.mp4'},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playVideo(currentvideo);
  }

  playVideo(int index) async {
    videoPlayerController = VideoPlayerController.asset(Videos[index]['video']);
    await videoPlayerController.initialize();

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.black,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: (chewieController == null)
                ? Center(child: CircularProgressIndicator())
                : Chewie(controller: chewieController!),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: Videos.length,
            itemBuilder: (context, index) {
              return ListTile(
                selected: currentvideo == index,
                selectedTileColor: Colors.black,
                selectedColor: Colors.grey,
                title: Text(Videos[index]['Name']!),
                onTap: () {
                  setState(() {
                    currentvideo = index;
                  });
                  playVideo(index);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
