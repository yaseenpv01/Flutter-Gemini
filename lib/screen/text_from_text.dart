import 'package:flutter/material.dart';
import 'package:flutter_gemini_test/provider/geminiProvider.dart';
import 'package:provider/provider.dart';

class TextFromTextScreen extends StatelessWidget {
  const TextFromTextScreen({super.key});

  static final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final geminiProvider = Provider.of<GeminiProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        geminiProvider.reset();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Text from Text ✨'),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 8,
                    child: TextField(
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
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        geminiProvider.generateContentFromText(
                            prompt: _textController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(16),
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                      ),
                      child: const Icon(Icons.send),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              geminiProvider.isLoading
                  ? const CircularProgressIndicator()
                  : AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: geminiProvider.response != null
                    ? Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        geminiProvider.response!,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

