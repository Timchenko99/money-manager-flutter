import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymanager_simple/data/models/TransactionModel.dart';
import 'package:moneymanager_simple/presentation/cubit/TransactionCubit.dart';
import 'package:uuid/uuid.dart';

import '../../core/styles.dart';

class AddScreen extends StatelessWidget {
  static const routeName = "/add-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            decoration: BoxDecoration(gradient: Styles.backgroundGradient),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(0),
                      onPressed: (){
                        FocusScope.of(context).requestFocus(FocusNode());
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 32.0,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "New",
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.bold,
                    fontSize: 36.0,
                  ),
                ),
                UserInput(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserInput extends StatefulWidget {
  @override
  _UserInputState createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  TextEditingController _transactionController ;
  TextEditingController _categoryController;
  TextEditingController _amountController;
  TextEditingController _dateController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _transactionController = TextEditingController();
    _categoryController = TextEditingController();
    _amountController = TextEditingController();
    _dateController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _transactionController.dispose();
    _categoryController.dispose();
    _amountController.dispose();
    _dateController.dispose();
  }

  Icon _icon = Icon(Icons.add_circle);
  DateTime _dateTime;

  _pickIcon(BuildContext context) async {
    IconData icon = await FlutterIconPicker.showIconPicker(context, iconPackMode: IconPack.material);

    _icon = Icon(icon);
    setState((){});

    debugPrint('Picked Icon:  $icon');
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (value){
              if(value.isEmpty){
                return "Please enter some text";
              }else{
                return null;
              }
            },
            controller: _transactionController,
            style: GoogleFonts.roboto(fontWeight: FontWeight.w600, fontSize: 18),
            decoration: InputDecoration(
                prefixIcon: IconButton(
                  onPressed: ()=>_pickIcon(context),
                  icon: _icon, color: Theme.of(context).primaryColor,),
                labelText: "Title"),
          ),
          SizedBox(
            height: media.size.height * 0.04,
          ),
          // TextFormField(
          //   validator: (value){
          //     if(value.isEmpty){
          //       return "Please enter some text";
          //     }else{
          //       return null;
          //     }
          //   },
          //   controller: _categoryController,
          //   style: GoogleFonts.roboto(fontWeight: FontWeight.w600, fontSize: 18),
          //   decoration: InputDecoration(labelText: "Category"),
          // ),
          // SizedBox(
          //   height: media.size.height * 0.04,
          // ),
          TextFormField(
            validator: (value){
              if(value.isEmpty){
                return "Please enter some text";
              }else{
                return null;
              }
            },
            controller: _amountController,
            style: GoogleFonts.roboto(fontWeight: FontWeight.w600, fontSize: 18),
            decoration: InputDecoration(labelText: "Amount"),
          ),
          SizedBox(
            height: media.size.height * 0.04,
          ),
          InputDatePickerFormField(
            fieldHintText: "dd.mm.yyyy",
            initialDate: DateTime.now(),
            firstDate: DateTime(2010),
            lastDate: DateTime.now(),
            onDateSaved: (value) => _dateTime = value,
          ),
          /*TextField(
            style: GoogleFonts.roboto(fontWeight: FontWeight.w600, fontSize: 18),
            decoration: InputDecoration(
              labelText: "Date",
              suffix: IconButton(
                onPressed: () {
                  showDatePicker(context: context, initialDate: null, firstDate: null, lastDate: null)
                },
                icon: Icon(
                  Icons.date_range,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),*/
          ButtonBar(
            children: [
              FlatButton(
                onPressed: (){},
                child: Text("CANCEL"),
              ),
              RaisedButton(
                onPressed: (){
                  if(_formKey.currentState.validate()){
                    _formKey.currentState.save();
                    final newTransaction = TransactionModel(id: Uuid().v1(), date: _dateTime, amount: double.parse(_amountController.text), icon: _icon.icon, title: _transactionController.text);
                    BlocProvider.of<TransactionCubit>(context).insertTransaction(newTransaction);
                    Navigator.of(context).pop();
                  }
                },
                child: Text("ADD"),
              )
            ],
          )
        ],
      ),

    );
  }
}

// class AddScreen extends StatefulWidget {
//   @override
//   _AddScreenState createState() => _AddScreenState();
// }
//
// class _AddScreenState extends State<AddScreen> {
//   final _amountTextController = TextEditingController();
//   int _selectedIndex = 0;
//
//   @override
//   void dispose() {
//     _amountTextController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Theme.of(context).backgroundColor,
//       body: SafeArea(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 25.0,
//             ),
//             Center(
//               child: Text(
//                 _selectedIndex==0 ? "New Expenses":"New Income",
//                 style: Theme.of(context).textTheme.headline4
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             _buildNeumorphicToggle(),
//             SizedBox(
//               height: 50,
//             ),
//             _buildNeumorphicTextField(),
//             SizedBox(
//               height: 30,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildIncrementButton(5),
//                 _buildIncrementButton(25),
//                 _buildIncrementButton(50),
//                 _buildIncrementButton(100)
//               ],
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             CircleSubmitButton(_amountTextController),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildIncrementButton(int amount){
//     return NeumorphicTheme(
//       theme: NeumorphicThemeData(),
//         child: NeumorphicButton(
//           style: NeumorphicStyle(
//             color: Theme.of(context).backgroundColor,
//             shape: NeumorphicShape.flat,
//             boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15))
//           ),
//           onPressed: ()=>_incrementAmountBy(amount),
//           child: Center(
//             child: Text("$amount\$", style: Theme.of(context).textTheme.button),
//           ),
//         )
//     );
//   }
//
//
//   Widget _buildNeumorphicTextField(){
//     return Neumorphic(
//
//       style: NeumorphicStyle(
//         color: Color.fromRGBO(208, 218, 227, 1),
//           depth: -3,
//           intensity: 1
//       ),
//       child: Container(
//         width: 360,
//         child: TextField(
//           inputFormatters: [
//             FilteringTextInputFormatter.deny(RegExp(r"(\.|,|-)"))
//           ],
//           onSubmitted: (v){
//             FocusScope.of(context).requestFocus(FocusNode());
//           },
//           textAlign: TextAlign.center,
//           controller: _amountTextController,
//           keyboardType: TextInputType.number,
//           decoration: InputDecoration(
//               border: InputBorder.none,
//               hintText: "Amount",
//               hintStyle: GoogleFonts.roboto(
//                 fontWeight: FontWeight.bold,
//                   fontStyle: FontStyle.italic,
//                   fontSize: 18.0,
//                   color: Color.fromRGBO(0, 0, 0, 0.20))),
//           style: GoogleFonts.roboto(
//               fontSize: 18.0, color: Color.fromRGBO(0, 0, 0, 0.7)),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNeumorphicToggle(){
//     return NeumorphicToggle(
//       height: 50,
//       width: 310,
//       selectedIndex: _selectedIndex,
//       displayForegroundOnlyIfSelected: true,
//       style: NeumorphicToggleStyle(
//         backgroundColor: Color.fromRGBO(208, 218, 227, 1),
//       ),
//       children: [
//         ToggleElement(background: Center(child: Text("Expenses", style: Theme.of(context).textTheme.bodyText1 )), foreground: Center(child: Text("Expenses", style: Theme.of(context).textTheme.bodyText1))),
//         ToggleElement(background: Center(child: Text("Income", style: Theme.of(context).textTheme.bodyText1 )), foreground: Center(child: Text("Income", style: Theme.of(context).textTheme.bodyText1)))
//       ],
//       thumb: Neumorphic(
//         style: NeumorphicStyle(
//             color: Theme.of(context).backgroundColor,
//             boxShape: NeumorphicBoxShape.roundRect(BorderRadius.all(Radius.circular(15)))
//         ),
//       ),
//       onChanged: (v){
//         setState(() {
//           _selectedIndex = v;
//         });
//       },
//     );
//   }
//
//   void _incrementAmountBy(int increment) {
//     if (_amountTextController.text.isEmpty) _amountTextController.text = "0";
//
//     int value = int.parse(_amountTextController.text
//  ?? "0"
//     );
//
//     _amountTextController.text = (value + increment).toString();
//   }
// }
//
// class CircleSubmitButton extends StatefulWidget {
//   final TextEditingController _amountTextController;
//
//
//   CircleSubmitButton(this._amountTextController);
//
//   @override
//   _CircleSubmitButtonState createState() => _CircleSubmitButtonState();
// }
//
// class _CircleSubmitButtonState extends State<CircleSubmitButton> {
//
//   int _selectedIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//
//     return  NeumorphicTheme(
//           theme: NeumorphicThemeData(),
//           child: NeumorphicButton(
//
//             onPressed: () {
//               FocusScope.of(context).requestFocus(FocusNode());
//
//               // double currentBalance = UserPreferences().currentBalance;
//               double result = 0;
//
//               if(_selectedIndex == 0){
//                 result = -double.parse(widget._amountTextController.text ?? 0);
//               }else{
//                 result = double.parse(widget._amountTextController.text ?? 0);
//               }
//               print("Result: $result");
//               // UserPreferences().currentBalance = result;
//               UserTransaction newTransaction = UserTransaction(id: Uuid().v1(), amount: result, type: _selectedIndex, day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year, weekday: DateTime.now().weekday);
//
//               DBHelper().newTransaction(newTransaction);
//               // await DBProvider.db.getAllTransactions().then((value) => print(value));
//               // print();
//               Navigator.pop(context);
//             },
//
//             style: NeumorphicStyle(
//                 color: Theme.of(context).backgroundColor,
//                 shape: NeumorphicShape.flat,
//                 boxShape: NeumorphicBoxShape.circle()
//             ),
//             child: Container(
//                 width: 253,
//                 height: 253,
//                 child: Icon(Icons.check, size: 80, color: Color.fromRGBO(116, 116, 116, 1))),
//           ),
//
//
//     );
//   }
// }
//
