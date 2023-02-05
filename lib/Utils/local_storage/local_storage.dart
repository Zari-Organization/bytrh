import 'dart:io';

import 'package:get_storage/get_storage.dart';

class LocaleStorage {
  /// Write
  void saveLanguage(String? language, bool arabic, bool english) async {
    await GetStorage().write('lang', language);
    await GetStorage().write('arabic', arabic);
    await GetStorage().write('english', english);
  }

  /// Read
  Future<String>? get languageSelected async {
    if (await GetStorage().read('lang') == null) {
      // return 'ar';
      return Platform.localeName.split("_")[0];
    }
    return await GetStorage().read('lang');
  }

  Future<bool>? get arabicSelected async {
    if (await GetStorage().read('arabic') == null) {
      return true;
    }
    return await GetStorage().read('arabic');
  }

  Future<bool>? get englishSelected async {
    if (await GetStorage().read('english') == null) {
      return false;
    }
    return await GetStorage().read('english');
  }
}
