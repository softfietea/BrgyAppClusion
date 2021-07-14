class CustomValidation {
  String emailValidation(String value) {
    String result;
    if (value == null) {
      result = "The Email should have a value";
    } else if (value.length > 50) {
      result = "The Email should not exceed in 50 letters";
    } else if (value.length < 4) {
      result = "Please insert a valid Email";
    } else
      return null;
  }

  String passwordValidation(String value) {
    String result;
    if (value == null) {
      result = "The password should have a value";
    } else if (value.length > 50) {
      result = "The password should not exceed in 50 letters";
    } else if (value.length < 6) {
      result = "Password should be atleast 6 letters";
    } else
      return null;
  }
}
