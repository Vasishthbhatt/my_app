part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

@immutable
sealed class DashboardActionState extends DashboardState {}

final class DashboardInitial extends DashboardState {}

class DashboardAddUserToTheCurrentDashboardGroupState extends DashboardState {
  final String grouId;

  DashboardAddUserToTheCurrentDashboardGroupState({required this.grouId});
}
