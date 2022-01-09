import 'package:esync_app/features/common/clip_wave_left_low_right_high.dart';
import 'package:flutter/material.dart';

class EndLoadinController extends StatelessWidget {
  const EndLoadinController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: ClipWaveLeftLowRightHigh(),
          child: Container(
            height: 70,
            color: Colors.pinkAccent,
          ),
        ),
      ],
    );
  }
}
