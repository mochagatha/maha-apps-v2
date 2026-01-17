import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:maha_apps_v2/widgets/colors.dart';
import 'package:maha_apps_v2/widgets/font.dart';

Widget customTextFieldApprovalTitleCustom({
  required String title,
  required BuildContext context,
  required TextEditingController controller,
  String? labelText,
  required String textValueKosong,
  Widget? prefixIcon,
  Widget? suffixIcon,
  TextInputType? keyboardType,
  bool onlyNumbers = false,
  bool formatMoney = false,
  bool isEnabled = true,
  double top = 20,
  double paddingTop = 10.0,
  TextCapitalization textCapitalization = TextCapitalization.none,
  Function(String)? onChanged,
  required Widget titleText,
  int maxLine = 1,
}) {
  return Padding(
    padding: EdgeInsets.only(top: top),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText,
        CustomTextFormField(
          maxLine: maxLine,
          onChanged: onChanged,
          enabled: isEnabled,
          textCapitalization: textCapitalization,
          keyboardType: keyboardType,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          controller: controller,
          paddingTop: paddingTop,
          labelText: labelText ?? "",
          validator: (value) {
            if (value!.isEmpty) {
              return textValueKosong;
            }
            return null;
          },
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'^\s')),
            if (onlyNumbers) FilteringTextInputFormatter.digitsOnly,
            if (formatMoney)
              TextInputFormatter.withFunction((oldValue, newValue) {
                final newText = newValue.text.replaceAll('.', '');
                if (newText.isEmpty) {
                  return TextEditingValue.empty;
                }

                final formatter = NumberFormat("#,###", "id_ID");
                final formattedText = formatter.format(
                  int.tryParse(newText) ?? 0,
                );

                return TextEditingValue(
                  text: formattedText,
                  selection: TextSelection.collapsed(
                    offset: formattedText.length,
                  ),
                );
              }),

            // if (formatMoney)
            //   TextInputFormatter.withFunction((oldValue, newValue) {
            //     final newText = newValue.text.replaceAll('.', '');
            //     if (newText.isEmpty) {
            //       return TextEditingValue.empty;
            //     }

            //     // Menggunakan NumberFormat untuk format dengan titik
            //     final formatter = NumberFormat("#,###", "id_ID");
            //     final formattedText =
            //         formatter.format(int.tryParse(newText) ?? 0);

            //     return newValue.copyWith(text: formattedText);
            //   }),
          ],
          onSaved: (value) {
            controller.text = value!;
          },
        ),
      ],
    ),
  );
}

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final Function(String?)? onSaved;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Function()? onTap;
  final bool readOnly;
  final TextCapitalization textCapitalization;
  final TextInputType? keyboardType;
  final bool enabled;
  final Color disableColor;
  final Color labelTextColor;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final double paddingTop;
  final int maxLine;
  final Function(String)? onChanged;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.onSaved,
    this.onChanged,
    this.inputFormatters,
    this.validator,
    this.controller,
    this.onTap,
    this.readOnly = false,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType,
    this.enabled = true,
    this.disableColor = Colors.grey,
    this.labelTextColor = Colors.grey,
    this.focusNode,
    this.suffixIcon,
    this.obscureText = false,
    this.paddingTop = 18.0,
    this.prefixIcon,
    this.maxLine = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: paddingTop),
      child: TextFormField(
        maxLines: maxLine,
        controller: controller,
        obscureText: obscureText,
        readOnly: readOnly,
        onTap: onTap,
        cursorColor: AppColors.primaryColor,
        inputFormatters: inputFormatters,
        focusNode: focusNode,
        decoration: textInputDecoration.copyWith(
          labelText: labelText,
          labelStyle: TextStyle(color: labelTextColor),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: disableColor),
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        textCapitalization: textCapitalization,
        keyboardType: keyboardType,
        onSaved: onSaved,
        onChanged: onChanged,
        enabled: enabled,
      ),
    );
  }
}
