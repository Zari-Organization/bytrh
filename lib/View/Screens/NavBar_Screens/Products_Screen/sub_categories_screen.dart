import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Routes/routes.dart';
import '../../../../Utils/app_colors.dart';
import '../Widgets/advertisements_Widget.dart';


class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.MAIN_COLOR,
        centerTitle: true,
        title: const Text("مواشي"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10
              ),
              itemCount: 5,
              shrinkWrap: true,
              padding: const EdgeInsets.all(16.0),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    Get.toNamed(Routes.productsScreen);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GridTile(
                      footer: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        color: Colors.black26,
                        alignment: Alignment.bottomCenter,
                        child: const Text(
                          "ماعز",
                          style: TextStyle(
                            height: 1.3,
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      child: Container(
                          color: Colors.white,
                          child:  FadeInImage.assetNetwork(
                            width: double.infinity,
                            height: double.infinity,
                            placeholder: 'assets/images/loading.gif',
                            image: "https://th.bing.com/th/id/OIP.Oy8TZE-0Li-zML05NxunVAHaFi?pid=ImgDet&rs=1",
                            fit: BoxFit.cover,
                          )
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
