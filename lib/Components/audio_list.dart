import 'package:flutter/material.dart';
import 'package:media_booster/Components/Audio.dart';

class AudioList extends StatefulWidget {
  const AudioList({super.key});

  @override
  State<AudioList> createState() => _AudioListState();
}

class _AudioListState extends State<AudioList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.black,
      child: ListView.builder(
        itemCount: songDetails.length,
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(
              songDetails[index]['image'],
            ),
          ),
          title: Text(
            songDetails[index]['title'],
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AudioPlayer(index)));
          },
        ),
      ),
    );
  }
}
