import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class DraggableFAB extends StatefulWidget {
  const DraggableFAB({super.key, required this.text, this.lang});
  final String? text;
  final String? lang;
  @override
  State<DraggableFAB> createState() => _DraggableFABState();
}

class _DraggableFABState extends State<DraggableFAB> {
  final FlutterTts _tts = FlutterTts();
  Offset fabPosition = const Offset(35, 150); // Initial position of the FAB
  bool _isListening = false;
  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future voiceUp() async {
      await _tts.setLanguage(widget.lang == 'en' ? "en-US" : 'ar-SA');
      await _tts.setPitch(1);
      await _tts.setSpeechRate(0.4);
      await _tts.speak(widget.text!);
      setState(() {
        _isListening = true;
      });
    }

    Future voicePause() async {
      await _tts.pause();

      setState(() {
        _isListening = false;
      });
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
              child:
                  Icon(!_isListening ? Icons.volume_up_outlined : Icons.pause),
            ),
            child: FloatingActionButton(
              onPressed: () => !_isListening ? voiceUp() : voicePause(),
              child:
                  Icon(!_isListening ? Icons.volume_up_outlined : Icons.pause),
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
