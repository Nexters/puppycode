import 'package:get/get.dart';
import 'package:puppycode/apis/models/user.dart';
import 'package:puppycode/shared/http.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class UserController extends GetxController {
  var user = Rxn<User>();
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final data = await HttpService.getOne('users', shouldSkipLogin: false);
      user.value = User(data);
      if (user.value?.id != null) {
        analytics.setUserId(id: user.value!.id.toString());
        analytics.setUserProperty(
            name: 'nickname', value: user.value!.nickname);
      }
    } catch (err) {
      return;
    }
  }

  Future<void> refreshData() async {
    await fetchUserData();
  }
}
