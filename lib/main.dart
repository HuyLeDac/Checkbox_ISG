import 'dart:js_util';

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
  const TodoApp({super.key});

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
  void addTodo(String value) {
  setState(() {
    todos.add({'title': value, 'isChecked': false});
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

  //Build the add todo button
  Padding buildAddTodoButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => addTodo(controller.text),
        child: const Tooltip(
          message: 'Write down your todo and click here to add it to the list.',
          child: Text('Add todo'),
        ),
      ),
    );
  }

  //Build the clear todos button
  Padding buildClearTodosButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            todos.clear();
          });
        },
        child: const Tooltip(
          message: 'Click here to clear the list of todos.',
          child: Text('Clear todos'),
        ),
      ),
    );
  }

  //Build the counter text
  Padding buildCounterText(int length) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('Number of todos: $length'),
    );
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
        
            //Text field to enter a new todo
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Enter a new ISG todo...',
              ),
              onSubmitted: (value) => addTodo(controller.text),
            ),
        
            //Row to add a new todo and clear the list of todos
            Row(
              children: [
                //Button to add a new todo
                buildAddTodoButton(),
                //Button to clear the list of todos
                buildClearTodosButton(),
                //Text to display the number of todos
                buildCounterText(todos.length),
              ],
            ),
           
            //Expanded is used to make the ListView take up the remaining space
            Expanded(
              //ListView is used to display the list of todos
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  //Each todo is displayed as a ListTile
                  return Card( // Wrap ListTile with a Card
                    color: Colors.grey[200], // Set the color of the card
                    child: ListTile(
                      title: Text(todos[index]['title']),
                      leading: Checkbox(
                        value: todos[index]['isChecked'], 
                        onChanged: (bool? value) {
                          setState(() {
                            todos[index]['isChecked'] = value!;
                          });
                        },
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => removeTodo(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
