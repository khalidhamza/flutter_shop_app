import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/register_states.dart';
import '../../models/apis/register_response_model.dart';
import '../../network/remote/endpoints.dart';
import '../../network/remote/http_dio.dart';

class RegisterCubit extends Cubit<RegisterStates>
{

  RegisterCubit() : super(RegisterInitialState());

  late RegisterResponseModel registerResponse;

  static RegisterCubit get (BuildContext context) => BlocProvider.of(context);

  IconData passwordSuffixIcon  = Icons.visibility_outlined;
  bool isHidden = true;

  void togglePasswordVisibility()
  {
    isHidden  = !isHidden;
    passwordSuffixIcon = isHidden ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(TogglePasswordVisibilityState());
  }

  void register({
    required String name,
    required String phone,
    required String email,
    required String password,
  }){
    emit(RegisterLoadingState());

    Http.post(
        path: registerEndpoint,
        data: {
          'name': name,
          'phone': phone,
          'email': email,
          'password': password,
        }
    ).then((response) {
      registerResponse = RegisterResponseModel.fromJson(response.data);
      emit(RegisterSuccessState(registerResponse));
    }).catchError((error){
      emit(RegisterErrorState(error: error.toString()));
    });
  }
}