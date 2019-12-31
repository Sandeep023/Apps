import 'package:animations/theme.dart';
import 'package:flutter/material.dart';

class CollapsingListTile extends StatefulWidget {

  final String title;
  final IconData icon;
  final AnimationController animationController;
  final bool isSelected;
  final Function onTap;

  CollapsingListTile({
    @required this.title,
    @required this.icon,
    @required this.animationController,
    this.isSelected = false,
    this.onTap,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CollapsingListTileState();
  }
}

class _CollapsingListTileState extends State<CollapsingListTile> {

  Animation<double> widthAnimation, sizeBoxAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widthAnimation = Tween<double>(begin: 250.0, end: 60).animate(widget.animationController);
    sizeBoxAnimation = Tween<double>(begin: 10.0, end: 0).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: widget.isSelected ? Colors.transparent.withOpacity(0.3) : Colors.transparent,
        ),
        width: widthAnimation.value,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: <Widget>[
            Icon(widget.icon, color: widget.isSelected ? selectedColor : Colors.white30, size: 38.0,),
            SizedBox(width: sizeBoxAnimation.value,),
            (widthAnimation.value >= 220) ?
              Text(widget.title, style: widget.isSelected ? listTitleSelectedStyle : listTitleDefaultStyle,) :
              Container(),
          ],
        ),
      ),
    );
  }
}
