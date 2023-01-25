import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:login_and_home_page/Services/movie_service.dart';

import '../../Model/movies.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<HomeEvent>((event, emit) async {
      List<Result>? data = await MovieServices.getMovies();
      emit(HomeState(movieList: data!));
    });
  }
}
