import 'package:flutter/material.dart';
import 'package:flutter_shader_demo/widget/invert.dart';
import 'package:flutter_shader_demo/widget/pixelate.dart';
import 'package:flutter_shader_demo/widget/pixelate_avg.dart';
import 'package:flutter_shader_demo/widget/pointillism.dart';
import 'package:flutter_shader_demo/widget/pointillism_transition.dart';
import 'package:flutter_shader_demo/widget/simple_shader.dart';

enum ShaderType {
  gradientH(SimpleShaderView(assetKey: 'shaders/gradient_h.frag')),
  gradient(SimpleShaderView(assetKey: 'shaders/gradient.frag')),
  invert(InvertView()),
  line(SimpleShaderView(assetKey: 'shaders/lines.frag')),
  pixelate(PixelateView()),
  pixelateAvg(PixelateAvgView()),
  animatedPixelate(AnimatedShaderView('shaders/pixelate_avg.frag')),
  pointillism(PointillismView()),
  animatedPointillism(AnimatedShaderView('shaders/pointillism.frag'));

  final Widget view;
  const ShaderType(this.view);
}

final ValueNotifier<ShaderType> _selection = ValueNotifier(ShaderType.values.first);

class Test2View extends StatelessWidget {
  const Test2View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Fractal 2')),
      backgroundColor: Colors.black,
      endDrawer: Drawer(
        child: Builder(builder: (context) {
          return ListView(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Shaders', style: textTheme.titleLarge),
                ),
              ),
              ...ShaderType.values.map(
                (e) => TextButton(
                  onPressed: () {
                    _selection.value = e;
                    Scaffold.of(context).closeEndDrawer();
                  },
                  child: Text(e.name),
                ),
              )
            ],
          );
        }),
      ),
      body: ValueListenableBuilder(
        valueListenable: _selection,
        builder: (context, value, _) => ShaderView(value),
      ),
    );
  }
}

class ShaderView extends StatelessWidget {
  final ShaderType type;

  const ShaderView(this.type, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          type.view,
          // Align(
          //   alignment: Alignment.topRight,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: ElevatedButton(
          //       child: const Icon(Icons.list),
          //       onPressed: () => Scaffold.of(context).openEndDrawer(),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
