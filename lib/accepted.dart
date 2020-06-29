import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class AcceptOrder extends StatelessWidget {
  final statusController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AcceptedOrder(),
      );
  }
}

class AcceptedOrder extends StatefulWidget {
  @override
  _AcceptedOrderState createState() => _AcceptedOrderState();
}

class _AcceptedOrderState extends State<AcceptedOrder> {
  var _orderstatus=['Pick Up'];
  var _currentstatusSelected ="Pick Up";
  String status,name,mobileno,email,address;
  Stream orderlist;
  final statusController = TextEditingController();
  final copydataReference = Firestore.instance;
  var currentdatetime ;
  final garmentController = TextEditingController();
  final garmentDescriptionController = TextEditingController();
  final servicetypeController = TextEditingController();


  
  
//getdata
  getData() async{
    return await Firestore.instance.collection("acceptorder").snapshots(); //stream
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

// update data
updateData(selectedDoc,newValues){
  Firestore.instance.collection("acceptorder").document(selectedDoc).updateData(newValues).catchError((e){
    print(e);
  });
}

//deleting data
deletedData(docId){
  Firestore.instance.collection("acceptorder").document(docId).delete().catchError((e){
    print(e);
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _acceptorderlistview(),     
    );
  }
  Widget _acceptorderlistview(){
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
                              leading: IconButton(icon: Icon(Icons.add), 
                              onPressed: (){
                                                // copydataReference.collection("profile")
                                                // .document(snapshot.data.documents[i].data['email'])
                                                // .collection("garmentdetails")
                                                // .document('1')
                                                // .delete(); 
                                                
                                                
                                                // copydataReference.collection("profile")
                                                // .document(snapshot.data.documents[i].data['email'])
                                                // .collection("garmentdetails")
                                                // .document('1')
                                                // .setData({
                                                //   'email': snapshot.data.documents[i].data['email'],
                                                // }); 

                                showDialog(
                                context: context,
                                builder: (context)=> AlertDialog(
                                  title: Text("Enter Garments Details"),
                                  content: Container(
                                    margin: EdgeInsets.all(10),
                                    width: double.infinity,
                                    height: 200,
                                    child: TextField(
                                                  // keyboardType: TextInputType.text,
                                                  decoration: InputDecoration(
                                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                                  focusColor: Colors.blue[100],
                                                  prefixIcon : Icon(Icons.note),
                                                  labelText: "Enter Garment Description:",
                                                  labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                                                  hintText: "Enter Garment Description:",
                                                  contentPadding: EdgeInsets.all(12),      
                                                  ),                   
                                                  controller: garmentDescriptionController,
                                                  maxLength: 250,
                                                  maxLines: 25,
                                                  ),
                                              ),
                                  actions:[
                                    FlatButton(
                                      onPressed: (){
                                      
                                      currentdatetime = DateTime.now();
                                //profile status changed
                                        copydataReference.collection("profile")
                                      .document(snapshot.data.documents[i].data['email'])
                                      .setData({
                                        'mobileno' : snapshot.data.documents[i].data['mobileno'],
                                        'name': snapshot.data.documents[i].data['name'],
                                        'address': snapshot.data.documents[i].data['address'],
                                        'email': snapshot.data.documents[i].data['email'],
                                        'orderrequest' : snapshot.data.documents[i].data['requestdate'],
                                        'orderpickup' : currentdatetime.toString(),
                                        'ordercomplete':'-',
                                        'orderbill':'-',
                                        'orderstatus': "Pick up",
                                        'garmentdescription': garmentDescriptionController.text,
                                      });

                                      

                                      //save data to accept document
                                      currentdatetime = DateTime.now();
                                      copydataReference.collection("pickuporder")
                                      // .document(snapshot.data.documents[i].data['email'])
                                      .document()
                                      .setData({
                                        'mobileno' : snapshot.data.documents[i].data['mobileno'],
                                        'name': snapshot.data.documents[i].data['name'],
                                        'address': snapshot.data.documents[i].data['address'],
                                        'email': snapshot.data.documents[i].data['email'],
                                        'requestdate' : snapshot.data.documents[i].data['requestdate'],
                                        'acceptdate' : snapshot.data.documents[i].data['acceptdate'],
                                        'pickupdate' : currentdatetime.toString(),
                                        'status': "Pick up",
                                        'garmentdescription': garmentDescriptionController.text
                                      });
                                      //delete data
                                      deletedData(snapshot.data.documents[i].documentID);
                                      Navigator.pop(context);

                                      }, 
                                      child: Text("Ok")),
                                  ],
                                ),
                                );
                                      // Navigator.pop(context);
                              }),

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
                            "Request Accept Date:  "+snapshot.data.documents[i].data['acceptdate']),
                            onTap: (){
                            },
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


