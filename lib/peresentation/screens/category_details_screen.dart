import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwithfirebase/business_logic/cubit/shop_cubit.dart';
import 'package:flutterwithfirebase/data/models/catigoris_model.dart';

import '../../data/models/catigory_details_model.dart';

class CategoryDetailScreen extends StatefulWidget {

  final int index;

  const CategoryDetailScreen(
      {Key? key,  required this.index})
      : super(key: key);

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    CategoryModel categorymodel = ShopCubit.get(context)
        .categoriesModel!
        .categoryDataModel!
        .data[widget.index];
    var categoryDetailsModel = ShopCubit.get(context)
        .categoryDetailsModel!
        .categoryDataModel!
        .data;
        return BlocConsumer<ShopCubit, ShopState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return ConditionalBuilder(
          condition: (ShopCubit.get(context).categoriesModel != null &&
              ShopCubit.get(context).categoryDetailsModel != null),
          builder: (context) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  title: Text(
                    '${categorymodel.name}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                body: BlocConsumer<ShopCubit, ShopState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {

                    return ConditionalBuilder(
                      condition:
                          (state != ShopGetCategoryDetailsModelLoadingState),
                      builder: (context) => ListView.separated(
                          itemBuilder: (context, index) =>
                              buildCategoryDetailsItem(
                                  categoryDetailsModel[index]),
                          separatorBuilder: (context, state) => Container(
                                width: double.infinity,
                                height: 3,
                                color: Colors.black,
                              ),
                          itemCount: categoryDetailsModel.length),
                      fallback: (context) => Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ));
          },
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
  },
);


  }
}

Widget buildCategoryDetailsItem(CategoryItemModel item) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      width: double.infinity,
      child: Column(children: [
        Text(
          '${item.name}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: Colors.black,
        ),
        SizedBox(
          height: 10,
        ),
        Image.network(
          '${item.image}',
          fit: BoxFit.cover,
          height: 400,
          width: double.infinity,
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: Colors.black,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          '${item.description}',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: Colors.black,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              'price : ${item.price}',
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
            Spacer(),
            Text(
              'Old price : ${item.price}',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ]),
    ),
  );
}
