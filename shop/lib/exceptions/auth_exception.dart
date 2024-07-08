class AuthException implements Exception {
  final String key;
  static const Map<String, String> errors = {
    "EMAIL_EXISTS": "E-mail existe",
    "OPERATION_NOT_ALLOWED": "Operação não permitida",
    "TOO_MANY_ATTEMPTS_TRY_LATER": "Muitas tentativas, tente mais tarde",
    "EMAIL_NOT_FOUND": "E-mail não encontrado",
    "INVALID_PASSWORD": "Senha inválida",
    "USER_DISABLED": "Usuário desabilitado",
  };

  const AuthException(this.key);

  @override
  String toString() {
    if (errors.containsKey(key)) {
      return errors[key]!;
    }
    return "Ocorreu um erro na autenticação";
  }
}
