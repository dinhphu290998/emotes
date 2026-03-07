import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../guide/guide_page.dart';
import '../../share/extensions/color_extensions.dart';
import '../home/home_page.dart';

class BottomTabbarPage extends StatefulWidget {
  @override
  State<BottomTabbarPage> createState() => _BottomTabbarPageState();
}

class _BottomTabbarPageState extends State<BottomTabbarPage> {
  int currentTabbar = 0;
  PageController _pageController = PageController(initialPage: 0, viewportFraction: 1);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 80,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  controller: _pageController,
                  itemBuilder: (BuildContext context, int itemIndex) {
                    switch (itemIndex) {
                      case 0:
                        return HomePage();
                      case 1:
                        return GuidePage();
                    }
                  },
                ),
              ),
              Expanded(
                child: Container(
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 80  ,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Container(
                          color: Colors.white,
                          child: Stack(
                            alignment: Alignment.center,
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            currentTabbar = 0;
                                            _pageController.jumpToPage(currentTabbar);
                                          });
                                        },
                                        child: Container(
                                          color: Colors.white,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Image(
                                                  width: 24,
                                                  height: 24,
                                                  image: currentTabbar == 0
                                                      ? AssetImage('assets/home.png')
                                                      : AssetImage('assets/un_home.png'),
                                                  color: currentTabbar == 0
                                                      ? HexColor.fromHex('#F55050')
                                                      : Colors.grey
                                              ),
                                              Text(
                                                'Home',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: currentTabbar == 0
                                                      ? HexColor.fromHex('#F55050')
                                                      : Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15 ,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            currentTabbar = 1;
                                            _pageController.jumpToPage(currentTabbar);
                                          });
                                        },
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Image(
                                                width: 24,
                                                height: 24,
                                                image: currentTabbar == 1
                                                    ? AssetImage('assets/guide.png')
                                                    : AssetImage('assets/un_guide.png'),
                                                color: currentTabbar == 1
                                                    ? HexColor.fromHex('#F55050')
                                                    : Colors.grey,
                                              ),
                                              Text(
                                                'Guide',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: currentTabbar == 1
                                                      ? HexColor.fromHex('#F55050')
                                                      : Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}
