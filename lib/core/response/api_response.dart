class ApiResponse<T>{

  bool hasError;
  String msg;
  T result;

  ApiResponse(this.msg, this.hasError, this.result);
}