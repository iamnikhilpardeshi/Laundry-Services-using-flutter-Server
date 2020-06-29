import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RatesScreen extends StatefulWidget {
  @override
  _RatesScreenState createState() => _RatesScreenState();
}

class _RatesScreenState extends State<RatesScreen> {
  final itemnameController = TextEditingController();
  final ironController = TextEditingController();
  final washController = TextEditingController();
  final starchController = TextEditingController();
  final drycleanController = TextEditingController();

  final databaseReference = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Rate"),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add), onPressed: () {}, color: Colors.white),
          ],
        ),
        body: ListPage(),
        floatingActionButton: Container(
            height: 60.0,
            width: 60.0,
            child: FittedBox(
                child: FloatingActionButton(
                    backgroundColor: Colors.black,
                    child: Icon(Icons.add),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                                child: Column(children: <Widget>[
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Add Item",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 30),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 20,
                                color: Colors.black,
                                indent: 40,
                                endIndent: 40,
                              ),
                              Container(
                                  // height: 400,
                                  width: double.infinity,
                                  child: ListView(shrinkWrap: true, children: <
                                      Widget>[
                                    SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              TextField(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  focusColor: Colors.blue[100],
                                                  prefixIcon: Icon(Icons.home),
                                                  labelText: "Item Name:",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  hintText: "Item Name:",
                                                  contentPadding:
                                                      EdgeInsets.all(12),
                                                ),
                                                controller: itemnameController,
                                              ),
                                              SizedBox(
                                                height: 8.0,
                                              ),
                                              TextField(
                                                keyboardType:
                                                    TextInputType.phone,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  focusColor: Colors.blue[100],
                                                  prefixIcon: Icon(
                                                      Icons.account_balance),
                                                  labelText: "Ironing Price:",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  hintText: "Ironing Price:",
                                                  contentPadding:
                                                      EdgeInsets.all(12),
                                                ),
                                                controller: ironController,
                                              ),
                                              SizedBox(
                                                height: 8.0,
                                              ),
                                              TextField(
                                                keyboardType:
                                                    TextInputType.phone,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  focusColor: Colors.blue[100],
                                                  prefixIcon: Icon(
                                                      Icons.account_balance),
                                                  labelText: "Wash Price:",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  hintText: "Wash Price:",
                                                  contentPadding:
                                                      EdgeInsets.all(12),
                                                ),
                                                controller: washController,
                                              ),
                                              SizedBox(
                                                height: 8.0,
                                              ),
                                              TextField(
                                                keyboardType:
                                                    TextInputType.phone,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  focusColor: Colors.blue[100],
                                                  prefixIcon: Icon(
                                                      Icons.account_balance),
                                                  labelText: "Dry Clean Price:",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  hintText: "Dry Clean Price:",
                                                  contentPadding:
                                                      EdgeInsets.all(12),
                                                ),
                                                controller: drycleanController,
                                              ),
                                              SizedBox(
                                                height: 8.0,
                                              ),
                                              TextField(
                                                keyboardType:
                                                    TextInputType.phone,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  focusColor: Colors.blue[100],
                                                  prefixIcon: Icon(
                                                      Icons.account_balance),
                                                  labelText: "Starch Price:",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  hintText: "Starch Price:",
                                                  contentPadding:
                                                      EdgeInsets.all(12),
                                                ),
                                                controller: starchController,
                                              ),
                                              SizedBox(
                                                height: 8.0,
                                              ),
                                              SizedBox(
                                                  width: double.infinity,
                                                  height: 40,
                                                  child: RaisedButton(
                                                    onPressed: () {
                                                      createRate();
                                                    },
                                                    splashColor:
                                                        Colors.yellow[200],
                                                    animationDuration:
                                                        Duration(seconds: 2),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(18.0),
                                                      side: BorderSide(
                                                          color: Colors.black),
                                                    ),
                                                    child: Text("Continue"),
                                                    color: Colors.blue[100],
                                                  ))
                                            ]))
                                  ]))
                            ]));
                          });
                    }))));
  }

  void createRate() async {
    await databaseReference.collection("rates").document().setData({
      'title': itemnameController.text,
      'wash': washController.text,
      'iron': ironController.text,
      'dryclean': drycleanController.text,
      'starch': starchController.text
    });
  }
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  String status, name, mobileno, email, address;

  Stream orderlist;

  final copydataReference = Firestore.instance;

//getdata
  getData() async {
    return await Firestore.instance.collection("rates").snapshots(); //stream
  }

  @override
  void initState() {
    getData().then((results) {
      setState(() {
        orderlist = results;
      });
    });
    super.initState();
  }

// update data
  updateData(selectedDoc, newValues) {
    Firestore.instance
        .collection("rates")
        .document(selectedDoc)
        .updateData(newValues)
        .catchError((e) {
      print(e);
    });
  }

//deleting data
  deletedData(docId) {
    Firestore.instance
        .collection("rates")
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ratelistview(),
    );
  }

  Widget _ratelistview() {
    if (orderlist != null) {
      return StreamBuilder(
          stream: orderlist,
          builder: (context, snapshot) {
            if (snapshot.data == null)
              return Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)));
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                padding: EdgeInsets.all(5.0),
                itemBuilder: (context, i) {
                  return new ListTile(
                    title: Text(snapshot.data.documents[i].data['title']),
                    subtitle: Text("Ironing Price: " +
                        snapshot.data.documents[i].data['iron'] +
                        "\n"
                            "Washing Price: " +
                        snapshot.data.documents[i].data['wash'] +
                        "\n"
                            "Dry Cleaning Price: " +
                        snapshot.data.documents[i].data['dryclean'] +
                        "\n"
                            "Starch Price: " +
                        snapshot.data.documents[i].data['starch']),
                    onTap: () {},
                    onLongPress: () {
                      deletedData(snapshot.data.documents[i].documentID);
                    },
                  );
                });
          });
    } else {
      return Text("Loading, please wait..");
    }
  }
}
