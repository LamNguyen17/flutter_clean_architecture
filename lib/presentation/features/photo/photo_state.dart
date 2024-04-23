import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/domain/entities/photo/photo.dart';

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
  final List<Hits> data;
  final bool hasReachedMax;
  final int currentPage;

  const PhotoLoaded(
      {required this.data, required this.hasReachedMax, required this.currentPage});

  @override
  List<Object> get props => [data, hasReachedMax, currentPage];
}

class PhotoError extends PhotoState {
  final String message;

  const PhotoError(this.message);

  @override
  List<Object> get props => [message];
}
