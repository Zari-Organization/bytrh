import 'package:bytrh/Utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpecializationWidget extends StatelessWidget {
  const SpecializationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
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
                    hintText: 'أبحث عن......',
                    suffixIcon: Icon(
                      Icons.search,
                      color: AppColors.MAIN_COLOR,
                    ),
                    hintStyle:
                        TextStyle(color: AppColors.GREY_COLOR, fontSize: 13)),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network("https://images.unsplash.com/photo-1644675272883-0c4d582528d8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80"),
            ),
             SizedBox(
              height: 16,
            ),
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
                      title: Text(
                        "أمراض باطنة",
                        style: TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(
                        "3 دكاترة",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
