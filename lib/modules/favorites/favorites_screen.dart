import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/shared/components/ecommerce.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_states.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state){
        AppCubit cubit = AppCubit.get(context);
        List<ProductModel> products = cubit.favoriteProductsResponse?.products ?? [];
        if (state is ! AppFavoritesDataLoadingState) {
          return ListView.separated(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => buildProductListItem(
                  context,
                  product: products[index],
                  isFavoriteList: true,
                ),
                separatorBuilder: (context, index) => const Divider(color: Colors.grey),
                itemCount: products.length
            );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}
