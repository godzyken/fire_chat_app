import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/games_controller.dart';

class GamesView extends GetView<GamesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GamesView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'GamesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
