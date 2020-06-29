import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class CompleteOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CompletedOrder(),
      );
  }
}
class CompletedOrder extends StatefulWidget {
  @override
  _CompletedOrderState createState() => _CompletedOrderState();
}

class _CompletedOrderState extends State<CompletedOrder> {
  Stream orderlist;
  final copydataReference = Firestore.instance;

//getdata
  getData() async{
    return await Firestore.instance.collection("completeorder").snapshots(); //stream
  }
  @override
  void initState(){
    getData().then((results){
      setState(() {
        orderlist=results;  
      });
    });
    super.initState();
  }

//deleting data
deletedData(docId){
  Firestore.instance.collection("completeorder").document(docId).delete().catchError((e){
    print(e);
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _completeorderlistview(),     
    );
  }
  Widget _completeorderlistview(){
    if(orderlist!=null){
        return StreamBuilder(
          stream: orderlist,
          builder: (context, snapshot){
            if(snapshot.data == null) return Center(child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)));
                    return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      padding: EdgeInsets.all(5.0),

                      itemBuilder: (context, i){
                        return Card(
                            child: new ListTile(
                              trailing: IconButton(icon: Icon(Icons.phone), 
                                  onPressed: (){
                                    String phone =snapshot.data.documents[i].data['mobileno'];
                                    print(phone);
                                    launch(('tel://${phone}'));
                                    // _callPhone(phone);
                                  }),

                                title: Text("Mobile No: "+snapshot.data.documents[i].data['mobileno']),
                                subtitle: Text("Name: "+snapshot.data.documents[i].data['name']+"\n"
                                "Address: "+snapshot.data.documents[i].data['address']+"\n"
                                // "Email: "+snapshot.data.documents[i].data['email']+"\n"
                                "Request Date:  "+snapshot.data.documents[i].data['requestdate']+"\n"
                                "Pick up Date:  "+snapshot.data.documents[i].data['pickupdate']+"\n"
                                "Dispatch Date:  "+snapshot.data.documents[i].data['dispatchdate']+"\n"
                                "Bill: "+snapshot.data.documents[i].data['bill']+"\n"
                                "Garment Description: "+snapshot.data.documents[i].data['garmentdescription']
                                ),                                
                                onTap: (){},
                                  onLongPress: (){
                                    deletedData(snapshot.data.documents[i].documentID);
                                  },
                          ),
                        );
                        });
                        });
                        }
                        else{
                          return Text("Loading, please wait..");
                        }
  }
}