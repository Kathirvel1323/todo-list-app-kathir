import 'package:flutter/material.dart';

void main() => runApp(const TodoApp());

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'To-Do List',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7C3AED)), useMaterial3: true),
        home: const TodoScreen(),
      );
}

class TodoItem {
  TodoItem(this.id, this.title);
  final int id;
  final String title;
  bool done = false;
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _controller = TextEditingController();
  final List<TodoItem> _items = [];
  int _nextId = 0;
  int get _remaining => _items.where((item) => !item.done).length;

  void _addTask() {
    final title = _controller.text.trim();
    if (title.isEmpty) return;
    setState(() {
      _items.add(TodoItem(_nextId++, title));
      _controller.clear();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('To-Do List'), centerTitle: true),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                Row(children: [
                  Expanded(child: TextField(controller: _controller, textInputAction: TextInputAction.done, onSubmitted: (_) => _addTask(), decoration: const InputDecoration(labelText: 'New task', hintText: 'e.g. Review Flutter widgets', border: OutlineInputBorder()))),
                  const SizedBox(width: 10),
                  FilledButton.icon(onPressed: _addTask, icon: const Icon(Icons.add), label: const Text('Add')),
                ]),
                const SizedBox(height: 16),
                Align(alignment: Alignment.centerLeft, child: Chip(label: Text('$_remaining remaining'))),
                Expanded(
                  child: _items.isEmpty
                      ? const Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.task_alt, size: 56, color: Colors.blueGrey), SizedBox(height: 12), Text('Nothing here yet. Add your first task!')]))
                      : ListView.builder(
                          itemCount: _items.length,
                          itemBuilder: (context, index) {
                            final item = _items[index];
                            return Dismissible(
                              key: ValueKey(item.id),
                              direction: DismissDirection.endToStart,
                              background: Container(alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 20), color: Colors.red, child: const Icon(Icons.delete, color: Colors.white)),
                              onDismissed: (_) => setState(() => _items.removeWhere((task) => task.id == item.id)),
                              child: Card(
                                child: CheckboxListTile(
                                  value: item.done,
                                  onChanged: (value) => setState(() => item.done = value ?? false),
                                  title: Text(item.title, style: TextStyle(decoration: item.done ? TextDecoration.lineThrough : null, color: item.done ? Colors.grey : null)),
                                  secondary: IconButton(icon: const Icon(Icons.delete_outline), tooltip: 'Delete ${item.title}', onPressed: () => setState(() => _items.removeWhere((task) => task.id == item.id))),
                                  controlAffinity: ListTileControlAffinity.leading,
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ]),
            ),
          ),
        ),
      );
}
