import 'package:KonnectGenie/models/checkUserRequestModel.dart';
import 'package:KonnectGenie/models/checkUserresponseModel.dart';
import 'package:KonnectGenie/models/loginResponseModel.dart';

import 'package:KonnectGenie/models/logonRequestModel.dart';

import '../Services/auth_service.dart';

class AuthRepository {
  final AuthService _service = AuthService();

  Future<CheckUserResponseModel> checkUser(
    CheckUserRequest request,
    String token,
  ) {
    return _service.checkUser(request, token);
  }

  Future<LoginResponseModel> login(LoginRequestModel request) {
    return _service.login(request);
  }
}
