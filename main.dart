import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gala/Dance.dart';
import 'package:gala/Music.dart';
import 'package:gala/WorkShop.dart';
import 'Schedule.dart';


void main() {
  runApp(
    MaterialApp(
      title: 'Kashiyatra GalaGuide',
      home: SplashPage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

// Splash Page
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => HomePage()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: const Stack(
        children: [
          Positioned(
            child: Image(
              image: AssetImage('assets/Image/BHU.png'),
              width: 150,
              height: 75,
            ),
            right: 0,
            top: 0,
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome to",
                  style: TextStyle(fontFamily: 'DancingScript', color: Colors.white),
                ),
                Text(
                  "Kashiyatra GalaGuide App",
                  style: TextStyle(fontFamily: 'DancingScript', color: Colors.white, fontStyle: FontStyle.italic),
                ),
                Padding(padding: EdgeInsets.only(top: 20)),
                Image(
                  image: AssetImage('assets/Image/KashiyatraLogo.png'),
                  width: 300,
                  height: 175,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// Home Page
class HomePage extends StatefulWidget {
  HomePage() : super();

  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Add this to track the selected index

  // List of pages
  final List<Widget> _pages = [
    HomePageContent(title: 'Music'),
    HomePageContent(title: 'Dance'),
    HomePageContent(title: 'Workshops'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(heading: 'Kashiyatra GalaGuide App'),
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Folder(name: 'Music',icon: Icons.music_note, destination: Music(),),
            Folder(name: 'Dance',icon: Icons.workspace_premium_outlined,destination: Dance(),),
            Folder(name: 'WorkShop',icon: Icons.people,destination: WorkShop(),)
          ],
        ),
      ),
    );
  }
}

class Folder extends StatefulWidget {
  Folder({required this.name, required this.icon, required this.destination,Key? key}) : super(key: key); // Fix constructor
  String name;
  IconData icon;
  Widget destination;

  State<Folder> createState() => _FolderState();
}

class _FolderState extends State<Folder> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Folder is Tapped');
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => widget.destination,
          ),
        );
      },
      child: Container(
        height: 150,width: 150,
        color: Colors.teal[300],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          IconButton(onPressed: null, icon: Icon(widget.icon,color: Colors.white,size: 30,)),
          Text(widget.name,style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontSize: 25),),
        ],),
      ),
    );
  }
}

// Custom App Bar
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  MyAppBar({required this.heading}); 
  String heading;

  @override
  Size get preferredSize => Size.fromHeight(100.0);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WavyAppBarClipper(),
      child: Container(
        child: Stack(
          children: [
            Image.asset('assets/Image/Waves.png', fit: BoxFit.cover, width: double.infinity, height: 100),
            Positioned(
              child: Text(
                heading,
                style: TextStyle(
                  fontFamily: 'DancingScript',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 45,
                ),
              ),
              top: 17,
              left: 20,
            )
          ],
        ),
      ),
    );
  }
}

class WavyAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 4, size.height - 30, size.width / 2, size.height - 20);
    path.quadraticBezierTo(3 * size.width / 4, size.height - 10, size.width, size.height - 30);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class HomePageContent extends StatelessWidget {
  final String title;

  HomePageContent({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title),
    );
  }
}
