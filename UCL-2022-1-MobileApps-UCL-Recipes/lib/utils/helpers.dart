import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String? validateEmail(String? value) {
  const String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  final RegExp regex = RegExp(pattern);
  if (value == null || !regex.hasMatch(value)) {
    return 'Formato de e-mail inválido';
  } else {
    return null;
  }
}

String? validatePassword(String? value) {
  return value == null || value.isEmpty || value.length < 4
      ? 'Campo obrigatório (mín. 4 caracteres)'
      : null;
}

String? validateName(String? value) {
  return value == null || value.isEmpty || value.length < 4
      ? 'Campo obrigatório (mín. 4 caracteres)'
      : null;
}

bool validateForm(GlobalKey<FormState> formKey, BuildContext context) {
  FocusScope.of(context).unfocus();
  if (!formKey.currentState!.validate()) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Preencha os campos corretamente'),
    ));
    return false;
  }
  return true;
}
