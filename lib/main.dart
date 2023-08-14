import 'package:firebase_core/firebase_core.dart';
import 'package:flipgrid/firebase_options.dart';
import 'package:flipgrid/login_signup/new_signup.dart';
import 'package:flipgrid/models/user.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

final currentUserStateProvider =
    ChangeNotifierProvider((ref) => CurrentUserState());

class CurrentUserState extends ChangeNotifier {
  late Customer _user;
  set setCurrentUser(Customer user) {
    _user = user;
    notifyListeners();
  }

  Customer get getCurrentUser {
    return _user;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NewSignUp(),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        // etc.
      };
}
