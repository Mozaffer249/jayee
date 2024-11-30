 import 'package:flutter/material.dart';
import 'package:taxi_app/app/data/common/app_colors.dart';
import 'package:taxi_app/app/data/common/constants.dart';

class BasicTextField extends StatelessWidget {
  const BasicTextField({
    Key? key,
    this.hintText,
    this.labelText,
    this.controller,
    this.suffix,
    this.prefix,
    this.readOnly = false,
    this.obsecure = false,
    this.validator,
    this.keyboardType,
    this.lines,
    this.minLine,
    this.hintTextStyle,
    this.labelTextStyle,
    this.onTap,
    this.onSubmit, this.onChanged,
  }) : super(key: key);

  final String? hintText, labelText;
  final TextStyle? hintTextStyle,labelTextStyle;
  final TextEditingController? controller;
  final Widget? suffix, prefix;
  final bool readOnly,obsecure;
  final String? Function(String? value)? validator;
  final TextInputType? keyboardType;
  final VoidCallback? onTap ;
  final Function(String)? onSubmit;
  final int? lines,minLine;
  final Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(labelText!, style:labelTextStyle ?? Theme.of(context).textTheme.bodySmall,),
        ),
        Padding(
          padding: EdgeInsets.all(4.0),
          child: Container(
            height: size.height*.07,
            decoration: BoxDecoration(
              color: Colors.white,
              // borderRadius: BorderRadius.circular(8),
              // border: Border.all(color: AppColors.greyTransparentColor)
            ),
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    style: TextStyle(fontSize: 14),
                    readOnly: readOnly,
                    validator: validator,
                    onChanged: onChanged,
                    keyboardType: keyboardType,
                    obscureText:obsecure ,
                    onTap: onTap,
                    maxLines: lines ?? 1,
                    minLines: minLine ?? 1,
                    onFieldSubmitted: onSubmit,
                    decoration: InputDecoration(
                      label:labelText != null ? Text(labelText!, style: TextStyle(color: grayeTextBackgroundColor,fontSize: 12),) : null,
                      hintText:hintText != null ? hintText : null ,
                      hintStyle:hintTextStyle ?? TextStyle(fontSize: 12,fontWeight: FontWeight.normal,color: Colors.black26),
                      prefixIcon: prefix != null ?prefix!:null,
                      suffixIcon: suffix != null?suffix!:null,
                      contentPadding: EdgeInsets.all(14),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.greyTransparentColor, // Color when the TextFormField is enabled but not focused
                            width: 1.0, // Width of the border
                          ),
                          borderRadius: BorderRadius.circular(8.0), // Optional: Adjust the border radius
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.grayTransparenrColor),
                        ),
                      border: OutlineInputBorder(),



                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
