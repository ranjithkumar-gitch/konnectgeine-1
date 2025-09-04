import 'package:KonnectGenie/models/checkUserRequestModel.dart';
import 'package:KonnectGenie/models/checkUserresponseModel.dart';

import 'package:KonnectGenie/models/logonRequestModel.dart';

import '../Services/auth_service.dart';

class AuthRepository {
  final AuthService _service = AuthService();

  Future<CheckUserResponseModel> checkUser(CheckUserRequest request) {
    return _service.checkUser(request);
  }

  Future<Map<String, dynamic>> login(LoginRequestModel request) {
    return _service.login(request);
  }
}
