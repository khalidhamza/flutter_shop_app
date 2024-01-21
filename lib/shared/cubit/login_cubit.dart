import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/apis/login_response_model.dart';
import 'package:shop_app/shared/cubit/login_states.dart';

import '../../network/remote/endpoints.dart';
import '../../network/remote/http_dio.dart';

class LoginCubit extends Cubit<LoginStates>
{

  LoginCubit() : super(LoginInitialState());

  late LoginResponseModel loginResponse;

  static LoginCubit get (BuildContext context) => BlocProvider.of(context);

  IconData passwordSuffixIcon  = Icons.visibility_outlined;
  bool isHidden = true;

  void togglePasswordVisibility()
  {
    isHidden  = !isHidden;
    passwordSuffixIcon = isHidden ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(TogglePasswordVisibilityState());
  }

  void login({
    required String email,
    required String password,
  }){
    emit(LoginLoadingState());

    Http.post(
        path: loginEndpoint,
        data: {
          'email': email,
          'password': password,
        }
    ).then((response) {
      // print(response.data);
      loginResponse = LoginResponseModel.fromJson(response.data);
      emit(LoginSuccessState(loginResponse));
    }).catchError((error){
      // print("Error");
      // print(error.toString());
      emit(LoginErrorState(error: error.toString()));
    });
  }
}