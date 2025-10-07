import 'package:autilab_project/core/network/api_exception.dart';
import 'package:autilab_project/features/data/doctor/data/repository/doctor_repository.dart';
import 'package:autilab_project/features/data/doctor/presentation/bloc/doctor/doctor_event.dart';
import 'package:autilab_project/features/data/doctor/presentation/bloc/doctor/doctor_state.dart';
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
    on<DisplaySpecialtyDoctor>(
      (event, emit) async {
        emit(DoctorLoading());
        var doctorResponse =
            await doctorRepository.fetchSpecialtyDoctor(event.doctorId);
        doctorResponse.fold(
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
          (response) {
            emit(SpecialtyDoctorResponse(response));
          },
        );
      },
    );
    on<DisplayDoctorWorkScheduel>(
      (event, emit) async {
        emit(DoctorLoading());
        var workScheduleResponse =
            await doctorRepository.fetchDoctorWorkSchedule(event.doctorId);
        workScheduleResponse.fold(
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
          (response) {
            emit(DoctorWorkScheduelResponseState(response));
          },
        );
      },
    );
    on<DisplaySpecialtyDoctorWorkScheduel>(
      (event, emit) async {
        emit(WorkScheduelDoctorLoading());
        var specialtyWorkScheduleResponse = await doctorRepository
            .fetchSpecialtyDoctorWorkSchedule(event.workScheduleId);
        specialtyWorkScheduleResponse.fold(
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
          (response) {
            emit(SpecialtyDoctorWorkScheduelResponseState(response));
          },
        );
      },
    );

    on<SetAppointmentPatient>(
      (event, emit) async {
        emit(SetAppointmentLoading());
        var setAppointment = await doctorRepository.setAppointment(
          event.doctorId,
          event.scheduelId,
          event.description,
        );
        setAppointment.fold(
          (exception) {
            emit(
              SetAppointmentError(
                ApiException(
                  statusCode: exception.statusCode,
                  message: exception.message,
                  type: exception.type,
                ),
              ),
            );
          },
          (r) {
            emit(SetAppointmentResponseState());
          },
        );
      },
    );
    // on<DisplayAllCenters>(
    //   (event, emit) async {
    //     emit(DoctorLoading());

    //     var cenetrs = await doctorRepository.fetchAllCenters();
    //     cenetrs.fold(
    //       (exception) {
    //         emit(DoctorError(exception));
    //       },
    //       (displayAllCenters) {
    //         emit(AllCenterResponseState(displayAllCenters));
    //       },
    //     );
    //   },
    // );
  }
}
