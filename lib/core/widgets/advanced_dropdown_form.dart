import 'package:clean_architecture/config/app_dimensions.dart';
import 'package:clean_architecture/core/theme/extension/theme_extension.dart';
import 'package:clean_architecture/config/app_icons.dart';
import 'package:clean_architecture/core/widgets/enum/widget_style_type.dart';
import 'package:clean_architecture/core/widgets/model/advanced_border_model.dart';
import 'package:clean_architecture/core/widgets/model/advanced_dropdown_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvancedDropdownForm extends ConsumerWidget {
  final String title;
  final IconData titleIcon;
  final List<AdvancedDropdownItemModel> options;
  final AdvancedDropdownItemModel selectedItem;
  final Future<void> Function(AdvancedDropdownItemModel?) onChanged;
  final AdvancedBorderModel border;

  const AdvancedDropdownForm({
    super.key,
    required this.title,
    required this.titleIcon,
    required this.options,
    required this.selectedItem,
    required this.onChanged,
    this.border = const AdvancedBorderModel(),
  });

  /// Creates a copy of this class.
  AdvancedDropdownForm copyWith({
    String? title,
    IconData? titleIcon,
    List<AdvancedDropdownItemModel>? options,
    AdvancedDropdownItemModel? selectedItem,
    Future<void> Function(AdvancedDropdownItemModel?)? onChanged,
    AdvancedBorderModel? border,
  }) {
    return AdvancedDropdownForm(
      title: title ?? this.title,
      titleIcon: titleIcon ?? this.titleIcon,
      options: options ?? this.options,
      selectedItem: selectedItem ?? this.selectedItem,
      onChanged: onChanged ?? this.onChanged,
      border: border ?? this.border,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: AppDimensions.widgetHeight,
      width: MediaQuery.sizeOf(context).width,
      child: InputDecorator(
        decoration: _createDropdownBorder(context: context),
        child: Row(
          children: <Widget>[
            const SizedBox(width: 10),
            Icon(titleIcon, color: context.appColors.transparentWidgetForegroundColor),
            const SizedBox(width: 10),
            Text(
              '$title:',
              style: context.appTextStyles.mediumTextWithTransparentBackground,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<AdvancedDropdownItemModel>(
                  borderRadius: border.getBorderRadius(context: context),
                  value: selectedItem,
                  isExpanded: true,
                  onChanged: onChanged,
                  style: context.appTextStyles.mediumTextWithTransparentBackground,
                  icon: _createDropdownIcon(context: context),
                  dropdownColor: context.appColors.appBarBackgroundColor,
                  items: _createDropdownItemList(context: context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Creates the dropdown icon widget.
  Widget? _createDropdownIcon({required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Icon(
        AppIcons.dropdownIcon,
        color: context.appColors.transparentWidgetForegroundColor,
      ),
    );
  }

  /// Creates the dropdown border.
  InputDecoration _createDropdownBorder({required BuildContext context}) {
    return InputDecoration(
      contentPadding: EdgeInsets.zero,
      enabledBorder: _getInputBorder(context: context),
      focusedBorder: _getInputBorder(context: context),
      errorBorder: _getInputBorder(context: context),
      disabledBorder: _getInputBorder(context: context),
      focusedErrorBorder: _getInputBorder(context: context),
      border: _getInputBorder(context: context),
    );
  }

  /// Get input border.
  InputBorder? _getInputBorder({required BuildContext context}) {
    return UnderlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: border.getRoundedRectangleBorder(context: context, widgetStyleType: WidgetStyleType.transparent).side,
    );
  }

  /// Creates the dropdown item list.
  List<DropdownMenuItem<AdvancedDropdownItemModel>>? _createDropdownItemList({required BuildContext context}) {
    return options.map<DropdownMenuItem<AdvancedDropdownItemModel>>((item) {
      return DropdownMenuItem<AdvancedDropdownItemModel>(
        value: item,
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Row(
            children: <Widget>[
              const SizedBox(width: 10),
              Icon(
                item.icon,
                color: context.appColors.transparentWidgetForegroundColor,
              ),
              const SizedBox(width: 10),
              Flexible(
                fit: FlexFit.tight,
                child: Text(
                  item.title,
                  style: context.appTextStyles.mediumTextWithTransparentBackground,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      );
    }).toList();
  }
}
