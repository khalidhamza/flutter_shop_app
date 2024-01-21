import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/enums/toast_status.dart';
import 'package:shop_app/models/apis/categories_response_model.dart';
import 'package:shop_app/models/apis/common_response_model.dart';
import 'package:shop_app/models/apis/favorite_products_response_model.dart';
import 'package:shop_app/models/apis/home_response_model.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/network/remote/http_dio.dart';
import 'package:shop_app/shared/components/toast.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/cubit/app_states.dart';

import '../../models/apis/profile_response_model.dart';
import '../../network/local/local_storage.dart';
import '../../network/remote/endpoints.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());

  static AppCubit get (BuildContext context) => BlocProvider.of(context);


  /// * DARK MODE START **
  void toggleDarkMode() async
  {

    bool isDark = LocalStorage.getBool(key: 'isDark') ?? false;
    isDark  = !isDark;

    LocalStorage.setData(key: 'isDark', value: isDark).then((value){
      emit(AppToggleDarkModeThemState(isDark));
    });
  }
  /// * DARK MODE END **



  /// * HOME PAGE START **
  int currentBottomNavigationIndex = 0;
  List<ProductModel> staticProducts = [];
  void changeCurrentBottomNavigationIndex(int index){
    currentBottomNavigationIndex = index;
    emit(AppChangeBottomNavIndexState());
  }
  List<Widget> homeScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];

  HomeResponseModel? homeResponse;
  Map<int, bool> favoriteProducts = {};
  void getHomeData()
  {
    Http.get(
      path:homeEndpoint,
      token: userToken
    ).then((response) {
      homeResponse  = HomeResponseModel.fromJson(response.data);
      List<ProductModel> products = homeResponse?.products ?? [];

      for (ProductModel product in products) {
        favoriteProducts[product.id] = product.inFavorites;
      }
      emit(AppHomeDataSuccessState());
    }).catchError((error) {
      showToast(message: error.toString(), status: ToastStatus.error);
      emit(AppHomeDataErrorState());
    });
  }

  late CommonResponseModel favoriteResponse;
  void toggleFavorite(int productId)
  {
    favoriteProducts[productId] = ! (favoriteProducts[productId] ?? false);
    emit(AppToggleFavoriteSuccessState());

    Http.post(
        path:toggleFavoriteEndpoint,
        data: {'product_id': productId},
        token: userToken
    ).then((response) {
      favoriteResponse  = CommonResponseModel.fromJson(response.data);
      ToastStatus toastStatus = ToastStatus.success;
      if(! favoriteResponse.status){
        favoriteProducts[productId] = ! (favoriteProducts[productId] ?? false);
        toastStatus = ToastStatus.error;
      }else{
        getFavoriteProductsData();
      }

      emit(AppToggleFavoriteSuccessState());

      showToast(message: favoriteResponse.message, status: toastStatus);
    }).catchError((error) {
      showToast(message: error.toString(), status: ToastStatus.error);
      emit(AppToggleFavoriteErrorState());
    });
  }
  /// * HOME PAGE END **

  /// * CATEGORIES START **
  CategoriesResponseModel? categoriesResponse;
  void getCategoriesData()
  {
    Http.get(
        path:categoriesEndpoint,
    ).then((response) {
      categoriesResponse  = CategoriesResponseModel.fromJson(response.data);
      emit(AppCategoriesDataSuccessState());
    }).catchError((error) {
      showToast(message: error.toString(), status: ToastStatus.error);
      emit(AppCategoriesDataErrorState());
    });
  }
  /// * CATEGORIES START **

  /// * FAVORITES DATA START **
  FavoriteProductsResponseModel? favoriteProductsResponse;
  void getFavoriteProductsData()
  {
    emit(AppFavoritesDataLoadingState());
    Http.get(
      path:favoriteEndpoint,
      token: userToken,
    ).then((response) {
      favoriteProductsResponse  = FavoriteProductsResponseModel.fromJson(response.data);
      emit(AppFavoritesDataSuccessState());
    }).catchError((error) {
      showToast(message: error.toString(), status: ToastStatus.error);
      emit(AppFavoritesDataErrorState());
    });
  }
  /// * FAVORITES DATA END **


  /// * PROFILE DATA START **
  ProfileResponseModel? profileResponse;
  void getProfileData()
  {
    Http.get(
      path:profileEndpoint,
      token: userToken,
    ).then((response) {
      profileResponse  = ProfileResponseModel.fromJson(response.data);
      emit(AppGetProfileDataSuccessState());
    }).catchError((error) {
      showToast(message: error.toString(), status: ToastStatus.error);
      emit(AppGetProfileDataErrorState());
    });
  }

  CommonResponseModel? updateProfileResponse;
  void updateProfile({
    required String name,
    required String phone,
    required String email,
  }){
    emit(AppUpdateProfileDataLoadingState());

    Http.put(
        path: updateProfileEndpoint,
        token: userToken,
        data: {
          'name': name,
          'phone': phone,
          'email': email
        }
    ).then((response) {
      profileResponse?.user?.name   = name;
      profileResponse?.user?.phone  = phone;
      profileResponse?.user?.email  = email;

      updateProfileResponse = CommonResponseModel.fromJson(response.data);
      emit(AppUpdateProfileDataSuccessState());

      getProfileData();

      ToastStatus status = (updateProfileResponse?.status ?? false) ? ToastStatus.success : ToastStatus.error;
      showToast(message: updateProfileResponse?.message ?? "", status: status);
    }).catchError((error){
      showToast(message: error.toString(), status: ToastStatus.error);
      emit(AppUpdateProfileDataErrorState());
    });
  }
  /// * PROFILE DATA END **
}
