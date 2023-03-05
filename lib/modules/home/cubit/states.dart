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


class AddImagePickerSuccess extends SocialHomeState{}
class AddImagePickerError extends SocialHomeState{}


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

