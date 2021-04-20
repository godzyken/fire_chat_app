import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/channel_controller.dart';

class ChannelView extends GetView<ChannelController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChannelView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ChannelView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
