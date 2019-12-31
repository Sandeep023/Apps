import 'package:animations/commons/collapsing_list_tile.dart';
import 'package:animations/model/navigation_model.dart';
import 'package:animations/theme.dart';
import 'package:flutter/material.dart';

class CollapsingNavigationDrawer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CollapsingNavigationDrawerState();
  }
}

class CollapsingNavigationDrawerState
    extends State<CollapsingNavigationDrawer> with SingleTickerProviderStateMixin{
  double maxWidth = 250;
  double minWidth = 60;
  bool isCollapsed = false;
  AnimationController _animationController;
  Animation<double> widthAnimation;
  int currentSelectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    widthAnimation = Tween<double>(begin: maxWidth, end: minWidth).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, widget) => getWidget(context, widget),
    );
  }

  Widget getWidget(context, widget){
    return Container(
      width: widthAnimation.value,
      color: drawerBackgroundColor,
      child: Column(
        children: <Widget>[
          CollapsingListTile(
            title: 'Sandeep Varma',
            icon: Icons.person,
            animationController: _animationController,
          ),
          Divider(color: Colors.grey, height: 40.0,),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index){
                return Divider(height: 12.0,);
              },
              itemBuilder: (context, index) {
                return CollapsingListTile(
                  onTap: (){
                    setState(() {
                      currentSelectedIndex = index;
                    });
                  },
                  isSelected: currentSelectedIndex == index,
                  title: navigationItems[index].title,
                  icon: navigationItems[index].icon,
                  animationController: _animationController,
                );
              },
              itemCount: navigationItems.length,
            ),
          ),
          InkWell(
              onTap: () {
                setState(() {
                  isCollapsed = !isCollapsed;
                  isCollapsed ? _animationController.forward() : _animationController.reverse();
                });
              },
              child: AnimatedIcon(
                icon: AnimatedIcons.close_menu,
                progress: _animationController,
                color: Colors.white,
                size: 50.0,
              )
          ),
        ],
      ),
    );
  }
}