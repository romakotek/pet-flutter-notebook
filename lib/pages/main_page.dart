import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  String _title = '', _text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent[100],
      appBar: AppBar(
        title: Text('Notebook'),
        centerTitle: true,
        actions: [
          // Создаем иконку в шапке
          IconButton(
            icon: Icon(Icons.add, size: 30, semanticLabel: 'Add'),
            onPressed: () {
              // При нажатии переходим на другую страницу
              Navigator.pushNamed(context, '/additem');
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('notes').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.data!.docs.length == 0) return Center(child: Text('No notes yet'),);
          return ListView.builder(
              itemCount:snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                    key: Key(snapshot.data!.docs[index].id),
                    child: Card(
                      color: Colors.yellow[100],
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data!.docs[index].get('title'), style: TextStyle(fontSize: 18),),
                                Text(snapshot.data!.docs[index].get('text'), style: TextStyle(color: Colors.grey),)
                              ],
                            )
                          ],
                        ),
                        trailing: Wrap(
                          children: [

                            IconButton(
                              onPressed: (){
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Edit the note'),
                                        content: Container(
                                          child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    width: 200,
                                                    child: TextField(
                                                        style: TextStyle(color: Colors.red),
                                                        decoration: InputDecoration(
                                                          border: UnderlineInputBorder(),
                                                          labelText: 'Input the note title',
                                                          labelStyle: new TextStyle(color: Colors.yellowAccent),
                                                          suffixIcon: Icon(Icons.text_fields),
                                                        ),
                                                        onChanged: (String value){
                                                          setState(() {
                                                            _title = value;
                                                          });
                                                        }
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 200,
                                                    child: TextField(
                                                        style: TextStyle(color: Colors.black),
                                                        decoration: InputDecoration(
                                                          border: UnderlineInputBorder(),
                                                          labelText: 'Type the note',
                                                          labelStyle: new TextStyle(color: Colors.yellowAccent),
                                                          suffixIcon: Icon(Icons.text_format),
                                                        ),
                                                        onChanged: (String value){
                                                          setState(() {
                                                            _text = value;
                                                          });
                                                        }
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: (){
                                              FirebaseFirestore.instance.collection('notes').
                                              doc(snapshot.data?.docs[index].id).set({'title': _title, 'text': _text});
                                              Navigator.pop(context);
                                            },
                                            child: Text('Save changes'),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              icon: Icon(Icons.edit, color: Colors.deepPurple[500],),),

                            IconButton(
                              onPressed: (){
                                FirebaseFirestore.instance.collection('notes').
                                doc(snapshot.data?.docs[index].id).delete();
                              },
                              icon: Icon(Icons.delete, color: Colors.deepPurple[500],),),
                          ],
                        ),
                      ),
                    ),
                  onDismissed: (direction) {
                      FirebaseFirestore.instance.collection('notes').doc(snapshot.data?.docs[index].id).delete();
                  },
                );
              }
          );
        }
      ),
    );
  }
}
