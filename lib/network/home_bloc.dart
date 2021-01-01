import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_box/model/response_model/all_programs_response_model.dart';
import 'package:health_box/network/api_result.dart';
import 'package:health_box/network/home_event.dart';
import 'package:health_box/network/network_exceptions.dart';
import 'package:health_box/network/result_state.dart';


import 'api_repository.dart';

class HomeBloc extends Bloc<HomeEvent, ResultState> {
  final APIRepository apiRepository;
  HomeBloc({this.apiRepository})
      : assert(apiRepository != null),
        super(Idle());

  @override
  Stream<ResultState> mapEventToState(HomeEvent event) async* {

    yield ResultState.loading();

    if (event is LoadMovies) {

      ApiResult<GetAllProgramsResponseModel> apiResult = await apiRepository.fetchMovieList();

      yield* apiResult.when(success: (GetAllProgramsResponseModel data) async* {

        yield ResultState.data(data: data);

      }, failure: (NetworkExceptions error) async* {

        yield ResultState.error(error: error);

      });
    }
  }
}