import 'package:shop_app/models/apis/api_pagination_model.dart';
import 'package:shop_app/models/apis/api_response_model.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/product_model.dart';

class FavoriteProductsResponseModel extends ApiResponseModel
{
  List<ProductModel> products = [];
  late ApiPaginationModel pagination;

  FavoriteProductsResponseModel.fromJson(Map<String, dynamic> json)
  {
    status  = json['status'] ?? false;
    message = json['message'] ?? "";

    pagination  = ApiPaginationModel.fromJson(json['data']);

    List responseCategories   = json['data']['data'] ?? [];
    for (var element in responseCategories) {
      products.add(ProductModel.fromJson(element['product']));
    }
  }
}