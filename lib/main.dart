import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_and_home_page/Application/Home/home_bloc.dart';
import 'package:login_and_home_page/Screens/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPref = await SharedPreferences.getInstance();
  final savedData = sharedPref.getBool('loggedin');
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> HomeBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: savedData != null  ? const HomePage() : LoginPage(),
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
      ),
    ),
  );  
}







// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//           primarySwatch: Colors.grey,
//           textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme)),
//       home: const LoginPage(),
//     );
//   }
// }



//  Future<void> getSavedData(BuildContext context) async {
//     final sharedPref = await SharedPreferences.getInstance();
//     final savedData = sharedPref.getString('saved_data');
//     if(savedData !=null){
//      Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> const HomePage()));
//     }else{
//       const LoginPage();
//     }
//    }