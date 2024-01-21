import 'package:shop_app/models/apis/login_response_model.dart';

import '../../models/apis/register_response_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
    final RegisterResponseModel response;
    RegisterSuccessState(this.response);
}

class RegisterErrorState extends RegisterStates {
    final String error;
    RegisterErrorState({required this.error});
}

class TogglePasswordVisibilityState extends RegisterStates {}

