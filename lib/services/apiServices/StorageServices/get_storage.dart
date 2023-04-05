import 'package:get_storage/get_storage.dart';
import '../../../models/registration/userRegResponse.dart';

class StorageCRUD {
  static final box = GetStorage();

  static Future write(String key, dynamic value) async {
    await box.write(key, value);
  }

  static Future read(String key) async {
    await box.read(key);
  }

  static Future remove(String key) async {
    await box.remove(key);
  }

  static Future erase() async {
    await box.erase();
  }

  static UserRegResponse getUser() {
    UserRegResponse userRegResponse = userRegResponseFromJson(box.read(StorageKeys.userData));

    return userRegResponse;
  }

  static Future<void> saveUser(String data) async {
    await box.write(StorageKeys.userData, data);
  }
}

class StorageKeys {
  static String userData = "userData";
}
