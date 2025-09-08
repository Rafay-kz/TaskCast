import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/theme/app_theme.dart';

class CustomPrimaryButton extends StatelessWidget {
  String? title;
  final Function onButtonPressed;
  String? iconPath;
  bool? iconLeft = false;
  bool? iconRight = false;
  double? width;
  Color? bgColor;
  Color? textColor;
  Color? borderColor;
  final double? height;

  CustomPrimaryButton(
      {this.title,
        required this.onButtonPressed,
        this.iconPath,
        this.iconLeft,
        this.iconRight,
        this.width,
        this.bgColor,
        this.textColor,
        this.borderColor,
        this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 50,
      child: ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.resolveWith<double>(
                  (Set<MaterialState> states) {
                return 0; // Defer to the widget's default.
              },
            ),
            foregroundColor: textColor == null
                ? MaterialStateProperty.all<Color>(AppTheme.lightBackground)
                : MaterialStateProperty.all<Color>(textColor!),
            backgroundColor: bgColor == null
                ? MaterialStateProperty.all<Color>(
                Theme.of(context).primaryColorDark)
                : MaterialStateProperty.all<Color>(bgColor!),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                        color: borderColor == null
                            ? Theme.of(context).secondaryHeaderColor
                            : borderColor!)))),
        onPressed: () {
          onButtonPressed();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconLeft == true
                ? Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SvgPicture.asset(
                width: 20,
                height: 20,
                iconPath!,
                color: textColor,
              ),
            )
                : Container(),
            Flexible(
              child: Text(
                "$title",
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13),
              ),
            ),
            iconRight == true
                ? Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SvgPicture.asset(
                width: 20,
                height: 20,
                iconPath!,
                color: textColor,
              ),
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}
