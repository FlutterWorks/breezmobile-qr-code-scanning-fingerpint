import 'dart:async';

import 'package:breez/theme_data.dart';
import 'package:breez_translations/breez_translations_locales.dart';
import 'package:flutter/material.dart';

Future<void> promptError(
  BuildContext context,
  String title,
  Widget body, {
  String okText,
  String optionText,
  Function optionFunc,
  Function okFunc,
  bool disableBack = false,
  bool isRestoreFlow = false,
}) {
  bool canPop = !disableBack;
  canPopCallback() => Future.value(canPop);

  return showDialog<void>(
    useRootNavigator: false,
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      final texts = context.texts();
      final themeData = isRestoreFlow ? blueTheme : Theme.of(context);

      return Theme(
        data: themeData,
        child: WillPopScope(
          onWillPop: canPopCallback,
          child: AlertDialog(
            titlePadding: const EdgeInsets.fromLTRB(24.0, 22.0, 0.0, 16.0),
            contentPadding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
            title: title == null
                ? null
                : Text(
                    title,
                    style: themeData.dialogTheme.titleTextStyle,
                  ),
            content: SingleChildScrollView(
              child: body,
            ),
            actions: [
              optionText != null
                  ? TextButton(
                      child: Text(
                        optionText,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'IBMPlexSans',
                          fontSize: 16.4,
                          letterSpacing: 0.0,
                          color: themeData.dialogTheme.titleTextStyle.color,
                        ),
                      ),
                      onPressed: () {
                        canPop = true;
                        optionFunc();
                      },
                    )
                  : Container(),
              TextButton(
                child: Text(
                  okText ?? texts.error_dialog_default_action_ok,
                  style: themeData.primaryTextTheme.labelLarge,
                ),
                onPressed: () {
                  canPop = true;
                  Navigator.of(context).pop();
                  if (okFunc != null) {
                    okFunc();
                  }
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<bool> promptAreYouSure(
  BuildContext context,
  String title,
  Widget body, {
  contentPadding = const EdgeInsets.only(top: 32.0, left: 32.0, right: 32.0),
  bool wideTitle = false,
  String okText,
  String cancelText,
  bool isRestoreFlow = false,
}) {
  final texts = context.texts();
  final themeData = isRestoreFlow ? blueTheme : Theme.of(context);

  Widget titleWidget = title == null
      ? null
      : Text(
          title,
          style: themeData.dialogTheme.titleTextStyle,
        );
  if (titleWidget != null && wideTitle) {
    titleWidget = SizedBox(
      width: MediaQuery.of(context).size.width,
      child: titleWidget,
    );
  }
  return showDialog<bool>(
    useRootNavigator: false,
    context: context,
    builder: (BuildContext context) {
      return Theme(
        data: themeData,
        child: AlertDialog(
          contentPadding: contentPadding,
          title: titleWidget,
          content: SingleChildScrollView(child: body),
          actions: [
            TextButton(
              child: Text(
                cancelText ?? texts.error_dialog_default_action_no,
                style: themeData.primaryTextTheme.labelLarge,
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text(
                okText ?? texts.error_dialog_default_action_yes,
                style: themeData.primaryTextTheme.labelLarge,
              ),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        ),
      );
    },
  );
}

Future<bool> promptMessage(
  BuildContext context,
  String title,
  Widget body, {
  contentPadding = const EdgeInsets.only(top: 32.0, left: 32.0, right: 32.0),
  bool wideTitle = false,
  String closeText,
  bool isRestoreFlow = false,
}) {
  final texts = context.texts();
  final themeData = isRestoreFlow ? blueTheme : Theme.of(context);

  Widget titleWidget = title == null
      ? null
      : Text(
          title,
          style: themeData.dialogTheme.titleTextStyle,
        );
  if (titleWidget != null && wideTitle) {
    titleWidget = SizedBox(
      width: MediaQuery.of(context).size.width,
      child: titleWidget,
    );
  }
  return showDialog<bool>(
    useRootNavigator: false,
    context: context,
    builder: (BuildContext context) {
      return Theme(
        data: themeData,
        child: AlertDialog(
          contentPadding: contentPadding,
          title: titleWidget,
          content: SingleChildScrollView(
            child: body,
          ),
          actions: [
            TextButton(
              child: Text(
                closeText ?? texts.error_dialog_default_action_close,
                style: themeData.primaryTextTheme.labelLarge,
              ),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          ],
        ),
      );
    },
  );
}
