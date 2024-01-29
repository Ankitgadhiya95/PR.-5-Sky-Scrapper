part of 'widgets.dart';

class ReusableCard extends StatelessWidget {
  final Color cardColor;
  //final Gradient cardGradient;
  // final EdgeInsetsGeometry cardPadding;
   final EdgeInsetsGeometry cardMargin;
  final Widget cardChild;
  ReusableCard({
    required this.cardColor,
    // required this.cardGradient,
    // required this.cardPadding,
    required this.cardMargin,
    required this.cardChild,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
     // padding: cardPadding,
      decoration: BoxDecoration(
        color: cardColor,
        //gradient: cardGradient,
        borderRadius: BorderRadius.circular(24.0),
      ),
     margin: cardMargin,
      child: cardChild,
    );
  }
}
