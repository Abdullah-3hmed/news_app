abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}

class NewsBusinessSuccessState extends NewsStates {}

class NewsBusinessErrorState extends NewsStates {
  final String error;

  NewsBusinessErrorState(this.error);
}

class NewsGetBusinessLoadingState extends NewsStates {}

class NewsSportsSuccessState extends NewsStates {}

class NewsSportsErrorState extends NewsStates {
  final String error;

  NewsSportsErrorState(this.error);
}

class NewsGetSportsLoadingState extends NewsStates {}

class NewsScienceSuccessState extends NewsStates {}

class NewsScienceErrorState extends NewsStates {
  final String error;

  NewsScienceErrorState(this.error);
}

class NewsGetScienceLoadingState extends NewsStates {}

class ChangeAppThemeModeState extends NewsStates {}

class NewsGetSearchLoadingState extends NewsStates {}

class NewsGetSearchSuccessState extends NewsStates {}

class NewsGetSearchErrorState extends NewsStates {
  final String error;

  NewsGetSearchErrorState(this.error);
}
