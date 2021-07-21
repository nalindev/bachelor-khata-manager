import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'Forget.dart';

import 'Dashboard_page.dart';
import '../core/Authcontroller.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final userdata = GetStorage();

  var email, pass;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text(
                    'Hello',
                    style: TextStyle(
                      fontSize: 80.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 180.0, 0.0, 0.0),
                  child: Text(
                    'User',
                    style: TextStyle(
                      fontSize: 80.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(265.0, 175.0, 0.0, 0.0),
                  child: Text(
                    '.',
                    style: TextStyle(
                      fontSize: 80.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 65.0, left: 20.0, right: 20.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'EMAIL',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  controller: emailController,
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'PASSWORD',

                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  obscureText: true,
                  controller: passController,
                ),

                SizedBox(
                  height: 15.0,
                ),
                Container(
                  alignment: Alignment(1.0, 0.0),
                  padding: EdgeInsets.only(top: 15.0, left: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(Forget_pass());
                    },
                    child: InkWell(
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  height: 45.0,
                  child: GestureDetector(
                    // onTap: () async {
                    //   var datas = await API_Manager().getdata('nalin','nalin87');
                    //   print(datas);
                    // },
                    onTap: () async {
                        setState(() {
                          email = emailController.text;
                          pass = passController.text;
                        });
                      Get.snackbar(
                        'Validating Credentials !',
                        'we are in a process to validate your credential',
                        icon: Icon(Icons.public_rounded),
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                        titleText: Text('Validating Credentials !',
                          style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),),
                      );

                      if(email.length > 2 && pass.length > 2){
                        showLoaderDialog(context);
                        var datas = await API_Manager().getdata('$email','$pass');
                        Navigator.of(context).pop();
                        if(datas['auth'] == 'true'){
                          userdata.write('isLogged', true);
                          userdata.write('username', email);

                          Get.offAll(Dashboard('$email'),);
                        }else{
                          var msg = datas['msg'];
                          // print(datas);
                          Get.snackbar(
                            "Wrong Credentials !",
                            '$msg',
                            icon: Icon(Icons.no_encryption_gmailerrorred_outlined),
                            colorText: Colors.white,
                            backgroundColor: Colors.redAccent,
                            isDismissible: true,
                          );
                        }
                        }else{
                        Get.snackbar(
                          "Please Fill out all the field.",
                          'NULL value is not allowed in our system',
                          icon: Icon(Icons.stop_screen_share_rounded),
                          colorText: Colors.white,
                          backgroundColor: Colors.blue,
                          isDismissible: true,
                        );
                      }
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.greenAccent,
                      color: Colors.green,
                      elevation: 7.0,
                      child: Center(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 45.0,
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: ImageIcon(AssetImage('assets/facebook.png')),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Center(
                          child: Text(
                            'Login In With Facebook',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 55.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'New to Randas ?',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    InkWell(
                      onTap: () {
                        Get.snackbar(
                          "New to Randas ? ",
                          "If you are a new member of randas group then you have to contact nalin nishant through whtasapp +91 6202 990 664",
                          //snackPosition: SnackPosition.BOTTOM,
                          //backgroundColor: Colors.amberAccent,
                          isDismissible: true,
                          margin: EdgeInsets.only(top: 5.0),
                        );
                      },
                      child: Text(
                        'Contact Nalin',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
}
