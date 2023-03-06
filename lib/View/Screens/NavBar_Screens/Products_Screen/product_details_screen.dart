import 'package:bytrh/Utils/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../Logic/controllers/Adoption_Controllers/adoption_controller.dart';
import '../../../../../../Utils/app_colors.dart';
import '../../../../../../Utils/app_icons.dart';
import '../../../../../../Utils/app_images.dart';
import '../../../Widgets/auth_button.dart';
import '../Home_Screen/Screens/Adoption_Screens/Widgets/pet_details_widget.dart';
import 'Widgets/product_Details_Widget.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE_COLOR,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.MAIN_COLOR,
        centerTitle: true,
        title: Text("التفاصيل"),
      ),
        bottomSheet: Container(
          padding: EdgeInsets.all(16),
          color: AppColors.WHITE_COLOR,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                  onPressed: (){},
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 10)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(AppColors.SECOND_COLOR),
                    foregroundColor: MaterialStateProperty.all(AppColors.WHITE_COLOR),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppIcons.cart_white_icon),
                      SizedBox(width: 10),
                      Text(
                        "شراء",
                        style: TextStyle(fontSize: 17),
                      ),

                    ],
                  )
              )
            ],
          ),
        ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  width: double.infinity,
                  fit: BoxFit.cover,
                  height: AppConstants.mediaHeight(context) / 2.5,
                  imageUrl: "https://th.bing.com/th/id/OIP.Oy8TZE-0Li-zML05NxunVAHaFi?pid=ImgDet&rs=1",
                  placeholder: (context, url) => Image.asset(
                    AppImages.placeholder,
                    width: double.infinity,
                    fit: BoxFit.fitHeight,
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    AppImages.placeholder,
                    width: double.infinity,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: AppConstants.mediaHeight(context) / 3),
                  child: SizedBox(
                    width: double.infinity,
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            )),
                        margin: EdgeInsets.only(bottom: 50),
                        elevation: 0,
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "اسم الحيوان ........................",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 12),
                              Text(
                                " 789 ر.س",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.MAIN_COLOR,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 12),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.location_icon,
                                    color: AppColors.GREY_COLOR,
                                  ),
                                  Text("المدينة المنورة",
                                    style: TextStyle(
                                        color: AppColors.GREY_COLOR),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              ProductDetailsWidget(),
                              SizedBox(height: 20),
                              Text(
                                "التفاصيل",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "لوريم إيبسوم هو ببساطة نص شكلي (بمعنى أن الغاية هي الشكل وليس المحتوى) ويُستخدم في صناعات المطابع ودور النشر. كان لوريم إيبسوم ولايزال المعيار للنص الشكلي منذ القرن الخامس عشر عندما قامت مطبعة مجهولة برص مجموعة من الأحرف بشكل عشوائي أخذتها من نص،",
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(height: 20),
                               Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "الألبوم",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  SizedBox(
                                    height: 100,
                                    child: ListView.separated(
                                      itemCount: 2,
                                      shrinkWrap: true,
                                      scrollDirection:
                                      Axis.horizontal,
                                      physics:
                                      const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(
                                              17),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            height: 70,
                                            width: 100,
                                            imageUrl: "",
                                            placeholder:
                                                (context, url) =>
                                                Image.asset(
                                                  AppImages.placeholder,
                                                  height: 70,
                                                  width: 100,
                                                  fit: BoxFit.cover,
                                                ),
                                            errorWidget: (context,
                                                url, error) =>
                                                Image.asset(
                                                  AppImages.placeholder,
                                                  height: 70,
                                                  width: 100,
                                                  fit: BoxFit.cover,
                                                ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context,
                                          index) =>
                                      const SizedBox(width: 8),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    width: 60,
                                    height: double.infinity,
                                    imageUrl: "",
                                    placeholder: (context, url) =>
                                        Image.asset(
                                          width: 60,
                                          height: double.infinity,
                                          AppImages.user_placeholder,
                                        ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                          width: 60,
                                          height: double.infinity,
                                          AppImages.user_placeholder,
                                        ),
                                  ),
                                ),
                                title: Text(
                                  "محمد هشام",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: AppColors.SECOND_COLOR,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                subtitle: Row(
                                  children: [
                                    SvgPicture.asset(AppIcons.call_icon,
                                        color: AppColors.GREY_COLOR,
                                        width: 16),
                                    SizedBox(width: 5),
                                    Directionality(
                                        textDirection:
                                        TextDirection.ltr,
                                        child: Text(
                                          "05508799",
                                          style: TextStyle(
                                              fontSize: 13,
                                              overflow: TextOverflow
                                                  .ellipsis),
                                        ))
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: TextButton(
                                        style: ButtonStyle(
                                            padding:
                                            MaterialStateProperty.all(
                                                EdgeInsets.symmetric(
                                                    vertical: 15)),
                                            shape:
                                            MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      15)),
                                            ),
                                            backgroundColor:
                                            MaterialStateProperty.all(
                                                AppColors.SECOND_COLOR)),
                                        onPressed: () {},
                                        child: SvgPicture.asset(
                                            AppIcons.message_icon,
                                            // color: AppColors.WHITE_COLOR,
                                            width: 16),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: TextButton(
                                        style: ButtonStyle(
                                            padding:
                                            MaterialStateProperty.all(
                                                EdgeInsets.symmetric(
                                                    vertical: 15)),
                                            shape: MaterialStateProperty
                                                .all(RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: AppColors
                                                        .SECOND_COLOR),
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    15)))),
                                        onPressed: () {

                                        },
                                        child: SvgPicture.asset(
                                            AppIcons.call_icon,
                                            color: AppColors.SECOND_COLOR,
                                            width: 16),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 50),
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}
