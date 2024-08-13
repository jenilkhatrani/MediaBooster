import 'package:flutter/material.dart';
import 'package:media_booster/Components/Video.dart';
import 'package:media_booster/Components/audio_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text('Tab Bar',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          bottom: const TabBar(
              labelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.red,
              indicatorWeight: 5,
              tabs: [
                Tab(
                  text: ('Home'),
                  icon: Icon(
                    Icons.audiotrack,
                    color: Colors.white,
                  ),
                ),
                Tab(
                  text: ('Chat'),
                  icon: Icon(
                    Icons.video_call,
                    color: Colors.white,
                  ),
                ),
              ]),
        ),
        body: const TabBarView(children: [
          AudioList(),
          VideoPlayer(),
        ]),
      ),
    );
  }
}
