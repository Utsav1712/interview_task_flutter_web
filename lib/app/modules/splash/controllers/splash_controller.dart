import 'package:get/get.dart';
import 'package:interview_task_flutter_web/app/routes/app_pages.dart';



class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
     return Get.offAndToNamed(Routes.LOGIN);
    });
  }
}
