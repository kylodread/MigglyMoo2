import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = "settings_screen";

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isSoundOn = true; // For sound setting
  bool _isPrivacyPolicyVisible = false; // For privacy policy setting
  bool _isContactVisible = false; // For contact details setting
  final String _versionNumber = "1.0.0"; // Version number

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Set the background color to white
        iconTheme: const IconThemeData(color: Colors.black), // Set icon color to black
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'SilkScreen'
            ), // Set text color to black
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sound Setting
            SwitchListTile(
              title: const Text('Sound'),
              value: _isSoundOn,
              onChanged: (value) {
                setState(() {
                  _isSoundOn = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // Privacy Policy Setting
            CheckboxListTile(
              title: const Text('Show Privacy Policy'),
              value: _isPrivacyPolicyVisible,
              onChanged: (value) {
                setState(() {
                  _isPrivacyPolicyVisible = value!;
                });
              },
            ),
            const SizedBox(height: 20),

            // Contact Details Setting
            CheckboxListTile(
              title: const Text('Show Contact Details'),
              value: _isContactVisible,
              onChanged: (value) {
                setState(() {
                  _isContactVisible = value!;
                });
              },
            ),
            const SizedBox(height: 20),

            // Version Number
            ListTile(
              title: Text('Version'),
              subtitle: Text(_versionNumber),
            ),
          ],
        ),
      ),
    );
  }
}
