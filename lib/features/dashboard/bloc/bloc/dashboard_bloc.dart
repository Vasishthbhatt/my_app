import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_app/features/dashboard/repo/dashboard_repo.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashBoardRepo _dashBoardRepo = DashBoardRepo();

  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<DashboardAddUserToCurrentGroupEvent>((event, emit) {
      _dashBoardRepo.addUserToTheCurrentGroup(event.groupId);
    });
  }
}
