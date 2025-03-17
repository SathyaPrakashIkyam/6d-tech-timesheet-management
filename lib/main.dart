import 'dart:html';

import 'package:flutter/material.dart';

import 'package:timesheet_management/dashboard/dashboard.dart';
import 'package:timesheet_management/login_screen/login_screen.dart';
import 'package:timesheet_management/project/list_projects.dart';
import 'package:timesheet_management/timesheet/list_timesheet.dart';
import 'package:timesheet_management/timesheet/weekly_table.dart';
import 'package:timesheet_management/utils/classes/arguments_classes.dart';
import 'package:timesheet_management/wbs/list_wbs.dart';
import 'package:url_strategy/url_strategy.dart';

import 'utils/classes/routes.dart';
void main() {

  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/":(context) => const InitialScreen(),
      },
      onGenerateRoute: (RouteSettings settings) {
        Widget newScreen;
        switch (settings.name){
          case SixDRoutes.homeRoute: {
            newScreen = const InitialScreen();
          }
          break;
          case SixDRoutes.projects: {
            ListProjectsArguments listProjectsArgs;

            if(settings.arguments!=null) {
              listProjectsArgs = settings.arguments as ListProjectsArguments;
            } else {
              listProjectsArgs = ListProjectsArguments(drawerWidth: 200, selectedDestination: 1);
            }
            newScreen =  ListProjects(args: listProjectsArgs);
          }
          break;
          case SixDRoutes.wbs: {
            WBSArguments wbsArguments;
            if(settings.arguments!=null) {
              wbsArguments = settings.arguments as WBSArguments;
            } else {
              wbsArguments = WBSArguments(drawerWidth: 200, selectedDestination: 1);
            }
            newScreen =  ListWBS(args: wbsArguments);
          }
          break;
          case SixDRoutes.timesheet: {
            ListTimeSheetArguments listTimesheetArguments;
            if(settings.arguments!=null) {
              listTimesheetArguments = settings.arguments as ListTimeSheetArguments;
            } else {
              listTimesheetArguments = ListTimeSheetArguments(drawerWidth: 200, selectedDestination: 1);
            }
            newScreen =  ListTimesheet(args: listTimesheetArguments);
          }
          default: newScreen = const InitialScreen();
        }
        return PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          reverseTransitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) => newScreen,
          settings: settings,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      },
      // home: InitialScreen(),
    );
  }
}

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return window.sessionStorage["login"] == "success" ? const Dashboard() :const LoginScreen();
  }
}








