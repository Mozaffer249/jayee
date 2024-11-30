import 'package:flutter/material.dart';
import 'package:taxi_app/app/data/common/constants.dart';

// ignore: must_be_immutable
class BasicButton extends StatelessWidget {
  final label;
  Function()? onPresed;
  double? verticalPadding;
  double? horzentalPadding;
  double? fontSize;
  double? raduis;
  final bool outline;
  final bool border;
   Color? buttonColor;
   Color? labelColor;

  BasicButton({
    Key? key,
    this.label,
    this.onPresed,
    this.verticalPadding,
    this.horzentalPadding,
    this.fontSize = 16.0,
    this.raduis = 16,
    this.outline = false,
    this.border = true,
    this.buttonColor ,
    this.labelColor ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      child: ElevatedButton(
        onPressed: onPresed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor == null ? backgroundColor : buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(raduis ?? 4),
          ),
        ),
        child: Center(
          child: label is String
              ? Text(
                  label,
                  style: TextStyle(
                    fontSize: fontSize,
                    color:labelColor == null ? Colors.white: labelColor,
                  ),
                ) : label,
        ),
      ),
    );
  }
}
