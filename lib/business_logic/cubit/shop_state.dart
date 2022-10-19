part of 'shop_cubit.dart';

@immutable
abstract class ShopState {}

class ShopInitial extends ShopState {}
class ShopChangePasswordVisibilityState extends ShopState{}
class ShopGetUserModelSuccessState extends ShopState{}
class ShopChangeIndexScreenState extends ShopState{}
class ShopGetUserModelErrorState extends ShopState{
  final String error;
  ShopGetUserModelErrorState(this.error);
}

class ShopPostRegisterUserModelSuccessState extends ShopState{}

class ShopGetUserModelLoadingState extends ShopState{}

class ShopPostRegisterUserModelErrorState extends ShopState{
  final String error;
  ShopPostRegisterUserModelErrorState(this.error);
}
class ShopPostRegisterUserModelLoadingState extends ShopState{}


class ShopGetHomeModelSuccessState extends ShopState{}
class ShopGetHomeModelErrorState extends ShopState{
  final String error;
  ShopGetHomeModelErrorState(this.error);
}
class ShopGetHomeModelLoadingState extends ShopState{}

class ShopGetCategoryModelSuccessState extends ShopState{}
class ShopAddFavoritesSuccessState extends ShopState{}
class ShopGetCategoryModelErrorState extends ShopState{
  final String error;
  ShopGetCategoryModelErrorState(this.error);
}
class ShopGetCategoryModelLoadingState extends ShopState{}

class ShopGetCategoryDetailsModelSuccessState extends ShopState{}
class ShopGetCategoryDetailsModelErrorState extends ShopState{
  final String error;
  ShopGetCategoryDetailsModelErrorState(this.error);
}
class ShopGetCategoryDetailsModelLoadingState extends ShopState{}