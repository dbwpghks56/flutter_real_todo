import 'dart:async';
import 'package:flutter_shopping_mall/models/model_auth.dart';
import 'package:flutter_shopping_mall/models/model_cart.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSplash extends StatefulWidget {

  @override
  _ScreenSplashState createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  Future<bool> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final authClient = Provider.of<FirebaseAuthProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    bool isLogin = prefs.getBool('isLogin') ?? false;
    print("[*] 로그인 상태 : ${isLogin.toString()}");

    if(isLogin) {
      String? email = prefs.getString('email');
      String? password = prefs.getString('password');
      print('[+] 저장된 정보로 로그인 시도');

      await authClient.loginWithEmail(email!, password!).then((value) {
        if(value == AuthStatus.loginSuccess) {
          print('[+] 로그인 성공');
          cartProvider.fetchCartItemsOrAddCart(authClient.user);
        } else {
          print('[+] 로그인 실패');
          isLogin = false;
          prefs.setBool('isLogin', false);
        }
      });

    }
    return isLogin;
  }
  
  void moveScreen() async {
    await checkLogin().then((value) {
      if(value) {
        Navigator.of(context).pushReplacementNamed("/index");
      } else {
        Navigator.of(context).pushReplacementNamed("/login");
      }
    });
  }
  
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1500), () {
      moveScreen();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: null,
      body: Center(
        child: Text("Splash Screen"),
      ),
    );
  }
}
