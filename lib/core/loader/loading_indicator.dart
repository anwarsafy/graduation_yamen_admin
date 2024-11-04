import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
Widget loadingIndicator({Color? color}){
  return Center(
    child: LoadingAnimationWidget.threeRotatingDots(

      color: color ??Colors.blueGrey,
      size: 50,
    ),
  );
}