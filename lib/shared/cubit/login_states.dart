import 'package:shop_app/models/apis/login_response_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
    final LoginResponseModel response;
    LoginSuccessState(this.response);
}

class LoginErrorState extends LoginStates {
    final String error;
    LoginErrorState({required this.error});
}


class TogglePasswordVisibilityState extends LoginStates {}

