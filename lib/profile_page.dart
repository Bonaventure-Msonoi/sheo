import 'package:flutter/material.dart';
class ProfilePage extends StatelessWidget {
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
          Positioned.fill(
            child: Image.asset(
              'assets/background.jpg', // Replace with your background image asset
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 50.0, // Adjust the vertical position as needed
            left: 50.0, // Adjust the horizontal position as needed
            child: Container(
              width: 100.0, // Adjust the container size as needed
              height: 100.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.orange.withOpacity(0.7), Colors.blue.withOpacity(0.7)],
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
                child: ClipOval(
                  child: Image.asset(
                    'assets/background.jpg', // Replace with your profile image asset path
                    width: 80.0,
                    height: 80.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 180.0, // Adjust the vertical position for the profile details
            left: 70.0, // Adjust the horizontal position for the profile details
            child: Container(
              width: 300.0, // Adjust the container size for the profile details
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                gradient: LinearGradient(
                  colors: [Colors.blue.withOpacity(0.7), Colors.orange.withOpacity(0.7)],
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
              child: Column(
                children: [
                  _buildProfileDetail("Name", "Bonaventure", Icons.person),
                  _buildProfileDetail("Email", "bonaventuremsonoi@gmail.com", Icons.email),
                  _buildProfileDetail("Phone Number", "+260951394766", Icons.phone),
                  _buildProfileDetail("Devices", "3", Icons.devices),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileDetail(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 10.0),
          Text("$label: $value"),
        ],
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////
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
              title: Text("E-pref"),
              onTap: () {
                // Implement E-pref button action here
              },
            ),
            ListTile(
              title: Text("E-hist"),
              onTap: () {
                // Implement E-hist button action here
              },
            ),
            ListTile(
              title: Text("E-opt"),
              onTap: () {
                // Implement E-opt button action here
              },
            ),
            ListTile(
              title: Text("E-sett"),
              onTap: () {
                // Implement E-sett button action here
              },
            ),
            //      //
            //     ElevatedButton(
            //   onPressed: () {
            //     // Implement sign-out logic here
            //   },
            //   child: Text("Sign Out"),
            // ),
            // //
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
