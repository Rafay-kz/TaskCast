import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class CustomPrimaryTextField extends StatelessWidget {
  const CustomPrimaryTextField({
    Key? key,
    required this.labelText,
    this.helperText,
    this.inputType,
    required this.textEditingController, this.maxLines,  this.minLines,this.isRequiredField=false, this.readOnly=false, this.onTap, this.prefixIcon, this.suffixIcon, this.enabled,this.maxLength
  }) : super(key: key);

  final String labelText;
  final TextInputType? inputType;
  final int? maxLines;
  final int? maxLength;
  final int? minLines;
  final bool isRequiredField;
  final bool readOnly;
  final bool? enabled;
  final String? helperText;
  final Function()? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      minLines: minLines,
      keyboardType: inputType,
      controller: textEditingController,
      readOnly: readOnly,
      enabled: enabled,
      onTap: onTap,
      maxLength: maxLength,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        alignLabelWithHint: true,
        labelStyle:  TextStyle(color: AppTheme.darkBackground),
        helperText: helperText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide:  BorderSide(width: 1, color: AppTheme.secondaryColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(width: 1, color: AppTheme.secondaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(width: 1, color: AppTheme.warningColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(width: 1, color:AppTheme.secondaryColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(width: 1, color: AppTheme.secondaryColor),
        ),
        label: isRequiredField?Text.rich(
          TextSpan(
              text: labelText,
              children: const <InlineSpan>[
                TextSpan(
                  text: '*',
                  style: TextStyle(color: AppTheme.warningColor),
                )
              ]
          ),

        ):Text(labelText),
      ),
    );
  }
}
