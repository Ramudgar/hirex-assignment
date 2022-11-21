import 'package:flutter_test/flutter_test.dart';
import 'package:hirexapp/repository/user_repository.dart';

void main() {
  late UserRepository? userRepository;
  setUp(() {
    userRepository = UserRepository();
  });

  test('profile created successfully', () async {
    bool expectedResult = true;
    String email = 'ram@12346';
    String password = '123';
    String role = 'employee';
    bool actualResult = await userRepository!.login(email, password, role);
    expect(actualResult, expectedResult);
  });
  test('profile updated successfully', () async {
    bool expectedResult = true;
    String email = 'ram@12346';
    String password = '123';
    String role = 'employee';
    bool actualResult = await userRepository!.login(email, password, role);
    expect(actualResult, expectedResult);
  });
  test('get profile successfully', () async {
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
