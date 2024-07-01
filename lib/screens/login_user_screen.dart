import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/cubit/cubit/auth_cubit.dart';
import 'package:my_app/cubit/cubit/data_login_cubit.dart';
import 'package:my_app/dto/login.dart';
import 'package:my_app/servis/dataservis.dart';
import 'package:my_app/utils/constants.dart';
import 'package:my_app/utils/secure_storage_util.dart';
import 'package:my_app/widgets/my_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;
  bool _loginFailed = false; // New variable to track login failure

  void isLogin(DataLoginCubit dataLogin) {
    final profile = context.read<DataLoginCubit>();
    final currentState = profile.state;
    debugPrint(currentState.roles);

    if (dataLogin.state.roles == 'admin') {
      Navigator.pushReplacementNamed(context, "/adminscreen");
    } else if (dataLogin.state.roles == 'teknisi') {
      Navigator.pushReplacementNamed(context, "/teknisiscreen");
    } else {
      Navigator.pushReplacementNamed(context, "/home");
    }
  }

  void sendLogin(BuildContext context, AuthCubit authCubit, DataLoginCubit dataLogin) async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    final response = await DataService.sendLoginData(username, password);
    if (response.statusCode == 200) {
      debugPrint("sending success");
      final data = jsonDecode(response.body);
      final loggedIn = Login.fromJson(data);
      await SecureStorageUtil.storage.write(key: tokenStoreName, value: loggedIn.accessToken);
      authCubit.login(loggedIn.accessToken);
      // ignore: use_build_context_synchronously
      getProfile(dataLogin, loggedIn.accessToken, context);
      debugPrint(loggedIn.accessToken);
      // ignore: use_build_context_synchronously
      _showLoginSuccessSnackbar(context); // Show green snackbar
    } else {
      setState(() {
        _loginFailed = true; // Set login failure state
      });
      // ignore: use_build_context_synchronously
      _showLoginFailedDialog(context); // Show pop-up alert
      debugPrint("failed not");
    }
  }

  void getProfile(DataLoginCubit profileCubit, String? accessToken, BuildContext context) {
    if (accessToken == null) {
      debugPrint('Access token is null');
      return;
    }

    DataService.fetchProfile(accessToken).then((profile) {
      debugPrint(profile.toString());
      profileCubit.setProfile(profile.roles, profile.userLogged);
      if (profileCubit.state.roles == 'admin') {
        Navigator.pushReplacementNamed(context, '/adminscreen');
      } else if (profileCubit.state.roles == 'teknisi') {
        Navigator.pushReplacementNamed(context, '/teknisiscreen');
      } else {
        Navigator.pushReplacementNamed(context, '/home');
      }
    }).catchError((error) {
      debugPrint('Error fetching profile: $error');
    });
  }

  void _showLoginFailedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login Failed'),
          content: const Text('Username atau password salah. Silakan coba lagi.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showLoginSuccessSnackbar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Login berhasil! Selamat Datang'),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _navigateToRegister(BuildContext context) {
    Navigator.pushNamed(context, '/register'); // Change this to your register screen route
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    final dataLogin = BlocProvider.of<DataLoginCubit>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Service Laptop',
              style: TextStyle(
                color: Color.fromARGB(255, 139, 108, 151),
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              "assets/images/servislaptop.jpg",
              width: 250,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(
                        color: _loginFailed ? const Color.fromARGB(255, 61, 22, 100) : Colors.black, // Change text color
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _loginFailed ? const Color.fromARGB(255, 61, 22, 100): Colors.black, // Change border color
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _loginFailed ? const Color.fromARGB(255, 61, 22, 100) : Colors.black, // Change border color
                        ),
                      ),
                      errorText: _loginFailed ? 'Silakan masukkan username' : null, // Error message
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: _loginFailed ? const Color.fromARGB(255, 61, 22, 100): Colors.black, // Change text color
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _loginFailed ? const Color.fromARGB(255, 61, 22, 100) : Colors.black, // Change border color
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _loginFailed ? const Color.fromARGB(255, 61, 22, 100): Colors.black, // Change border color
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible ? Icons.visibility : Icons.visibility_off,
                          color: _loginFailed ? const Color.fromARGB(255, 61, 22, 100) : Colors.black, // Change icon color
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      errorText: _loginFailed ? 'Silakan masukkan password' : null, // Error message
                    ),
                  ),
                  const SizedBox(height: 20),
                  MyButton(
                    customColor: const Color.fromARGB(255, 163, 135, 195),
                    text: "Login",
                    onTap: () {
                      sendLogin(context, authCubit, dataLogin);
                    },
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      _navigateToRegister(context);
                    },
                    child: const Text(
                      'Belum punya akun? Daftar di sini',
                      style: TextStyle(
                        color: Color.fromARGB(255, 61, 22, 100),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
