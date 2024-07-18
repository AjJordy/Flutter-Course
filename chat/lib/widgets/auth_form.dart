import 'package:chat/models/auth_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthData authData) onSubmit;
  const AuthForm(this.onSubmit, {super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final AuthData _authData = AuthData();
  final GlobalKey<FormState> _formKey = GlobalKey();

  _submit() {
    bool isValid = _formKey.currentState?.validate() ?? false;
    FocusScope.of(context).unfocus(); // Fecha o teclado
    if (isValid) {
      widget.onSubmit(_authData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    key: const ValueKey('name'),
                    initialValue: _authData.name ?? "",
                    decoration: const InputDecoration(labelText: 'Nome'),
                    onChanged: (value) => _authData.name = value,
                    validator: (value) {
                      if (value == null || value.trim().length < 4) {
                        return "Nome deve ter no mínimo 4 caracteres";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    key: const ValueKey('email'),
                    decoration: const InputDecoration(labelText: 'E-mail'),
                    onChanged: (value) => _authData.email = value,
                    validator: (value) {
                      if (value == null || !value.contains('@')) {
                        return "Forneça um e-mail válido";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    key: const ValueKey('password'),
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'senha'),
                    onChanged: (value) => _authData.password = value,
                    validator: (value) {
                      if (value == null || value.trim().length < 7) {
                        return "A senha deve ter no mínimo 7 caracteres";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text(_authData.isLogin ? 'Entrar' : 'Cadastrar'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() => _authData.toggleMode());
                    },
                    child: Text(
                      _authData.isLogin
                          ? 'Criar nova conta ?'
                          : 'Já possui uma conta ?',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
