import 'package:bytrh/Utils/app_images.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Logic/controllers/Home_Controllers/home_controllers.dart';
import '../../../../../Utils/app_colors.dart';
import '../../../../../Utils/app_constants.dart';

class OurNewWidget extends StatelessWidget {
  OurNewWidget({Key? key}) : super(key: key);
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (homeController.ourNewList.isEmpty) {
        return const SizedBox();
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              // onTap: () async {},
              leading: Text(
                "جديدنا",
                style: TextStyle(color: AppColors.BLACK_COLOR, fontSize: 20),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "عرض الكل",
                    style: const TextStyle(
                      color: AppColors.MAIN_COLOR,
                      fontSize: 12,
                      // decoration: TextDecoration.underline,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.MAIN_COLOR,
                    size: 15,
                  )
                ],
              ),
            ),
            SizedBox(
              // width: double.infinity,
              height: 180,
              child: ListView.separated(
                itemCount: homeController.ourNewList.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Container(
                        width: AppConstants.mediaWidth(context) / 1.8,
                        // margin: const EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                          color: AppColors.GREY_Light_COLOR,
                          borderRadius: BorderRadius.circular(15),),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: double.infinity,
                                  imageUrl: homeController
                                      .ourNewList[index].petPicture,
                                  placeholder: (context, url) => Image.asset(
                                    AppImages.placeholder,
                                    height: 80,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                        AppImages.placeholder,
                                        height: 80,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                homeController.ourNewList[index].petName,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: AppColors.BLACK_COLOR,
                                    // fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis),
                                // maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(width: 10),
              ),
            ),
          ],
        );
      }
    });
  }
}
