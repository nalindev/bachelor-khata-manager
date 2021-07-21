import 'package:flutter/material.dart';
import '../colors/constants.dart';
import '../core/Postcontroller.dart';
import 'package:get/get.dart';
import '../core/Authcontroller.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_svg/flutter_svg.dart';

class dueList extends StatefulWidget {
  var data;
  int id;
  dueList(this.data, this.id);

  @override
  _dueListState createState() => _dueListState();
}

class _dueListState extends State<dueList> {
  removeId(int id) async{
    var info = await API_PostManager().deleteById(id);
    return info;
  }

  removeAll(var user, var kisse) async{
    var info = await API_PostManager().deleteAll(user, kisse);
    setState(() {
    });
    return info;
  }

  showSnackBAr(context, var title, var amount){
    Get.snackbar(
      "$title (Rs ${amount}) deleted successfully !",
      'You have deleted this item',
      icon: Icon(Icons.assignment_turned_in, color: Colors.white,),
      colorText: Colors.white,
      backgroundColor: Colors.indigo,
    );
  }

  @override
  Widget build(BuildContext context) {
    var data = widget.data;
    int id = widget.id;

    return Scaffold(
      appBar: buildAppBar(data, id),
      body: Column(
        children: [
          buildHelpCard(context, data, id),
          Expanded(
            child: Container(
              color: kPrimaryColor.withOpacity(0.035),
              child: Center(
                child: FutureBuilder(
                  future: API_Manager().getdash(data[0]['name']),  //getting user from login page
                  builder: (context, snapshot) {
                    Widget retVal;
                    if (snapshot.connectionState == ConnectionState.done) {
                      retVal = list(snapshot.data, id);
                    } else {
                      retVal = CircularProgressIndicator(backgroundColor: Colors.red);
                    }
                    return retVal;
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Builder(builder: (BuildContext context){
        return FloatingActionButton.extended(
          onPressed: () async {
            showLoaderDialog(context);
            var info = await removeAll(data[0]['name'], data[id]['username']);
            Navigator.of(context).pop();
            showSnackBAr(context, 'All amount of ', data[id]['info']['dues']);
        },
          backgroundColor: Colors.black,

          icon: Icon(Icons.refresh),
          label: Text("Delete All", style: TextStyle(fontSize: 18.0),),
          elevation: 15,
        );
      },),
    );
  }

  Widget list(var data, int id){
    var count = data[id]['due count'] == null ? 0 : data[id]['due count'];
    return count > 0 ? ListView.builder(
      padding: EdgeInsets.all(20.0),
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return row(context, index, data, id);
      },
    ) : Center(child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/empty.webp", width: 110.0,),
        Text('There is no due on ${data[id]['name']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
      ],
    ));
  }

  Widget row(context, index, var data, int id) {
    return Dismissible(
        key: Key(data[id]['due list'][index]['discription']),
        onDismissed: (direction) async {
          var title = data[id]['due list'][index]['discription'];
          var amount = data[id]['due list'][index]['money'];
          showSnackBAr(context, title, amount);
          showLoaderDialog(context);
          var info = await removeId(data[id]['due list'][index]['id']);
          Navigator.of(context).pop();
          //handle info
        },
      background: refreshBg(),
        child: Card(
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${data[id]['due list'][index]['discription']}', style: TextStyle(fontSize: 21.0,fontWeight: FontWeight.bold, letterSpacing: 0.9),),
                    Text('Date - ${data[id]['due list'][index]['day']}', style: TextStyle(fontSize: 12.0, color: Colors.grey[500]),),
                  ],
                ),
                Text('Rs. ${data[id]['due list'][index]['money']}'),
              ],
            ),
          ),
        ),
    );
  }

  Widget refreshBg() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: const Icon(
        Icons.delete,
        color: Colors.white,
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

  Container buildHelpCard(BuildContext context, var data, var id) {
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
              borderRadius: BorderRadius.circular(10),
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Total Dues - ${data[id]["info"]['dues']}\n Total Pay - ${data[id]["info"]['pay']}\n",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white),
                  ),
                  TextSpan(
                    text: "You have a difference with ${data[id]["name"]} is Rs. ${data[id]["info"]['diff']}",
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
}


AppBar buildAppBar(var data, int id) {
  return AppBar(
    backgroundColor: kPrimaryColor.withOpacity(.05),
    elevation: 0,
    title: Text("Due On ${data[id]['name']}", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
    iconTheme: IconThemeData(
      color: kPrimaryColor,
      size: 28.0,
    ),
  );
}