import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/apis/search_response_model.dart';
import 'package:shop_app/network/remote/endpoints.dart';
import 'package:shop_app/network/remote/http_dio.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/cubit/search/search_states.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(BuildContext context) => BlocProvider.of(context);

  SearchResponseModel? searchResponse;

  void search(String? keyword)
  {
    emit(SearchLoadingState());
    Http.post(
        path: productsSearchEndpoint,
        token: userToken,
        data: {'text' : keyword}
    ).then((response) {
      print(response);
      searchResponse = SearchResponseModel.fromJson(response.data);
      emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}