// class HomeModel{
//   late bool status;
//   String? message;
//   late HomeDataModel data;
//   HomeModel.fromJson(Map<String,dynamic>json){
//     status=json['status'];
//     message=json['message'];
//     data=HomeDataModel.fromJson(json['data']);
//   }
//
// }
// class HomeDataModel{
//  List<BannerModel>banners=[];
//  List<ProductModel>products=[];
//
// HomeDataModel.fromJson(Map<String,dynamic>json){
//   json['banners'].forEach((element){
//     banners.add(BannerModel.fromJson(element));
//   });
//   json['products'].forEach((element){
//     products.add(ProductModel.fromJson(element));
//   });
// }
//
// }
//
// class BannerModel{
//   late int id;
//   late String image;
//   BannerModel.fromJson(Map<String,dynamic>json){
//     id=json['id'];
//     image=json['image'];
//   }
// }
//
// class ProductModel{
//   late int id;
//   late String image;
//   late String  name;
//   late dynamic price;
//   late dynamic old_price;
//   late dynamic discount;
//    String? description;
//   late bool in_favorites;
//   ProductModel.fromJson(Map<String,dynamic>json){
//     id=json['id'];
//     image=json['image'];
//     name=json['name'];
//     price=json['price'];
//     old_price=json['old_price'];
//     discount=json['discount'];
//     description=json['description'];
//     in_favorites=json['in_favorites'];
//
//
//   }
// }
//
//


class HomeModel{
  late bool status;
  HomeData? data;

  HomeModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = HomeData.fromJSON(json['data']);
  }
}
class HomeData{
  List<BannerModel> banners = [];
  List<ProductsModel> products = [];
  HomeData.fromJSON(Map<String, dynamic> json){
    json['banners'].forEach((element){
      banners.add(BannerModel.fromJSON(element));
    });
    json['products'].forEach((element){
      products.add(ProductsModel.fromJSON(element));
    });
  }
}
class BannerModel{
  late int id;
  late String image;
  // late String category;
  // late String product;
  BannerModel.fromJSON(Map<String, dynamic> json){
    id = json['id'];
    image = json['image'];
    // category = json['category'];
    // product = json['product'];
  }
}
class ProductsModel{
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late String description;
  late bool inFavourite;
  late bool inCart;
  ProductsModel.fromJSON(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    description = json['description'];
    image = json['image'];
    name = json['name'];

    inFavourite = json['in_favorites'];
    inCart = json['in_cart'];
  }
}

