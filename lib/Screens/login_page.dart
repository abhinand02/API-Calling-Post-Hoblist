import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_and_home_page/Screens/register.dart';
import 'package:login_and_home_page/Services/movie_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    final sharedPref = await SharedPreferences.getInstance();
    email = sharedPref.getString('email');
    password = sharedPref.getString('password');
    print(password);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            mainText(),
            loginForm(width, context),
          ],
        ),
      ),
    );
  }

  Form loginForm(double width, BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  'Email',
                  style: TextStyle(color: Colors.grey.shade800),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 20, bottom: 40),
                child: TextFormField(
                    // controller: _controller,
                    cursorHeight: 25.0,
                    decoration: InputDecoration(
                      icon: const Icon(
                        Icons.email_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                      hintText: 'Enter Email.',
                      hintStyle: GoogleFonts.lato(),
                    ),
                    validator: (value) {
                      if (value != email) {
                        return "enter a valid email";
                      } else {
                        saveData(value);
                        return null;
                      }
                    }),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  'Password',
                  style: TextStyle(color: Colors.grey.shade800),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 20, bottom: 10),
                child: TextFormField(
                    obscureText: true,
                    cursorHeight: 25.0,
                    decoration: InputDecoration(
                      icon: const Icon(
                        Icons.lock_outline,
                        color: Colors.black,
                        size: 30,
                      ),
                      hintText: 'Enter Password.',
                      hintStyle: GoogleFonts.lato(),
                    ),
                    validator: (value) {
                      if (value != password) {
                        return "incorrect Password";
                      } else {
                        return null;
                      }
                    }),
              ),
            ],
          ),
          const SizedBox(
            height: 80,
          ),
          Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 98, 219, 198),
                    Color.fromARGB(255, 48, 159, 140)
                  ]),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                width: width * .9,
                child: ElevatedButton(
                  onPressed: () async {
                    
                    if (_formKey.currentState!.validate()) {
                      MovieServices.getMovies();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    }else{
                      const snackbar =
                          SnackBar(content: Text('Invalid Credentials'));

                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Register()));
              },
              child: const Text(
                'New User? Register Now',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
          )
        ],
      ),
    );
  }

  Column mainText() {
    return Column(
      children: const [
        Text(
          'Let\'s Sign You In',
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Future<void> saveData(email) async {
    // print(email);
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool('loggedin', true);
  }
}
