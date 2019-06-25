library supernova_flutter_ui_toolkit;

import 'package:flutter/animation.dart';


List<Keyframe> _sorted(List<Keyframe> keyframes) {
  keyframes.sort((lhs, rhs) {
    return lhs.fraction.compareTo(rhs.fraction);
  });

  return keyframes;
}

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

    double tweenLength = toKeyframe.fraction - fromKeyframe.fraction;
    double currentTweenT = (t - fromKeyframe.fraction) / tweenLength;
    return fromKeyframe.value + (toKeyframe.value - fromKeyframe.value) * currentTweenT;
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