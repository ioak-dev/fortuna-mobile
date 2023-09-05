import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ThemeManager.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Consumer<ThemeManager>(
          builder: (context, themeManager, _) => SwitchListTile(
            title: Text('Dark Mode',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black,
                  offset: Offset(1.0, 1.0),
                  blurRadius: 3.0,
                ),
              ],),),
            value: themeManager.currentTheme == AppTheme.Dark,
            onChanged: (_) {
              themeManager.toggleTheme();
            },
          ),
        ),
      ),
    );
  }
}
