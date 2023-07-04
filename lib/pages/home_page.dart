import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_test/pages/Drawer.dart';
import 'package:tflite_test/widgets/generealpre.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String label = "";
  List labels = [];
  // String confidence = "";
  double confidence = 0;

  File? filepath;

  String information = '';

  Future<void> _initTfLite() async {
    String? res = await Tflite.loadModel(
        // model: "assets/modelTest.tflite",
        model: "assets/model_unquant2.tflite",
        labels: "assets/labels03.txt",
        numThreads: 1, // defaults to 1
        isAsset:
            true, // defaults to true, set to false to load resources outside assets
        useGpuDelegate:
            false // defaults to false, set to true to use GPU delegate
        );
  }

  getImageCamera() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) {
      return;
    }

    var imageMap = File(image.path);

    setState(() {
      filepath = imageMap;
    });

    var recognitions = await Tflite.runModelOnImage(
        path: image.path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1

        asynch: true // defaults to true
        );

    if (recognitions == null) {
      print("recognitions.... null");
      return;
    }

    print(recognitions[0]['confidence']);
    print(recognitions[0]['label']);
    // print(recognitions);

    setState(() {
      confidence = (recognitions[0]['confidence'] * 100);
      // labels = recognitions;
      label = recognitions[0]['label'].toString();
    });

    //Todo change the Conditions
    if (recognitions[0]['label'].toString() == "Melanoma") {
      setState(() {
        information = "is Melanoma ooh";
      });
    } else if (recognitions[0]['label'].toString() == "Basal cell carcinoma") {
      setState(() {
        information = "is Basal cell carcinoma ooh";
      });
    } else if (recognitions[0]['label'].toString() ==
        "Squamos cell carcinoma") {
      setState(() {
        information = "is Squamos cell carcinoma ooh";
      });
    } else {
      setState(() {
        information = "is Non cancerous ooh";
      });
    }
    //Todo change the end
  }

  getImageGallery() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return;
    }

    var imageMap = File(image.path);

    setState(() {
      filepath = imageMap;
    });

    var recognitions = await Tflite.runModelOnImage(
        path: image.path, // required
        imageMean: 0.0, // defaults to 117.0

        imageStd: 255.0, // defaults to 1.0

        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1

        asynch: true // defaults to true
        );

    if (recognitions == null) {
      print("recognitions.... null");
      return;
    }

    print(recognitions[0]['confidence']);
    print(recognitions[0]['label'].toString());
    // print(recognitions);

    // recognitions.map((e) {
    //   print(e);
    // });

    setState(() {
      confidence = (recognitions[0]['confidence'] * 100);
      // labels = recognitions;
      label = recognitions[0]['label'].toString();
    });
//Todo change the Conditions
    if (recognitions[0]['label'].toString() == "Melanoma") {
      setState(() {
        information = "is Melanoma ooh";
      });
    } else if (recognitions[0]['label'].toString() == "Basal cell carcinoma") {
      setState(() {
        information = "is Basal cell carcinoma ooh";
      });
    } else if (recognitions[0]['label'].toString() ==
        "Squamos cell carcinoma") {
      setState(() {
        information = "is Squamos cell carcinoma ooh";
      });
    } else {
      setState(() {
        information = "is Non cancerous ooh";
      });
    }
    //Todo: change the end
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  @override
  void initState() {
    super.initState();
    _initTfLite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(Icons.info_outline, size: 30.0),
        //   onPressed: () {
        //     Navigator.of(context).push(
        //       MaterialPageRoute(
        //         builder: (context) => const DetailsPage(),
        //       ),
        //     );
        //   },
        // ),
        title: const Text("Skin Cancer Detection"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white, size: 30.0),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/login_page/", (route) => false);
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: MyDrawer(),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 12,
              ),
              Card(
                elevation: 20,
                clipBehavior: Clip.hardEdge,
                child: SizedBox(
                  width: 300,
                  // height: 580,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 18,
                        ),
                        Container(
                          height: 280,
                          width: 280,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            image: const DecorationImage(
                                image: AssetImage('assets/IMG.jpg'),
                                fit: BoxFit.fill),
                          ),
                          child: filepath == null
                              ? const Text("")
                              : Image.file(
                                  filepath!,
                                  fit: BoxFit.fill,
                                ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                label,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                "The Accuracy is ${confidence.toStringAsFixed(0)}%",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                information,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  getImageCamera();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13.0)),
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  "Take a photo",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  getImageGallery();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13.0)),
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  "pick from gallery",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
