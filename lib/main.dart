import 'package:flutter/material.dart';
import 'package:Randas/pages/login.dart';
import 'package:get/get.dart';
import 'colors/constants.dart';
import 'package:get_storage/get_storage.dart';
import 'pages/Dashboard_page.dart';

void main() async{
  await GetStorage.init();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Roommate Manager',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),
      ),
      debugShowCheckedModeBanner: false,
      //home: MyHomePage(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  final userdate = GetStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userdate.writeIfNull('isLogged', false);
    Future.delayed(Duration.zero,() async{
      checkiflogged();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              color: Colors.white,
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.orange,
                          radius: 55.0,
                          backgroundImage: AssetImage('assets/randa.png'),
                          // child: Icon(
                          //   Icons.pets,
                          //   size: 48.0,
                          // ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text(
                            'Roommate Manager',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 32,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  CircularProgressIndicator(backgroundColor: Colors.red,),
                  Padding(
                    padding: EdgeInsets.only(top: 16,bottom: 32),
                    child: Text(
                      'API call will take time if your connection is weak.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
  void checkiflogged() async {
    await Future.delayed(Duration(seconds: 2));
    userdate.read('isLogged') ? Get.offAll(Dashboard(userdate.read('username'))) : Get.offAll(MyHomePage());
  }

}