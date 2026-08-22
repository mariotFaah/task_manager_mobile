import 'dart:convert';
import 'dart:io';
import 'models.dart';

abstract interface class Repository<T> {
  Future<List<T>> readAll();
  Future<void> saveAll(List<T> items);
}

class JsonTaskRepository implements Repository<Task> {
  JsonTaskRepository(this.file);
  final File file;

  @override
  Future<List<Task>> readAll() async {
    if (!await file.exists()) return [];
    final content = await file.readAsString();
    if (content.trim().isEmpty) return [];
    final decoded = jsonDecode(content) as List<dynamic>;
    return decoded
        .map((item) => Task.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> saveAll(List<Task> items) async {
    await file.parent.create(recursive: true);
    await file.writeAsString(
      const JsonEncoder.withIndent('  ')
          .convert(items.map((task) => task.toJson()).toList()),
    );
  }
}
