import 'package:flutter/material.dart';
import 'package:paulonia_utils/paulonia_utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key = const Key(""), this.title = ""}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
                future: PUtils.checkNetwork(),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snap.data != null) return Text("There is Internet");
                  return Text("There isn't Internet");
                }),
            SizedBox(height: 40),
            PUtils.isOnRelease()
                ? Text("App is in Release")
                : Text("App is not in Release"),
            SizedBox(height: 40),
            PUtils.isOnTest()
                ? Text("App is in Test")
                : Text("App is not in Test"),
            SizedBox(height: 40),
            PUtils.isOnWeb()
                ? Text("App is running in Web")
                : Text("App is not running in Web"),
            SizedBox(height: 40),
            PUtils.isOnIOS()
                ? Text("App is running in iOS")
                : Text("App is not running in iOS"),
            SizedBox(height: 40),
            FutureBuilder(
                future: PUtils.getNTPDate(),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snap.data == null) return Text("NTP date: No Internet");
                  return Text("NTP date: " + snap.data.toString());
                }),
            SizedBox(height: 40),
            FutureBuilder(
              future: PUtils.supportsAppleSignIn(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snap.data != null)
                  return Text("The device supports Apple SignIn");
                return Text("The device not support Apple SignIn");
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
      ),
    );
  }
}
