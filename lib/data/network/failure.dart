class Failure {
  int code; // 200,201,400,404 and so on
  String message; // error , success
  
  Failure(this.code, this.message);
}
