import 'package:flutter/material.dart';

class LoginPembeliScreen extends StatefulWidget {
  @override
  _LoginPembeliScreenState createState() => _LoginPembeliScreenState();
}

class _LoginPembeliScreenState extends State<LoginPembeliScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  static const snackBar_emptylogin = SnackBar(
    content: Text(
      'Username dan Password tidak boleh kosong!',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: Color.fromARGB(255, 43, 43, 43),
  );
  static const snackBar_wronglogin = SnackBar(
    content: Text(
      'Username dan Password yang anda masukkan salah!',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.red,
  );

  void _login() {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar_emptylogin);
    } else {
      if (username == 'ghina' && password == '123') {
        Navigator.pushNamed(context, '/homepage-pembeli');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(snackBar_wronglogin);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Masuk Akun Pembeli',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 28),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Silahkan masukan nomor handphone & kata sandi akun anda yang telah terdaftar untuk masuk ke aplikasi',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
              SizedBox(height: 36),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Masukkan username atau email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Masukkan Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/lupasandi');
                    },
                    child: Text(
                      'Lupa Kata Sandi?',
                      style: TextStyle(
                        color: Colors.green,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  fixedSize: Size.fromHeight(56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Belum punya akun? ', style: TextStyle(fontSize: 14)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/register-pembeli');
                    },
                    child: Text('Daftar Sekarang',
                        style: TextStyle(color: Colors.green, fontSize: 14)),
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
