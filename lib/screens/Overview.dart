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
            _buildOverviewBar(context)

          ],
        ),

      ),
    );
  }
  
  Widget _buildOverviewBar(BuildContext context){
    return Stack(
      children: [
        Center(
          child: Neumorphic(
            style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15))
            ),
            child: Container(
              width: 341,
              height: 206,
            ),
          ),
        ),
        Positioned(
            top: 70,
            left: 50,
            child: Text("Total Amount Saved")
        ),
        Positioned(
            top: 100,
            left: 50,
            child: Text("\$24 000.20", style: Theme.of(context).textTheme.bodyText1)
        ),
        Positioned(
            right: 50,
            child: NeumorphicIcon(Icons.settings, size: 36, style: NeumorphicStyle(color: Colors.black))
        ),
        Positioned(
            bottom: 40,
            left: 50,
            child: Text("You have reached 13% of your goal")
        ),

      ],
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
        ToggleElement(background: Center(child: Text("This Week", style: Theme.of(context).textTheme.bodyText1 )), foreground: Center(child: Text("Expenses", style: Theme.of(context).textTheme.bodyText1))),
        ToggleElement(background: Center(child: Text("This Month", style: Theme.of(context).textTheme.bodyText1 )), foreground: Center(child: Text("Income", style: Theme.of(context).textTheme.bodyText1)))
      ],
      thumb: Neumorphic(
        style: NeumorphicStyle(
            color: Theme.of(context).backgroundColor,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.all(Radius.circular(15)))
        ),
      ),
      // onChanged: (v){
      //   setState(() {
      //     _selectedIndex = v;
      //   });
      // },
    );
  }

  Widget _buildNeumorphicBarChart(){
    return Container();
  }

  Widget _buildNeumorphicLineChart(){
    return Container();
  }

}
