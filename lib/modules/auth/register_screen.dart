import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/auth/login_screen.dart';
import 'package:shop_app/shared/components/navigation.dart';
import 'package:shop_app/shared/cubit/register_cubit.dart';
import 'package:shop_app/shared/cubit/register_states.dart';
import '../../enums/toast_status.dart';
import '../../layout/home_layout.dart';
import '../../network/local/local_storage.dart';
import '../../shared/components/buttons.dart';
import '../../shared/components/toast.dart';
import '../../shared/constants.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  var formKey = GlobalKey<FormState>();
  final nameController    = TextEditingController();
  final phoneController   = TextEditingController();
  final emailController   = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state){

            // RegisterSuccessState
            if(state is RegisterSuccessState){

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

            // RegisterErrorState
            else if (state is RegisterErrorState){
              showToast(message: state.error, status: ToastStatus.error);
            }
          },
          builder: (context, state){
            RegisterCubit cubit = RegisterCubit.get(context);
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
                            'Register'.toUpperCase(),
                            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: Colors.black
                            ),
                          ),

                          // padding 10
                          const SizedBox(height: 10),

                          // login sub title
                          Text(
                            'Create your account now to browse our offers',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Colors.grey
                            ),
                          ),

                          // padding
                          const SizedBox(height: 50),

                          // name input
                          TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.text,
                            validator: (String? value) {
                              return value!.isEmpty ? "This field is required" : null;
                            },
                            decoration: const InputDecoration(
                                labelText: 'Full name',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person_outline)
                            ),
                          ),
                          const SizedBox(height: 20),

                          // phone input
                          TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.number,
                            validator: (String? value) {
                              return value!.isEmpty ? "This field is required" : null;
                            },
                            decoration: const InputDecoration(
                                labelText: 'Phone number',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.phone_iphone_outlined)
                            ),
                          ),

                          // padding
                          const SizedBox(height: 20),

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
                                label: 'register',
                                function: state is ! RegisterLoadingState ? (){
                                  if(formKey.currentState!.validate()){
                                    cubit.register(
                                        name: nameController.text,
                                        phone: phoneController.text,
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
                              const Text("Have an account?"),
                              TextButton(
                                child: const Text('Login Now!'),
                                onPressed: (){
                                  navigateAndFinish(context, LoginScreen());
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
