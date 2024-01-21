import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/shared/components/ecommerce.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/search/search_cubit.dart';
import 'package:shop_app/shared/cubit/search/search_states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state){},
        builder: (context, state){
          SearchCubit cubit = SearchCubit.get(context);
          List<ProductModel> products = cubit.searchResponse?.products ?? [];
          var formKey = GlobalKey<FormState>();
          final searchController = TextEditingController();

          return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        validator: (String? value) {
                          return value!.isEmpty ? "This field is required" : null;
                        },
                        decoration: const InputDecoration(
                            labelText: 'Search ...',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.search)
                        ),
                        onFieldSubmitted: (String keyword){
                          if(formKey.currentState!.validate()){
                            cubit.search(keyword);
                          }
                        },
                      ),

                      state is SearchLoadingState
                        ? Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: const LinearProgressIndicator(),
                        )
                        : Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(top: 20),
                            child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) => buildProductListItem(
                                context,
                                product: products[index],
                                isFavoriteList: false
                              ),
                              separatorBuilder: (context, index) => const Divider(color: Colors.grey),
                              itemCount: products.length
                            ),
                          ),
                        )


                    ],
                  ),
                ),
              ),
          );
        },
      ),
    );
  }
}
