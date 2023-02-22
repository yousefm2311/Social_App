abstract class SocialHomeState {}

class SocialGetInitialState extends SocialHomeState {}

class SocialGetSuccessState extends SocialHomeState {}

class SocialGetErrorState extends SocialHomeState {
  final String error;

  SocialGetErrorState(this.error);
}

class SocialGetLoadingState extends SocialHomeState {}
