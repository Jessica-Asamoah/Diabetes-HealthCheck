import 'package:chatbot/views/chatbot.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: const Dashboard(),
      routes: {'/chatbot/': (context) => const ChatBot()},
    ),
  );
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        // extendBodyBehindAppBar: true,
        // appBar: AppBar(
        //   centerTitle: true,
        //   automaticallyImplyLeading: false,
        //   leading: const Padding(
        //     padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        //     child: CircleAvatar(
        //       backgroundImage:
        //           AssetImage('assets/images/photo_2023-03-30_12-47-30.jpg'),
        //     ),
        //   ),
        //   title: const Padding(
        //     padding: EdgeInsets.fromLTRB(0, 0, 220, 0),
        //     child: Text(
        //       'Hi,\nAwura',
        //     ),
        //   ),
        //   actions: <Widget>[
        //     Container(
        //       margin: const EdgeInsets.fromLTRB(0, 8, 15, 8),
        //       child: const Icon(Icons.menu),
        //     )
        //   ],
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        // ),
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/image_2023-06-09_13-38-14.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                CircleAvatar(
                  backgroundImage:
                      AssetImage("assets/images/photo_2023-03-30_12-47-30.jpg"),
                ),
                Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 50.0,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(18.0),
            child: Text(
              "Welcome, Awuradjoa",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Wrap(
                spacing: 20.0,
                runSpacing: 20.0,
                children: [
                  SizedBox(
                    width: 329.0,
                    height: 203.0,
                    child: Card(
                      color: const Color(0xFFF4F4F4),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(44.0)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(35.0),
                          child: Column(children: [
                            Image.asset(
                              "assets/images/camera.png",
                              width: 64.0,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const Text(
                              "Camera",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const Text("Check for Calories",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w100))
                          ]),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 329.0,
                    height: 203.0,
                    child: Card(
                      color: const Color(0xFFF4F4F4),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(44.0)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(35.0),
                          child: Column(children: [
                            Image.asset(
                              "assets/images/chatbot.png",
                              width: 50.0,
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const ChatBot()));
                              },
                              child: const Text(
                                "ChatDBT",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 1.0,
                            ),
                            const Text("Ask me Anything",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w100))
                          ]),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 329.0,
                    height: 203.0,
                    child: Card(
                      color: const Color(0xFFF4F4F4),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(44.0)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(35.0),
                          child: Column(children: [
                            Image.asset(
                              "assets/images/idea.png",
                              width: 64.0,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const Text(
                              "Tips",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const Text("Get some health tips",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w100))
                          ]),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    ));
  }
}
