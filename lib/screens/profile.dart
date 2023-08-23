import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static const String id = "profile_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/profile_image.png'), // Add your image asset path here
            ),
            SizedBox(height: 20),
            Text(
              'John Doe', // Replace with user's name
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'john.doe@example.com', // Replace with user's email
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            _buildProfileItem(icon: Icons.location_on, text: 'New York, USA'), // Replace with user's location
            _buildProfileItem(icon: Icons.cake, text: 'Born on January 1, 1990'), // Replace with user's birthdate
            _buildProfileItem(icon: Icons.school, text: 'University of ABC'), // Replace with user's education
            // Add more profile items as needed
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: Colors.blue,
          ),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
