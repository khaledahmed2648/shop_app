class UserModel{
  late bool status;
  late String message;
  late UserDataModel dataModel;
  UserModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    message=json['message'];
    dataModel=(json['data']!=null)?UserDataModel.fromJson(json['data']):UserDataModel.fromJson({


    });
  }

}

class UserDataModel{
  int? id=0;
  String? name='';
  String?  email='';
  String?  phone='';
  String?  image='';
  String? token;
  UserDataModel.fromJson(Map<String,dynamic> json){
    id =json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    image=json['image'];
    token=json['token'];
  }
}