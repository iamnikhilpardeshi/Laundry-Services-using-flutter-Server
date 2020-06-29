import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RequestedOrder(),
    );
  }
}

class RequestedOrder extends StatefulWidget {
  @override
  _RequestedOrderState createState() => _RequestedOrderState();
}

class _RequestedOrderState extends State<RequestedOrder> {
  var _orderstatus = ['Accept'];
  var _currentstatusSelected = "Accept";
  String status, name, mobileno, email, address;
  Stream orderlist;
  final statusController = TextEditingController();
  final copydataReference = Firestore.instance;

  var currentdatetime;

//getdata
  getData() async {
    return await Firestore.instance
        .collection("requestorder")
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
        .collection("requestorder")
        .document(selectedDoc)
        .updateData(newValues)
        .catchError((e) {
      print(e);
    });
  }

//deleting data
  deletedData(docId) {
    Firestore.instance
        .collection("requestorder")
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }

  String phone = "";

  _callPhone(phone) async {
    if (await canLaunch(phone)) {
      await launch(phone);
    } else {
      throw 'Could not Call Phone';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _requestorderlistview(),
    );
  }

  Widget _requestorderlistview() {
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
                                title: Text("Accept / Delete"),
                                content: Text(
                                    "Do you want to Accept or Delete the order.."),
                                actions: [
                                  FlatButton(
                                      onPressed: () {
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
                                          'orderpickup': '-',
                                          'ordercomplete': '-',
                                          'orderbill': '-',
                                          'orderstatus':
                                              "Sorry! Your location is out of our service area.",
                                        });
                                        deletedData(snapshot
                                            .data.documents[i].documentID);
                                        Navigator.pop(context);
                                      },
                                      child: Text("Delete")),
                                  FlatButton(
                                      onPressed: () {
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
                                          'orderpickup': '-',
                                          'ordercomplete': '-',
                                          'orderbill': '-',
                                          'orderstatus': "Accepted",
                                        });

                                        //save data to accept document
                                        currentdatetime = DateTime.now();
                                        copydataReference
                                            .collection("acceptorder")
                                            // .document(snapshot.data.documents[i].data['email'])
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
                                          'acceptdate':
                                              currentdatetime.toString(),
                                          'status': "Accepted",
                                        });
                                        deletedData(snapshot
                                            .data.documents[i].documentID);
                                        Navigator.pop(context);
                                      },
                                      child: Text("Accept")),
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
                      subtitle: Text("Name: " +
                          snapshot.data.documents[i].data['name'] +
                          "\n"
                              "Address: " +
                          snapshot.data.documents[i].data['address'] +
                          "\n"
                              "Request Date:  " +
                          snapshot.data.documents[i].data['requestdate']),
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
