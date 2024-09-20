import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_textstyle.dart';

Widget customTextField(
    {double? topPadding,
    double? bottomPadding,
    double? topFieldPadding,
    double? bottomFieldPadding,
    double? leftFieldPadding,
    double? rightFieldPadding,
    double? leftPadding,
    double? rightPadding,
    String? hintText,
    String? title,
    @required TextEditingController? textEditingController,
    Widget? suffix,
    Widget? prefix,
    bool obscureText = false,
    Color? textFieldBackgroundColor,
    Color? borderSideColor,
    Color? textColor,
    TextStyle? textStyle,
    int maxLines = 1,
    double borderRadius = 10,
    String? errorText,
    String? labelText,
    bool needValidation = false,
    Function? onTap,
    bool isEmailValidator = false,
    bool enable = true,
    bool isPasswordValidator = false,
    bool isPhoneValidator = false,
    bool isPinCodeValidator = false,
    bool isFirstName = false,
    String? validationMessage,
    TextInputType? textInputType,
    bool isReadOnly = false,
    bool autofocus = false,
    FocusNode? focusNode,
    TextCapitalization? textCapitalization,
    Function()? onPressed,
    int maxLength = 1000,
    Function(String)? onChange,
    onSubmitted,
    double? height,
    bool? isShowEditIcon,
    final suffixPadding,
    final prefixPadding,
    List<TextInputFormatter>? inputFormatters}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title != null
          ? Padding(padding: const EdgeInsets.only(left: 2, right: 15), child: Text(title, style: AppTextStyle.semiBold.copyWith(fontSize: 13)))
          : SizedBox(),
      SizedBox(
        height: title != null ? 5 : 0,
      ),
      Stack(
        alignment: Alignment.topRight,
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.disabled,
            inputFormatters: inputFormatters,
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            controller: textEditingController,
            obscureText: obscureText,
            maxLines: maxLines,
            maxLength: maxLength,
            autofocus: autofocus,
            onChanged: onChange,
            onFieldSubmitted: onSubmitted,
            focusNode: focusNode,
            validator: /*needValidation*/
                /*? (value) => TextFieldValidation.validation(
                      value: value ?? "",
                      isPasswordValidator: isPasswordValidator,
                      validationMessage: validationMessage,
                      isEmailValidator: isEmailValidator,
                      message: validationMessage ?? (hintText ?? title),
                      isPinCodeValidator: isPinCodeValidator,
                      isPhoneNumberValidator: isPhoneValidator,
                    )
                :*/
                null,
            keyboardType: textInputType ?? TextInputType.text,
            readOnly: isReadOnly,
            onTap: onPressed,
            onSaved: (v) {
              debugPrint("value is $v");
            },
            style: textStyle ?? AppTextStyle.medium.copyWith(fontSize: 14, color: textColor ?? AppColors.blackColor),
            enabled: enable,
            cursorColor: AppColors.whiteColor,
            decoration: InputDecoration(
              fillColor: textFieldBackgroundColor ?? AppColors.whiteColor,
              filled: true,
              labelText: labelText ?? " ",
              errorMaxLines: 2,
              errorStyle: AppTextStyle.medium.copyWith(
                color: AppColors.redColor,
                fontSize: 12,
              ),
              labelStyle: AppTextStyle.semiBold.copyWith(fontSize: 14, color: AppColors.lightGreyColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              counterText: "",
              enabledBorder: OutlineInputBorder(
                borderRadius: maxLines != 1 ? BorderRadius.circular(borderRadius) : BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: borderSideColor ?? AppColors.primaryColor.withOpacity(0.25),
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: maxLines != 1 ? BorderRadius.circular(borderRadius) : BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: AppColors.redColor.withOpacity(0.4),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: maxLines != 1 ? BorderRadius.circular(borderRadius) : BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: borderSideColor ?? AppColors.primaryColor,
                  width: 1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: maxLines != 1 ? BorderRadius.circular(borderRadius) : BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: AppColors.redColor.withOpacity(0.25),
                  width: 1,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: borderSideColor ?? AppColors.primaryColor.withOpacity(0.25),
                  width: 1,
                ),
              ),
              contentPadding: EdgeInsets.fromLTRB(leftFieldPadding ?? 20, topFieldPadding ?? 14, rightFieldPadding ?? 0, bottomFieldPadding ?? 14),
              suffixIcon: suffix != null
                  ? Padding(
                      padding: suffixPadding ?? const EdgeInsets.fromLTRB(16, 15, 12, 15),
                      child: suffix,
                    )
                  : null,
              prefixIcon: prefix != null
                  ? Padding(
                      padding: prefixPadding ?? const EdgeInsets.fromLTRB(16, 15, 12, 15),
                      child: prefix,
                    )
                  : null,
              hintText: hintText,
              hintMaxLines: 1,
              hintStyle: AppTextStyle.medium.copyWith(fontSize: 14, color: AppColors.blackColor.withOpacity(0.3)),
            ),
          ),
          isShowEditIcon == true
              ? Positioned(
                  right: -2,
                  top: -5,
                  child: InkWell(
                    onTap: () {
                      debugPrint("Here");
                      if (onTap != null) {
                        onTap();
                      }
                    },
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
                      elevation: 5,
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        child: const Icon(
                          Icons.edit_outlined,
                          size: 14,
                          color: Color(0xff444460),
                        ),
                      ),
                    ),
                  ))
              : const SizedBox()
        ],
      ),
    ],
  );
}

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? hint;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final bool readOnly;
  final bool enableInteractiveSelection;
  final GestureTapCallback? onTap;
  final VoidCallback? onEditingComplete;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? errorBorder;
  final int? maxLines;
  final int? maxLength;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry? contentPadding;
  final bool autofocus;
  final Color? fillColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final Function(String)? onChanged;

  const AppTextField(
      {super.key,
      this.controller,
      this.keyboardType = TextInputType.text,
      @required this.hint,
      this.inputFormatters,
      this.validator,
      this.obscureText = false,
      this.readOnly = false,
      this.onTap,
      this.enableInteractiveSelection = true,
      this.enabledBorder,
      this.focusedBorder,
      this.focusedErrorBorder,
      this.errorBorder,
      this.maxLines,
      this.maxLength,
      this.margin = const EdgeInsets.only(top: 0),
      this.autofocus = false,
      this.fillColor,
      this.prefixIcon,
      this.suffixIcon,
      this.onEditingComplete,
      this.focusNode,
      this.onChanged,
      this.contentPadding});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextFormField(
        onChanged: onChanged,
        autofocus: autofocus,
        focusNode: focusNode,
        enableInteractiveSelection: enableInteractiveSelection,
        onTap: onTap,
        obscureText: obscureText,
        onEditingComplete: onEditingComplete,
        readOnly: readOnly,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        maxLines: maxLines,
        maxLength: maxLength,
        style: AppTextStyle.regular.copyWith(color: AppColors.whiteColor, fontWeight: FontWeight.w600, fontSize: 14),
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 45,
            minHeight: 45,
          ),
          suffixIcon: suffixIcon,
          hintText: hint!,
          hintStyle: AppTextStyle.regular.copyWith(fontSize: 14, color: AppColors.greyColor, fontWeight: FontWeight.w500),
          filled: true,
          fillColor: fillColor ?? AppColors.lightBlackColor,
          contentPadding: contentPadding ?? const EdgeInsets.only(left: 15, top: 8,bottom: 8,right: 10),
          enabledBorder: enabledBorder ?? appOutlineInputBorder(),
          focusedBorder: focusedBorder ?? appOutlineInputBorder(),
          errorBorder: errorBorder ?? appOutlineInputBorder(color: AppColors.redColor),
          focusedErrorBorder: focusedErrorBorder ?? appOutlineInputBorder(color: AppColors.redColor),
          errorMaxLines: 2,
          errorStyle: const TextStyle(
            fontSize: 13,
            color: AppColors.redColor,
            fontWeight: FontWeight.w500,
          ),
          //   border: appOutlineInputBorder(),
        ),
      ),
    );
  }

  static OutlineInputBorder appOutlineInputBorder({Color? color, double? borderRadius}) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 30),
        borderSide: BorderSide(color: color ?? AppColors.primaryColor.withOpacity(0.2), width: 1),
      );
}
