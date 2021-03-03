class APIResponse<T>{
  T data;
  bool errer;
  String errorMessage;

  APIResponse({this.data, this.errer, this.errorMessage});
}