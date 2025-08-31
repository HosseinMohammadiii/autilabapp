import 'package:autilab_project/features/data/doctor/data/repository/doctor_repository.dart';
import 'package:autilab_project/features/data/doctor/presentation/bloc/center/center_event.dart';
import 'package:autilab_project/features/data/doctor/presentation/bloc/center/center_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class CenterBloc extends Bloc<CenterEvent, CenterState> {
  DoctorRepository doctorRepository;
  CenterBloc(this.doctorRepository) : super(CenterInitiateState()) {
    on<DisplayAllCenters>(
      (event, emit) async {
        emit(CenterLoading());
        var centerResponse = await doctorRepository.fetchAllCenters();
        centerResponse.fold(
          (error) {
            emit(CenterError(error));
          },
          (response) {
            emit(AllCenterResponseState(response));
          },
        );
      },
    );
  }
}
