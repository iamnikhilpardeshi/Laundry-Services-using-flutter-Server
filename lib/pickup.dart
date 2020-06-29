import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class PickupOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PickupedOrder(),
    );
  }
}

class PickupedOrder extends StatefulWidget {
  @override
  _PickupedOrderState createState() => _PickupedOrderState();
}

class _PickupedOrderState extends State<PickupedOrder> {
  var _orderstatus = ['Complete Order'];
  var _currentstatusSelected = "Complete Order";
  String status, name, mobileno, email, address;
  Stream orderlist;
  final billController = TextEditingController();
  final copydataReference = Firestore.instance;

  var currentdatetime;

//getdata
  getData() async {
    return await Firestore.instance
        .collection("pickuporder")
        .snapshots(); //stream
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
        .collection("pickuporder")
        .document(selectedDoc)
        .updateData(newValues)
        .catchError((e) {
      print(e);
    });
  }

//deleting data
  deletedData(docId) {
    Firestore.instance
        .collection("pickuporder")
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pickuporderlistview(),
    );
  }

  Widget _pickuporderlistview() {
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
                  return Card(
                    child: new ListTile(
                      leading: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Enter Bill"),
                                content: TextField(
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    focusColor: Colors.blue[100],
                                    prefixIcon: Icon(Icons.phone),
                                    labelText: "Bill:",
                                    labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                    hintText: "Bill:",
                                    contentPadding: EdgeInsets.all(12),
                                  ),
                                  controller: billController,
                                ),
                                actions: [
                                  FlatButton(
                                      onPressed: () {
                                        currentdatetime = DateTime.now();

                                        //profile status changed
                                        copydataReference
                                            .collection("profile")
                                            .document(snapshot.data.documents[i]
                                                .data['email'])
                                            .setData({
                                          'mobileno': snapshot.data.documents[i]
                                              .data['mobileno'],
                                          'name': snapshot
                                              .data.documents[i].data['name'],
                                          'address': snapshot.data.documents[i]
                                              .data['address'],
                                          'email': snapshot
                                              .data.documents[i].data['email'],
                                          'orderrequest': snapshot.data
                                              .documents[i].data['requestdate'],
                                          'orderpickup': snapshot.data
                                              .documents[i].data['pickupdate'],
                                          'ordercomplete':
                                              currentdatetime.toString(),
                                          'orderbill': billController.text,
                                          'orderstatus': "Completed",
                                          'garmentdescription': snapshot
                                              .data
                                              .documents[i]
                                              .data['garmentdescription']
                                        });

                                        //save data into usercart
                                        copydataReference
                                            .collection("profile")
                                            .document(snapshot.data.documents[i]
                                                .data['email'])
                                            .collection("mycart")
                                            .document()
                                            .setData({
                                          'mobileno': snapshot.data.documents[i]
                                              .data['mobileno'],
                                          'name': snapshot
                                              .data.documents[i].data['name'],
                                          'address': snapshot.data.documents[i]
                                              .data['address'],
                                          'email': snapshot
                                              .data.documents[i].data['email'],
                                          'orderrequest': snapshot.data
                                              .documents[i].data['requestdate'],
                                          'orderpickup': snapshot.data
                                              .documents[i].data['pickupdate'],
                                          'ordercomplete':
                                              currentdatetime.toString(),
                                          'orderbill': billController.text,
                                          'orderstatus': "Completed",
                                          'garmentdescription': snapshot
                                              .data
                                              .documents[i]
                                              .data['garmentdescription']
                                        });

                                        //save data to accept document
                                        currentdatetime = DateTime.now();
                                        copydataReference
                                            .collection("completeorder")
                                            .document()
                                            .setData({
                                          'mobileno': snapshot.data.documents[i]
                                              .data['mobileno'],
                                          'name': snapshot
                                              .data.documents[i].data['name'],
                                          'address': snapshot.data.documents[i]
                                              .data['address'],
                                          'email': snapshot
                                              .data.documents[i].data['email'],
                                          'requestdate': snapshot.data
                                              .documents[i].data['requestdate'],
                                          'acceptdate': snapshot.data
                                              .documents[i].data['acceptdate'],
                                          'pickupdate': snapshot.data
                                              .documents[i].data['pickupdate'],
                                          'dispatchdate':
                                              currentdatetime.toString(),
                                          'status': "Completed",
                                          'bill': billController.text,
                                          'garmentdescription': snapshot
                                              .data
                                              .documents[i]
                                              .data['garmentdescription']
                                        });

                                        //delete data
                                        deletedData(snapshot
                                            .data.documents[i].documentID);
                                        Navigator.pop(context);
                                      },
                                      child: Text("Ok")),
                                ],
                              ),
                            );
                          }),
                      trailing: IconButton(
                          icon: Icon(Icons.phone),
                          onPressed: () {
                            String phone =
                                snapshot.data.documents[i].data['mobileno'];
                            print(phone);
                            launch(('tel://${phone}'));
                            // _callPhone(phone);
                          }),
                      title: Text("Mobile No: " +
                          snapshot.data.documents[i].data['mobileno']),
                      subtitle: Text(
                        "Name: " +
                            snapshot.data.documents[i].data['name'] +
                            "\n"
                                "Address: " +
                            snapshot.data.documents[i].data['address'] +
                            "\n"
                                // "Email: "+snapshot.data.documents[i].data['email']+"\n"
                                "Request Date:  " +
                            snapshot.data.documents[i].data['requestdate'] +
                            "\n"
                                "Request Accept Date:  " +
                            snapshot.data.documents[i].data['acceptdate'] +
                            "\n"
                                "Pick up Date:  " +
                            snapshot.data.documents[i].data['pickupdate'] +
                            "\n"
                                "Garment Description:  " +
                            snapshot
                                .data.documents[i].data['garmentdescription'],
                      ),
                      onTap: () {},
                      onLongPress: () {
                        deletedData(snapshot.data.documents[i].documentID);
                      },
                    ),
                  );
                });
          });
    } else {
      return Text("Loading, please wait..");
    }
  }
}
