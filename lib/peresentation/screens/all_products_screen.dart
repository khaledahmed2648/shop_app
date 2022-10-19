import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwithfirebase/business_logic/cubit/shop_cubit.dart';
import 'package:flutterwithfirebase/data/models/home_model.dart';
import 'package:flutterwithfirebase/peresentation/helper_widgets.dart';
import 'package:flutterwithfirebase/peresentation/screens/category_details_screen.dart';
import 'package:flutterwithfirebase/peresentation/screens/home_login_screen.dart';
import 'package:flutterwithfirebase/peresentation/screens/product_details_screen.dart';

import '../../business_logic/helpers/helper.dart';

class AllProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()
        ..getHomeData()
        ..getCategoryData(),
      child: BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {
          // TODO: implement listener

        },
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          //print(cubit.homeModel.data!.products[0]);

          // if(token!=null)
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              title: Text(
                '${titles[cubit.currentItem]}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ))
              ],
            ),
            body: Screens[cubit.currentItem],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentItem,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                cubit.changeItemScreen(index);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category_outlined), label: 'Categories'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'Favorites'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
              ],
            ),
          );
        },
      ),
    );
  }

  List<String> titles = ['All products', 'Categories', 'Favorites', 'Settings'];
  List<Widget> Screens = [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];
}

Widget buildProductItem(ProductsModel model, context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(model: model)));
    },
    child: Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                width: double.infinity,
                height: 200,
              ),
              if (model.discount != 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.red,
                  child: Text(
                    'DISCOUND',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, height: 1),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: TextStyle(fontSize: 12, color: Colors.red),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}',
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: (ShopCubit.get(context).categoriesModel!=null),
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) => Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CarouselSlider(
                    items: cubit.homeModel.data!.banners
                        .map((e) => Image.network(
                              '${e.image}',
                              fit: BoxFit.cover,
                            ))
                        .toList(),
                    options: CarouselOptions(
                        initialPage: 0,
                        viewportFraction: 1,
                        height: 200,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Container(
                          height: 100,
                          width: 100,
                          child: GridTile(
                            footer: Container(
                              padding: EdgeInsets.all(3),
                              color: Colors.grey[300],
                              child: Text(
                                '${cubit.categoriesModel!.categoryDataModel!.data[index].name}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13),
                              ),
                            ),
                            child: Image.network(
                              '${cubit.categoriesModel!.categoryDataModel!.data[index].image}',
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 5,
                      ),
                      itemCount:
                          cubit.categoriesModel!.categoryDataModel!.data.length,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1 / 1.65,
                    ),
                    itemBuilder: (context, int index) => buildProductItem(
                        cubit.homeModel.data!.products[index], context),
                    itemCount: cubit.homeModel.data!.products.length,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      builder: (context, state) {
        ShopCubit();

        var categoryDataModel =
            ShopCubit.get(context).categoriesModel!.categoryDataModel!;
        return ConditionalBuilder(condition: (ShopCubit.get(context).categoriesModel!=null), builder: (context){
          return  ListView.separated(
            itemBuilder: (context, index) {
              if(state is ShopGetCategoryDetailsModelSuccessState){

              }
              return Container(
                height: 150,
                width: double.infinity,
                padding: EdgeInsets.all(12),
                child: InkWell(
                  onTap: () {

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => BlocProvider(
                    //           create: (context) => ShopCubit()..getCategoryDetailsData(categoryDataModel.data[index].id),
                    //           child: CategoryDetailScreen(
                    //               index:index
                    //           ),
                    //         )));

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.network(
                        '${categoryDataModel.data[index].image}',
                        fit: BoxFit.cover,
                        height: 150,
                        width: 150,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        '${categoryDataModel.data[index].name}',
                        style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => Container(
              height: 1,
              color: Colors.black,
            ),
            itemCount: categoryDataModel.data.length,
          );
        },
        fallback: (context)=>Center(child: CircularProgressIndicator(),
        ),
        );

      },
      listener: (context, state) {

      },
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ListView.separated(
          itemBuilder: (context, index) {
            if (cubit.homeModel.data!.products[index].inFavourite)
              return Container(
                height: 150,
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductDetailsScreen(
                                      model: cubit
                                          .homeModel.data!.products[index])));
                        },
                        child: Container(
                          padding: EdgeInsets.all(1),
                          color: Colors.black,
                          child: Container(
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.network(
                                  '${cubit.homeModel.data!.products[index].image}',
                                  fit: BoxFit.cover,
                                  height: 150,
                                  width: 150,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Text(
                                    '${cubit.homeModel.data!.products[index].name}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis),
                                    maxLines: 4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.blue,
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            )))
                  ],
                ),
              );
            else
              return Container(
                color: Colors.white,
              );
          },
          separatorBuilder: (context, index) => Container(
            height: 1,
            color: Colors.black,
          ),
          itemCount: cubit.homeModel.data!.products.length,
        );
      },
      listener: (context, state) {},
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: defaultMaterialButton(onPressed: (){
      token=null;
      Helper.sharedPreferences.remove('token').then((value) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeLoginScreen()), (route) => false);

      });
    }, text: 'logout'),);
  }
}
