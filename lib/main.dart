import 'package:flutter/material.dart';
import 'CustonIcons.dart';
import 'package:storyapp/data.dart';
import 'dart:math';
import 'data.dart';

void main() => runApp(MaterialApp(
  home: MyApp(),
  debugShowCheckedModeBanner: false,
));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

var cardAspectRatio = 12.0 / 16.0 ;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _MyAppState extends State<MyApp> {

  var currentPage = images.length - 0.0;

  @override
  Widget build(BuildContext context) {

    PageController pageController = PageController(
        initialPage: images.length - 1);
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page;
      });
    });

    return Scaffold(
      backgroundColor: Color(0xFF2d3447),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(padding: const EdgeInsets.only(
                left: 12.0, right: 12.0, top: 30.0, bottom: 8.0
            ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        customIcons.menu,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      onPressed: () {},
                    )
                  ],)
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Meghal",
                      style: TextStyle(
                        color: Colors.white70,
                        fontFamily: "Calibre-Semibold",
                        fontSize: 45.50,
                        letterSpacing: 1.0,
                      )
                  ),
                ],
              ),
            ),
            Stack(
              children: <Widget>[
                cardScrollWidget(currentPage),

                Positioned.fill(
                    child: PageView.builder(
                      itemCount: images.length,
                      controller: pageController,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return Container();
                      },
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable, camel_case_types
class cardScrollWidget extends StatelessWidget {

  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;

  cardScrollWidget(this.currentPage);

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
        aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context,constraints)
    {
      var width = constraints.maxWidth;
      var height = constraints.maxHeight;

      var safeWidth = width - 2 * padding;
      var safeHeight = height - 2 * padding;

      var heightOfPrimaryCard = safeHeight;
      var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

      var primaryCardLeft = safeWidth - widthOfPrimaryCard;
      var horizontalInset = primaryCardLeft / 2;

      List<Widget> cardList = new List();

      for (var i = 0; i < images.length; i++) {
        var delta = i - currentPage;
        var isOnRight = delta > 0;

        var start = padding + max(
            primaryCardLeft - horizontalInset * -delta * (isOnRight ? 15 : 1),
            0.0);
        var cardItem;
        cardItem = Positioned.directional(
          top: padding + verticalInset + max(-delta, 0.0),
          bottom: padding + verticalInset + max(-delta, 0.0),
          start: start,
          textDirection: TextDirection.rtl,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white70,
              boxShadow: [
                BoxShadow(
                  color: Colors.cyan,
                  offset: Offset(3.0,6.0),
                  blurRadius: 10.0
                )
              ]
            ),
            child: AspectRatio(aspectRatio: cardAspectRatio,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.asset(images[i],
                      fit: BoxFit.cover),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                          child: Text(title[i],
                          style: TextStyle(
                            color: Colors.brown,
                            fontSize: 25.0,
                            fontFamily: "SF-Pro-Text-Regular",
                          )),
                        ),
                      ],
                    ),
            ),
          ],
              ),
            ),
          ),
        )
        );
        cardList.add(cardItem);
      }
      return Stack(
        children: cardList,
      );
    }),
    );
  }}

