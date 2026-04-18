import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_task_flutter_web/app/modules/login/controllers/login_controller.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_text_styles.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: AppColors.accent.withOpacity(0.3)),
                  ),
                  child: const Icon(Icons.shield_outlined, color: AppColors.accent, size: 80),
                ),
                const SizedBox(height: 32),
                Text(
                  "Play crypto 360",
                  style: AppTextStyles.heading1.copyWith(
                    letterSpacing: 8,
                    fontSize: 48,
                  ),
                ),
                const SizedBox(height: 16),
                const SizedBox(
                  width: 200,
                  child: LinearProgressIndicator(
                    backgroundColor: AppColors.surface,
                    color: AppColors.accent,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
