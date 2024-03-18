part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

class DashboardAddUserToCurrentGroupEvent extends DashboardEvent {
  final String groupId;

  DashboardAddUserToCurrentGroupEvent({required this.groupId});
}
