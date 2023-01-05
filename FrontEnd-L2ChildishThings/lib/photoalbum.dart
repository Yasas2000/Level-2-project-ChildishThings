// ignore_for_file: unused_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';

class PhotoAlbum extends StatefulWidget {
  const PhotoAlbum({Key? key}) : super(key: key);

  @override
  State<PhotoAlbum> createState() => _PhotoAlbumState();
}

class _PhotoAlbumState extends State<PhotoAlbum> with TickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedBackground(
          behaviour: RandomParticleBehaviour(
            options: const ParticleOptions(
               spawnMaxRadius: 50,
               spawnMinSpeed: 10.00,
               particleCount: 68,
               spawnMaxSpeed: 50,
               minOpacity: 0.3,
               spawnOpacity: 0.4,
               baseColor: Colors.blue, 
            ),
          ),
          vsync: this,
          child: Text("Animated background"),
        ),
    );
  }
}
