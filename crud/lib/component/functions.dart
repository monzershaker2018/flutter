String? validPassword(value) {
  if (value == null || value.trim().isEmpty) {
    return "* Required";
  }  if (value.length < 6) {
    return "Password should be at least 6 characters";
  }  if (value.length > 15) {
    return "Password should not be greater than 15 characters";
  }
  return null;
}

RegExp regExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

String? validEmail(value) {
  if (value == null || value.trim().isEmpty) {
    return ' the email vaild is Required ';
  }
  if (value.length < 4) {
    return "Email should be at least 4 characters ";
  }
  if (value.length > 25) {
    return "Password should not be greater than 25 characters";
  }
  if (!regExp.hasMatch(value)) {
    return "Email in not valid";
  }
  return null;
}
