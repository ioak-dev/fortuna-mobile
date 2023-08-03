class AuthService {
  Future<bool> login(String username, String password) async {
    // API call for authorization
    await Future.delayed(Duration(seconds: 10));
    return username == "Chinmay" && password == "Cr7";
  }
}
