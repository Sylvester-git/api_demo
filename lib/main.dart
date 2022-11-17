import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String stringresponse;
  Map? maprespnse;
  List? listusers;

  Future getrequest() async {
    http.Response response;
    response = await http
        .get(Uri.parse('https://reqres.in/api/users?page=2' //list of users url
            /*"https://reqres.in/api/users/2"*/));
    if (response.statusCode == 200) {
      setState(() {
        // stringresponse = response.body;
        maprespnse = json.decode(response.body);
        listusers = maprespnse!['data'];
      });
    }
  }

  @override
  void initState() {
    getrequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('API DEMO'),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: listusers == null ? 0 : listusers!.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              height: 300,
              width: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  listusers![index]['avatar'].toString(),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
            );
          },
        )
        //  Center(
        //     child: Container(
        //   color: Colors.blue,
        //   width: 300,
        //   height: 300,
        //   child: Center(
        //     child: listusers == null
        //         ? Text('Getting your data')
        //         : Text(listusers![0]['first_name'].toString()),
        //   ),
        // )),
        );
  }
}
