import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/core/app_colors.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Secure Access",
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.accent,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.dark().copyWith(
          primary: AppColors.accent,
          secondary: AppColors.accent,
          surface: AppColors.surface,
        ),
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
