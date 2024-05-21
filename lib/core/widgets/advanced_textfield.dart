import 'package:clean_architecture/config/app_dimensions.dart';
import 'package:clean_architecture/core/theme/extension/theme_extension.dart';
import 'package:clean_architecture/core/widgets/enum/widget_style_type.dart';
import 'package:clean_architecture/core/widgets/model/advanced_border_model.dart';
import 'package:clean_architecture/core/widgets/model/advanced_icon_button_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvancedTextField extends ConsumerWidget {
  final String title;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final AdvancedBorderModel border;
  final String? hintText;
  final int? minLines;
  final int maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final bool isReadOnly;
  final Future<void> Function(String)? onChanged;
  final Future<void> Function(String?)? onSaved;
  final Future<void> Function(String)? onFieldSubmitted;
  final Future<void> Function()? onEditingComplete;
  final TextInputType keyboardType;
  final FloatingLabelAlignment floatingLabelAlignment;
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextCapitalization textCapitalization;
  final AdvancedIconButtonModel? prefixIconButton;
  final AdvancedIconButtonModel? suffixIconButton;

  const AdvancedTextField({
    super.key,
    required this.title,
    required this.textEditingController,
    required this.focusNode,
    this.textInputAction = TextInputAction.done,
    this.border = const AdvancedBorderModel(),
    this.hintText,
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.isReadOnly = false,
    this.onChanged,
    this.onSaved,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.keyboardType = TextInputType.text,
    this.floatingLabelAlignment = FloatingLabelAlignment.start,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.textCapitalization = TextCapitalization.sentences,
    this.prefixIconButton,
    this.suffixIconButton,
  });

  /// Creates a copy of this class.
  AdvancedTextField copyWith({
    String? title,
    TextEditingController? textEditingController,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
    AdvancedBorderModel? border,
    String? hintText,
    int? minLines,
    int? maxLines,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
    bool? isReadOnly,
    final Future<void> Function(String)? onChanged,
    final Future<void> Function()? onEditingComplete,
    TextInputType? keyboardType,
    FloatingLabelAlignment? floatingLabelAlignment,
    FloatingLabelBehavior? floatingLabelBehavior,
    TextCapitalization? textCapitalization,
    AdvancedIconButtonModel? prefixIconButton,
    AdvancedIconButtonModel? suffixIconButton,
  }) {
    return AdvancedTextField(
      title: title ?? this.title,
      textEditingController: textEditingController ?? this.textEditingController,
      focusNode: focusNode ?? this.focusNode,
      textInputAction: textInputAction ?? this.textInputAction,
      border: border ?? this.border,
      hintText: hintText ?? this.hintText,
      minLines: minLines ?? this.minLines,
      maxLines: maxLines ?? this.maxLines,
      maxLength: maxLength ?? this.maxLength,
      inputFormatters: inputFormatters ?? this.inputFormatters,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      onChanged: onChanged ?? this.onChanged,
      onEditingComplete: onEditingComplete ?? this.onEditingComplete,
      keyboardType: keyboardType ?? this.keyboardType,
      floatingLabelAlignment: floatingLabelAlignment ?? this.floatingLabelAlignment,
      floatingLabelBehavior: floatingLabelBehavior ?? this.floatingLabelBehavior,
      textCapitalization: textCapitalization ?? this.textCapitalization,
      prefixIconButton: prefixIconButton ?? this.prefixIconButton,
      suffixIconButton: suffixIconButton ?? this.suffixIconButton,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: AppDimensions.widgetHeight,
      width: MediaQuery.sizeOf(context).width,
      child: _createTextField(context: context),
    );
  }

  /// Creates a button.
  Widget _createTextField({required BuildContext context}) {
    return TextField(
      textInputAction: textInputAction,
      controller: textEditingController,
      focusNode: focusNode,
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      readOnly: isReadOnly,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      style: isReadOnly ? context.appTextStyles.mediumDisabledTextWithTransparentBackground : context.appTextStyles.mediumTextWithTransparentBackground,
      decoration: InputDecoration(
        label: Text(
          title,
          style: isReadOnly ? context.appTextStyles.mediumDisabledTextWithTransparentBackground : context.appTextStyles.mediumTextWithTransparentBackground,
        ),
        hintText: hintText,
        hintStyle: context.appTextStyles.mediumDisabledTextWithTransparentBackground,
        prefixIcon: _createIconButton(context: context, advancedIconButtonModel: prefixIconButton),
        suffixIcon: _createIconButton(context: context, advancedIconButtonModel: suffixIconButton),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        floatingLabelAlignment: floatingLabelAlignment,
        floatingLabelBehavior: floatingLabelBehavior,
        fillColor: isReadOnly ? context.appColors.transparentWidgetDisabledBackgroundColor : context.appColors.transparentWidgetBackgroundColor,
        focusedBorder: _getInputBorder(context: context),
        enabledBorder: _getInputBorder(context: context),
        focusedErrorBorder: _getInputBorder(context: context),
        errorBorder: _getInputBorder(context: context),
        disabledBorder: _getInputBorder(context: context),
        border: _getInputBorder(context: context),
      ),
    );
  }

  /// Creates a button.
  Widget? _createIconButton({required BuildContext context, required AdvancedIconButtonModel? advancedIconButtonModel}) {
    if (advancedIconButtonModel == null) {
      return null;
    }

    return IconButton(
      onPressed: advancedIconButtonModel.onTap,
      icon: Icon(advancedIconButtonModel.icon),
      tooltip: advancedIconButtonModel.tooltip,
      focusColor: context.appColors.transparentWidgetBackgroundColor,
      hoverColor: context.appColors.transparentWidgetBackgroundColor,
      splashColor: context.appColors.transparentWidgetBackgroundColor,
      disabledColor: context.appColors.transparentWidgetBackgroundColor,
      color: context.appColors.transparentWidgetBackgroundColor,
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(advancedIconButtonModel.onTap == null ? context.appColors.transparentWidgetDisabledForegroundColor : context.appColors.transparentWidgetForegroundColor),
        shape: WidgetStatePropertyAll(
          border.copyWith(hasBorder: false).getRoundedRectangleBorder(context: context, widgetStyleType: WidgetStyleType.transparent),
        ),
      ),
    );
  }

  /// Get input border.
  InputBorder _getInputBorder({required BuildContext context}) {
    return OutlineInputBorder(
      borderRadius: border.getBorderRadius(context: context),
      borderSide: border.getRoundedRectangleBorder(context: context, widgetStyleType: WidgetStyleType.transparent, isDisabled: isReadOnly).side,
    );
  }
}
