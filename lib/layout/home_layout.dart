import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/components/navigation.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_states.dart';

import '../shared/constants.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context){
        return AppCubit()..getHomeData()..getCategoriesData()..getFavoriteProductsData()..getProfileData();
      },
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){},
        builder: (context, state){
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(

              title: Text(appName.toString()),
              // centerTitle: true,
              actions: [
                IconButton(
                  onPressed: (){
                    navigateTo(context, const SearchScreen());
                  },
                  icon: const Icon(Icons.search)
                )
              ],
            ),
            body: cubit.homeScreens[cubit.currentBottomNavigationIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentBottomNavigationIndex,
              onTap: (int index){
                cubit.changeCurrentBottomNavigationIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),

                BottomNavigationBarItem(
                    icon: Icon(Icons.apps),
                    label: 'Categories'
                ),

                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'Favorite'
                ),

                BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Settings'
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
