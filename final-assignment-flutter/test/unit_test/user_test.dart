import 'package:flutter_test/flutter_test.dart';
import 'package:hirexapp/model/user.dart';
import 'package:hirexapp/repository/user_repository.dart';

void main() {
  late UserRepository? userRepository;
  setUp(() {
    userRepository = UserRepository();
  });
  test('user registration', () async {
    bool expectedResult = true;
    User user = User(
      email: 'ram@123456',
      password: '123',
      username: 'ram2',
      role: 'employee',
    );
    bool actualResult = await userRepository!.registerUser(user);
    expect(actualResult, expectedResult);
  });

  test('user login', () async {
    bool expectedResult = true;
    String email = 'ram@12346';
    String password = '123';
    String role = 'employee';
    bool actualResult = await userRepository!.login(email, password, role);
    expect(actualResult, expectedResult);
  });

  tearDown(() {
    userRepository = null;
  });
}
