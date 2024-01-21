import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/auth/login_screen.dart';
import 'package:shop_app/modules/onboarding/onboarding_screen.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_states.dart';
import 'package:shop_app/shared/cubit/bloc_observer.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'network/local/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Bloc
  Bloc.observer = MyBlocObserver();

  // Obtain shared preferences.
  LocalStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // bool isAppThemeDark = prefs.getBool('isDark') ?? false;

    bool isAppThemeDark = LocalStorage.getBool(key: 'isDark') ?? false;
    bool onboardingSeen = LocalStorage.getBool(key: 'onboarding_seen') ?? false;
    userToken    = LocalStorage.getString(key: 'user_token') ?? "";

    Widget mainScreen;

    if(onboardingSeen){
      if(userToken != ""){
        mainScreen = const HomeLayout();
      }else{
        mainScreen = LoginScreen();
      }
    }else{
      mainScreen = const OnboardingScreen();
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){
          if(state is AppToggleDarkModeThemState){
            isAppThemeDark  = state.isDarkMode;
          }
        },
        builder: (context, state){
          return MaterialApp(
            title: 'Shop App',
            home: mainScreen,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: isAppThemeDark ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

