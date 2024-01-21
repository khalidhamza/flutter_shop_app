import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/shared/components/ecommerce.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';

import '../../shared/cubit/app_states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){},
        builder: (context, state){
          AppCubit cubit = AppCubit.get(context);
          List<CategoryModel> categories  = cubit.categoriesResponse?.categories ?? [];
          return Container(
            child: buildVerticalCategoriesList(categories),
          );
        }
    );
  }
}
