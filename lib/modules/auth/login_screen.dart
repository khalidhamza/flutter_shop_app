import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/enums/toast_status.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/auth/register_screen.dart';
import 'package:shop_app/network/local/local_storage.dart';
import 'package:shop_app/shared/components/buttons.dart';
import 'package:shop_app/shared/components/navigation.dart';
import 'package:shop_app/shared/cubit/login_cubit.dart';
import 'package:shop_app/shared/cubit/login_states.dart';

import '../../shared/components/toast.dart';
import '../../shared/constants.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state){

          // LoginSuccessState
          if(state is LoginSuccessState){

            ToastStatus toastStatus = state.response.status ? ToastStatus.success : ToastStatus.error;

            showToast(message: state.response.message, status: toastStatus);

            if(state.response.status && state.response.date?.token != null){
              // save the token and redirect to home page
              String? token = state.response.date?.token;
              LocalStorage.setData(key: 'user_token', value: token).then((value) {
                if(value != null && value){
                  userToken = token ?? "";
                  navigateAndFinish(context, const HomeLayout());
                }else{
                  showToast(message: somethingWentWrong, status: ToastStatus.error);
                }
              }).catchError((error){
                showToast(message: error.toString(), status: ToastStatus.error);
              });
            }
          }

          // LoginErrorState
          else if (state is LoginErrorState){
            showToast(message: state.error, status: ToastStatus.error);
          }
        },
        builder: (context, state){
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // login headline
                        Text(
                          'Login'.toUpperCase(),
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                              color: Colors.black
                          ),
                        ),

                        // padding 10
                        const SizedBox(height: 10),

                        // login sub title
                        Text(
                          'Login now to browse our offers',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.grey
                          ),
                        ),

                        // padding
                        const SizedBox(height: 50),

                        // email input
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (String? value) {
                            return value!.isEmpty ? "This field is required" : null;
                          },
                          decoration: const InputDecoration(
                              labelText: 'Email address',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email_outlined)
                          ),
                        ),

                        // padding
                        const SizedBox(height: 20),

                        // password input
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          obscureText: cubit.isHidden,
                          validator: (String? value) {
                            return value!.isEmpty ? "This field is required" : null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: const OutlineInputBorder(),
                              prefixIcon: const Icon(Icons.lock_outline),
                            suffix: GestureDetector(
                              onTap: (){
                                cubit.togglePasswordVisibility();
                              },
                              child: Icon(cubit.passwordSuffixIcon),
                            ),
                          ),
                        ),

                        // padding
                        const SizedBox(height: 20),

                        SizedBox(
                          width: double.infinity, // <-- Your width
                          height: 65,
                          child: primaryBtn(
                            label: state is ! LoginLoadingState ? 'login' : 'loading ...',
                            function: state is ! LoginLoadingState ? (){
                              if(formKey.currentState!.validate()){
                                cubit.login(
                                    email: emailController.text,
                                    password: passwordController.text
                                );
                              }
                            } : null
                          ),

                        ),
                        // login button

                        // padding
                        const SizedBox(height: 20),

                        // register
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(
                              child: const Text('Register Now!'),
                              onPressed: (){
                                navigateAndFinish(context, RegisterScreen());
                              },
                            )
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      )
    );
  }
}
