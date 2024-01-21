import 'package:flutter/material.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';

/// *** PRODUCTS START ***
List<Widget> buildProductsGridView(context)
{
  AppCubit cubit = AppCubit.get(context);
  List<ProductModel> products = cubit.homeResponse?.products ?? [];

  List<Widget> productsList = [];
  for (var product in products) {
    productsList.add(
      buildGridSingleProduct(context, product: product),
    );
  }
  return productsList;
}

Widget buildGridSingleProduct(context, {required ProductModel product})
{
  AppCubit cubit = AppCubit.get(context);
  Map<int, bool> favoriteProducts = cubit.favoriteProducts;

  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Image(
              image: NetworkImage(product.image),
              width: double.infinity,
              height: 200,
            ),

            if(product.discount != 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              color: Colors.red,
              child: Text(
                "discount".toUpperCase(),
                style: const TextStyle(
                  color: Colors.white
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 8),

        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 14,
                    height: 1.3
                ),
              ),

              const SizedBox(height: 5),

              Row(
                children: [
                  Text(
                    product.price.toString(),
                    style: const TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                  const SizedBox(width: 10),

                  if(product.discount != 0)
                    Text(
                      product.oldPrice.toString(),
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough
                      ),
                    ),

                  const Spacer(),
                  IconButton(
                      onPressed: (){
                        cubit.toggleFavorite(product.id);
                      },
                      icon: CircleAvatar(
                        backgroundColor:  (favoriteProducts[product.id] ?? false) ? primaryColor : Colors.grey,
                        child: const Icon(
                          Icons.favorite_border,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget buildFavoriteProductsList(context, {required List<ProductModel> products})
{
  if(products.isNotEmpty){
    AppCubit cubit = AppCubit.get(context);
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => buildProductListItem(
          context,
          product: products[index],
          isFavoriteList: true
        ),
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: products.length
    );
  }else{
    return const SizedBox();
  }
}

Widget buildProductListItem(context, {required ProductModel product, required bool isFavoriteList})
{
  AppCubit cubit = AppCubit.get(context);
  Map<int, bool> favoriteProducts = cubit.favoriteProducts;
  return Container(
    padding: const EdgeInsets.all(20),
    height: 120,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Image(
              image: NetworkImage(product.image),
              width: 120,
              height: 120,
            ),

            if(product.discount != 0 && isFavoriteList)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                color: Colors.red,
                child: Text(
                  "discount".toUpperCase(),
                  style: const TextStyle(
                      color: Colors.white
                  ),
                ),
              )
          ],
        ),

        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 14,
                      height: 1
                  ),
                ),

                const Spacer(),

                Row(
                  children: [
                    Text(
                      product.price.toString(),
                      style: const TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.bold
                      ),
                    ),

                    const SizedBox(width: 10),

                    if(product.discount != 0 && isFavoriteList)
                      Text(
                        product.oldPrice.toString(),
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough
                        ),
                      ),

                    const Spacer(),
                    IconButton(
                      onPressed: (){
                        cubit.toggleFavorite(product.id);
                      },
                      icon: CircleAvatar(
                        backgroundColor: (isFavoriteList || (favoriteProducts[product.id] ?? false) ) ? primaryColor : Colors.grey,
                        // child: Text(favoriteProducts[product.id].toString()),
                        child: const Icon(
                          Icons.favorite_border,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
/// *** PRODUCTS END ***


/// *** CATEGORIES START ***
Widget buildHorizontalCategoriesList(List<CategoryModel> categories)
{
  if(categories.isNotEmpty){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Categories',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 100,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => buildHorizontalCategoriesItem(categories[index]),
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemCount: categories.length
          ),
        ),
      ],
    );
  }else{
    return const SizedBox();
  }
}

Widget buildHorizontalCategoriesItem(CategoryModel category)
{
  return Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
       Image(
        image: NetworkImage(category.image),
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      ),
      Container(
        width: 100,
        color: Colors.black.withOpacity(.7),
        child: Text(
          category.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
      )
    ],
  );
}

Widget buildVerticalCategoriesList(List<CategoryModel> categories)
{
  if(categories.isNotEmpty){
    return ListView.separated(
        itemBuilder: (context, index) => buildVerticalCategoriesItem(categories[index]),
        separatorBuilder: (context, index) => const Divider(color: Colors.grey),
        itemCount: categories.length
    );
  }else{
    return const SizedBox();
  }
}

Widget buildVerticalCategoriesItem(CategoryModel category)
{
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Row(
      children: [
        Image(
          image: NetworkImage(category.image),
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),

        const SizedBox(width: 10),
        Text(
          category.name,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
        ),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios),
      ],
    ),
  );
}
/// *** CATEGORIES END ***