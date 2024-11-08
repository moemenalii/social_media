class PostModel{
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;
  String? comment;

  PostModel(
      {
        this.name,
        this.uId,
        this.image,
        this.dateTime,
        this.text,
        this.postImage,
        this.comment,
      }) {
  }
  PostModel.fromjson(Map<String ,dynamic>?json){
    name=json!['name'];
    uId=json['uId'];
    image=json['image'];
    dateTime=json['dateTime'];
    text=json['text'];
    postImage=json['postImage'];
    comment=json['comment'];
  }
  Map<String ,dynamic> toMap(){
    return{
      'name':name,
      'dateTime':dateTime,
      'postImage':postImage,
      'uId':uId,
      'text':text,
      'image':image,
      'comment':comment,
    };
  }
}