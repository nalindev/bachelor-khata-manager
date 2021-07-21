import 'package:flutter/material.dart';
import '../colors/constants.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/info_card.dart';
import '../core/Authcontroller.dart';
import 'duesDetails.dart';
import 'package:lottie/lottie.dart';
import 'setting_page.dart';
import '../widgets/due_amount.dart';
import 'add_due_amount.dart';
import 'due_list.dart';
import 'package:Randas/widgets/sidebar.dart';

class Dashboard extends StatefulWidget {
  final String argument;

  Dashboard(this.argument);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  void Refresh() {
    setState(() {
    });
  }

  //render UI when content is loaded
  Widget _loadedScreen(var data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(0.03),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          child: Wrap(
            runSpacing: 20,
            spacing: 20,
            children: <Widget>[
              InfoCard(
                title: data[1]['name'],
                img: data[1]['img'],
                iconColor: Color(0xFFFF8C00),
                effectedNum: data[1]['info']['pay'],
                press: () {
                  Get.to(duesDetails(data, 1));
                },
              ),
              InfoCard(
                title: data[2]['name'],
                img: data[2]['img'],
                iconColor: Color(0xFFFF2D55),
                effectedNum: data[2]['info']['pay'],
                press: () {
                  Get.to(duesDetails(data, 2));
                },
              ),
              InfoCard(
                title: data[3]['name'],
                img: data[3]['img'],
                iconColor: Color(0xFF50E3C2),
                effectedNum: data[3]['info']['pay'],
                press: () {
                  Get.to(duesDetails(data, 3));
                },
              ),
              InfoCard(
                title: data[4]['name'],
                img: data[4]['img'],
                iconColor: Color(0xFF5856D6),
                effectedNum: data[4]['info']['pay'],
                press: () {
                  Get.to(duesDetails(data, 4));
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Add Amounts",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                buildPreventation(data),
                SizedBox(height: 20),
                Text(
                  "Due Details",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                dueAmount_fun(data),
                SizedBox(height: 40),
                buildHelpCard(context, data),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: buildAppBar(),
      drawer: Drawer(
        child: MainDrawer(widget.argument),
      ),
      body: Center(
        child: FutureBuilder(
          future: API_Manager().getdash(widget.argument),  //getting user from login page
          builder: (context, snapshot) {
            Widget retVal;
            if (snapshot.connectionState == ConnectionState.done) {
              retVal = _loadedScreen(snapshot.data);
            } else {
              retVal = CircularProgressIndicator(backgroundColor: Colors.red,);
            }
            return retVal;
          },
        ),
      ),
      floatingActionButton: Builder(builder: (BuildContext context){
        return FloatingActionButton.extended(onPressed: (){
          Refresh();
        },
          backgroundColor: Colors.redAccent,

          icon: Icon(Icons.refresh),
          label: Text("Refresh", style: TextStyle(fontSize: 18.0),),
          elevation: 15,
        );
      },),
    );
  }

  Row buildPreventation(var data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        InkWell(
          splashColor: kPrimaryColor.withOpacity(0.5),
          onTap: (){
            Get.to(payAmount(data, 1));
          },
          child: PreventitonCard(
            img: data[1]['img'],
            title: data[1]['name'],
          ),
        ),
        InkWell(
          splashColor: kPrimaryColor.withOpacity(0.5),
          onTap: (){
            Get.to(payAmount(data, 2));
          },
          child: PreventitonCard(
            img: data[2]['img'],
            title: data[2]['name'],
          ),
        ),
        InkWell(
          splashColor: kPrimaryColor.withOpacity(0.5),
          onTap: (){
            Get.to(payAmount(data, 3));
          },
          child: PreventitonCard(
            img: data[3]['img'],
            title: data[3]['name'],
          ),
        ),
        InkWell(
          splashColor: kPrimaryColor.withOpacity(0.5),
          onTap: (){
            Get.to(payAmount(data, 4));
          },
          child: PreventitonCard(
            img: data[4]['img'],
            title: data[4]['name'],
          ),
        ),
      ],
    );
  }

  Row dueAmount_fun(var data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        InkWell(
          splashColor: kPrimaryColor.withOpacity(0.5),
          onTap: (){
            Get.to(dueList(data, 1));
          },
          child: dueAmount(
            img: data[1]['img'],
            title: data[1]['name'],
          ),
        ),
        InkWell(
          splashColor: kPrimaryColor.withOpacity(0.5),
          onTap: (){
            Get.to(dueList(data, 2));
          },
          child: dueAmount(
            img: data[2]['img'],
            title: data[2]['name'],
          ),
        ),
        InkWell(
          splashColor: kPrimaryColor.withOpacity(0.5),
          onTap: (){
            Get.to(dueList(data, 3));
          },
          child: dueAmount(
            img: data[3]['img'],
            title: data[3]['name'],
          ),
        ),
        InkWell(
          splashColor: kPrimaryColor.withOpacity(0.5),
          onTap: (){
            Get.to(dueList(data, 4));
          },
          child: dueAmount(
            img: data[4]['img'],
            title: data[4]['name'],
          ),
        ),
      ],
    );
  }

  Container buildHelpCard(BuildContext context, var data) {
    return Container(
      height: 120,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              // left side padding is 40% of total width
              left: MediaQuery.of(context).size.width * .4,
              top: 20,
              right: 10,
            ),
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF60BE93),
                  Color(0xFF1B8D59),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "${data[5]["title"]}\n",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white),
                  ),
                  TextSpan(
                    text: "${data[5]["dis"]}",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 200.0, 15.0),
            child: Lottie.asset('assets/friends2.json', height: 300,),
            // child: SvgPicture.asset("assets/svg/friends.svg"),
          ),
          Positioned(
            top: 30,
            right: 10,
            child: SvgPicture.asset("assets/svg/virus.svg"),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor.withOpacity(.03),
      elevation: 0,
      iconTheme: IconThemeData(color: kPrimaryColor),
      title: Text("Roommate Manager", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/svg/settings.svg", height: 28, color: kPrimaryColor ),
          onPressed: () {
            Get.to(setting());
          },
        ),
      ],
    );
  }
}

class PreventitonCard extends StatelessWidget {
  final String img;
  final String title;
  const PreventitonCard({
    Key key,
    this.img,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30.0,
              backgroundImage: AssetImage('assets/ball.gif'),
              child: CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(img),
              ),
            ),
            Positioned(
              bottom: 0, right: 0, //give the values according to your requirement
              child: Card(
                margin: EdgeInsets.only(left: 25.0, top: 25.0),
                child: CircleAvatar(backgroundColor: Colors.white,
                    radius: 12,
                    child: Icon(Icons.add, color: Colors.black,)),
                elevation: 25.0,
                shape: CircleBorder(),
                clipBehavior: Clip.antiAlias,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0,),
        Text(
          title.split(" ")[0],
          //title,
          style:
          Theme.of(context).textTheme.bodyText1.copyWith(color: kPrimaryColor),
        )
      ],
    );
  }
}