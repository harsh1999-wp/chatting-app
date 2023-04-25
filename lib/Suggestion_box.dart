import 'package:flutter/material.dart';
import 'package:medical_bot/pallete.dart';

class Suggestion_box extends StatelessWidget {
  final Color color;
  final String headerText;
  final String discriptionText;
  const Suggestion_box({Key? key, required this.color, required this.headerText, required this.discriptionText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
          margin: EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 10,
          ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(15),),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20).copyWith(
          left: 15,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(headerText,style: TextStyle(
                fontFamily: 'Cera Pro',
                color: Pallete.blackColor,
              ),
              ),
            ),
            Text(discriptionText,style: TextStyle(
              fontFamily: 'Cera Pro',
              color: Pallete.blackColor,
            ),),

          ],
        ),
      ),
    );
  }
}
