import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}


//This class should create a simple todo app with a list of todos and checkboxes to mark them as done.
//The app should have a text field to add new todos and a button to add them to the list. 
//StatelessWidget is used because the app does not need to maintain any state.
class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Todo App',
      home: TodoApp(),
    );
  }
}

//This class should create a stateful widget that builds the todo app.
class TodoApp extends StatefulWidget {
  const TodoApp({Key? key}) : super(key: key);

  //State class is created to maintain the state of the app
  @override
  State<TodoApp> createState() => _TodoAppState();
}

// '_' is used to make the class private
class _TodoAppState extends State<TodoApp> {
  //List of todos with state if they are checked or not
  final List<Map<String, dynamic>> todos = [];
  //Text controller to get the text from the text field
  final TextEditingController controller = TextEditingController();

  //Add a new todo to the list
  //Clear the text field after adding the todo
  void addTodo() {
    setState(() {
      todos.add({'title': controller.text, 'isChecked': false});
      controller.clear();
    });
  }

  //Remove a todo from the list
  void removeTodo(int index) {
    setState(() {
      //Remove the todo at the given index
      todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App bar with the title
      appBar: AppBar(
        title: const Text('ISG Todo App'),
        backgroundColor: Color.fromRGBO(0, 157, 224, 1),
      ),

      //Body of the app
      body: Column(
        children: [

          //Text field to enter a new todo
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Enter a new ISG todo...',
            ),
          ),

          //Button to add a new todo
          ElevatedButton(
            //When the button is pressed, addTodo function is called
            onPressed: addTodo,
            child: const Text('Add Todo'),
          ),

          //List of todos
          //Expanded is used to make the ListView take up the remaining space
          Expanded(
            //ListView is used to display the list of todos
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                //Each todo is displayed as a ListTile
                return ListTile(
                  title: Text(todos[index]['title']),
                  
                  //Checkbox to mark the todo as done
                  leading: Checkbox(
                    value: todos[index]['isChecked'], 
                    onChanged: (bool? value) {
                      setState(() {
                        // update the value of checkbox
                        todos[index]['isChecked'] = value!;

                      });
                    },
                  ),
                 
                  //Delete button to remove the todo
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => removeTodo(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
