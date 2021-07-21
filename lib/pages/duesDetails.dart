import 'package:flutter/material.dart';
import '../colors/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import "dart:math";

class duesDetails extends StatefulWidget {
  var data;
  var count;
  duesDetails(this.data, this.count);

  @override
  _duesDetailsState createState() => _duesDetailsState();
}

class _duesDetailsState extends State<duesDetails> {
  @override
  Widget build(BuildContext context) {
    var alldata = widget.data; // added all value to data for easy access
    int count = widget.count;
    int pay = alldata[count]['info']['pay'];
    int due = alldata[count]['info']['dues'];
    int diff = pay - due;
    int payment = diff <= 0 ? 0 : diff;

    var emlist = ['🍇','🍈','🍉','🍊','🍋','🍌','🍍','🥭','🍎','🍏','🍐','🍄','🥜','🥞','🍔'];


    return Scaffold(
      appBar: buildAppBar(alldata, count),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.05),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildHelpCard(context, alldata, pay, due, count),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 23.0, right: 23.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 9, bottom: 8, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                InkWell(
                                  //onTap: () {},
                                  child: Text(
                                    '${emlist[Random().nextInt(emlist.length)]} ${alldata[count]['pay list'][index]['discription']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                ),
                                Text(
                                  '         Day - ${alldata[count]['pay list'][index]['day']}',
                                  style: TextStyle(color: Colors.grey.shade500),
                                ),
                                Text(
                                  '         Time - ${alldata[count]['pay list'][index]['time']}',
                                  style: TextStyle(color: Colors.grey.shade500),
                                ),
                              ],
                            ),
                            Container(
                              height: 30,
                              width: 80,
                              child: Text(
                                'Rs. ${alldata[count]['pay list'][index]['money']}',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: alldata[count]['pay count'] == null ? 0 : alldata[count]['pay count'],
              ),
            ),
          ],
        ),
      floatingActionButton: Builder(builder: (BuildContext context){
        return FloatingActionButton.extended(onPressed: (){
          _openMap(payment, alldata[0]['name'], alldata[count]['upi']);
        },
        backgroundColor: Colors.redAccent,

        icon: Icon(Icons.payment),
        label: Text("Pay Rs.$payment", style: TextStyle(fontSize: 18.0),),
          elevation: 15,
        );
      },),
    );
  }

  _openMap(int payment, String from, var upi) async {
    var url = "upi://pay?pa=$upi&pn=$from&am=$payment&cu=INR";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

AppBar buildAppBar(var data, int count) {
  return AppBar(
    backgroundColor: kPrimaryColor.withOpacity(.05),
    elevation: 0,
    //title: Obx(() => Text('Randas ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),),
    title: Text("${data[count]['name']} Pay", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
   iconTheme: IconThemeData(
     color: kPrimaryColor,
     size: 28.0,
   ),
  );
}

  Container buildHelpCard(BuildContext context, var data, int pay, int due, int count) {
    return Container(
      height: 110,
      width: double.infinity,
      child: Container(
        height: 130,
        width: double.infinity,
        decoration: BoxDecoration(
          //color: Colors.white,
          gradient: LinearGradient(
            colors: [
              Color(0xFF60BE93),
              Color(0xFF1B8D59),
            ],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Total Pay\n\n",
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: Colors.white),
                  ),
                  TextSpan(
                    text: "  Rs. $pay",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage('${data[count]['img']}'), maxRadius: 26.0,
                  backgroundColor: Colors.redAccent,
                ),
                Text(
                  '\nDifference\n📈 Rs. ${data[count]['info']['diff']}',
                  style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white),
                ),
              ],
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Total Due\n\n",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white),
                  ),
                  TextSpan(
                    text: "  Rs. $due",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
