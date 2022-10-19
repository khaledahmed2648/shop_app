class CategoriesModel {
  late bool status;
   String? message;
   CategoryDataModel? categoryDataModel;
CategoriesModel.fromJson(Map<String,dynamic>json){
  status=json['status'];
  message=json['message'];
   categoryDataModel=CategoryDataModel.fromJson(json['data']);
}
}

class CategoryDataModel{
  List<CategoryModel> data=[];
  CategoryDataModel.fromJson(Map<String,dynamic> json){
    json['data'].forEach((element){
      data.add(CategoryModel.fromJson(element));
    });
  }

}
class CategoryModel{
  late int id;
  late String name;
  late String image;

  CategoryModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}