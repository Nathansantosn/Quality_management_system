import 'package:flutter/material.dart';

showSnackBar({
  required BuildContext context,
  required String texto,
  bool isErro = true,
}) {
  SnackBar snackBar = SnackBar(
    content: Text(texto),
    backgroundColor: (isErro) ? Colors.red : Colors.green,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    duration: const Duration(seconds: 4),
    action: SnackBarAction(
      label: 'Ok',
      textColor: Colors.white,
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
