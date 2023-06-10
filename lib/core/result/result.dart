

import '../error/base_error.dart';

class Result<E extends BaseError, D>{
  final E error;
  final D data;

  Result({this.data, this.error}){
    assert(data != null || error != null);
  }

  bool get hasDataAndError => data != null && error != null;

  bool get  hasDataOnly => data != null && error == null;

  bool get hasErrorOnly => data == null && error != null;

}