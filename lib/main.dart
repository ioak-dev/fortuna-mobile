import 'package:endurance/activity/activity_edit/activity_edit_page.dart';
import 'package:endurance/bloc/activity_bloc.dart';
import 'package:endurance/bloc/preset_bloc.dart';
import 'package:endurance/preset/preset_create/preset_create_page.dart';
import 'package:endurance/preset/preset_view/preset_view_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:endurance/home/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EnduranceApp());
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
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
          ),
          darkTheme: ThemeData(
            primarySwatch: Colors.blueGrey,
            brightness: Brightness.dark,
            primaryColor: Colors.blueGrey,
          ),
          themeMode: ThemeMode.system,
          initialRoute: '/',
          routes: {
            '/': (context) => const HomePage(title: 'Home Page'),
            '/preset/create': (context) => const CreatePresetPage()
          },
        ));
  }
}
