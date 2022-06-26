import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
const mainColor = Color(0xffF07824);
const accentColor = Color(0xffFDF2EA);
class SnakeButton extends StatefulWidget {
  final Widget child;
  const SnakeButton({Key key,  this.child}) : super(key: key);
  @override
  _SnakeButtonState createState() => _SnakeButtonState();
}

class _SnakeButtonState extends State<SnakeButton>
    with SingleTickerProviderStateMixin {
   AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: accentColor,
      child: CustomPaint(
        painter: _CustomPainter(
          animation: _controller,
        ),
        child: Container(
          alignment: Alignment.center,
          child: widget.child,
        ),
      ),
    );
  }
}

class _CustomPainter extends CustomPainter {
  final Animation animation;
  final Color snakeColor;
  final Color borderColor;
  final double borderWidth;
  _CustomPainter({
     this.animation,
    this.snakeColor = mainColor,
    this.borderColor = Colors.white,
    this.borderWidth = 4.0,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..shader = SweepGradient(
        colors: [
          snakeColor,
          Colors.transparent,
        ],
        stops: [
          0.7,
          1.0,
        ],
        startAngle: 0,
        endAngle: vector.radians(80),
        transform: GradientRotation(vector.radians(360.00 * (animation.value))),
      ).createShader(rect);
    final path = Path.combine(
      PathOperation.xor,
      Path()..addRect(rect),
      Path()
        ..addRect(
          rect.deflate(borderWidth),
        ),
    );
    //path.addRect(rect);
    canvas.drawRect(
        rect.deflate(borderWidth / 2),
        Paint()
          ..color = Colors.white
          ..strokeWidth = borderWidth
          ..style = PaintingStyle.stroke);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
