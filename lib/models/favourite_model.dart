class favouriteModel {
  String? post_id;
  String? post_user_id;
  int? status;
  String? user_id;
  favouriteModel({this.post_id, this.post_user_id, this.status, this.user_id});
  favouriteModel.fromJson(Map<String, dynamic> json) {
    post_id = json['post_id'];
    post_user_id = json['post_user_id'];
    status = json['status'];
    
    user_id = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_id'] = this.post_id;
    data['post_user_id'] = this.post_user_id;
    data['status'] = this.status;
  
    data['user_id'] = this.user_id;

    return data;
  }
}
