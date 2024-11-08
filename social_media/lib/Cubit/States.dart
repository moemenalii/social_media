abstract class socialStates {}

class socialInitial extends socialStates{}

class socialGetUserLoading extends socialStates{}

class socialGetUserSuccess extends socialStates{}

class socialGetUserErorr extends socialStates{
  final erorr;

  socialGetUserErorr(this.erorr);
}
class changeBottomNva extends socialStates{}

class socialNewPost extends socialStates{}

class socialPickedImageSuccess extends socialStates{}

class socialPickedImageErorr extends socialStates{}

class socialPickedCoverSuccess extends socialStates{}

class socialPickedCoverErorr extends socialStates{}

class socialUpLoadProfileImageSuccess extends socialStates{}

class socialUpLoadProfileImageErorr extends socialStates{}

class socialUpLoadCoverImageSuccess extends socialStates{}

class socialUpLoadCoverImageErorr extends socialStates{}

class socialUpdateUserLoading extends socialStates{}

class socialUpdateUserErorr extends socialStates{}

// creat post

class creatPostLoadingState extends socialStates{}

class creatPostSuccessState extends socialStates{}

class creatPostErorrState extends socialStates{
  // final error;
  // creatPostErorrState(this.error);
}

class socialPickedPostImageSuccess extends socialStates{}

class socialPickedPostImageErorr extends socialStates{}

class socialGetPostsSuccess extends socialStates{}

class socialGetPostsErorr extends socialStates{
  final erorr;

  socialGetPostsErorr(this.erorr);
}
// get all users
class socialGetAllUsersLoading extends socialStates{}

class socialGetAllUsersSuccess extends socialStates{}

class socialGetAllUsersErorr extends socialStates{
  final erorr;

  socialGetAllUsersErorr(this.erorr);
}
// like post
class socialLikePostSuccess extends socialStates{}

class socialLikePostErorr extends socialStates{
  final erorr;

  socialLikePostErorr(this.erorr);
}

// comment post
class socialCommentPostSuccess extends socialStates{}

class socialCommentPostErorr extends socialStates{
  final erorr;
  socialCommentPostErorr(this.erorr);
}
// sendMessage
class socialSendMessageSuccess extends socialStates{}

class socialSendMessageErorr extends socialStates{
  final erorr;

  socialSendMessageErorr(this.erorr);
}
// getMessage
class socialGetMessageSuccess extends socialStates{}

