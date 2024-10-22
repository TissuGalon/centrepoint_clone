import 'package:flutter/material.dart';
import 'package:policy_centrepoint/CONFIGURATION/configuration.dart';
import 'db_helper.dart';
import 'item_model.dart'; // Import model Item

class SQLiteTest extends StatefulWidget {
  @override
  _SQLiteTestState createState() => _SQLiteTestState();
}

class _SQLiteTestState extends State<SQLiteTest> {
  final TextEditingController _nameController = TextEditingController();
  List<Item> _items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshItems();
  }

  Future<void> _refreshItems() async {
    final data = await DatabaseHelper().getItems();
    setState(() {
      _items = data;
      isLoading = false;
    });
  }

  Future<void> _addItem() async {
    final name = _nameController.text;
    if (name.isNotEmpty) {
      await DatabaseHelper().insertItem(Item(name: name));
      _nameController.clear();
      _refreshItems();
    }
  }

  Future<void> _deleteItem(int id) async {
    await DatabaseHelper().deleteItem(id);
    _refreshItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite Test'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Enter Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _addItem,
                  child: Text('Add Item'),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Warna.Primary),
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 255, 223, 223))),
                        child: ListTile(
                          title: Text(_items[index].name),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _deleteItem(_items[index].id!),
                          ),
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
