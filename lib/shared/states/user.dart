import 'package:get/get.dart';
import 'package:puppycode/apis/models/user.dart';
import 'package:puppycode/shared/http.dart';

class UserController extends GetxController {
  var user = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final data = await HttpService.getOne('users', shouldSkipLogin: false);
      user.value = User(data);
    } catch (err) {
      return;
    }
  }

  Future<void> refreshData() async {
    await fetchUserData();
  }
}
