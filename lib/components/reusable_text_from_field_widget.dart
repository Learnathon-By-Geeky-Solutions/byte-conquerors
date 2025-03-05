import 'package:flutter/material.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';

class ReusableTextFormField extends StatefulWidget {
  const ReusableTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    this.onSuffixIconPress,
    this.onChanged,
    this.maxLines,
    this.showLabelText = true,
    this.makeUnfocus = true,
    this.readonly = false,
    this.onTap,
    this.validator,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.isPassword = false,
  });

  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final VoidCallback? onSuffixIconPress;
  final ValueChanged<String>? onChanged;
  final int? maxLines;
  final bool showLabelText;
  final bool makeUnfocus, readonly;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final AutovalidateMode autoValidateMode;
  final bool isPassword;

  @override
  State<ReusableTextFormField> createState() => _ReusableTextFormFieldState();
}

class _ReusableTextFormFieldState extends State<ReusableTextFormField> {
  late FocusNode _focusNode;
  final ValueNotifier<bool> _isFocusedNotifier = ValueNotifier(false);
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      _isFocusedNotifier.value = _focusNode.hasFocus;
    });

    _passwordVisible = !widget.isPassword;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _isFocusedNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isFocusedNotifier,
      builder: (context, isFocused, child) {
        return TextFormField(
          onTap: widget.onTap,
          readOnly: widget.readonly,
          maxLines: widget.isPassword ? 1 : widget.maxLines ?? 1,
          obscureText: widget.isPassword && !_passwordVisible,
          cursorColor: AppColors.primary,
          onChanged: widget.onChanged,
          controller: widget.controller,
          focusNode: _focusNode,
          validator: widget.validator,
          autovalidateMode: widget.autoValidateMode,
          onTapOutside: (_) {
            if (widget.makeUnfocus) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          keyboardType: widget.keyboardType,
          autocorrect: false,
          enableSuggestions: !widget.isPassword,
          decoration: InputDecoration(
            labelText: !widget.showLabelText
                ? null
                : isFocused
                    ? widget.hintText
                    : null,
            hintText: widget.hintText,
            alignLabelWithHint: widget.maxLines != null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.primary,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  )
                : null,
          ),
          style: Theme.of(context).textTheme.bodyLarge,
        );
      },
    );
  }
}
