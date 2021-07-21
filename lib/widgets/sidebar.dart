import 'package:flutter/material.dart';
import '../pages/setting_page.dart';
import 'package:get/get.dart';
import '../pages/addToAll.dart';

class MainDrawer extends StatelessWidget {
  var user;
  MainDrawer(this.user);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        child: Padding(
          padding: EdgeInsets.only(top: 45.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 190,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/sidebar.jpg", ),
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),

            ],
          ),
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      //Now let's Add the button for the Menu
      //and let's copy that and modify it
      // ListTile(
      //   onTap: () {},
      //   leading: Icon(
      //     Icons.person,
      //     color: Colors.black,
      //   ),
      //   title: Text("Your Profile"),
      // ),

      ListTile(
        onTap: () {
          Navigator.pop(context);
        },
        leading: Icon(
          Icons.assessment,
          color: Colors.black,
        ),
        title: Text("Your Dashboard"),
      ),

      ListTile(
        onTap: () {
          Get.to(add_to_all(user));
        },
        leading: Icon(
          Icons.inbox,
          color: Colors.black,
        ),
        title: Text("Add To All"),
      ),

      ListTile(
        onTap: () {
          Get.to(setting());
        },
        leading: Icon(
          Icons.settings,
          color: Colors.black,
        ),
        title: Text("Settings"),
      ),
    ]);
  }
}