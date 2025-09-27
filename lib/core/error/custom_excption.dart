/*
 * CustomException class
 * represents a custom exception with an error message
 */
class CustomException implements Exception {
  final String errMessage;

  // Constructor
  CustomException({required this.errMessage});
  // Override toString method to provide a meaningful error message
  @override
  String toString() {
    return errMessage;
  }
}
