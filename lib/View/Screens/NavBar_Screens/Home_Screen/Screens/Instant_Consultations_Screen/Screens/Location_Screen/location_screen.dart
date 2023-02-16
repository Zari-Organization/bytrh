import 'package:bytrh/Utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Widgets/filter_button.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                      "https://images.unsplash.com/photo-1644675272883-0c4d582528d8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80"),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilterButton(title: "أختر التصنيف"),
                ),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: AppColors.BLACK_COLOR, height: .8),
                    cursorColor: AppColors.MAIN_COLOR,
                    // textAlign: TextAlign.end,
                    decoration: InputDecoration(
                        fillColor: AppColors.GREY_Light_COLOR,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'أبحث عن دكتور .....',
                        suffixIcon: Icon(
                          Icons.search,
                          color: AppColors.MAIN_COLOR,
                        ),
                        hintStyle: TextStyle(
                            color: AppColors.GREY_COLOR, fontSize: 13)),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "الأطباء المتاحون الآن",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                SizedBox(height: 16),
                ListView.separated(
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (BuildContext context, index) {
                    return InkWell(
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.zero,
                        elevation: 2,
                        child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            // contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            tileColor: Color(0xffFAFAFA),
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor: AppColors.MAIN_COLOR,
                              backgroundImage: NetworkImage(
                                  "https://th.bing.com/th/id/OIP.UbDbXEqJhFcicqR0AeKahwAAAA?pid=ImgDet&w=265&h=360&rs=1"),
                            ),
                            title: Text(
                              "د.محمود منير",
                              style: TextStyle(fontSize: 16),
                            ),
                            subtitle: Text(
                              "تخصص",
                              style: TextStyle(fontSize: 12),
                            ),
                            trailing: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "90 ر.س",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Expanded(
                                  child: Radio(
                                    value: false,
                                    groupValue: true,
                                    onChanged: (value) {},
                                  ),
                                ),
                              ],
                            )),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {},
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(vertical: 15),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(AppColors.MAIN_COLOR),
              foregroundColor: MaterialStateProperty.all(AppColors.WHITE_COLOR),
            ),
            child: Text(
              "طلب إستشارة",
              style: const TextStyle(color: AppColors.WHITE_COLOR),
            ),
          ),
        ),
      ],
    );
  }
}
