class usersModel {
  int? id;
  String? email;
  String? name;
  // String? password;
  // String? password2;
  int? phone;

  usersModel(
      {this.id,
      this.email,
      this.name,
      // this.password,
      // this.password2,
      this.phone,
      });

  usersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    // password = json['password'];
    // password2 = json['password2'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    // data['password'] = this.password;
    // data['password2'] = this.password2;
    data['phone'] = this.phone;
    return data;
  }
}
