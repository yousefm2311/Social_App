abstract class SocialHomeState {}

class SocialGetInitialState extends SocialHomeState {}

class SocialGetSuccessState extends SocialHomeState {}

class SocialGetErrorState extends SocialHomeState {
  final String error;

  SocialGetErrorState(this.error);
}

class SocialGetLoadingState extends SocialHomeState {}

class ChangeBottomNavState extends SocialHomeState {}

class AddPostState extends SocialHomeState {}

class GetProfileImagePickerSuccess extends SocialHomeState {}

class GetProfileImagePickerError extends SocialHomeState {}

class GetCoverImagePickerSuccess extends SocialHomeState {}

class GetCoverImagePickerError extends SocialHomeState {}

class UploadProfileImageSucces extends SocialHomeState {}

class UploadProfileImageError extends SocialHomeState {
  final String error;

  UploadProfileImageError(this.error);
}

class UploadCoverImageSucces extends SocialHomeState {}

class UploadCoverImageError extends SocialHomeState {
  final String error;

  UploadCoverImageError(this.error);
}

class UpdateUserError extends SocialHomeState {
  final String error;

  UpdateUserError(this.error);
}

class UpdateUserLoading extends SocialHomeState {}

class AddImagePickerSuccess extends SocialHomeState {}

class AddImagePickerError extends SocialHomeState {}

class UploadAddImageSuccess extends SocialHomeState {}

class UploadAddImageError extends SocialHomeState {}

class UploadAddImageLoading extends SocialHomeState {}

//create Post

class CreateNewPostSuccessState extends SocialHomeState {}

class CreateNewPostErrorState extends SocialHomeState {
  final String error;

  CreateNewPostErrorState(this.error);
}

class CreateNewPostLoadingState extends SocialHomeState {}

class GetPostImagePickerSuccess extends SocialHomeState {}

class GetPostImagePickerError extends SocialHomeState {}

class RemovePostImagePicker extends SocialHomeState {}

//get post data

class GetPostDataSuccessState extends SocialHomeState {}

class GetPostDataErrorState extends SocialHomeState {
  final String error;

  GetPostDataErrorState(this.error);
}

class GetPostDataLoadingState extends SocialHomeState {}

// add like

class AddLikeSuccessState extends SocialHomeState {}

class AddLikeErrorState extends SocialHomeState {
  final String error;

  AddLikeErrorState(this.error);
}

class AddLikesLenght extends SocialHomeState {}

// get all users

class GetAllUsersSuccessState extends SocialHomeState {}

class GetAllUsersErrorState extends SocialHomeState {
  final String error;
  GetAllUsersErrorState(this.error);
}

class GetAllUsersLoadingState extends SocialHomeState {}

// chat with user
class GetChatSuccessState extends SocialHomeState {}


// add chat with user

class AddChatSuccessState extends SocialHomeState{}
class AddChatErrorState extends SocialHomeState{
  final String error;

  AddChatErrorState(this.error);
}


//send notification  using firebase
class SendNotificationSuccessState extends SocialHomeState {}
class SendNotificationErrorState extends SocialHomeState {
  final String error;

  SendNotificationErrorState(this.error);
}
class SendNotificationLoadingState extends SocialHomeState {}


// create tpken state
class CreateTokenSuccessState extends SocialHomeState {}
class CreateTokenErrorState extends SocialHomeState {
  final String error;

  CreateTokenErrorState(this.error);
}
class CreateTokenLoadingState extends SocialHomeState {}