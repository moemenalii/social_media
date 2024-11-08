class userModel{
  String? name;
  String? phone;
  String? email;
  String? uId;
  String? bio;
  String? image;
  String? cover;
  bool? isEmailVerified;
  userModel(
      {this.name,
        this.phone,
        this.email,
        this.uId,
        this.bio,
        this.image,
        this.cover,
        this.isEmailVerified,
      }) {
  }
  userModel.fromjson(Map<String ,dynamic>?json){
    email=json!['email'];
    name=json['name'];
    phone=json['phone'];
    uId=json['uId'];
    bio=json['bio'];
    image=json['image'];
    cover=json['cover'];
    isEmailVerified=json['isEmailVerified'];
  }
  Map<String ,dynamic> toMap(){
    return{
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'bio':bio,
      'image':image,
      'cover':cover,
      'isEmailVerified':isEmailVerified,
    };
  }
}