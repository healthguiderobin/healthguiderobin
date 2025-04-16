import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../data/clrs.dart';

class CustomField extends StatefulWidget {
  final TextEditingController textCon;
  final String? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final bool? isPassField;
  final bool? isEnabled;
  final TextInputType? inputType;
  final double? width, height;
  final FontWeight? txtFontWeight;
  final Color? fillClr;
  final Color? brdrClr;
  final double? txtSize;
  final EdgeInsets? cPadding;
  final Color? txtClr;
  final int? maxLine;
  final int? maxChar;
  final bool? autoFocusFlag;
  final InputBorder? inputBrdr;
  final TextInputAction? customAction;
  final Function(String)? onChangedFn;
  final TextAlign? textAlign;
  const CustomField(
      {Key? key,
      required this.textCon,
      this.prefixIcon,
      this.suffixIcon,
      required this.hintText,
      this.isPassField,
      this.isEnabled,
      this.inputType,
      this.width,
      this.height,
      this.txtFontWeight,
      this.fillClr,
      this.brdrClr,
      this.txtSize,
      this.cPadding,
      this.txtClr,
      this.maxLine,
      this.maxChar,
      this.autoFocusFlag,
      this.inputBrdr,
      this.onChangedFn,
      this.customAction,
      this.textAlign})
      : super(key: key);

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  bool obscureText = false;

  @override
  void initState() {
    obscureText = widget.isPassField ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? 388.w,
      height: widget.height ?? 50.h,
      child: TextField(
        // inputFormatters: widget.maxChar != null
        //     ? [
        //         LengthLimitingTextInputFormatter(widget.maxChar),
        //       ]
        //     : null,
        autofocus: widget.autoFocusFlag ?? false,
        textAlign: widget.textAlign ?? TextAlign.start,
        enabled: widget.isEnabled,
        onChanged: widget.onChangedFn,
        cursorColor: AppClrs.kPrimaryClr,
        textInputAction: widget.customAction ?? TextInputAction.done,
        maxLines: widget.isPassField != null ? 1 : widget.maxLine ?? 1,
        style: TextStyle(
          fontSize: widget.txtSize ?? 16.sp,
          fontWeight: widget.txtFontWeight ?? FontWeight.normal,
          color: widget.isEnabled != null
              ? widget.txtClr ?? Colors.grey.shade500
              : widget.txtClr ?? null,
        ),
        obscureText: obscureText,
        controller: widget.textCon,
        keyboardType: widget.inputType,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.fillClr ?? Colors.white,
          contentPadding: widget.cPadding ??
              EdgeInsets.only(
                left: 15.w,
                top: widget.maxLine != null ? 25.h : 0.h,
              ),
          border: widget.inputBrdr ?? getInputBorder(),
          enabledBorder: widget.inputBrdr ?? getInputBorder(),
          focusedBorder: widget.inputBrdr ?? getInputBorder(),
          disabledBorder: widget.inputBrdr ?? getInputBorder(),
          prefixIcon: widget.prefixIcon == null
              ? null
              : SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: Center(
                    child: SvgPicture.asset(
                      widget.prefixIcon!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: widget.txtSize ?? 16.sp,
            fontWeight: widget.txtFontWeight,
            color: AppClrs.kPrimaryClr.withOpacity(0.3),
          ),
          suffixIcon: widget.suffixIcon ??
              (widget.isPassField == null
                  ? null
                  : IconButton(
                      onPressed: () =>
                          setState(() => obscureText = !obscureText),
                      icon: Icon(
                        obscureText
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.black,
                      ),
                    )),
        ),
      ),
    );
  }

  InputBorder getInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(
        color: widget.isEnabled != null
            ? widget.brdrClr ?? Colors.grey.shade300
            : widget.brdrClr ?? AppClrs.kPrimaryClr.withOpacity(0.3),
        width: 1,
      ),
    );
  }
}
