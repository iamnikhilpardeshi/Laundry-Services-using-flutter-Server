import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'rates_screen.dart';
import 'request.dart' as requestpage;
import 'accepted.dart' as acceptedpage;
import 'pickup.dart' as pickuppage;
import 'complete.dart' as completepage;

class TabbedAppBar extends StatefulWidget {
  @override
  _TabbedAppBarState createState() => _TabbedAppBarState();
}
class _TabbedAppBarState extends State<TabbedAppBar> with SingleTickerProviderStateMixin{



  TabController controller;
  @override
  void initState(){
    super.initState();
    controller = new TabController(length: 4, vsync: this);
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // var currentdate = DateTime.now();
    return Scaffold(
      appBar: AppBar(title: Text("Admin"),
      // appBar: AppBar(title: Text(currentdate.toString()),
      centerTitle: true,
      backgroundColor: Colors.black,
      actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_balance_wallet),
            onPressed: (){
              Navigator.push(context, 
              MaterialPageRoute(
              builder: (context) => RatesScreen(),
              )
            );
            },
            color: Colors.white),
      ],
      bottom:  new TabBar(
        controller: controller,
        tabs: <Widget>[
          new Tab(icon: Icon(Icons.queue),text: "Request Orders",),
          new Tab(icon: Icon(Icons.queue),text: "Accepted Orders",),
          new Tab(icon: Icon(Icons.queue),text: "Pick up Orders",),
          new Tab(icon: Icon(Icons.queue),text: "Completed Orders",),
        ]),
      ),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new requestpage.RequestOrder(),
          new acceptedpage.AcceptOrder(),
          new pickuppage.PickupOrder(),
          new completepage.CompleteOrder(),
        ]),
    );
  }
}