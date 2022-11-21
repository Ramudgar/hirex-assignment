import 'package:hirexapp/api/user_api.dart';
import 'package:hirexapp/model/user.dart';

class UserRepository {
  Future<bool> registerUser(User user) async {
    return await UserAPI().registerUser(user);
  }

  Future<bool> login(String email, String password, String role) {
    return UserAPI().login(email, password, role);
  }
}
