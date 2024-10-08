import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penny_places/core/constants/constants_colors.dart';
import 'package:penny_places/presentation/providers/addPlacesProvider.dart';
import 'package:penny_places/presentation/providers/deleteAccountProvider.dart';
import 'package:penny_places/presentation/providers/fetchPlacesProvider.dart';
import 'package:penny_places/presentation/providers/getProfileProvider.dart';
import 'package:penny_places/presentation/providers/openPostProvider.dart';
import 'package:penny_places/presentation/providers/placeTypeProvider.dart';
import 'package:penny_places/presentation/providers/postLikeProvider.dart';
import 'package:penny_places/presentation/providers/postPlaceCountProvider.dart';
import 'package:penny_places/presentation/providers/privatePostProvider.dart';
import 'package:penny_places/presentation/providers/publicPostProvider.dart';
import 'package:penny_places/presentation/providers/reportPlaceProvider.dart';
import 'package:penny_places/presentation/screens/main_screen.dart';
import 'package:penny_places/presentation/screens/onboarding_screen.dart';
import 'package:penny_places/presentation/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBloc {
  final _onboardingController = StreamController<bool>.broadcast();

  Stream<bool> get onboardingStream => _onboardingController.stream;

  void checkOnboardingStatus() async {
    _prefs = await SharedPreferences.getInstance();
    prefs = await SharedPreferences.getInstance();
    bool shownOnboarding = _prefs?.getBool('shownOnboarding') ?? true;
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    userName = prefs?.getString('userName');
    email = prefs?.getString('email');
    profilePic = prefs!.getString('profilePicture');
    bio = prefs?.getString('bio');
    debugPrint("userID: $userID");
    debugPrint("userName: $userName");
    debugPrint("profilePic: $profilePic");
    debugPrint("bio: $bio");

    if (shownOnboarding) {
      if (userID != null) {
        _onboardingController.sink.add(true); // User is logged in
      } else {
        _onboardingController.sink.add(false); // User is not logged in
      }
    } else {
      _onboardingController.sink.add(false); // Onboarding not shown
    }
  }

  void dispose() {
    _onboardingController.close();
  }
}

final appBloc = AppBloc();

SharedPreferences? _prefs;
SharedPreferences? prefs;
String? userID;
String? userName;
String? email;
String? profilePic;
String? bio;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _prefs = await SharedPreferences.getInstance();
  bool shownOnboarding = _prefs?.getBool('shownOnboarding') ?? false;
  runApp(MyApp(shownOnboarding: shownOnboarding));
}

class MyApp extends StatefulWidget {
  final bool shownOnboarding;
  const MyApp({super.key, required this.shownOnboarding});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    appBloc.checkOnboardingStatus();
  }

  @override
  void dispose() {
    appBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).colorScheme.surface, // Status bar color
      statusBarIconBrightness: Brightness.dark, // For dark status bar icons
    ));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetProfileProvider()),
        ChangeNotifierProvider(create: (_) => PlaceTypeProvider()),
        ChangeNotifierProvider(create: (_) => DeleteAccountProvider()),
        ChangeNotifierProvider(create: (_) => PublicPostProvider()),
        ChangeNotifierProvider(create: (_) => PrivatePostProvider()),
        ChangeNotifierProvider(create: (_) => FetchPlacesPostProvider()),
        ChangeNotifierProvider(create: (_) => AddPlacesProvider()),
        ChangeNotifierProvider(create: (_) => PostLikeProvider()),
        ChangeNotifierProvider(create: (_) => PostPlaceCountProvider()),
        ChangeNotifierProvider(create: (_) => OpenPostProvider()),
        ChangeNotifierProvider(create: (_) => ReportPlacesProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
          colorScheme:
              ColorScheme.fromSeed(seedColor: ConstantsColors.blueColor),
          useMaterial3: true,
        ),
        home: StreamBuilder<bool>(
          stream: appBloc.onboardingStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == true) {
                return const MainScreen(index: 0);
              } else {
                return const Onboarding();
              }
            } else {
              return const SplashScreen();
            }
          },
        ),
      ),
    );
  }
}
