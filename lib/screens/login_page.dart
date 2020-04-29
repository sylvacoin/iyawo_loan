import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iyawo/blocs/login/login_bloc.dart';
import 'package:iyawo/repositories/auth_repository.dart';


class LoginPage extends StatefulWidget {
  final AuthRepository authRepo;

  LoginPage({@required this.authRepo});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _loginFormKey = GlobalKey<FormState>();

  TextEditingController _usernameCtrl = TextEditingController();
  TextEditingController _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _doLogin() {
      BlocProvider.of<LoginBloc>(context).add(OnLoginButtonPressed(
          password: _passwordCtrl.text, username: _usernameCtrl.text));
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailed) {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          body: new GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SafeArea(
              child: Container(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      Text('Login',
                          style: TextStyle(
                            fontSize: 35.0,
                          )),
                      SizedBox(height: 50.0),
                      new Form(
                        key: _loginFormKey,
                        child: Column(children: <Widget>[
                          TextFormField(
                            controller: _usernameCtrl,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Email Address',
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 25),
                          TextFormField(
                            controller: _passwordCtrl,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Password',
                            ),
                            obscureText: true,
                          ),
                          SizedBox(height: 25),
                          Builder(
                              builder: (context) => RaisedButton(
                                  padding: EdgeInsets.only(
                                      top: 15, bottom: 15, left: 50, right: 50),
                                  onPressed:
                                      state is! LoginLoading ? _doLogin : null,
                                  color: Colors.deepPurple,
                                  child: Text(
                                      state is LoginLoading
                                          ? 'Please wait...'
                                          : 'Login',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ))))
                        ]),
                      ),
                    ],
                  )),
            ),
          ),
        );
      }),
    );
  }
}
