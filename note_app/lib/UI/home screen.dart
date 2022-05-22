import 'package:flutter/material.dart';
import 'package:note_app/Database/Note_dp.dart';
import 'edit screen.dart';
import '../Database/Note_dp.dart';

class homeScreen extends StatefulWidget {
  homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  SqlDb note_dp = SqlDb();
  bool isLoding = true;
  List notes = [];

  Future<List<Map>> readData() async {
    List<Map> response = await note_dp.readData("SELECT * FROM notes");
    notes.addAll(response);
    isLoding = false;
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
        backgroundColor: const Color(0xFF1321E0),
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'MY Notes',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: ListView(
            children: [
              ListView.builder(
                reverse: true,
                itemCount: notes.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  return MaterialButton(
                    onPressed: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => editNoteScreen(
                            title: notes[i]['title'],
                            note: notes[i]['note'],
                            color: notes[i]['color'],
                            id: notes[i]['id'],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      shape: Border(
                        left: BorderSide(
                            color: Color(notes[i]['color']), width: 5),
                      ),
                      child: ListTile(
                        title: Text(
                          "${notes[i]['title']}",
                          style: TextStyle(
                            color: Color(notes[i]['color']),
                          ),
                        ),
                        subtitle: Text("${notes[i]['note']}"),
                      ),
                    ),
                  );
                  ;
                },
              ),
              if (notes.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Image(
                          image: AssetImage('images/Empty Note.png'),
                          width: 220,
                          height: 150,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            'No Notes :(',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xBE1321E0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            'You have no task to do.',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        hoverColor: Colors.orange,
        child: Column(
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.bottomRight,
                  stops: [
                    0.1,
                    0.9,
                  ],
                  colors: [
                    Color(0xBE1321E0),
                    Color(0xFF86108B),
                  ],
                ),
              ),
              child: const Icon(
                Icons.add,
                size: 40,
              ),
            ),
          ],
        ),
        onPressed: () {
          Navigator.of(context).pushNamed("addnotes");
        },
      ),
    );
  }
}
