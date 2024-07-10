import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/providers/auth.dart';

enum AuthMode { Signup, Login }

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  GlobalKey<FormState> _form = GlobalKey();
  Map<String, String> _authData = {'email': '', 'password': ''};
  final _passwordController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;
  bool _isLoading = false;

  // Não é necessário com AnimatedContainer
  late AnimationController _controller;
  // late Animation<Size> _heightAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    // Não é necessário com AnimatedContainer
    // _heightAnimation = Tween(
    //   begin: Size(double.infinity, 280),
    //   end: Size(double.infinity, 340),
    // ).animate(
    //   CurvedAnimation(
    //     parent: _controller,
    //     curve: Curves.linear,
    //   ),
    // );

    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -1.5),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    // Não é necessário com AnimatedBuilder
    // _heightAnimation.addListener(() => setState(() {}));

    super.initState();
  }

  @override
  void dispose() {
    // Não é necessário com AnimatedContainer
    // _controller.dispose();
    super.dispose();
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Ocorreu um erro"),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Fechar'),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (_form.currentState == null) {
      return;
    }
    if (!_form.currentState!.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    _form.currentState!.save();

    Auth auth = Provider.of(context, listen: false);
    try {
      if (_authMode == AuthMode.Login) {
        await auth.login(_authData["email"]!, _authData["password"]!);
      } else {
        await auth.signup(_authData["email"]!, _authData["password"]!);
      }
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog("Ocorreu um erro inesperado");
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.linear,
        height: _authMode == AuthMode.Login ? 280 : 340,
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value != null &&
                      (value.isEmpty || !value.contains('@'))) {
                    return "Informe um e-mail válido!";
                  }
                  return null;
                },
                onSaved: (value) => _authData['email'] = value ?? "",
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                controller: _passwordController,
                validator: (value) {
                  if (value != null && (value.length < 5)) {
                    return "Informe um senha válida!";
                  }
                  return null;
                },
                onSaved: (value) => _authData['password'] = value ?? "",
              ),
              // if (_authMode == AuthMode.Signup)
              AnimatedContainer(
                constraints: BoxConstraints(
                  minHeight: _authMode == AuthMode.Signup ? 60 : 0,
                  maxHeight: _authMode == AuthMode.Signup ? 120 : 0,
                ),
                duration: Duration(milliseconds: 300),
                curve: Curves.linear,
                child: FadeTransition(
                  opacity: _opacityAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Comfirmar senha'),
                      obscureText: true,
                      validator: _authMode == AuthMode.Signup
                          ? (value) {
                              if (value != _passwordController.text) {
                                return "Senhas diferentes!";
                              }
                              return null;
                            }
                          : null,
                    ),
                  ),
                ),
              ),
              Spacer(),
              if (_isLoading)
                CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: Text(
                    _authMode == AuthMode.Login ? 'Entrar' : 'Registrar',
                    style: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              SizedBox(height: 16),
              TextButton(
                onPressed: _switchAuthMode,
                child: Text(
                  "Alternar para ${_authMode == AuthMode.Login ? 'Registrar' : 'Login'}",
                ),
              )
            ],
          ),
        ),
      ),

      // child: AnimatedBuilder(
      //   animation: _heightAnimation,
      //   builder: (ctx, child) => Container(
      //     width: deviceSize.width * 0.75,
      //     // height: _authMode == AuthMode.Login ? 280 : 340,
      //     height: _heightAnimation.value.height,
      //     padding: const EdgeInsets.all(16),
      //     child: child,
      //   ),
      //   child: Form(
      //     key: _form,
      //     child: Column(
      //       children: [
      //         TextFormField(
      //           decoration: InputDecoration(labelText: 'E-mail'),
      //           keyboardType: TextInputType.emailAddress,
      //           validator: (value) {
      //             if (value != null &&
      //                 (value.isEmpty || !value.contains('@'))) {
      //               return "Informe um e-mail válido!";
      //             }
      //             return null;
      //           },
      //           onSaved: (value) => _authData['email'] = value ?? "",
      //         ),
      //         TextFormField(
      //           decoration: InputDecoration(labelText: 'Senha'),
      //           obscureText: true,
      //           controller: _passwordController,
      //           validator: (value) {
      //             if (value != null && (value.length < 5)) {
      //               return "Informe um senha válida!";
      //             }
      //             return null;
      //           },
      //           onSaved: (value) => _authData['password'] = value ?? "",
      //         ),
      //         if (_authMode == AuthMode.Signup)
      //           TextFormField(
      //             decoration: InputDecoration(labelText: 'Comfirmar senha'),
      //             obscureText: true,
      //             validator: _authMode == AuthMode.Signup
      //                 ? (value) {
      //                     if (value != _passwordController.text) {
      //                       return "Senhas diferentes!";
      //                     }
      //                     return null;
      //                   }
      //                 : null,
      //           ),
      //         Spacer(),
      //         if (_isLoading)
      //           CircularProgressIndicator()
      //         else
      //           ElevatedButton(
      //             onPressed: _submit,
      //             style: ElevatedButton.styleFrom(
      //               backgroundColor: Theme.of(context).primaryColor,
      //             ),
      //             child: Text(
      //               _authMode == AuthMode.Login ? 'Entrar' : 'Registrar',
      //               style: TextStyle(
      //                 color: Theme.of(context).secondaryHeaderColor,
      //                 fontSize: 16,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //           ),
      //         SizedBox(height: 16),
      //         TextButton(
      //           onPressed: _switchAuthMode,
      //           child: Text(
      //             "Alternar para ${_authMode == AuthMode.Login ? 'Registrar' : 'Login'}",
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
