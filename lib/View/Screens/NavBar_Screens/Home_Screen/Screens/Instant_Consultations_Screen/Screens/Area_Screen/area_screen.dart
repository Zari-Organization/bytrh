import 'package:bytrh/Utils/app_colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Widgets/filter_button.dart';
import 'Widgets/animals_category_filter_widget.dart';
import 'Widgets/area_filter_widget.dart';
import 'Widgets/area_textField_widget.dart';
import 'Widgets/consultations_doctors_list_widget.dart';

class AreaScreen extends StatelessWidget {
  AreaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                  "https://images.unsplash.com/photo-1644675272883-0c4d582528d8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80"),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                // Expanded(child:    DropdownButton(
                //
                //   // Initial Value
                //   value: "Item 1",
                //
                //   // Down Arrow Icon
                //   icon: const Icon(Icons.keyboard_arrow_down),
                //
                //   // Array list of items
                //   items: [
                //     'Item 1',
                //     'Item 2',
                //     'Item 3',
                //     'Item 4',
                //     'Item 5',
                //   ].map((String items) {
                //     return DropdownMenuItem(
                //       value: items,
                //       child: Text(items),
                //     );
                //   }).toList(),
                //   // After selecting the desired option,it will
                //   // change button value to selected value
                //   onChanged: (String? newValue) {
                //     // dropdownvalue = newValue!;
                //   },
                // ),),
                // Expanded(child: FilterButton(title: "أختر المنطقة"),),
                // DropdownButton<String>(
                //   items: <String>['A', 'B', 'C', 'D'].map((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                //   onChanged: (_) {},
                // ),
                // Expanded(child: DropdownButton(
                //   hint:Text('Dropdown'),
                //   isExpanded: true,
                //   iconSize: 30.0,
                //   style: TextStyle(color: Colors.blue),
                //   items: ['One', 'Two', 'Three'].map(
                //         (val) {
                //       return DropdownMenuItem<String>(
                //         value: val,
                //         child: Text(val),
                //       );
                //     },
                //   ).toList(),
                //   onChanged: (val) {
                //     // setState(
                //     //       () {
                //     //     _dropDownValue = val;
                //     //   },
                //     // );
                //   },
                // ),),

                Expanded(
                  child: AreaWidgetFilter(),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: AnimalsCategoryWidgetFilter(),
                ),
              ],
            ),
            AreaTextFieldWidget(),
            SizedBox(height: 30),
            ConsultationsDoctorsListWidget(),
          ],
        ),
      ),
    );
  }
}
