class ItemGroupModel{
  final String? name;

  ItemGroupModel({this.name});

  factory ItemGroupModel.fromJson(Map<String,dynamic> json){
    return ItemGroupModel(name: json['name']??'');
  }
}