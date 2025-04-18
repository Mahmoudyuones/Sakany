class AppValidator {
  static bool isEmailValid(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  static bool isPhoneValid(String phone) {
    final phoneRegex = RegExp(r'^(010|011|012|015)\d{8}$');
    return phoneRegex.hasMatch(phone);
  }
}
