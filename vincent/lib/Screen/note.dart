import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final DatabaseReference _notesRef = FirebaseDatabase.instance.ref('notes');
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  Future<void> _saveNote() async {
    if (_titleController.text.isNotEmpty && _contentController.text.isNotEmpty) {
      String noteId = _notesRef.push().key!;
      await _notesRef.child(noteId).set({
        'title': _titleController.text,
        'content': _contentController.text,
        'createdAt': DateTime.now().toIso8601String(),
      });
      _titleController.clear();
      _contentController.clear();
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ghi chú đã được lưu')),
      );
    }
  }

  Future<void> _updateNote(String noteId) async {
    if (_titleController.text.isNotEmpty && _contentController.text.isNotEmpty) {
      await _notesRef.child(noteId).update({
        'title': _titleController.text,
        'content': _contentController.text,
        'updatedAt': DateTime.now().toIso8601String(),
      });
      _titleController.clear();
      _contentController.clear();
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ghi chú đã được cập nhật')),
      );
    }
  }

  Future<void> _deleteNoteWithConfirmation(String noteId) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Xác nhận xóa'),
          content: Text('Bạn có chắc chắn muốn xóa ghi chú này?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                _notesRef.child(noteId).remove().then((_) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Ghi chú đã được xóa')),
                  );
                });
              },
              child: Text('Xóa'),
            ),
          ],
        );
      },
    );
  }

  void _showAddNoteDialog() {
    _titleController.clear();
    _contentController.clear();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Thêm ghi chú mới'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Tiêu đề'),
              ),
              TextField(
                controller: _contentController,
                decoration: InputDecoration(labelText: 'Nội dung'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: _saveNote,
              child: Text('Lưu'),
            ),
          ],
        );
      },
    );
  }

  void _showEditNoteDialog(String noteId, String currentTitle, String currentContent) {
    _titleController.text = currentTitle;
    _contentController.text = currentContent;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Chỉnh sửa ghi chú'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Tiêu đề'),
              ),
              TextField(
                controller: _contentController,
                decoration: InputDecoration(labelText: 'Nội dung'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () => _updateNote(noteId),
              child: Text('Cập nhật'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản Lý Ghi Chú'),
        actions: [
          IconButton(
            icon: Icon(Icons.note_add, size: 30,),
            onPressed: () => _showAddNoteDialog(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<DatabaseEvent>(
                stream: _notesRef.onValue,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
                    return Center(child: Text('Chưa có ghi chú nào.'));
                  }

                  final notesData = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                  final notesList = notesData.entries.map((entry) {
                    String key = entry.key;
                    String title = entry.value['title'] ?? 'Không có tiêu đề';
                    String content = entry.value['content'] ?? 'Không có nội dung';
                    return Card(
                      child: ListTile(
                        title: Text(title),
                        subtitle: Text(content),
                        onTap: () => _showEditNoteDialog(key, title, content),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteNoteWithConfirmation(key),
                        ),
                      ),
                    );
                  }).toList();

                  return ListView(children: notesList);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
