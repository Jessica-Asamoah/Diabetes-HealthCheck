import 'dart:io';
import 'package:camera/camera.dart';
import 'package:chatbot/views/api.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class RecScreen extends StatefulWidget {
  const RecScreen({Key? key}) : super(key: key);

  @override
  State<RecScreen> createState() => _RecScreenState();
}

class _RecScreenState extends State<RecScreen> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;
  bool isReady = false;
  List<dynamic>? recognitions;
  String? detectedLabel; // Add this variable

  int direction = 0;

  // Add TFLite model variables
  late String modelPath;
  late String labelsPath;
  bool isModelLoaded = false;

  @override
  void initState() {
    modelPath = 'assets/FruitsINC1.tflite';
    labelsPath = 'assets/fruit_labels.txt';
    loadModel();
    startCamera(0);
    super.initState();
  }

  Future<void> loadModel() async {
    try {
      await Tflite.loadModel(
        model: modelPath,
        labels: labelsPath,
      );
      isModelLoaded = true;
    } catch (e) {
      print('Error loading model: $e');
    }
  }

  void startCamera(int direction) async {
    cameras = await availableCameras();

    cameraController = CameraController(
        cameras[direction], ResolutionPreset.high,
        enableAudio: false);

    await cameraController.initialize().then((value) {
      isReady = true;
      if (!mounted) {
        return;
      }

      setState(() {});
      //to refresh widget
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    Tflite.close();
    super.dispose();
  }

  Future<void> runModel(File imageFile) async {
    if (!isModelLoaded) return;

    recognitions = await Tflite.runModelOnImage(
      path: imageFile.path,
      numResults: 1, // Maximum number of results to display
    );

    // Assign the label to the detectedLabel variable
    detectedLabel = recognitions![0]['label'];

    // Handle the list of recognition results here
    for (var recognition in recognitions!) {
      print('Label: ${recognition['label']}');
      print('Confidence: ${recognition['confidence']}');
      // You can also access other properties like 'rect' for bounding box coordinates
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isReady) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Capture Food"),
          backgroundColor: const Color(0XFFff5a5f),
        ),
        body: Stack(
          children: [
            SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: CameraPreview(cameraController),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  direction = direction == 0 ? 1 : 0;
                  startCamera(direction);
                });
              },
              child:
                  button(Icons.flip_camera_ios_outlined, Alignment.bottomLeft),
            ),
            GestureDetector(
              onTap: () {
                cameraController.takePicture().then((XFile? file) async {
                  if (mounted && file != null) {
                    print("Picture saved to ${file.path}");
                    await runModel(File(file.path));
                  }
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DisplayPictureScreen(
                        // Pass the automatically generated path to
                        // the DisplayPictureScreen widget.
                        imagePath: file!.path,
                        recognitions: recognitions!,
                        detectedLabel: detectedLabel, // Pass the detected label
                      ),
                    ),
                  );
                });
              },
              child: button(Icons.camera_alt_outlined, Alignment.bottomCenter),
            ),
            GestureDetector(
              onTap: () async {
                final pickedImage =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedImage != null) {
                  File imageFile = File(pickedImage.path);
                  await runModel(imageFile);

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DisplayPictureScreen(
                        imagePath: imageFile.path,
                        recognitions: recognitions!,
                        detectedLabel: detectedLabel, // Pass the detected label
                      ),
                    ),
                  );
                }
              },
              child:
                  button(Icons.photo_library_outlined, Alignment.bottomRight),
            ),
            // Align(
            //   alignment: AlignmentDirectional.topCenter,
            //   child: Text(
            //     "Check Calories",
            //     style: TextStyle(fontSize: 30, color: Colors.amber),
            //   ),
            // )
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget button(IconData icon, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.only(
          left: 20,
          bottom: 20,
        ),
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(2, 2),
                blurRadius: 10,
              )
            ]),
        child: Center(
          child: Icon(
            icon,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final List<dynamic> recognitions;
  final String? detectedLabel;

  const DisplayPictureScreen({
    Key? key,
    required this.imagePath,
    required this.recognitions,
    this.detectedLabel, // Initialize the detected label
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Object Detection Results'),
        backgroundColor: Color(0xFF5390d9),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image.file(File(imagePath)),
          ),
          SizedBox(height: 10),
          Text(
            'Detected Objects:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              itemCount: recognitions.length,
              itemBuilder: (context, index) {
                var label = recognitions[index]['label'];
                var confidence = recognitions[index]['confidence'];
                return ListTile(
                  title: Text('$label - ${confidence.toStringAsFixed(2)}'),
                );
              },
            ),
          ),
          SizedBox(height: 5), // Add some space
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          TestApi(query: detectedLabel ?? '')));
              // Handle the 'Check Calories' button press
              // You can navigate to a new screen or perform an action here
            },
            child: Text('Check Calories'),
          ),
        ],
      ),
    );
  }
}
