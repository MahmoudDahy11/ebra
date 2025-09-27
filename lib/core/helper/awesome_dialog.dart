import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

/*
 * showDialogMessage function
 * displays a customizable dialog using AwesomeDialog package
 */
void showDialogMessage(
  BuildContext context, {
  DialogType dialogType = DialogType.error,
  String title = "Error",
  String desc = "",
  VoidCallback? onOk,
  VoidCallback? onCancel,
}) {
  AwesomeDialog(
    context: context,
    dialogType: dialogType,
    animType: AnimType.scale, 
    headerAnimationLoop: false,
    borderSide: BorderSide(
      color: dialogType == DialogType.success
          ? Colors.green
          : dialogType == DialogType.error
          ? Colors.red
          : Colors.blueAccent,
      width: 2,
    ),
    btnOkColor: dialogType == DialogType.success
        ? Colors.green
        : dialogType == DialogType.error
        ? Colors.red
        : Colors.blueAccent,
    buttonsBorderRadius: const BorderRadius.all(Radius.circular(12)),
    dismissOnTouchOutside: true,
    dismissOnBackKeyPress: true,
    dialogBorderRadius: BorderRadius.circular(20), 
    title: title,
    titleTextStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    desc: desc,
    descTextStyle: const TextStyle(fontSize: 16, color: Colors.black87),
    btnCancelOnPress: onCancel,
    btnOkOnPress: onOk,
    btnCancelText: "Cancel",
    btnOkText: "OK",
  ).show();
}
