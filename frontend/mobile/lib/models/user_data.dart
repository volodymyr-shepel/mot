class UserData {
  String? email;
  String? password;
  String? firstName;
  String? lastName;

  UserData({
    this.email,
    this.password,
    this.firstName,
    this.lastName,
  });

  // Setters for updating properties
  void setEmail(String? newEmail) {
    email = newEmail;
  }

  void setPassword(String? newPassword) {
    password = newPassword;
  }


  void setFirstName(String? newFirstName) {
    firstName = newFirstName;
  }

  void setLastName(String? newLastName) {
    lastName = newLastName;
  }

  String? getEmail() {
    return email;
  }

  String? getPassword() {
    return password;
  }

  String? getFirstName() {
    return firstName;
  }

  String? getLastName() {
    return lastName;
  }

}
