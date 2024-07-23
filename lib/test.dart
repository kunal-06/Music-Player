import 'dart:io';

import 'package:flutter/material.dart';
import 'package:music_player/FilePicker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/FilePicker.dart';

class Test extends StatefulWidget {
  Test({super.key});
  late List<File> files=[];

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  late String _localFilePath;


  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                child: const Text("Import"),
                onPressed: () async => {
                  await pickAndPlayAudio().then((file)=>{
                    setState(() {
                      if(files!=null) {
                        files!.addAll(file);
                      }else{
                        files=file;
                      }
                      print("--------------------------------------${files?.length}TT");
                      print((files?.length !=null && files!.isNotEmpty));
                    })
                  })
                },
              ),
              (files?.length !=null && files!.isNotEmpty) ? Expanded(child: ListView.builder(itemBuilder: (context, index) {
                return ListTile(leading: Icon(Icons.music_note),title: Text(files![index].path.toString().split("/")[files![index].path.toString().split("/").length-1].replaceFirst(".mp3", "")));
              },itemCount: files?.length,)):Center(child: Text("List Is Empty",style: TextStyle(fontSize: 30),),)
            ],
          ),
        ))
    );
  }

  void _pause() {
    _audioPlayer.pause();
  }

  void _stop() {
    _audioPlayer.stop();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
