import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ChecklistScreen extends StatefulWidget {
  @override
  _ChecklistScreenState createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  final TextEditingController _checklistController = TextEditingController();
  final List<Map<String, dynamic>> _checklistItems = [];

  @override
  void initState() {
    super.initState();
    _loadChecklistItems();
  }

  // Carrega os itens da checklist salvos em shared_preferences
  Future<void> _loadChecklistItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedItems = prefs.getString('checklistItems');
    if (savedItems != null) {
      setState(() {
        _checklistItems.addAll(
          List<Map<String, dynamic>>.from(json.decode(savedItems)),
        );
      });
    }
  }

  // Salva os itens da checklist em shared_preferences
  Future<void> _saveChecklistItems() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('checklistItems', json.encode(_checklistItems));
  }

  void _addChecklistItem() {
    if (_checklistController.text.isNotEmpty) {
      setState(() {
        _checklistItems.add({
          'text': _checklistController.text,
          'completed': false,
        });
        _checklistController.clear();
      });
      _saveChecklistItems();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('O item não pode ser vazio!')),
      );
    }
  }

  void _toggleCompletion(int index) {
    setState(() {
      _checklistItems[index]['completed'] = !_checklistItems[index]['completed'];
    });
    _saveChecklistItems();
  }

  void _removeItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Excluir Item"),
          content: Text("Tem certeza que deseja excluir este item da checklist?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Excluir"),
              onPressed: () {
                setState(() {
                  _checklistItems.removeAt(index);
                });
                _saveChecklistItems();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _checklistController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB3E5FC), // Azul bebê
        title: Text(
          'Checklist',
          style: TextStyle(fontFamily: 'Nunito', fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _checklistController,
                    decoration: InputDecoration(
                      labelText: 'Adicionar item à checklist',
                      prefixIcon: Icon(Icons.check),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addChecklistItem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFB3E5FC),
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(16),
                  ),
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _checklistItems.length,
              itemBuilder: (context, index) {
                final item = _checklistItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: ListTile(
                      leading: Checkbox(
                        value: item['completed'],
                        onChanged: (value) {
                          _toggleCompletion(index);
                        },
                      ),
                      title: Text(
                        item['text'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          decoration: item['completed']
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: item['completed']
                              ? Colors.grey
                              : Colors.black87,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () => _removeItem(index),
                      ),
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

