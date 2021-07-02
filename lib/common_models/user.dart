class User {
  final String email;
  final String firstname;
  final String fullname;
  final String username;

  User(
      {this.email = '',
      this.firstname = '',
      this.fullname = '',
      this.username = ''});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] ?? '',
      firstname: json['first_name'] ?? '',
      username: json['username'] ?? '',
      fullname: json['full_name'] ?? '',
    );
  }
}
