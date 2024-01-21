import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/apis/categories_response_model.dart';
import 'package:shop_app/models/apis/home_response_model.dart';
import 'package:shop_app/shared/components/ecommerce.dart';
import 'package:shop_app/shared/components/loaders.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_states.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return cubit.homeResponse == null ? primaryLoader() : buildHomeScreen(context);
      },
    );
  }

  Widget buildHomeScreen(context)
  {
    AppCubit cubit = AppCubit.get(context);
    HomeResponseModel? response = cubit.homeResponse;
    CategoriesResponseModel? categoriesResponse = cubit.categoriesResponse;
    // favoriteProducts: cubit.favoriteProducts,

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: response?.banners.map((e) {
              return Image(
                  image: NetworkImage(e.image.toString()),
              );
            }).toList(),
            options: CarouselOptions(
              height: 250,
              initialPage: 0,
              viewportFraction: .8,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.easeIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                buildHorizontalCategoriesList(categoriesResponse?.categories ?? []),
                const SizedBox(height: 20),
                const Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),

          Container(
            color: Colors.grey[300],
            // padding: const EdgeInsets.only(left: 10, right: 10),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1/1.55,
              children: buildProductsGridView(context),
            ),
          ),
        ],
      ),
    );
  }
}
