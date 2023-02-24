import 'package:bytrh/Utils/app_colors.dart';
import 'package:bytrh/Utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Widgets/instant_consultations_cart_icon.dart';
import 'Widgets/consultations_widget.dart';
import 'Widgets/other_services_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.MAIN_COLOR,
        centerTitle: true,
        title: const Text("الرئيسية"),
        actions: [
          // ConsultationsCartIcon()
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConsultationWidget(),
              const SizedBox(height: 20),
              OtherServicesWidget()
            ],
          ),
        )
      ),
    );
  }
}
