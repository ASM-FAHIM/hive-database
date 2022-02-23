import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key, required String title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Refer the box
   late Box<String> leaveApplyBox ;
   TextEditingController _idController = TextEditingController();
  TextEditingController _taskAssignToController = TextEditingController();

  @override
  void initState() {
    // initialize for opening the box(database)
    leaveApplyBox = Hive.box("leaveApplybox");
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('database CRUD operation',),
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: leaveApplyBox.listenable(), //we need to provide the instance of the box
                builder: (context, Box<String> leaveApply, _){
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      final keys = leaveApply.keys.toList()[index];
                      final value = leaveApply.get(keys);
                      return ListTile(
                        title: Text(value!.toUpperCase() , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        subtitle: Text(keys, style: TextStyle(fontSize: 15),),
                      );
                    },
                    separatorBuilder: (_, index) => Divider(),
                    itemCount: leaveApply.keys.toList().length,
                  );
                }
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatButton(
                  onPressed: (){
                    showDialog(
                        context: context,
                          builder: (_){
                          return Dialog(
                            child: Container(
                              child: Column(
                                children: [
                                  TextField(
                                    controller: _idController,
                                    decoration: InputDecoration(labelText: 'Enter id'),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  TextField(
                                    controller: _taskAssignToController,
                                    decoration: InputDecoration(labelText: 'Enter Task assign to'),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  // TextField(
                                  //   controller: _reasonForApplicationController,
                                  //   decoration: InputDecoration(labelText: 'Enter reason for leave'),
                                  // ),
                                  // SizedBox(
                                  //   height: 5,
                                  // ),
                                  // TextField(
                                  //   controller: _contactNumberController,
                                  //   decoration: InputDecoration(labelText: 'Enter contact number'),
                                  // ),
                                  // SizedBox(
                                  //   height: 5,
                                  // ),
                                  FlatButton(
                                    color: Colors.blue,
                                      child: Text('Submit file',),
                                      onPressed: (){
                                      //adding data to the box
                                        final key = _idController.text;
                                        final value= _taskAssignToController.text;
                                        leaveApplyBox.put(key, value,);
                                        // print(leaveApplyBox.get(key));
                                        Navigator.pop(context);
                                      },

                                  )
                                ],
                              ),
                            ),
                          );
                          }
                    );
                  },
                  child: Text('Apply'),color: Colors.lightBlue,),
                FlatButton(onPressed: (){}, child: Text('Update'),color: Colors.greenAccent,),
                FlatButton(onPressed: (){}, child: Text('Delete'),color: Colors.yellowAccent,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
