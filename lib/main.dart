// ignore_for_file: library_private_types_in_public_api

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_yamen_afmin/core/user_repository/lib/src/firebase_user_repo.dart';
import 'package:graduation_yamen_afmin/presentation/students/view/student_screen.dart';
import 'package:routemaster/routemaster.dart';
import 'auth/auth/welcome_screen.dart';
import 'auth/blocs/authentication_bloc/authentication_bloc.dart';
import 'auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'firebase_options.dart';
import 'routes.dart';
import 'app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  debugPrint("called main");
  runApp(MyApp1());
}

class MyApp1 extends StatefulWidget {
  const MyApp1();


  static _MyApp1State? of(BuildContext context) => context.findAncestorStateOfType<_MyApp1State>();

  @override
  _MyApp1State createState() => _MyApp1State();
}

class _MyApp1State extends State<MyApp1> {
  ThemeMode themeMode = ThemeMode.light;

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  void setThemeMode(ThemeMode mode) async {
    setState(() {
      themeMode = mode;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', mode.toString().split('.').last);
  }

  void _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final savedThemeMode = prefs.getString('themeMode') ?? 'light';
    setState(() {
      themeMode = ThemeMode.values.firstWhere((e) => e.toString().split('.').last == savedThemeMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("called MyApp1");
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(userRepository: FirebaseUserRepo()),
        ),
        BlocProvider(
          create: (context) => SignInBloc(userRepository: FirebaseUserRepo()),
        ),
      ],
      child: AppView(themeMode: themeMode, onThemeChanged: setThemeMode),
    );
  }
}

class AppView extends StatelessWidget {
  final ThemeMode themeMode;
  final RouteInformationProvider? routeInformationProvider;
  final bool siteBlockedWithoutLogin;
  final Function(ThemeMode) onThemeChanged;

  AppView({
    super.key,
    required this.themeMode,
    this.siteBlockedWithoutLogin = true,
    this.routeInformationProvider,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {

    debugPrint('FirebaseAuth.instance.currentUser.toString())');
    debugPrint(FirebaseAuth.instance.currentUser.toString());
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'SFS',
          theme: AppTheme.lightTheme(context),
          darkTheme: AppTheme.darkTheme(context),
          themeMode: themeMode,
          routeInformationParser: const RoutemasterParser(),
          routeInformationProvider: routeInformationProvider,
          routerDelegate: RoutemasterDelegate(
            observers: [MyObserver()],
            routesBuilder: (context) {
              if (state.status != AuthenticationStatus.authenticated) {
                return loggedOutRouteMap;
              }
              return _buildRouteMap(context);
            },
          ),
        );
      },
    );
  }

  final loggedOutRouteMap = RouteMap(
    onUnknownRoute: (path) {
      return const Redirect("/");
    },
    routes: {
      '/': (route) => const NoAnimationPage(child: WelcomeScreen()),
    },
  );
}

class MyObserver extends RoutemasterObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    if (kDebugMode) {
      debugPrint('Popped a route');
    }
  }

  @override
  void didChangeRoute(RouteData routeData, Page page) {
    if (kDebugMode) {
      debugPrint('New route: ${routeData.path}');
    }
  }
}

RouteMap _buildRouteMap(BuildContext context) {
  return RouteMap(
    onUnknownRoute: (path) {
      if (path == "/") {
        return const Redirect('/students');
      }
      return NoAnimationPage(
        child: Scaffold(
          body: Center(
            child: Text(
              "lbl_Couldnot_find_page".tr(),
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
        ),
      );
    },
    routes: checkAuthority(),
  );
}
