import 'package:autilab_project/core/network/api_exception.dart';
import 'package:autilab_project/features/data/doctor/data/repository/doctor_repository.dart';
import 'package:autilab_project/features/data/doctor/presentation/bloc/doctor_event.dart';
import 'package:autilab_project/features/data/doctor/presentation/bloc/doctor_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final DoctorRepository doctorRepository;
  DoctorBloc(this.doctorRepository) : super(DoctorInitiateState()) {
    on<DisplayDoctors>(
      (event, emit) async {
        emit(DoctorLoading());

        var displayAllDoctor = await doctorRepository.fetchDoctorList();
        var displayAllSpecialty = await doctorRepository.fetchAllSpecialty();
        displayAllDoctor.fold(
          (exception) {
            emit(
              DoctorError(
                ApiException(
                  statusCode: exception.statusCode,
                  message: exception.message,
                  type: exception.type,
                ),
              ),
            );
          },
          (doctors) {
            displayAllSpecialty.fold(
              (exception) {
                emit(
                  DoctorError(
                    ApiException(
                      statusCode: exception.statusCode,
                      message: exception.message,
                      type: exception.type,
                    ),
                  ),
                );
              },
              (specialty) {
                emit(AllDoctorResponseState(doctors, specialty));
              },
            );
          },
        );
      },
    );

    on<DisplayAllCenters>(
      (event, emit) async {
        emit(DoctorLoading());

        var cenetrs = await doctorRepository.fetchAllCenters();
        cenetrs.fold(
          (exception) {
            print(exception.message);
            emit(DoctorError(exception));
          },
          (displayAllCenters) {
            emit(AllCenterResponseState(displayAllCenters));
          },
        );
      },
    );
  }
}
