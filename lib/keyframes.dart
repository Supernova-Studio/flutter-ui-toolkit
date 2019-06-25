library supernova_flutter_ui_toolkit;

import 'dart:ui';

import 'package:flutter/animation.dart';

class Interpolation<T> extends Animatable<T> {

  Interpolation({
    List<Keyframe<T>> keyframes
  }): assert(keyframes.isNotEmpty),
        this.keyframes = _sorted(keyframes);

  final List<Keyframe<T>> keyframes;

  @override
  T transform(double t) {
    if (t <= this.keyframes.first.fraction) {
      return this.keyframes.first.value;
    }

    if (t >=  this.keyframes.last.fraction) {
      return this.keyframes.last.value;
    }

    if (this.keyframes.length == 1) {
      return this.keyframes.first.value;
    }

    return this._interpolate(t);
  }

  T _interpolate(double t) {

    Keyframe fromKeyframe;
    Keyframe toKeyframe;

    for(var i = 0; i < this.keyframes.length; i++) {
      Keyframe keyframe = this.keyframes[i];
      if (keyframe.fraction > t) {
        fromKeyframe = this.keyframes[i - 1];
        toKeyframe = this.keyframes[i];
        break;
      }
    }

    double currentTweenT = (t - fromKeyframe.fraction) / (toKeyframe.fraction - fromKeyframe.fraction);
    return this.performInterpolation(fromKeyframe, toKeyframe, currentTweenT);
  }

  T performInterpolation(Keyframe begin, Keyframe end, double t) {
    return begin.value + (end.value - begin.value) * t;
  }
}

class ColorInterpolation extends Interpolation<Color> {

  ColorInterpolation({
    List<Keyframe<Color>> keyframes
  }): super(keyframes: keyframes);

  @override
  Color performInterpolation(Keyframe begin, Keyframe end, double t) {
    return Color.lerp(begin.value, end.value, t);
  }
}

class OffsetInterpolation extends Interpolation<Offset> {

  OffsetInterpolation({
    List<Keyframe<Offset>> keyframes
  }): super(keyframes: keyframes);

  @override
  Offset performInterpolation(Keyframe begin, Keyframe end, double t) {
    return Offset.lerp(begin.value, end.value, t);
  }
}

class Keyframe<T> {

  Keyframe({
    this.fraction,
    this.value
  });

  final double fraction;
  final T value;
}

List<Keyframe> _sorted(List<Keyframe> keyframes) {
  keyframes.sort((lhs, rhs) {
    return lhs.fraction.compareTo(rhs.fraction);
  });

  return keyframes;
}