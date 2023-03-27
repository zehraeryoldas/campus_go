class usersModel {
  int? id;
  String? mail;
  String? name;
  String? password;
  int? phone;

  usersModel({this.id, this.mail, this.name, this.password, this.phone});

  usersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mail = json['mail'];
    name = json['name'];
    password = json['password'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mail'] = this.mail;
    data['name'] = this.name;
    data['password'] = this.password;
    data['phone'] = this.phone;
    return data;
  }
}
