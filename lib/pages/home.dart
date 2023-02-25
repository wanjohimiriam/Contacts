// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:contacts/pages/data.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  ScrollController scrollController = ScrollController();


  List <Map<String, dynamic>> _foundusers = [];

  @override
  void initState() {
     _foundusers = contacts;
    super.initState();
  }

  void _runfilter(String enteredKeyword) {
    List <Map<String, dynamic>> results = [];

    if (enteredKeyword.isEmpty) {
      results = contacts;
    } else {
      results = contacts.where((users) =>
                    users['name'].toLowerCase().contains(enteredKeyword.toLowerCase())).toList();

    }
    setState(() {
      _foundusers = results;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color.fromARGB(255, 230, 179, 240),
        title: Center(
          child: Text(
            'Contacts',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            onChanged: (value){
              _runfilter(value);
            },
            decoration: InputDecoration(
                hintText: 'Search',
                hintMaxLines: 10,
                //loatingLabelStyle: TextStyle(color:Color.fromARGB(255, 230, 179, 240)),
                suffixIcon: Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 230, 179, 240),
                )),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: Scrollbar(
              controller: scrollController,
              isAlwaysShown: true,
              showTrackOnHover: true,
              child: ListView.builder(
                  controller: scrollController,
                  itemCount:_foundusers.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 243, 222, 247),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                blurRadius: 3,
                                spreadRadius: 0.5,
                                color: Colors.black12,
                                offset: Offset(3, 4),
                              )
                            ],
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(8.0),
                          //tileColor: Color.fromARGB(255, 243, 222, 247),
                          leading: Text(_foundusers[index]['id'].toString()),
                          title: Text(_foundusers[index]['name']),
                          subtitle: Text(_foundusers[index]['phone_number']),
                          trailing: Icon(Icons.phone),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ]),
      ),
    );
  }
}
