import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class DraggableFAB extends StatefulWidget {
  const DraggableFAB({super.key, required this.text});
  final text;
  @override
  State<DraggableFAB> createState() => _DraggableFABState();
}

class _DraggableFABState extends State<DraggableFAB> {
  final FlutterTts _tts = FlutterTts();
  Offset fabPosition = const Offset(35, 150); // Initial position of the FAB

  @override
  Widget build(BuildContext context) {
    Future voiceUp() async {
      await _tts.setLanguage("en-US");
      await _tts.setPitch(1);
      await _tts.setSpeechRate(0.4);
      await _tts.speak(widget.text);
    }

    return Stack(
      children: <Widget>[
        // Your main content here

        // Draggable FAB
        Positioned(
          left: fabPosition.dx,
          top: fabPosition.dy,
          child: Draggable(
            feedback: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.volume_up_outlined),
            ),
            child: FloatingActionButton(
              onPressed: () => voiceUp(),
              child: const Icon(Icons.volume_up_outlined),
            ), // Hide FAB when isFABVisible is false
            onDragEnd: (details) {
              setState(() {
                fabPosition =
                    details.offset; // Update FAB position when dragged
              });
            },
          ),
        ),
      ],
    );
  }
}
