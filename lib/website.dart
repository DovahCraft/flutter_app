//NOTE: Create your website code and widgets here in website.dart.
import 'package:flutter/material.dart';

//Joe: Change this to a Stateful widget so we can add new courses and display them.
//Use the setState() method to reflect UI changes.
//TODO: Look up how to format and use stateful widgets, try and get them working by Tuesday
//TODO: Try and add new course widgets to first screen, that way we can test on
//Tuesday.

//This widget is a very basic class that does not need much code in it.
//It creates an instance of _FirstScreenState, where most of the UI and
//Logic for the FirstScreen is.
class FirstScreen extends StatefulWidget {
  FirstScreen({Key key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

//Edit this _FirstScreenState class to add functionality to the FirstScreen
//page widget. initState is called when this class is first created (when you
//first render a FirstScreen page.)
class _FirstScreenState extends State<FirstScreen> {
  final List<Widget> courses = new List();

  //This method is called when you create a FirstScreen page
  void initState() {
    super.initState();
    createCourses();
  }

//This method is called from initstate to create five course panels with
//trailing arrow icons.
  void createCourses() {
    for (var i = 0; i < 5; i++) {
      courses.add(ListTile(
        title: Text("Course $i"),
        //This parameter adds the arrow icon to each ListTile.
        trailing: IconButton(
          icon: Icon(Icons.subdirectory_arrow_right),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => new ModuleScreen()));
          },
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Courses'), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          tooltip: 'add course',
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => new CreateCourse()));
          },
        ),
      ]),
      body: Center(
        child: Column(
          children: courses.toList(),
        ),
      ),
    );
  }
}

//TODO: Make this a Stateful widget so you can add new modules to it
//using userinput.
class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('ENG400-Module1')),
        body: Center(child: ExpansionPanelPage()));
  }
}

class ModuleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Modules'), actions: <Widget>[
          IconButton(
            icon: Icon(Icons.ac_unit),
            tooltip: 'add module',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new CreateModule()));
            },
          ),
        ]),
        body: Center(
          child: RaisedButton(
            child: Text('Module1'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new SecondScreen()));
            },
          ),
        ));
  }
}

class CreateCourse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('CreateCourse')),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            Container(
              child: TextField(
                keyboardType: TextInputType.name,
                maxLines: 1,
                autofocus: false,
                cursorColor: Colors.blue,
                maxLength: 10,
                maxLengthEnforced: true,
                onChanged: (text) {
                  print("CourseName = $text");
                },
                decoration: InputDecoration(
                  labelText: "Course Name",
                  prefixIcon: Icon(Icons.folder),
                  //Unfocus Text is grey
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  //Focued Text is blue
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: RaisedButton(
                    child: Text("Create Course"),
                    onPressed: () {
                      Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FirstScreen()));
                    }),
              ),
            ),
          ],
        )));
  }
}

class CreateModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('CreateCourse')),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            Container(
              child: TextField(
                keyboardType: TextInputType.name,
                maxLines: 1,
                autofocus: false,
                cursorColor: Colors.blue,
                maxLength: 10,
                maxLengthEnforced: true,
                decoration: InputDecoration(
                  labelText: "Module Name",
                  prefixIcon: Icon(Icons.folder),
                  //Unfocus Text is grey
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  //Focued Text is blue
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: RaisedButton(
                    child: Text("Create Module"), onPressed: () {}),
              ),
            ),
          ],
        )));
  }
}

class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });
  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Lesson $index',
      expandedValue: 'This is lesson $index',
    );
  });
}

class ExpansionPanelPage extends StatefulWidget {
  ExpansionPanelPage({Key key}) : super(key: key);
  @override
  _ExpansionPanelPageState createState() => _ExpansionPanelPageState();
}

class _ExpansionPanelPageState extends State<ExpansionPanelPage> {
  List<Item> _data = generateItems(8);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ENG400'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: _buildPanel(),
        ),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
              title: Text(item.expandedValue),
              subtitle: Text('To delete this panel, tap the trash can icon'),
              trailing: Icon(Icons.delete),
              onTap: () {
                setState(() {
                  _data.removeWhere((currentItem) => item == currentItem);
                });
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
