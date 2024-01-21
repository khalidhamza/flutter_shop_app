abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppToggleDarkModeThemState extends AppStates {
  final bool isDarkMode;
  AppToggleDarkModeThemState(this.isDarkMode);
}

class AppChangeBottomNavIndexState extends AppStates {}

class AppHomeDataLoadingState extends AppStates {}

class AppHomeDataSuccessState extends AppStates {}

class AppHomeDataErrorState extends AppStates {}

class AppCategoriesDataSuccessState extends AppStates {}

class AppCategoriesDataErrorState extends AppStates {}

class AppToggleFavoriteSuccessState extends AppStates {}

class AppToggleFavoriteErrorState extends AppStates {}

class AppFavoritesDataLoadingState extends AppStates {}

class AppFavoritesDataSuccessState extends AppStates {}

class AppFavoritesDataErrorState extends AppStates {}

class AppGetProfileDataSuccessState extends AppStates {}

class AppGetProfileDataErrorState extends AppStates {}

class AppUpdateProfileDataLoadingState extends AppStates {}

class AppUpdateProfileDataSuccessState extends AppStates {}

class AppUpdateProfileDataErrorState extends AppStates {}
