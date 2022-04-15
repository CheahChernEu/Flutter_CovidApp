
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'main.dart';
import 'package:loading_animations/loading_animations.dart';


class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminHomePage> with WidgetsBindingObserver {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  final asset = 'assets/video/covid19.mp4';

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.asset(asset)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => _controller.play());
    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
  }


  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DemoLocalizations.of(context).adminHomepageTitle),
      ),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the VideoPlayerController has finished initialization, use
                // the data it provides to limit the aspect ratio of the video.
                return AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  // Use the VideoPlayer widget to display the video.
                  child: VideoPlayer(_controller),

                );
              } else {
                // If the VideoPlayerController is still initializing, show a
                // loading spinner.
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [

                Text(DemoLocalizations.of(context).message,
                  textAlign: TextAlign.right,),

                // Expanded( child: Text("", textAlign: TextAlign.right,)),
                Spacer(),

                FloatingActionButton(

                  onPressed: () {
                    // Wrap the play or pause in a call to `setState`. This ensures the
                    // correct icon is shown.
                    setState(() {
                      // If the video is playing, pause it.
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                      } else {
                        // If the video is paused, play it.
                        _controller.play();
                      }
                    });
                  },
                  // Display the correct icon depending on the state of the player.
                  child: Icon(
                    _controller.value.isPlaying ? Icons.pause : Icons
                        .play_arrow,
                  ),
                ),

              ],
            ),


            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                ElevatedButton(
                  child: Text(DemoLocalizations.of(context).caseBtn),
                  onPressed: () {
                    final message = SnackBar(
                      content: LoadingFilling.square(),
                    );
                    // It returns true if the form is valid, otherwise returns false
                    Navigator.pushNamed(context, '/adminDashboard');
                    ScaffoldMessenger.of(context).showSnackBar(message);

                  },
                ),

                ElevatedButton(
                  child: Text(DemoLocalizations.of(context).clinicBtn),
                  onPressed: () {
                    final message = SnackBar(
                      content: LoadingFilling.square(),
                    );
                    // It returns true if the form is valid, otherwise returns false
                    Navigator.pushNamed(context, '/adminClinicDashboard');
                    ScaffoldMessenger.of(context).showSnackBar(message);

                  },
                ),

              ],
            ),

          ]),

    );
  }
}

