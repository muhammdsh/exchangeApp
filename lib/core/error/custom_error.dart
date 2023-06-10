import 'base_error.dart';

class CustomError extends BaseError {
  final String message;

  CustomError({this.message});

  @override
  String toString() {
    return message;
  }
  @override
  List<Object> get props => [];
}