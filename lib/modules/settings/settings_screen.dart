import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/modules/auth/login_screen.dart';
import 'package:shop_app/network/local/local_storage.dart';
import 'package:shop_app/shared/components/buttons.dart';
import 'package:shop_app/shared/components/navigation.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_states.dart';

import '../../shared/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    final nameController    = TextEditingController();
    final phoneController   = TextEditingController();
    final emailController   = TextEditingController();

    return  BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state){
        AppCubit cubit  = AppCubit.get(context);
        UserModel? loggedInUser = cubit.profileResponse?.user;
        if(loggedInUser != null){
          nameController.text   = loggedInUser.name;
          phoneController.text  = loggedInUser.phone;
          emailController.text  = loggedInUser.email;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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

                      SizedBox(
                        width: double.infinity,
                        height: 65,
                        child: primaryBtn(
                            label: 'update',
                            function: state is ! AppUpdateProfileDataLoadingState ? (){
                              if(formKey.currentState!.validate()){
                                cubit.updateProfile(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                );
                              }
                            } : null
                        ),
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 65,
                        child: secondaryBtn(
                            label: 'logout',
                            function: (){
                              LocalStorage.removeData(key: 'user_token');
                              userToken = "";
                              navigateAndFinish(context, LoginScreen());
                            }
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }else{
          return const Text("Login");
        }
      },
    );
  }
}
