part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required List<Result> movieList,
  }) = _Initial;

  factory HomeState.initial(){
     return const HomeState(movieList: []);
  }
}
