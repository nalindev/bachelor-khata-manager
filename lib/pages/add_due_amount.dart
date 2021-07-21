import 'dart:ui';

import 'package:flutter/material.dart';
import '../colors/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import '../core/Postcontroller.dart';
import 'package:get/get.dart';

class payAmount extends StatefulWidget {
  var data;
  int id;
  payAmount(this.data, this.id);

  @override
  _payAmountState createState() => _payAmountState();
}

class _payAmountState extends State<payAmount> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController disController = TextEditingController();

  var dis, name, kisse, amount;

  @override
  Widget build(BuildContext context) {
    var data = widget.data;
    int id = widget.id;
    return Scaffold(
      appBar: buildAppBar(data, id),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage('${data[id]['hdimg']}'),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter
                )
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 270),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.all(23),
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Container(
                      color: Color(0xfff5f5f5),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SFUIDisplay'
                        ),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Add Amount',
                            prefixIcon: Icon(Icons.dialpad),
                            labelStyle: TextStyle(
                                fontSize: 15
                            ),
                        ),
                        controller: amountController,
                      ),
                    ),
                  ),
                  Container(
                    color: Color(0xfff5f5f5),
                    child: TextFormField(
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'SFUIDisplay'
                      ),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Discription',
                          prefixIcon: Icon(Icons.auto_stories),
                          labelStyle: TextStyle(
                              fontSize: 15
                          )
                      ),
                      controller: disController,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: MaterialButton(
                      onPressed: () async {
                        setState(() {
                          amount = amountController.text;
                          dis = disController.text;
                          name = data[0]['name'];
                          kisse = data[id]['username'];
                        });
                        if(amount.length > 0 && dis.length > 2){
                          showLoaderDialog(context);
                          var datas = await API_PostManager().postdata('$name','$kisse','$dis','$amount');
                          amountController.clear();
                          disController.clear();
                          FocusScope.of(context).requestFocus(new FocusNode());
                          Navigator.of(context).pop();
                          if(datas['info'] == 'true'){
                            Get.snackbar(
                              "😊 Rs. $amount (${dis}) is inserted on $kisse.",
                              'Your data is successfully inserted',
                              isDismissible: true,
                              duration: Duration(seconds: 5),
                              icon: Icon(Icons.assignment_turned_in_outlined),
                              colorText: Colors.white,
                              margin: EdgeInsets.only(top: 56.0),
                              backgroundColor: Colors.blue,
                            );
                          }else{
                            Get.snackbar(
                              "Something went wrong.",
                              'This app is not able to recognize the issue please contact to nalin.',
                              icon: Icon(Icons.assignment_turned_in_outlined),
                              colorText: Colors.white,
                              margin: EdgeInsets.only(top: 56.0),
                              backgroundColor: Colors.indigoAccent,
                              isDismissible: true,
                            );
                          }
                        }else{
                          Get.snackbar(
                            "Something not valid.",
                            'NULL or inapropriate value is not allowed in our system',
                            icon: Icon(Icons.stop_screen_share_rounded),
                            colorText: Colors.white,
                            margin: EdgeInsets.only(top: 56.0),
                            backgroundColor: Colors.red,
                            isDismissible: true,
                          );
                        }
                      },//since this is only a UI app
                      child: Text('Add Amount',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'SFUIDisplay',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: Colors.green,
                      elevation: 0,
                      minWidth: 400,
                      height: 50,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(top: 20),
                  //   child: Center(
                  //     child: Text('Forgot your password?',
                  //       style: TextStyle(
                  //           fontFamily: 'SFUIDisplay',
                  //           fontSize: 15,
                  //           fontWeight: FontWeight.bold
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "API call will take time if your net connection is slow. ",
                                  style: TextStyle(
                                    fontFamily: 'SFUIDisplay',
                                    color: Colors.black,
                                    fontSize: 15,
                                  )
                              ),
                            ]
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  buildHelpCard(context, data, id),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

showLoaderDialog(BuildContext context){
  AlertDialog alert=AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(backgroundColor: Colors.red,),
        Container(margin: EdgeInsets.only(left: 7),child:Text("  Loading..." )),
      ],),
  );
  showDialog(barrierDismissible: false,
    context:context,
    builder:(BuildContext context){
      return alert;
    },
  );
}

Container buildHelpCard(BuildContext context, var data, int id) {
  return Container(
    height: 150,
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
                  text: "${data[id]['name']}\n",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.white),
                ),
                TextSpan(
                  text: "Total Due Amount is ${data[id]['info']['dues']}  on ${data[id]['due count']} items & Pay Amount is ${data[id]['info']['pay']} on ${data[id]['pay count']} items.",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 0.0, 200.0, 10.0),
          child: Lottie.asset('assets/transaction.json', height: 300,),
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

AppBar buildAppBar(var data, int id) {
  return AppBar(
    backgroundColor: kPrimaryColor.withOpacity(.05),
    elevation: 0,
    title: Text("Add Rs. On ${data[id]['name']}", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
    iconTheme: IconThemeData(
      color: kPrimaryColor,
      size: 28.0,
    ),
  );
}