import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../Logic/controllers/Consultations_Controllers/term_consultations_controller.dart';
import '../../../../../../../../../Utils/app_colors.dart';

DateTime selectedDate = DateTime.now();

Future<void> selectReservationDay(BuildContext context) async {
  final termConsultationsController = Get.find<TermConsultationsController>();
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.subtract(Duration(days: 0)),
      firstDate: selectedDate,
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(primary: AppColors.MAIN_COLOR)),
          child: child!,
        );
      });

  termConsultationsController.selectedDoctorDay.value = '';
  termConsultationsController.selectedDoctorDate.value = '';
  if (picked != null) {
    selectedDate = picked;
    termConsultationsController.selectedDoctorDay.value = DateFormat('EEEE').format(selectedDate).toUpperCase();
    termConsultationsController.selectedDoctorDate.value = DateFormat('yyyy-MM-dd').format(selectedDate);
    termConsultationsController.selectedDoctorDayLocale.value = DateFormat.EEEE(Localizations.localeOf(context).languageCode).format(selectedDate).toUpperCase();
    termConsultationsController.selectedDoctorDateLocale.value = DateFormat.yMd(Localizations.localeOf(context).languageCode).format(selectedDate);
    termConsultationsController.daySelectedIndex.value = -1;
    termConsultationsController.setDoctorProfileDays(
        termConsultationsController.consultationsDoctorProfileData.value.idDoctor.toString(),
    );
    selectedDate = DateTime.now();
  } else {
    selectedDate = DateTime.now();
  }
}