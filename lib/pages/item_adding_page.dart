import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ItemAddingPage extends StatefulWidget {
  const ItemAddingPage({Key? key}) : super(key: key);

  @override
  _ItemAddingPageState createState() => _ItemAddingPageState();
}

class _ItemAddingPageState extends State<ItemAddingPage> {

  String _title = '', _text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellowAccent[100],
      appBar: AppBar(
        title: Text('Adding new note'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 50),
        // color: Colors.grey,
        // width: 400,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text('Enter values bellow:', style: TextStyle(fontSize: 20, color: Colors.deepPurple[500]),),
                Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  width: 200,
                  child: TextField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Type the title here',
                        labelStyle: new TextStyle(color: Colors.deepPurple[500], fontStyle: FontStyle.italic),
                        suffixIcon: Icon(Icons.text_fields),
                      ),
                      onChanged: (String value){
                        setState(() {
                          _title = value;
                        });
                      }
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  width: 200,
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Type the note',
                        labelStyle: new TextStyle(color: Colors.deepPurple[500], fontStyle: FontStyle.italic),
                        suffixIcon: Icon(Icons.text_format),
                    ),
                      onChanged: (String value){
                        setState(() {
                          _text = value;
                        });
                      }
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                ElevatedButton(
                    onPressed: (){
                      FirebaseFirestore.instance.collection('notes').add({'title': _title, 'text': _text});
                      Navigator.pop(context);
                    },
                    child: Text('Add the note'),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.deepPurple[500])),)
              ],
            )
          ],
        ),
      )
    );
  }
}
