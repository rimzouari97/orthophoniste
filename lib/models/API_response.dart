class APIResponse<T>{
  T data;
  String  token;
  bool errer;
  String errorMessage;

  APIResponse({this.data, this.errer, this.errorMessage});
}