import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storys_apps/data/api/api.dart';
import 'package:storys_apps/provider/add_story_provider.dart';
import 'package:storys_apps/provider/auth_provider.dart';
import 'package:storys_apps/provider/list_data_provider.dart';
import 'package:storys_apps/provider/location_provider.dart';
import 'package:storys_apps/routes/router_delegate.dart';
import 'package:storys_apps/utils/fonts.dart';
import 'package:storys_apps/utils/style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MyRouterDelegate myRouterDelegate;

  @override
  void initState() {
    super.initState();
    myRouterDelegate = MyRouterDelegate();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(
            create: (context) => DataListProvider(api: Api())),
        ChangeNotifierProvider(
            create: (context) => AddStoryProvider(api: Api())),
        ChangeNotifierProvider(
            create: (context) => LocationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Story Apps',
        theme: ThemeData(
          textTheme: myTextTheme,
          appBarTheme: const AppBarTheme(elevation: 0),
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primaryColor,
                onPrimary: Colors.black,
                secondary: secondaryColor,
              ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            backgroundColor: secondaryColor,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(0),
              ),
            ),
          )),
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Router(
          routerDelegate: myRouterDelegate,
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      ),
    );
  }
}
