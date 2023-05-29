import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class FractalPyramid extends StatefulWidget {
  const FractalPyramid({super.key});

  @override
  State<FractalPyramid> createState() => _FractalPyramidState();
}

class _FractalPyramidState extends State<FractalPyramid> with SingleTickerProviderStateMixin {
  double _time = 0.0;

  late final _ticker = createTicker((elapsed) {
    setState(() {
      _time += 0.06;
    });
  });

  @override
  void initState() {
    super.initState();
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("fractal pyramid"),
      ),
      body: ShaderBuilder(
        (context, shader, child) => AnimatedSampler(
          (image, size, canvas) {
            shader
              ..setFloat(0, _time)
              ..setFloat(1, size.width)
              ..setFloat(2, size.height);
            canvas.save();
            canvas.drawPaint(Paint()..shader = shader);
            canvas.restore();
          },
          child: child!,
        ),
        assetKey: 'shaders/fractal_pyramid.glsl',
        child: SizedBox(
          height: mediaQuery.size.height,
          width: mediaQuery.size.width,
        ),
      ),
    );
  }
}
