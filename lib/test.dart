import 'dart:io';

import 'package:flutter/material.dart';
import 'package:music_player/FilePicker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/FilePicker.dart';

class Test extends StatefulWidget {
  Test({super.key});
  late List<String?> files=[];
  bool Play=false;
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
                      if(file.isNotEmpty){
                        widget.files = file;
                      print("---------------------------------------------");
                      print(widget.files.toString());
                      print("---------------------------------------------");
                    }
                    }),
                    })
                  }),
              Expanded(
                child:
                ListView.builder(itemBuilder: (context, index) {
                  return ListTile(leading: Icon(Icons.music_note),title: Text("hii"),onTap: (){
                    _audioPlayer.setUrl(widget.files[index].toString());
                    
                    if(widget.Play){
                      _audioPlayer.pause();
                      setState(() {
                        widget.Play!=widget.Play;
                      });

                    }else{
                      _audioPlayer.play();
                      setState(() {
                        widget.Play!=widget.Play;
                      });
                    }
                  },);
                },itemCount: widget.files.length,),
              ),
              //( widget.files.length > 0) ? ListView.builder(itemBuilder: (context, index) {
              //    return ListTile(leading: Icon(Icons.music_note),title: Text("hii"));
              //},itemCount: widget.files.length,):Text("")
            ],
          ),
        ))
    );
  }


  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
