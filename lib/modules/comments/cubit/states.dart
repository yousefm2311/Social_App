abstract class SocialAppCommentState{}

class InitialCommentState extends SocialAppCommentState{}


// add comment

class AddCommentSuccessState extends SocialAppCommentState {}
class AddCommentErrorState extends SocialAppCommentState {
  final String error;

  AddCommentErrorState(this.error);
}
class AddCommentLoadingState extends SocialAppCommentState {}


// add comment image state
class AddCommentImageSuccessState extends SocialAppCommentState {}
class AddCommentImageErrorState extends SocialAppCommentState {
  final String error;

  AddCommentImageErrorState(this.error);
}
class AddCommentImageLoadingState extends SocialAppCommentState {}

//get comments data
class GetCommentsDataSuccessState extends SocialAppCommentState {}
class GetCommentsDataLoadingState extends SocialAppCommentState {}
class GetCommentsDataErrorState extends SocialAppCommentState {
  final String error;

  GetCommentsDataErrorState(this.error);
}

// image packer state

class PackImageSuccessState extends SocialAppCommentState {}
class PackImageErrorState extends SocialAppCommentState {}
class RemoveCommentImageState extends SocialAppCommentState {}



