import 'package:equatable/equatable.dart';

abstract class PhotoState extends Equatable {
  const PhotoState();

  @override
  List<Object> get props => [];
}

class PhotoInitial extends PhotoState {
  const PhotoInitial();
}

class PhotoLoading extends PhotoState {
  const PhotoLoading();
}

class PhotoLoaded extends PhotoState {
  final dynamic data;
  final bool hasReachedMax;
  final int currentPage;

  const PhotoLoaded(
      {this.data, required this.hasReachedMax, required this.currentPage});

  @override
  List<Object> get props => [data, hasReachedMax, currentPage];
}

class PhotoError extends PhotoState {
  final String message;

  const PhotoError(this.message);

  @override
  List<Object> get props => [message];
}
