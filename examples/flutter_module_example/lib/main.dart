import 'package:flutter/material.dart';
import 'package:one_sdk_flutter/one_sdk_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Example',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          ),
      home: MyHomePage(title: 'Flutter Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String SITE_KEY = "ONE-XABKKQ5X5E-1000";
  final String TOUCHPOINT = "android://flutter-example";
  final String API_KEY = "eff883bb-d4e5-4d0e-bba0-7c7094c3c112";
  final String SHARED_SECRET = "f22413d6-1667-46e5-bfcb-e0f9c61cb445";
  final String USER_ID = "apop@onedemo-presales";
  final String HOST = "https://onedemo.thunderhead.com";

  @override
  void initState() {
    super.initState();
    One.initializeOne(
        SITE_KEY, TOUCHPOINT, API_KEY, SHARED_SECRET, USER_ID, HOST, false);
    One.setThunderheadLogLevel(true);
    One.sendInteraction("/home", null);
  }

  @override
  Widget build(BuildContext context) {
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        backgroundColor: Color.fromARGB(255, 238, 81, 88),
      ),
      backgroundColor: Color.fromRGBO(31, 29, 40, 1.0),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            THImage(),
            RaisedButton(
              splashColor: Colors.pink,
              textColor: Colors.purple,
              color: Color.fromARGB(255, 238, 81, 88),
              child: Text(
                "Click to Navigate",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SecondRoute()))
                    // Send Interaction each time this view appears (when SecondRoute is popped of the view stack and returns to this view).
                    .then((value) => One.sendInteraction("/home", null));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class THImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage thImage = AssetImage("assets/images/thwhite.png");
    Image image = Image(image: thImage, width: 300.0, height: 200.0);
    return image;
  }
}

class SecondRoute extends StatelessWidget {
  void _sendInteraction(BuildContext context) async {
    var tid = await One.sendInteraction(
        "/secondPageButton", {'email': 'user@address.com'});
    var alert = AlertDialog(
      title: Text("Tid Result"),
      content: Text(tid),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  @override
  Widget build(BuildContext context) {
    One.sendInteraction("/secondPage", null);

    return Scaffold(
        appBar: AppBar(title: Text("Second Page")),
        body: Center(
          child: Text("Navigate back to send a new interaction request."),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              _sendInteraction(context);
            },
            label: Text('Send Interaction')));
  }
}
