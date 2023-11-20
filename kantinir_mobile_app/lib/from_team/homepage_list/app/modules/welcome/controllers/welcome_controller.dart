import 'package:coffee/app/routes/app_pages.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  RxInt selectedIndex = 0.obs;

  onNavigationChanged(value) {
    switch (value) {
      case 1:
        Get.toNamed(Routes.ITEM_VIEW);

        break;

      case 2:
        Get.toNamed(Routes.CART);
        break;

      default:
        Get.toNamed(Routes.HOME);
        break;
    }

    selectedIndex.value = value;
  }
}
