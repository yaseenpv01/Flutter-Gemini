import 'package:flutter/material.dart';
import 'package:flutter_gemini_test/provider/geminiProvider.dart';
import 'package:flutter_gemini_test/provider/mediaProvider.dart';

import 'package:provider/provider.dart';

class TextFromImageScreen extends StatelessWidget {
  const TextFromImageScreen({super.key});

  static final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final geminiProvider = Provider.of<GeminiProvider>(context);
    final mediaProvider = Provider.of<MediaProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        mediaProvider.reset();
        geminiProvider.reset();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Text from Image ✨', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          elevation: 0,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  mediaProvider.bytes == null
                      ? IconButton(
                    onPressed: () {
                      mediaProvider.setImage();
                    },
                    icon: const Icon(Icons.add_a_photo, color: Colors.blueAccent),
                    iconSize: 50,
                  )
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.memory(
                      mediaProvider.bytes!,
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Enter your prompt here...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (mediaProvider.bytes != null)
                    ElevatedButton(
                      onPressed: () {
                        geminiProvider.generateContentFromImage(
                          prompt: _textController.text,
                          bytes: mediaProvider.bytes!,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Generate', style: TextStyle(fontSize: 18)),
                    ),
                  const SizedBox(height: 24),
                  geminiProvider.isLoading
                      ? const CircularProgressIndicator()
                      : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      geminiProvider.response ?? '',
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
