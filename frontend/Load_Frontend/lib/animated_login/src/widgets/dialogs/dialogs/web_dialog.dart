import 'package:load_frontend/animated_login/src/models/animated_dialog_theme.dart';
import 'package:load_frontend/animated_login/src/responsiveness/dynamic_size.dart';
import 'package:load_frontend/animated_login/src/widgets/dialogs/dialogs/base_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Web specific alert dialog.
class PlatformDialog with BaseDialog {
  /// Web specific alert dialog.
  const PlatformDialog({
    this.contentText,
    this.actionText,
    this.willPop = true,
    this.isDismissible = true,
    this.action,
    this.content,
    this.title,
    this.contentPaddingFactor,
  });

  /// Text of the content.
  final String? contentText;

  /// Bool to determine whether popping is allowed.
  final bool willPop;

  /// Whether the dialog can be dismissible.
  final bool isDismissible;

  /// Content widget for the dialog.
  final Widget? content;

  /// Title of the dialog.
  final Widget? title;

  /// Async callback to call on pressed.
  final AsyncCallback? action;

  /// Padding factor for the content.
  final double? contentPaddingFactor;

  /// Call to action text.
  final String? actionText;

  /// Builds the dialog.
  Widget build(BuildContext context, AnimatedDialogTheme dialogTheme) =>
      AlertDialog(
        shape: dialogTheme.shape ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: dialogTheme.elevation ?? 5,
        backgroundColor:
            dialogTheme.backgroundColor ?? Colors.white.withOpacity(.9),
        title: title,
        content: Padding(
          padding: dialogTheme.contentPadding ??
              EdgeInsets.all(
                DynamicSize(context).responsiveSize *
                    (contentPaddingFactor ?? 3),
              ),
          child: getContent(
            context,
            contentText: contentText,
            content: content,
            dialogTheme: dialogTheme,
          ),
        ),
        actions: getButtons(
          context,
          action: action,
          actionText: actionText,
          willPop: willPop,
          dialogTheme: dialogTheme,
        ),
      );
}
