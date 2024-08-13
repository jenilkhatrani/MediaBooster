import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:media_booster/Provider/AudioProvider.dart';
import 'package:provider/provider.dart';

class AudioPlayer extends StatefulWidget {
  late int? currentIndex;
  AudioPlayer(this.currentIndex, {super.key});

  @override
  State<AudioPlayer> createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  late int currentIndex;
  @override
  void initState() {
    super.initState();
    assetsAudioPlayer.open(
      Playlist(audios: audioPlaylist),
      autoStart: false,
    );
    currentIndex = widget.currentIndex!;
    playAudio(currentIndex);
  }

  void playAudio(int index) {
    assetsAudioPlayer.playlistPlayAtIndex(index);
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
        backgroundColor: Colors.grey,
      ),
      body: Container(
        color: Colors.grey,
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: songDetails.length,
            options: CarouselOptions(
              initialPage: currentIndex,
              height: 380,
              autoPlay: false,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
                playAudio(index); // Play audio when the slide changes
              },
            ),
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              return Container(
                width: MediaQuery.of(context).size.width,
                decoration:
                    const BoxDecoration(color: Colors.black, boxShadow: [
                  BoxShadow(
                    offset: Offset(BorderSide.strokeAlignOutside,
                        BorderSide.strokeAlignCenter),
                    color: Colors.grey,
                    blurRadius: 20.0,
                  ),
                ]),
                child: Column(
                  children: [
                    SizedBox(
                        height: 250,
                        width: 200,
                        child: Image.asset(songDetails[itemIndex]['image'])),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      songDetails[itemIndex]['title'],
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      songDetails[itemIndex]['artist'],
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  if (currentIndex > 0) {
                    _carouselController.previousPage();
                    playAudio(currentIndex - 1);
                  }
                },
                icon: const Icon(
                  Icons.skip_previous,
                  size: 30,
                  color: Colors.black,
                ),
              ),
              (Provider.of<Audioprovider>(
                        context,
                      ).audioModel.isPlay ==
                      false)
                  ? IconButton(
                      onPressed: () async {
                        await assetsAudioPlayer.play();
                        Provider.of<Audioprovider>(context, listen: false)
                            .AudioPlay();
                      },
                      icon: const Icon(
                        Icons.play_arrow,
                        size: 30,
                        color: Colors.black,
                      ))
                  : IconButton(
                      onPressed: () async {
                        await assetsAudioPlayer.pause();
                        Provider.of<Audioprovider>(context, listen: false)
                            .AudioPlay();
                      },
                      icon: const Icon(
                        Icons.pause,
                        size: 30,
                        color: Colors.black,
                      )),
              IconButton(
                onPressed: () {
                  if (currentIndex < songDetails.length - 1) {
                    _carouselController.nextPage();
                    playAudio(currentIndex + 1);
                  }
                },
                icon: const Icon(
                  Icons.skip_next,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder(
                stream: assetsAudioPlayer.currentPosition,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('ERROR : ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    Duration? currentPosition = snapshot.data;
                    Duration totalDuration =
                        (assetsAudioPlayer.current.valueOrNull == null)
                            ? const Duration(seconds: 0)
                            : assetsAudioPlayer
                                .current.valueOrNull!.audio.duration;

                    return Row(
                      children: [
                        Text("${currentPosition.toString().split(".")[0]} "),
                        Slider(
                          activeColor: Colors.black,
                          min: 0,
                          max: totalDuration.inSeconds.toDouble(),
                          value: currentPosition?.inSeconds.toDouble() ?? 0,
                          onChanged: (val) {
                            assetsAudioPlayer.seek(
                              Duration(
                                seconds: val.toInt(),
                              ),
                            );
                          },
                        ),
                        Text("${totalDuration.toString().split(".")[0]} "),
                      ],
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          )
        ]),
      ),
    );
  }
}

final List<Map<String, dynamic>> songDetails = [
  {
    "title": "shiv 1",
    "image": "assets/image/shiv1.jpeg",
    "artist": "hansraj raghuwanshi"
  },
  {
    "title": "shiv 2",
    "image": "assets/image/shiv2.jpeg",
    "artist": "hansraj raghuwanshi"
  },
  {
    "title": "shiv 3",
    "image": "assets/image/shiv3.jpeg",
    "artist": "hansraj raghuwanshi"
  },
  {
    "title": "shiv 4",
    "image": "assets/image/shiv4.jpeg",
    "artist": "hansraj raghuwanshi"
  },
  {
    "title": "dakla 1",
    "image": "assets/image/dakla1.jpeg",
    "artist": "aghori muzik"
  },
  {
    "title": "dakla 2",
    "image": "assets/image/dakla2.jpeg",
    "artist": "aishwariyajoshi"
  },
  {
    "title": "dakla 3",
    "image": "assets/image/dakla3.jpeg",
    "artist": "bandish"
  },
  {
    "title": "dakla 5",
    "image": "assets/image/dakla5.jpeg",
    "artist": "aghori muzik"
  },
];

final List<Audio> audioPlaylist = [
  Audio("assets/Audio/shiv1.mp3"),
  Audio("assets/Audio/shiv2.mp3"),
  Audio("assets/Audio/shiv3.mp3"),
  Audio("assets/Audio/shiv4.mp3"),
  Audio("assets/Audio/dakla1.mp3"),
  Audio("assets/Audio/dakla2.mp3"),
  Audio("assets/Audio/dakla3.mp3"),
  Audio("assets/Audio/dakla5.mp3"),
];
