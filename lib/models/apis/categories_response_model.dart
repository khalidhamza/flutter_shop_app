import 'package:shop_app/models/apis/api_pagination_model.dart';
import 'package:shop_app/models/apis/api_response_model.dart';
import 'package:shop_app/models/category_model.dart';

class CategoriesResponseModel extends ApiResponseModel
{
  List<CategoryModel> categories = [];
  late ApiPaginationModel pagination;

  CategoriesResponseModel.fromJson(Map<String, dynamic> json)
  {
    status  = json['status'] ?? false;
    message = json['message'] ?? "";

    pagination  = ApiPaginationModel.fromJson(json['data']);

    List responseCategories   = json['data']['data'] ?? [];
    for (var element in responseCategories) {
      categories.add(CategoryModel.fromJson(element));
    }
  }
}