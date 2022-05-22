import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'home screen.dart';
import 'scroll_toutch_mouse..dart';
import '../Database/Note_dp.dart';

class newNoteScreen extends StatefulWidget {
  newNoteScreen({Key? key}) : super(key: key);

  @override
  State<newNoteScreen> createState() => _newNoteScreenState();
}

class _newNoteScreenState extends State<newNoteScreen> {
  bool colorBlue = true;
  bool colorRed = false;
  bool colorBlue2 = false;
  bool colorGreen = false;
  bool colorYallow = false;
  bool colorOrange = false;

  int valueColor = Color(0xFF1321E0).value;
  Color themeColor = const Color(0xFF1321E0);

  GlobalKey<FormState> formstate = GlobalKey();
  GlobalKey<FormState> formstatecolor = GlobalKey();

  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();
  SqlDb note_dp = SqlDb();
  List notes = [];

  Future<List<Map>> readData() async {
    List<Map> response = await note_dp.readData("SELECT * FROM Notes");
    notes.addAll(response);
    if (this.mounted) {
      setState(() {});
    }
    return response;
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        elevation: 15,
        title: const Text(
          'New Note',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          MaterialButton(
            minWidth: 15,
            textColor: Colors.white,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return BottomSheet(
                    onClosing: () {},
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Wrap(
                          children: [
                            MaterialButton(
                                child: const ListTile(
                                  leading: Icon(Icons.share),
                                  title: Text('Share with your friends'),
                                ),
                                onPressed: () async {
                                  await Share.share("This Note");
                                }),
                            MaterialButton(
                              child: const ListTile(
                                leading: Icon(Icons.delete),
                                title: Text('Delete'),
                              ),
                              onPressed: () async {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => homeScreen()),
                                    (route) => false);
                              },
                            ),
                            MaterialButton(
                              child: const ListTile(
                                leading: Icon(Icons.control_point_duplicate),
                                title: Text('Duplicate'),
                              ),
                              onPressed: () async {
                                int response = await note_dp.insertData(
                                    '''INSERT INTO Notes ('title','note', 'color')
                                        VALUES ("${title.text}", "${note.text}", $valueColor) ''');
                                if (response > 0) {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => homeScreen()),
                                      (route) => false);
                                }
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Container(
                                margin: const EdgeInsets.only(
                                  left: 15.0,
                                ),
                                height: 50.0,
                                child: ScrollConfiguration(
                                  behavior: MyCustomScrollBehavior(),
                                  child: Form(
                                    key: formstatecolor,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: const Color(0xFF1321E0),
                                            shape: const CircleBorder(),
                                          ),
                                          onPressed: () => setState(() {
                                            colorBlue = true;
                                            colorRed = false;
                                            colorBlue2 = false;
                                            colorGreen = false;
                                            colorYallow = false;
                                            colorOrange = false;
                                            themeColor =
                                                const Color(0xFF1321E0);
                                            valueColor = themeColor.value;
                                          }),
                                          child: Icon(
                                            colorBlue ? Icons.check : null,
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.red,
                                            shape: const CircleBorder(),
                                          ),
                                          onPressed: () => setState(() {
                                            colorBlue = false;
                                            colorRed = true;
                                            colorBlue2 = false;
                                            colorGreen = false;
                                            colorYallow = false;
                                            colorOrange = false;
                                            themeColor = Colors.red;
                                            valueColor = themeColor.value;
                                          }),
                                          child: Icon(
                                            colorRed ? Icons.check : null,
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.blue,
                                            shape: const CircleBorder(),
                                          ),
                                          onPressed: () => setState(() {
                                            colorBlue = false;
                                            colorRed = false;
                                            colorBlue2 = true;
                                            colorGreen = false;
                                            colorYallow = false;
                                            colorOrange = false;
                                            themeColor = Colors.blue;
                                            valueColor = themeColor.value;
                                          }),
                                          child: Icon(
                                            colorBlue2 ? Icons.check : null,
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.green,
                                            shape: const CircleBorder(),
                                          ),
                                          onPressed: () => setState(() {
                                            colorBlue = false;
                                            colorRed = false;
                                            colorBlue2 = false;
                                            colorGreen = true;
                                            colorYallow = false;
                                            colorOrange = false;
                                            themeColor = Colors.green;
                                            valueColor = themeColor.value;
                                          }),
                                          child: Icon(
                                            colorGreen ? Icons.check : null,
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.yellow,
                                            shape: const CircleBorder(),
                                          ),
                                          onPressed: () => setState(() {
                                            colorBlue = false;
                                            colorRed = false;
                                            colorBlue2 = false;
                                            colorGreen = false;
                                            colorYallow = true;
                                            colorOrange = false;
                                            themeColor = Colors.yellow;
                                            valueColor = themeColor.value;
                                          }),
                                          child: Icon(
                                            colorYallow ? Icons.check : null,
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.orange,
                                            shape: const CircleBorder(),
                                          ),
                                          onPressed: () => setState(() {
                                            colorBlue = false;
                                            colorRed = false;
                                            colorBlue2 = false;
                                            colorGreen = false;
                                            colorYallow = false;
                                            colorOrange = true;
                                            themeColor = Colors.orange;
                                            valueColor = themeColor.value;
                                          }),
                                          child: Icon(
                                            colorOrange ? Icons.check : null,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
            child: const Icon(
              Icons.more_vert,
            ),
          ),
          MaterialButton(
            minWidth: 15,
            textColor: Colors.white,
            onPressed: () async {
              int response = await note_dp
                  .insertData('''INSERT INTO Notes ('title','note' ,'color')
                  VALUES ("${title.text}", "${note.text}", "${valueColor}") ''');
              if (response > 0) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => homeScreen()),
                    (route) => false);
              }
            },
            child: const Icon(Icons.check),
          ),
        ],
      ),
      body: Form(
        key: formstate,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: title,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    label: Text(
                      'Type Something....',
                      style: TextStyle(
                        color: Color(0xFF1321E0),
                      ),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              const Divider(
                thickness: 3,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: TextFormField(
                  controller: note,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    label: Text(
                      'Type Something....',
                      style: TextStyle(
                        color: Color(0x931321E0),
                      ),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
