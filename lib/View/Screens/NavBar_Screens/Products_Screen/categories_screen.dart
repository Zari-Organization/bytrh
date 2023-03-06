import 'package:bytrh/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Utils/app_colors.dart';
import '../Widgets/advertisements_Widget.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.MAIN_COLOR,
        centerTitle: true,
        title: const Text("الفئات"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            AdvertisementsWidget(),
            const SizedBox(height: 20),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10
              ),
              itemCount: 8,
              shrinkWrap: true,
              padding: const EdgeInsets.all(16.0),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    Get.toNamed(Routes.subCategoriesScreen);
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
                          "مواشي",
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
                            image: "https://www.grasstecgroup.com/wp-content/uploads/2021/04/15-HolFr-Bulling-Heifers-5-768x576.jpg",
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
