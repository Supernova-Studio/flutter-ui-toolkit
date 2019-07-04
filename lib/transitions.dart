
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const Animation<Color> _defaultColorAnimation = AlwaysStoppedAnimation(Colors.transparent);
const Animation<double> _defaultDoubleAnimation = AlwaysStoppedAnimation<double>(0);
const Animation<Offset> _defaultOffsetAnimation = AlwaysStoppedAnimation(Offset.zero);

class DecorationTransition extends AnimatedWidget {

  DecorationTransition({
    Key key,
    this.child,
    this.colorAnimation = _defaultColorAnimation,
    this.borderColorAnimation = _defaultColorAnimation,
    this.borderWidthAnimation = _defaultDoubleAnimation,
    this.cornerRadiusAnimation = _defaultDoubleAnimation,
    this.shadowColorAnimation = _defaultColorAnimation,
    this.shadowRadiusAnimation = _defaultDoubleAnimation,
    this.shadowOffsetAnimation = _defaultOffsetAnimation
  }): super(key: key, listenable: Listenable.merge([
    colorAnimation, borderColorAnimation, borderWidthAnimation, cornerRadiusAnimation,
    shadowColorAnimation, shadowRadiusAnimation, shadowOffsetAnimation
  ]));

  final Widget child;

  final Animation<Color> colorAnimation;

  final Animation<Color> borderColorAnimation;
  final Animation<double> borderWidthAnimation;

  final Animation<double> cornerRadiusAnimation;

  final Animation<Color> shadowColorAnimation;
  final Animation<double> shadowRadiusAnimation;
  final Animation<Offset> shadowOffsetAnimation;

  @override
  Widget build(BuildContext context) {

    return DecoratedBox(
      decoration: BoxDecoration(
        color: this.colorAnimation.value,
        border: Border.all(
          color: this.borderColorAnimation.value,
          width: this.borderWidthAnimation.value,
        ),
        borderRadius: BorderRadius.all(Radius.circular(this.cornerRadiusAnimation.value)),

        boxShadow: [
          BoxShadow(
            color: this.shadowColorAnimation.value,
            blurRadius: this.shadowRadiusAnimation.value,
            offset: this.shadowOffsetAnimation.value
          )
        ]
      ),

      child: this.child,
    );
  }
}


class TranslationTransition extends AnimatedWidget {

  TranslationTransition({
    Key key,
    this.child,
    this.translationX = _defaultDoubleAnimation,
    this.translationY = _defaultDoubleAnimation,
  }): super(key: key, listenable: Listenable.merge([
    translationX, translationY
  ]));


  final Widget child;

  final Animation<double> translationX;
  final Animation<double> translationY;


  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(this.translationX.value, this.translationY.value),
      child: this.child,
    );
  }
}