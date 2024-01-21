import 'package:shop_app/models/apis/api_response_model.dart';
import 'package:shop_app/models/banner_model.dart';
import 'package:shop_app/models/product_model.dart';

class HomeResponseModel extends ApiResponseModel
{
  List<BannerModel> banners = [];
  List<ProductModel> products = [];
  String? ad;

  HomeResponseModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'] ?? false;
    message = json['message'] ?? "";
    ad = json['data']['ad'] ?? "";


    List responseBanners = json['data']['banners'] ?? [];
    for (var element in responseBanners) {
      banners.add(BannerModel.fromJson(element));
    }

    List responseProducts = json['data']['products'] ?? [];
    for (var element in responseProducts) {
      products.add(ProductModel.fromJson(element));
    }
  }
}