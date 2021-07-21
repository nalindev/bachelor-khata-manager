import 'package:flutter/material.dart';
import '../colors/constants.dart';

class dueAmount extends StatelessWidget {
  final String img;
  final String title;
  const dueAmount({
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
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),//or 15.0
              child: Container(
                height: 70.0,
                width: 70.0,
                color: Color(0xffFF0E58),
                child: Image.network(img, height: 40.0,),
              ),
            ),

            Positioned(
              bottom: 36.0, right: 35.0, //give the values according to your requirement
              child: Card(
                //margin: EdgeInsets.only(left: 25.0, top: 25.0),
                child: CircleAvatar(backgroundColor: Colors.white,
                    radius: 13,
                    child: Icon(Icons.auto_stories, color: Colors.black, size: 14.0,)),
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