import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutterwithfirebase/data/models/catigoris_model.dart';
import 'package:flutterwithfirebase/data/models/catigory_details_model.dart';
import 'package:flutterwithfirebase/data/web_services/web_services.dart';
import 'package:meta/meta.dart';

import '../../data/models/home_model.dart';
import '../../data/models/user_model.dart';
import '../helpers/helper.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());
  late UserModel userModel;
   CategoriesModel? categoriesModel;
   CategoryDetailsModel? categoryDetailsModel;
  HomeModel homeModel = HomeModel.fromJson({
    'status': false,
    'message': '',
    'data': {'banners': [], 'products': []}
  });

  static ShopCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  int currentItem = 0;

  void changeItemScreen(int index) {
    currentItem = index;
    emit(ShopChangeIndexScreenState());
  }

  void changePasswordVisibility() {
    isPassword != isPassword;
  }

  void getUserData(Map<String, dynamic> data) {
    emit(ShopGetUserModelLoadingState());
    Webservices.postData(url: 'login', data: data).then((value) {
      userModel = UserModel.fromJson(value.data);
      token = userModel.dataModel.token!;
      Helper.sharedPreferences.setString('token', token!);
      print(token);
      print(userModel);

      emit(ShopGetUserModelSuccessState());
      if (userModel.status == false)
        Fluttertoast.showToast(
            msg: '${userModel.message}',
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.red,
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.white);
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetUserModelErrorState(error.toString()));
    });
  }

  void postRegisterUserData(Map<String, dynamic> data) {
    emit(ShopPostRegisterUserModelLoadingState());
    Webservices.postData(url: 'register', data: data).then((value) {
      userModel = UserModel.fromJson(value.data);
      token = userModel.dataModel.token!;
      Helper.sharedPreferences.setString('token', token!);
      print(token);
      print(userModel);

      emit(ShopPostRegisterUserModelSuccessState());
      if (userModel.status == false)
        Fluttertoast.showToast(
            msg: '${userModel.message}',
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.red,
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.white);
    }).catchError((error) {
      print(error.toString());
      emit(ShopPostRegisterUserModelErrorState(error.toString()));
    });
  }

  void getHomeData() {
    emit(ShopGetHomeModelLoadingState());
    Webservices.getData(url: 'home', token: token).then((value) {
      print(value.data);
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel.data!.banners[0].image);
      emit(ShopGetHomeModelSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetHomeModelErrorState(error.toString()));
    });
  }

  void getCategoryData() {
    emit(ShopGetCategoryModelLoadingState());
    Webservices.getData(url: 'categories')
        .then((value) {
          categoriesModel=CategoriesModel.fromJson(value.data);
          emit(ShopGetCategoryModelSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(ShopGetCategoryModelErrorState(error));
    });
  }
  void getCategoryDetailsData(int id){
    emit(ShopGetCategoryDetailsModelLoadingState());
    Webservices.getData(url: 'categories/${id}',token: token).then((value) {
      categoryDetailsModel=CategoryDetailsModel.fromJson(value.data);
      print(categoryDetailsModel!.categoryDataModel!.data[0]. image);
      emit(ShopGetCategoryDetailsModelSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopGetCategoryDetailsModelErrorState(error));
    });
  }
  void addOrRemoveFavoriteItem(int id){
    Webservices.postData(url: 'favorites', data: {
      'product_id':id
    }).then((value){
      emit(ShopAddFavoritesSuccessState());
    } );
  }
  IconData favIcon=Icons.favorite_border;
}

