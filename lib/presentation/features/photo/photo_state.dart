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

class PhotoSuccess extends PhotoState {
  final dynamic data;

  const PhotoSuccess(this.data);
}

class PhotoError extends PhotoState {
  final String message;
  const PhotoError(this.message);
}
