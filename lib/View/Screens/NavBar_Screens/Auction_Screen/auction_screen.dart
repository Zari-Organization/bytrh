import 'package:flutter/material.dart';

import '../../../../Utils/app_colors.dart';


class AuctionScreen extends StatelessWidget {
  const AuctionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.MAIN_COLOR,
        centerTitle: true,
        title: Text("مزاد"),
      ),
    );
  }
}
