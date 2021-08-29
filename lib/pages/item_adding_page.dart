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
      appBar: AppBar(
        title: Text('Adding new note'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 100),
        // color: Colors.grey,
        // width: 400,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text('Укажите значения', style: TextStyle(fontSize: 20, color: Colors.green),),
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
                ElevatedButton(
                    onPressed: (){
                      FirebaseFirestore.instance.collection('notes').add({'title': _title, 'text': _text});
                      Navigator.pop(context);
                    },
                    child: Text('Add the note'))
              ],
            )
          ],
        ),
      )
    );
  }
}
