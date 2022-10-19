import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/model_auth.dart';
import '../models/model_register.dart';

class ScreenRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => RegisterFieldModel(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("로그인 화면"),
          ),
          body: Column(
            children: [
              EmailInput(),
              PasswordInput(),
              PasswordConfirmInput(),
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
    final registerField = Provider.of<RegisterFieldModel>(context, listen: false);
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: TextField(
        onChanged: (email) {
          registerField.setEmail(email);
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
    final registerField = Provider.of<RegisterFieldModel>(context, listen: false);

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: TextField(
        onChanged: (password) {
          registerField.setPassword(password);
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

class PasswordConfirmInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final registerField = Provider.of<RegisterFieldModel>(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: TextField(
        onChanged: (password) {
          registerField.setPasswordConfirm(password);
        },
        obscureText: true,
        decoration: InputDecoration(
          labelText: "비밀번호 확인",
          helperText: '',
          errorText: registerField.password != registerField.passwordConfirm ? '비밀번호가 일치하지 않습니다.' : null,
        ),
      ),
    );
  }
}
class RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authClient = Provider.of<FirebaseAuthProvider>(context,listen: false);
    final registerField = Provider.of<RegisterFieldModel>(context, listen: false);

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
          await authClient.registerWithEmail(registerField.email, registerField.password)
          .then((value) {
            if(value == AuthStatus.registerSuccess) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(content: Text('회원가입이 완료되었습니다.')),
                );
              Navigator.of(context).pop();
            } else {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(content: Text('회원가입에 실패했습니다. 다시 시도해주세요.')),
                );
            }
          });

        },
        child: const Text('회원가입'),
      ),
    );
  }
}

