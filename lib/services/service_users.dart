class Users {

  BigInt id;
  String username;
  String password;
  int status;
  String email;
  int user_type;


  Users({
    required this.id,
    required this.username,
    required this.password,
    required this.status,
    required this.email,
    required this.user_type,
  });
}