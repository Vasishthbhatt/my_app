part of 'api_bloc.dart';

@immutable
sealed class ApiState {}

abstract class ApiActionState extends ApiState {}

final class ApiInitial extends ApiState {}

class ApiLoadMoreDataState extends ApiActionState {
  final List<Post> posts;
  ApiLoadMoreDataState({required this.posts});
}

class ApiMoreDataLoadedState extends ApiState {}
