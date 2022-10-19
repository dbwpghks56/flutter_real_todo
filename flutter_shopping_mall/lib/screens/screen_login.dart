import '../models/model_auth.dart';
import '../models/model_login.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ScreenLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginFieldModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("로그인 화면"),
        ),
        body: Column(
          children: [
            EmailInput(),
            PasswordInput(),
            LoginButton(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(thickness: 1,),
            ),
            RegisterButton(),
          ],
        ),
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginField = Provider.of<LoginFieldModel>(context, listen: false);

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: TextField(
        onChanged: (email) {
          loginField.setEmail(email);
        },
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          labelText: "이메일",
          helperText: '',
        ),
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginField = Provider.of<LoginFieldModel>(context, listen: false);

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: TextField(
        onChanged: (password) {
          loginField.setPassword(password);
        },
        obscureText: true,
        decoration: const InputDecoration(
          labelText: "비밀번호",
          helperText: '',
        ),
      ),
    );
  }
}
class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authClient = Provider.of<FirebaseAuthProvider>(context, listen: false);
    final loginfield = Provider.of<LoginFieldModel>(context, listen: false);

    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () async {
          await authClient.loginWithEmail(loginfield.email, loginfield.password).then((value) {
            if(value == AuthStatus.loginSuccess) {
              print(value);
              ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
                SnackBar(content: Text('${loginfield.email}님 환영합니다.'))
              );
              Navigator.of(context).pushReplacementNamed('/index');
            } else {
              ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
                 const SnackBar(content: Text('로그인에 실패했습니다. 다시시도해주세요.'))
              );
            }
          });
        },
        child: const Text('로그인'),
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/register');
      },
      child: Text('이메일로 회원가입하기', style: TextStyle(
        color: theme.primaryColor,
      ),),
    );
  }
}
