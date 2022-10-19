class CategoryDetailsModel {
  late bool status;
   String? message;
   CategoryItemDetailsDataModel? categoryDataModel;
  CategoryDetailsModel.fromJson(Map<String,dynamic>json){
  status=json['status'];
  message=json['message'];
   categoryDataModel=CategoryItemDetailsDataModel.fromJson(json['data']);
}
}

class CategoryItemDetailsDataModel{
  List<CategoryItemModel> data=[];
  CategoryItemDetailsDataModel.fromJson(Map<String,dynamic> json){
    json['data'].forEach((element){
      data.add(CategoryItemModel.fromJson(element));
    });
  }

}
class CategoryItemModel{
  late int id;
 dynamic price;
  dynamic old_price;
  late String description;
  late String name;
  late String image;

  CategoryItemModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    price=json['price'];
    old_price=json['old_price'];
    description=json['description'];
    name=json['name'];
    image=json['image'];
  }
}