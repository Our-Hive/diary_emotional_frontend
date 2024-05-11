class Validators {
  static bool isEmail(String email) {
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegExp.hasMatch(email);
  }

  // todo: 7 to password | 3 to username
  static bool isMinLength(String string, int length) {
    return string.length >= length;
  }

  static bool isSamePassword(String password, String confirmPassword) {
    return password == confirmPassword;
  }

  static bool isEmpty(String string) {
    return string.isEmpty;
  }
}
