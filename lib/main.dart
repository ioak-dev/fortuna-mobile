import 'package:endurance/activity/activity_edit/activity_edit_page.dart';
import 'package:endurance/bloc/activity_bloc.dart';
import 'package:endurance/bloc/preset_bloc.dart';
import 'package:endurance/preset/preset_create/preset_create_page.dart';
import 'package:endurance/preset/preset_view/preset_view_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:endurance/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:endurance/home/loading.dart';
import 'package:provider/provider.dart';
import 'package:endurance/theme/ThemeManager.dart';
import 'package:endurance/theme/Settings_page.dart';
import 'package:endurance/expnses/Expenses_page.dart';



void main() {
  runApp(
      ChangeNotifierProvider(
      create: (_) => ThemeManager(),
  child: EnduranceApp(),
      ),
  );
}

class EnduranceApp extends StatelessWidget {
  const EnduranceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<PresetBloc>(
              create: (BuildContext context) => PresetBloc()),
          BlocProvider<ActivityBloc>(
              create: (BuildContext context) => ActivityBloc())
        ],
        child: MaterialApp(
          title: 'Endurance',
          theme: Provider.of<ThemeManager>(context).themeData,
          darkTheme: Provider.of<ThemeManager>(context).darkThemeData,
          themeMode: Provider.of<ThemeManager>(context).currentThemeMode,
          initialRoute: '/',
          routes: {
            "/" : (context) => LoadingPage(),
            "/home" : (context) => HomePage(title: 'Home Page', username: 'your_username_here',),
            // '/': (context) => const HomePage(title: 'Home Page'),
            '/preset/create': (context) => const CreatePresetPage()
          },
        ));
  }
}
