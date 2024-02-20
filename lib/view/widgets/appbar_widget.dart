import 'package:ecommerce/view/widgets/icon_widget.dart';
import 'package:ecommerce/view/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class AppBarWidgets {
  appBarWithAction(context,
      {required title,
      IconData? iconbutton,
      Color? color,
      VoidCallback? onPressed}) {
    Size size = MediaQuery.of(context).size;
    return AppBar(
      backgroundColor: color,
      foregroundColor: Colors.white,
      centerTitle: true,
      title: TextWidgets()
          .mainHeadingText(context, text: title, color: Colors.white),
      actions: [
        IconsWidgets().IconButtonWidget(context, size,
            color: Colors.white, iconData: iconbutton!, onPressed: onPressed)
      ],
    );
  }

  appBar(
    context, {
    Color? backgroundColor,
    Color? foregroundColor,
    required title,
  }) {
    return AppBar(
      centerTitle: true,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      title: TextWidgets().mainHeadingText(context,
          text: title, color: const Color.fromARGB(255, 219, 20, 20)),
    );
  }
}
