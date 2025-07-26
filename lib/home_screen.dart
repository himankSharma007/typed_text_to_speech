import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController _controller = TextEditingController();

  double pitch = 1.0;
  double textSize = 18.0;
  String language = "en-US";

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage(language);
    await flutterTts.setPitch(pitch);
    await flutterTts.speak(text);
  }

  void _openSettings() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[800],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Settings",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Pitch
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Pitch",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                pitch -= 0.1;
                                if (pitch < 0.5) pitch = 0.5;
                              });
                              setModalState(() {});
                            },
                            icon: const Icon(
                              Icons.arrow_downward,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            pitch.toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                pitch += 0.1;
                                if (pitch > 2.0) pitch = 2.0;
                              });
                              setModalState(() {});
                            },
                            icon: const Icon(
                              Icons.arrow_upward,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Text Size
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Text Size",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                textSize -= 2;
                                if (textSize < 10) textSize = 10;
                              });
                              setModalState(() {});
                            },
                            icon: const Icon(
                              Icons.arrow_downward,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            textSize.toStringAsFixed(0),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                textSize += 2;
                              });
                              setModalState(() {});
                            },
                            icon: const Icon(
                              Icons.arrow_upward,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Language toggle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Language",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            language = language == "en-US" ? "hi-IN" : "en-US";
                          });
                          setModalState(() {});
                        },
                        child: Text(language == "en-US" ? "English" : "Hindi"),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    flutterTts.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text(
          "TTS Machine",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _openSettings,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _controller,
                style: TextStyle(color: Colors.white, fontSize: textSize),
                decoration: const InputDecoration(
                  labelText: "Enter text here",
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    _speak(_controller.text);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(150, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: const Text("Speak"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
