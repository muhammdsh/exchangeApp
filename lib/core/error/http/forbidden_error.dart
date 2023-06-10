import '../http_error.dart';

class ForbiddenError extends HttpError with Exception {
  @override
  String toString() {
    return 'Forbidden';
  }
}