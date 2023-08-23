import 'package:flutter/material.dart';
import 'package:tetris/screens/profile.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = "settings_screen";

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isSoundOn = true; // For sound setting


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'SilkScreen',
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        children: [
          SwitchListTile(
            title: const Text('Sound'),
            value: _isSoundOn,
            onChanged: (value) {
              setState(() {
                _isSoundOn = value;
              });
            },
          ),
          _buildSettingsItem(
            title: 'My Profile',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),

          _buildSettingsItem(
            title: 'Privacy Policy',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()),
              );
            },
          ),
          _buildSettingsItem(
            title: 'Reach Out',
            onTap: () {
              _showContactDetailsDialog(context);
            },
          ),
          // Add more settings items as needed
        ],
      ),
    );
  }

  void _showContactDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
              color: Colors.white.withOpacity(0.9),
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Contact',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Developed by Kylo codenamekylo.co.za',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Perform the save operation
                          Navigator.pop(context);
                        },
                        child: Text('Close'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSettingsItem(
      {required String title, required VoidCallback onTap}) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Privacy Policy',
            style: TextStyle(fontFamily: 'Silkscreen'),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '''
        
Privacy Policy for MigglyMoo 2

Effective Date: [21/08/23]

This Privacy Policy outlines the manner in which MigglyMoo 2 ("we," "us," or "our"), created by Kylo (also known as CodeNameKylo or Joshua Nichols), collects, uses, maintains, and discloses information collected from users (referred to as "you" or "your") of the MigglyMoo 2 mobile game for iOS and Android platforms (referred to as the "Game").

1. **Information Collection and Use**

   1.1 **Personal Information**: We do not collect any personal information that directly identifies you, such as your name, address, email address, or phone number.

   1.2 **Non-Personal Information**: We may collect non-personal information about your device, including but not limited to your device type, operating system, unique device identifier, IP address, and mobile advertising identifiers (such as IDFA and AAID). This information is used to understand the usage patterns of our Game and improve its functionality.

   1.3 **Game Progress and Analytics**: We may collect data related to your in-game progress, achievements, and interactions with the Game. This data is used for analytics purposes to enhance the Games user experience and gameplay.

2. **Third-Party Services**

   2.1 **Analytics**: We may use third-party analytics services to collect, monitor, and analyze usage patterns of the Game. These services may include but are not limited to Google Analytics and Firebase Analytics. The information collected is used to improve the Games performance and features.

   2.2 **Advertisements**: The Game may display third-party advertisements. Advertisements are provided by advertising networks, and these networks may collect information about your interests and interactions with ads. We do not have control over the data collected by these networks. Please refer to the respective privacy policies of these networks for more information.

3. **Childrens Privacy**

   The Game is not intended for use by children under the age of 13. We do not knowingly collect personal information from children under 13. If you are a parent or guardian and believe that your child has provided us with personal information, please contact us at [contact email] to request deletion of such information.

4. **Security**

   We take reasonable measures to protect the information collected from unauthorized access, disclosure, alteration, or destruction. However, please be aware that no data transmission over the internet or electronic storage is completely secure.

5. **Changes to this Privacy Policy**

   We reserve the right to update this Privacy Policy at any time. Any changes will be posted within the Game and will be effective immediately upon posting. Your continued use of the Game after any changes to the Privacy Policy constitutes your acceptance of those changes.

6. **Contact Us**

   If you have any questions or concerns about this Privacy Policy or the practices of the Game, you can contact us at [developerkylo@gmail.com].

By downloading, installing, and using the MigglyMoo 2 mobile game, you agree to the terms outlined in this Privacy Policy.

[Last updated: 21/08/23]''',
                style: TextStyle(fontSize: 12.0),
              ),
            ),
          ),
        ));
  }
}
