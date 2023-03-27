class categoryModel {
  String? categoryName;
  String? id;

  categoryModel({this.categoryName, this.id});

  categoryModel.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.categoryName;
    data['id'] = this.id;
    return data;
  }
}
