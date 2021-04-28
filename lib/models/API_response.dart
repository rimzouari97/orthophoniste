class APIResponse<T>{
  T data;
  bool errer;
  String errorMessage;
  List<T> data1;

  APIResponse({this.data, this.errer, this.errorMessage,this.data1});
}