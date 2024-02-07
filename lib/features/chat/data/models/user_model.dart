class UserModel {
 String? id;
   String ? firstName;
   String ? lastName;
  String ?email;
 String ? avatar;
 String ? token;

  UserModel({
   this.id,
   this.firstName,
     this.lastName,
   this.email,
   this.avatar,
   this.token,
  });

 UserModel.fromJson(json) {

      id= json['_id'];
      firstName= json['firstName'];
      lastName = json['lastName'];
      email=json['email'];
      avatar= json['avatar'];
      token= json['token'];

  }
}
