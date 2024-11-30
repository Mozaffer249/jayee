import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app/app/data/common/app_colors.dart';
import 'package:taxi_app/app/data/models/payment_card.dart';

class PaymentCardOption extends StatelessWidget {
  final PaymentCard paymentCard;
  final bool selected;
  final VoidCallback? onTap;

  const PaymentCardOption({Key? key, required this.paymentCard,
    this.selected = false, this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Radio(
            value: selected,
            groupValue: true,
            onChanged: (val) =>onTap,
            fillColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.blueDarkColor;
              }
              return AppColors.blueDarkColor;
            })
        ),
        Row(
          children: [
            Text("${paymentCard.cardLast4Digits!}",
              style: GoogleFonts.cairo(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: selected ? Colors.indigo[900] : Colors.grey,
              ),
            ),
            Text("******",
              style: GoogleFonts.cairo(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: selected ? Colors.indigo[900] : Colors.grey,
              ),
            ),
          ],
        ),

      ],
    );
  }
}