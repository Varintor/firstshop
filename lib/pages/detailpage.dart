import 'dart:math';

import 'package:confetti/confetti.dart'; // Import the package
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Detailpage extends StatefulWidget {
  // In a real app, you would pass data here, like:
  // final String title;
  // const Detailpage({Key? key, required this.title}) : super(key: key);

  @override
  _DetailpageState createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  // 1. Declare the ConfettiController
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();
    // 2. Initialize the controller. Define how long the confetti lasts per blast.
    _controllerCenter = ConfettiController(
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    // 3. Always dispose of the controller when the page is closed
    _controllerCenter.dispose();
    super.dispose();
  }

  /// A custom Path to draw stars for the confetti
  Path drawStar(Size size) {
    // Method to convert degrees to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(
        halfWidth + externalRadius * cos(step),
        halfWidth + externalRadius * sin(step),
      );
      path.lineTo(
        halfWidth + internalRadius * cos(step + halfDegreesPerStep),
        halfWidth + internalRadius * sin(step + halfDegreesPerStep),
      );
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Transparent AppBar to show gradient behind it
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Detail Overview",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      // 4. Use a Stack to layer content. Background at bottom, Confetti on top.
      body: Stack(
        children: [
          // --- Layer 1: Background Gradient ---
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.black12],
              ),
            ),
          ),

          // --- Layer 2: Main Page Content (Card) ---
          Center(
            child: Container(
              margin: const EdgeInsets.all(24.0),
              padding: const EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(
                  0.9,
                ), // Slightly transparent white
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Wrap content height
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Decorative Icon
                  Icon(
                    Icons.info_outline_rounded,
                    size: 60,
                    color: const Color.fromARGB(255, 43, 7, 59),
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Detail Information',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'This is the decorated Detail Page. Click the button below to trigger a screen celebration effect!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 30),

                  // --- The NEW Celebration Button ---
                  SizedBox(
                    width: double.infinity, // Make button full width
                    height: 50,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.amber.shade700, // Gold/Orange color
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                      ),
                      icon: const Icon(Icons.celebration),
                      label: const Text(
                        'CELEBRATE!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        // 5. Trigger the confetti controller to play
                        _controllerCenter.play();
                      },
                    ),
                  ),

                  const SizedBox(height: 15),

                  // --- The Go Back Button (Styled) ---
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.purple.shade700,
                    ),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 16,
                    ),
                    label: const Text(
                      'Go Back Home',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),

          // --- Layer 3: The Confetti Widget (On Top) ---
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController:
                  _controllerCenter, // Corrected parameter name from previous step
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
              ],
              createParticlePath: drawStar,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.2,
              // spread: 1.0,  <-- REMOVE THIS LINE

              // Add these instead to control the explosion size:
              maxBlastForce: 20, // How fast/far the farthest particles go
              minBlastForce: 5, // How fast/far the closest particles go
            ),
          ),
        ],
      ),
    );
  }
}
