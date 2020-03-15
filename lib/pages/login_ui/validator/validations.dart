class ValidationsLogin {
  static bool isValidUser(String user) {
    return user.length > 6 && user.contains("@") && user != null;
  }

  static bool isValidPassword(String passWord) {
    return passWord.length > 6 && passWord!=null;
  }
}
