import 'package:flutter/material.dart';
import 'package:flutter_with_webapi/add_user.dart';
import 'package:flutter_with_webapi/api_handler.dart';
import 'package:flutter_with_webapi/edit_page.dart';
import 'package:flutter_with_webapi/model.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ApiHandler apiHandler = ApiHandler();

  late List<User> data = [];

  void getData() async {
    data = await apiHandler.getUserData();
    setState(() {});
  }

  void deleteUser(int id) async {
    await apiHandler.deleteUser(id: id);
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UserApi"),
        centerTitle: true,
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: MaterialButton(
        color: Colors.amber,
        textColor: Colors.white,
        padding: const EdgeInsets.all(20),
        onPressed: getData,
        child: const Text('Refresh'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber[700],
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddUser(),
              ));
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditPage(user: data[index]),
                    ),
                  );
                },
                leading: Text("${data[index].Id}"),
                title: Text("${data[index].firstName} ${data[index].lastName}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Email: ${data[index].email}"),
                    Text("Phone: ${data[index].phoneNumber}"),
                    Text("Password: ${data[index].password}"),
                  ],
                ),
                isThreeLine:
                    true, // Ensures the ListTile can expand for multiple lines
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    deleteUser(data[index].Id);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
