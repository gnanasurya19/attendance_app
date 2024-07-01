import 'package:attendance_app/res/common_lib.dart';
import 'package:flutter/services.dart';

class InputWidget extends StatelessWidget {
  final TextCapitalization textCapitalization;
  final bool isPassword;
  final String placeholder;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? Function(String? value) validator;
  const InputWidget({
    super.key,
    required this.textCapitalization,
    required this.isPassword,
    required this.controller,
    required this.placeholder,
    required this.focusNode,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    var inputDecoration = InputDecoration(
      hintText: placeholder,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: AppColors.blue,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: AppColors.red,
          width: 2,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: AppColors.red,
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: AppColors.lightGrey,
          width: 2,
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.only(bottom: style.insets.md),
      child: TextFormField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(isPassword ? 4 : null)
        ],
        cursorColor: AppColors.blue,
        focusNode: focusNode,
        enabled: true,
        obscureText: isPassword,
        textCapitalization: textCapitalization,
        validator: validator,
        decoration: inputDecoration,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
