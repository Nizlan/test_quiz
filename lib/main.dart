import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/quiz_cubit.dart';
import 'pages/first_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Test Quiz',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.blue[100],
          primarySwatch: Colors.blue,
        ),
        home: const FirstPage(),
      ),
    );
  }
}
