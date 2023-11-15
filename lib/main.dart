import 'package:flutter/material.dart';
//import 'package:tflite_v2/tflite_v2.dart';
import 'dart:async'; // Import Timer from dart:async
import 'dart:math';
import 'dart:typed_data';
import 'profile_page.dart';
import 'devices_page.dart';
import 'datacollection_page.dart';
//side menu
// import 'sensor_data.dart';
import 'EPreferencePage.dart';
import 'EHistoryPage.dart';
import 'EOptionsPage.dart';
import 'ESettingsPage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Tflite.loadModel(
  //   model: "assets/model.tflite", // Path to your TFLite model
  // );
  runApp(MyApp());
}
// void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("SHEO"),
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                // Open the side menu when the menu icon is clicked
                Scaffold.of(context).openDrawer();
              },
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.purple, Colors.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      drawer: SideMenu(), // Add the side menu here
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.red],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Email",
                        ),
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Password",
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          
                          // Implement signup logic here
                          // Navigate to the profile page when the "Sign Up" button is pressed
      // Navigator.of(context).push(MaterialPageRoute(
      //   builder: (BuildContext context) => ProfileScreen(),
      // ));
                        Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DashboardPage(),
                           ),
                         );

                        },
                        child: Text("Sign in"),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  "Dont have an account? Sign up!",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




 

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("SHEO"),
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                // Open the side menu when the menu icon is clicked
                Scaffold.of(context).openDrawer();
              },
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.purple, Colors.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Center(
        child: Text(
          "WELCOME to SHEO",
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  } 
}

//--------------------------------------------------
class DashboardPage extends StatelessWidget {
  //
//   final User user;

//   DashboardPage({required this.user});

// //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SHEO"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.purple, Colors.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      drawer: SideMenu(),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/background.jpg', // Replace with your image asset path
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LargeButton(
                  text: "Profile",
                  onPressed: () {
                    // Implement profile button action here
                     // Navigate to the profile page
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                      ),
                    );
                  },
                ),

           
                SizedBox(height: 20.0),
                LargeButton(
                  text: "Devices",
                  onPressed: () {
                    // Implement energy tips button action here
                    Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DevicesPage(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20.0),
                LargeButton(
                  text: "Data Collection",
                  onPressed: () {
                    // Implement Data Collection button action here
                     Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DataCollectionPage(),
                      ),
                    );
                  },
                ),
               
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class LargeButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  LargeButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: LinearGradient(
            colors: [Colors.purple.withOpacity(0.7), Colors.red.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 5.0,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      ),
    );
  }
}





class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.purple, Colors.red],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text("Side Menu"),
            ),
            ListTile(
              title: Text("E-preference"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EPreferencePage()),
                );
              },
            ),
            ListTile(
              title: Text("E-history"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EHistoryPage()),
                );
              },
            ),
            ListTile(
              title: Text("E-options"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EOptionsPage()),
                );
              },
            ),
            ListTile(
              title: Text("E-settings"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ESettingsPage()),
                );
              },
            ),
            ListTile(
              title: Text("LOGOUT"),
              onTap: () {
                // Implement logout button action here
              },
            ),
          ],
        ),
      ),
    );
  }
}
