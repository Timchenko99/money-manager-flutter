import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';


class Overview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildOverviewBar(context),
            SizedBox(height: 35),
            _buildNeumorphicToggle(context),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NeumorphicBar(width: 50, height: 300, value: 0.5, text: "Mon"),
                SizedBox(width: 10),
                NeumorphicBar(width: 50, height: 300, value: 0.1, text: "Tue"),
                SizedBox(width: 10),
                NeumorphicBar(width: 50, height: 300, value: 1.0, text: "Wed"),
                SizedBox(width: 10),
                NeumorphicBar(width: 50, height: 300, value: 0.2, text: "Thu"),
                SizedBox(width: 10),
                NeumorphicBar(width: 50, height: 300, value: 0.4, text: "Fri"),
                SizedBox(width: 10),
                NeumorphicBar(width: 50, height: 300, value: 0.5, text: "Sun"),
                SizedBox(width: 10),
                NeumorphicBar(width: 50, height: 300, value: 0.6, text: "Sat"),

              ],
            )

          ],
        ),

      ),
    );
  }
  
  Widget _buildOverviewBar(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Stack(
        children: [
          Center(
            child: Neumorphic(
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                color: Theme.of(context).backgroundColor,
                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15))
              ),
              child: Container(
                width: 340,
                height: 200,
              ),
            ),
          ),
          Positioned(
              top: 40,
              left: 50,
              child: Text("Total Amount Saved", style: Theme.of(context).textTheme.subtitle2)
          ),
          Positioned(
              top: 70,
              left: 50,
              child: Text("\$24 000.20", style: Theme.of(context).textTheme.headline5)
          ),
          Positioned(
              top: 70,
              right: 50,
              child: NeumorphicIcon(Icons.settings, size: 36, style: NeumorphicStyle(color: Color.fromRGBO(90, 90, 90, 1)))
          ),
          Positioned(
              bottom: 40,
              left: 50,
              child: Text("You have reached 13% of your goal")
          ),

        ],
      ),
    );
  }

  Widget _buildNeumorphicToggle(BuildContext context){
    return NeumorphicToggle(
      height: 50,
      width: 300,

      displayForegroundOnlyIfSelected: true,
      style: NeumorphicToggleStyle(
        backgroundColor: Color.fromRGBO(208, 218, 227, 1),
      ),
      children: [
        ToggleElement(background: Center(child: Text("This Week", style: Theme.of(context).textTheme.bodyText1 )), foreground: Center(child: Text("This Week", style: Theme.of(context).textTheme.bodyText1))),
        ToggleElement(background: Center(child: Text("This Month", style: Theme.of(context).textTheme.bodyText1 )), foreground: Center(child: Text("This Month", style: Theme.of(context).textTheme.bodyText1)))
      ],
      thumb: Neumorphic(
        style: NeumorphicStyle(
            color: Theme.of(context).backgroundColor,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.all(Radius.circular(15))),
            shape: NeumorphicShape.flat
        ),
      ),
      // onChanged: (v){
      //   setState(() {
      //     _selectedIndex = v;
      //   });
      // },
    );
  }

  Widget _buildNeumorphicBarChart(BuildContext context){
    return LayoutBuilder(
      // builder: (),
    );
  }

  Widget _buildNeumorphicLineChart(){
    return Container();
  }

}
//
// class NeumorphicBarChart extends StatelessWidget{
//
//   final num height;
//   final List<NeumorphicBarData> barData;
//   final Color color;
//
//   const NeumorphicBarChart({Key key,
//     @required this.height,
//     @required this.barData,
//     this.color
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Container(
//       child: Row(
//         children: _buildBars()
//       ),
//     );
//   }
//
//   List<Widget> _buildBars() => barData.map((barData)=>NeumorphicBar(barData: barData)).toList();
//
// }
//
// class NeumorphicBar extends StatelessWidget{
//
//   final NeumorphicBarData barData;
//   // final num height;
//   // final num width;
//
//   const NeumorphicBar({Key key, this.barData}):super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraint)=>Container(
//
//       ),
//     );
//   }
//
//   num normalize(){
//     //TODO: get total daily and month budget and normalize it from 0 to 1
//   }
//
// }
//
// class NeumorphicBarData{
//   final num value;
//   final String text;
//
//   const NeumorphicBarData(this.value, this.text);
//
// }

class NeumorphicBar extends StatelessWidget {
  const NeumorphicBar({
    Key key,
    @required this.width,
    @required this.height,
    @required this.value,
    @required this.text,
    this.color,
  }) : super(key: key);

  final double width;
  final double height;

  /// Value from 1.0 to 0.0
  final double value;

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final innerContainerWidth = width * 0.95;
    final innerContainerHeight = height * value * 0.96;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          // color: Colors.pinkAccent,
          height: height * 1.01,
          width: width.toDouble() / 4,
          child: Stack(
            children: <Widget>[
              DugContainer(
                width: width,
                height: height,
              ),
              InnerContainer(
                  width: innerContainerWidth,
                  height: innerContainerHeight,
                  color: color),
            ],
          ),
        ),
        SizedBox(height: 10),
        Text(
          text,
          style: TextStyle(
            color: Colors.blueGrey[300],
          ),
        ),
      ],
    );
  }
}

class InnerContainer extends StatelessWidget {
  const InnerContainer({
    Key key,
    @required this.height,
    @required this.width,
    this.color,
  }) : super(key: key);

  final double height;
  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Neumorphic(
          style: NeumorphicStyle(
            color: Colors.greenAccent,
            shape: NeumorphicShape.flat
          ),
          child: Container(
            height: height ,
            width: width ,

          ),
        ),
      ),
    );
  }
}

class DugContainer extends StatelessWidget {
  const DugContainer({
    Key key,
    @required this.height,
    @required this.width,
  }) : super(key: key);
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Neumorphic(
        style: NeumorphicStyle(
          shape: NeumorphicShape.convex
        ),
        child: Container(
          height: height /** 600 / 896*/,
          width: width /** 100 / 414*/,

        ),
      ),
    );
  }
}

