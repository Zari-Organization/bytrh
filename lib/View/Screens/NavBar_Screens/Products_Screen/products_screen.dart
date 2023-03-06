import 'package:bytrh/Utils/app_alerts.dart';
import 'package:bytrh/Utils/app_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../Routes/routes.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_constants.dart';
import '../../../../Utils/app_images.dart';
import '../Widgets/advertisements_Widget.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.MAIN_COLOR,
        centerTitle: true,
        title: const Text("المنتجات"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 9,
                  mainAxisSpacing: 9,
                  childAspectRatio: 0.8),
              itemCount: 8,
              shrinkWrap: true,
              padding: const EdgeInsets.all(16.0),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.toNamed(Routes.productDetailsScreen);
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.GREY_Light_COLOR,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    height: 100,
                                    width: double.infinity,
                                    imageUrl: "https://th.bing.com/th/id/OIP.Oy8TZE-0Li-zML05NxunVAHaFi?pid=ImgDet&rs=1",
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
                                IconButton(
                                  onPressed: () {},
                                  icon: CircleAvatar(
                                    backgroundColor:
                                        AppColors.WHITE_COLOR.withOpacity(0.7),
                                    radius: 17,
                                    child: SvgPicture.asset(
                                      AppIcons.favorite_icon,
                                      color: AppColors.BLACK_COLOR,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "اسم الحيوان",
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.BLACK_COLOR,
                                fontWeight: FontWeight.bold,
                              ),
                              // maxLines: 2,
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  "السعر يبدأ من:",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.BLACK_COLOR,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  // maxLines: 2,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "670 ر.س",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.MAIN_COLOR,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  // maxLines: 2,
                                ),
                              ],
                            )
                          ],
                        ),
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
