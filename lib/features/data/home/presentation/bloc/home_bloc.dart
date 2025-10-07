import 'package:autilab_project/features/data/home/data/repository/home_repository.dart';
import 'package:autilab_project/features/data/home/presentation/bloc/home_event.dart';
import 'package:autilab_project/features/data/home/presentation/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeRepository homeRepository;
  HomeBloc(this.homeRepository) : super(HomeInitiateState()) {
    on<DisplayHomeContent>(
      (event, emit) async {
        try {
          emit(HomeLoading());
          var response = await homeRepository.getNewAppointmentList();
          emit(HomeFetchData(response));
        } catch (e) {
          emit(HomeErrorHandling(e.toString()));
        }
      },
    );
    on<DisplayAppointmentList>(
      (event, emit) async {
        try {
          emit(HomeLoading());
          var response = await homeRepository.fetchAppointmentList();
          emit(AppointmentFetchData(response));
        } catch (e) {
          emit(HomeErrorHandling(e.toString()));
        }
      },
    );
  }
}
