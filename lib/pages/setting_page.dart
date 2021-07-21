import 'package:flutter/material.dart';
import '../colors/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class setting extends StatefulWidget {

  @override
  _settingState createState() => _settingState();
}

class _settingState extends State<setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            Row(
              children: [
                Icon(
                  Icons.settings,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Dependency Used",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            buildAccountOptionRow(context, "Get Advance", "https://pub.dev/packages/get"),
            buildAccountOptionRow(context, "Http helper", "https://pub.dev/packages/http"),
            buildAccountOptionRow(context, "fl chart", "https://pub.dev/packages/fl_chart"),
            buildAccountOptionRow(context, "cupertino icons", "https://pub.dev/packages/cupertino_icons"),
            buildAccountOptionRow(context, "flutter svg", "https://pub.dev/packages/flutter_svg"),
            buildAccountOptionRow(context, "url launcher", "https://pub.dev/packages/url_launcher"),
            buildAccountOptionRow(context, "lottie", "https://pub.dev/packages/lottie"),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.web,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Cloud Technology",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            buildAccountOptionRow(context, "LightSpeed Server", "https://docs.litespeedtech.com/cp/cpanel/"),
            buildAccountOptionRow(context, "Cloudflare", "https://www.cloudflare.com/"),
            buildAccountOptionRow(context, "Hostitbro", "https://www.hostitbro.in/"),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.computer,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Server Technology",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            buildAccountOptionRow(context, "MySql", "https://www.mysql.com/"),
            buildAccountOptionRow(context, "Laravel Rest Api", "https://laravel.com/"),
            buildAccountOptionRow(context, "Bootstrap", "https://getbootstrap.com/"),

          ],
        ),
      ),
    );
  }

  GestureDetector buildAccountOptionRow(BuildContext context, String title, String url) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _launchURL(url);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor.withOpacity(.05),
      elevation: 0,
      title: Text("Settings", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
      iconTheme: IconThemeData(
        color: kPrimaryColor,
        size: 28.0,
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
