import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  XFile _file = XFile('');
  String repertoire = '';
  List files = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //select directory
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  const typeGroup = XTypeGroup(
                    label: 'audio',
                    extensions: ['mp3', 'ogg', 'wav'],
                  );
                  final file = await openFile(acceptedTypeGroups: [typeGroup]);
                  setState(() {
                    if (file != null && file.path != null) {
                      _file = file;
                      repertoire = p.dirname(file.path);
                      files = Directory(repertoire).listSync();
                      files.sort((a, b) => a.path.compareTo(b.path));
                      print(files);
                    }
                  });
                },
                child: Text(_file.path == ''
                    ? 'Select Directory'
                    : repertoire.split('/').last),
              ),
            ),
            //view list files
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: files.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    width: double.infinity,
                    color: Theme.of(context).primaryColorLight,
                    child: Text(files[index].path.split('/').last),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
