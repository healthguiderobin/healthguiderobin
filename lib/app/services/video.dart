import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerView extends StatefulWidget {
  final String url;
  const VideoPlayerView({super.key, required this.url});

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late VideoPlayerController _vCon;
  late ChewieController _cCon;
  bool _isInitialized = false;
  double _scale = 1.0;
  double _rotation = 0.0;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      _vCon = VideoPlayerController.networkUrl(
        Uri.parse(widget.url),
      );
      await _vCon.initialize();

      _cCon = ChewieController(
        videoPlayerController: _vCon,
        aspectRatio: _vCon.value.aspectRatio,
        autoInitialize: true,
        autoPlay: false,
        looping: false,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              'Error loading video: $errorMessage',
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      );

      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      print('Error initializing video player: $e');
    }
  }

  @override
  void dispose() {
    if (_isInitialized) {
      _vCon.dispose();
      _cCon.dispose();
    }
    super.dispose();
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _scale = details.scale;
      _rotation = details.rotation;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return GestureDetector(
      onScaleUpdate: _handleScaleUpdate,
      child: Transform.scale(
        scale: _scale,
        child: Transform.rotate(
          angle: _rotation,
          child: AspectRatio(
            aspectRatio: _vCon.value.aspectRatio,
            child: Chewie(
              controller: _cCon,
            ),
          ),
        ),
      ),
    );
  }
}
