import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LoginProvider with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = '';
  String _userRole = '';
  String _userName = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String get userRole => _userRole;
  String get userName => _userName;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    const url = 'http://127.0.0.1:8000/api/login';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('token', responseData['token']);
        await prefs.setString('role', responseData['role']);
        await prefs.setString('name', responseData['user']['name']);
        _userRole = responseData['role'];
        _userName = responseData['user']['name'];

        notifyListeners();
        return true;
      } else {
        _errorMessage = responseData['message'] ?? 'Login gagal';
        notifyListeners();
        return false;
      }
    } catch (error) {
      _errorMessage = 'Terjadi kesalahan: $error';
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('token');
    await prefs.remove('role');
    await prefs.remove('name');
    notifyListeners();
    return true;
  }
}
