import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:tinder_app/model/tinder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColorBrightness: Brightness.light, primaryColor: Colors.blue),
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  String image;
  Tinder tinder;

  // Name
  String title;
  String first;
  String last;
  // DOB
  String dob;

  // Location
  String street;
  String city;
  String state;

  String phone;
  String username;

  TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildCardTinder();
            } else {
              return Container(
                  child: Center(child: CircularProgressIndicator()));
            }
          },
          future: getDataList(context),
        ));
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Center(child: Text('Tinder')),
    );
  }

  Widget _buildCardTinder() {
    tinder.results.forEach((element) {
      image = element.picture.large;
      title = element.name.title;
      first = element.name.first;
      last = element.name.last;
      dob = element.dob;
      street = element.location.street;
      city = element.location.city;
      state = element.location.state;
      phone = element.phone;
      username = element.login.username;
    });
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Swipable(
          onSwipeRight: (finalPosition) {
            print("Saved to favorites");
          },
          onSwipeLeft: (finalPosition) {
            print("Next humman");
          },
          child: Container(
            padding: EdgeInsets.only(top: 20),
            color: Colors.grey[100],
            child: Stack(
              children: <Widget>[
                Card(
                  // elevation: 2,
                  margin: EdgeInsets.only(top: 130),
                  child: Container(
                      height: 300,
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(top: 45.0),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Container(
                                height: 100.0,
                                child: TabBarView(
                                  controller: _controller,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 40),
                                      child: Container(
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                title,
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              Text(
                                                '$first $last',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 40),
                                      child: Container(
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Text('Date of birth',
                                                  style:
                                                      TextStyle(fontSize: 20)),
                                              Text(dob,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 40),
                                      child: Container(
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Text('Address',
                                                  style:
                                                      TextStyle(fontSize: 20)),
                                              Text(street,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25)),
                                              Text(city,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25)),
                                              Text(state,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 40),
                                      child: Container(
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Text('Phonenumber',
                                                  style:
                                                      TextStyle(fontSize: 20)),
                                              Text(phone,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 40),
                                      child: Container(
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Text('Username',
                                                  style:
                                                      TextStyle(fontSize: 20)),
                                              Text(username,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: TabBar(
                                  indicatorColor: Colors.transparent,
                                  unselectedLabelColor: Colors.grey,
                                  labelColor: Colors.green[200],
                                  controller: _controller,
                                  isScrollable: true,
                                  tabs: [
                                    Tab(
                                      icon: Icon(Icons.person),
                                    ),
                                    Tab(
                                      icon: Icon(Icons.calendar_today_rounded),
                                    ),
                                    Tab(
                                      icon: Icon(Icons.map),
                                    ),
                                    Tab(
                                      icon: Icon(Icons.phone),
                                    ),
                                    Tab(icon: Icon(Icons.lock))
                                  ]),
                            )
                          ],
                        ),
                      )),
                ),
                Positioned(
                  top: .0,
                  left: .0,
                  right: .0,
                  child: Center(
                    child: Container(
                      width: 190.0,
                      height: 190.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill, image: NetworkImage(image)),
                          shape: BoxShape.circle,
                          color: Colors.black,
                          border: Border.all(width: 0.1)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Tinder> getDataList(BuildContext context) async {
    tinder = tinderFromJson(
        await DefaultAssetBundle.of(context).loadString("assets/tinder.json"));
    return tinder;
  }
}
