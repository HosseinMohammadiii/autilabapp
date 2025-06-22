class ApiException {
  int statusCode;
  String message;
  ApiException({required this.statusCode, required this.message}) {
    switch (statusCode) {
      case 401:
        message = "Malformed data or validations failed.";
        break;
    }
  }
}
