import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'validator_event.dart';
part 'validator_state.dart';

class ValidatorBloc extends Bloc<ValidatorEvent, ValidatorState> {
  ValidatorBloc() : super(ValidatorInitial()) {
    on<ValidatorEvent>((event, emit) {
      emit(ValidatorTypingState());
    });
  }
}
