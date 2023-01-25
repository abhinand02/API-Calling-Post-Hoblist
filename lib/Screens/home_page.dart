import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_and_home_page/Screens/company_info.dart';
import 'package:login_and_home_page/Screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login_and_home_page/constants/styles.dart';

import '../Application/Home/home_bloc.dart';
import '../Model/movies.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(const GetList());
    });
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          ListTile(
            leading: Icon(Icons.info_outline_rounded),
            title: Text('Company Info'),
            onTap: () => {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CompanyInfo()))
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {
              Navigator.of(context).pop(),
              logoutUser(context),
            },
          ),
        ],
      )),
      appBar: appBar(context),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.movieList.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          }
          return ListView.separated(
            itemBuilder: (context, index) {
              DateTime releaseDate = DateTime.fromMillisecondsSinceEpoch(
                  state.movieList[index].releasedDate * 1000);
              final day = releaseDate.day;
              final month = releaseDate.month;
              final movieList = state.movieList[index];
              return customCard(
                genre: movieList.genre,
                poster: movieList.poster,
                director: movieList.director,
                stars: movieList.stars,
                pageViews: movieList.pageViews,
                day: day.toString(),
                month: month,
                language: movieList.language,
                votes: movieList.totalVoted.toString(),
                title: movieList.title,
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                thickness: 1,
                endIndent: 10,
                indent: 10,
              );
            },
            itemCount: state.movieList.length,
            physics: const AlwaysScrollableScrollPhysics(),
          );
        },
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text('Home'),
      centerTitle: true,
      backgroundColor: const Color.fromARGB(55, 98, 219, 198),
    );
  }

  logoutUser(BuildContext ctx) async {
    return showDialog(
      context: ctx,
      builder: (ctx1) {
        return AlertDialog(
          content: Text(
            'Are you sure to Logout?',
            style: popupHeading,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: buttonTextStyle,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    clearData();
                    Navigator.pushReplacement(
                      ctx,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text(
                    'Yes',
                    style: buttonTextStyle,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class customCard extends StatelessWidget {
  customCard(
      {Key? key,
      required this.title,
      required this.votes,
      required this.genre,
      required this.poster,
      required this.director,
      required this.stars,
      required this.pageViews,
      required this.day,
      required this.month,
      required this.language})
      : super(key: key);
  final String title, votes, genre, poster, day;
  final List<String> director, stars;
  final int pageViews, month;
  final Language language;

  final List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(
                    flex: 1,
                  ),
                  Column(
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.arrow_drop_up,
                            size: 50,
                          ),
                          Text(
                            votes,
                            style: TextStyle(fontSize: 18),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            size: 50,
                          ),
                        ],
                      ),
                      Text(
                        'Votes',
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        poster,
                        errorBuilder: (context, error, stackTrace) =>
                            Center(child: const CircularProgressIndicator()),
                        fit: BoxFit.fill,
                        height: 120,
                        width: 80,
                      ),
                    ),
                  ),
                  // Spacer(flex: 1,),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 220,
                          child: Text(
                            title,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Genre: ',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(genre),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Director: ',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(director.first),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Starring',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                                width: 190,
                                child: Text(
                                  stars.first,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ))
                          ],
                        ),
                        Text('Mins | Kannada | $day ${months[month]}',
                            style: TextStyle(
                              fontSize: 15,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '$pageViews views | Voted by $votes People ',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Spacer(
                    flex: 5,
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Watch Trailer',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

Future<void> clearData() async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  sharedPref.remove('loggedin');
  // sharedPref.remove('email');
  // sharedPref.remove('password');
  // sharedPref.remove('number');
  // sharedPref.remove('profession');
}
