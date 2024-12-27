import 'package:flutter/material.dart';

class SurahEditPage extends StatefulWidget {
  final bool isEdit; // Menentukan apakah ini untuk edit atau tambah
  final String? surahName; // Nama surah yang akan diedit, null jika tambah

  const SurahEditPage({
    super.key,
    required this.isEdit,
    this.surahName,
  });

  @override
  State<SurahEditPage> createState() => _SurahEditPageState();
}

class _SurahEditPageState extends State<SurahEditPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Jika mode edit, isi field dengan nama surah
    if (widget.isEdit && widget.surahName != null) {
      _controller.text = widget.surahName!;
    }
  }

  void _saveSurah() {
    final surahName = _controller.text.trim();
    if (surahName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama surah tidak boleh kosong!')),
      );
      return;
    }

    // Kirim kembali data surah ke halaman sebelumnya
    Navigator.pop(context, surahName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Edit Surah' : 'Tambah Surah'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Nama Surah',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveSurah,
              child: Text(widget.isEdit ? 'Simpan Perubahan' : 'Tambah Surah'),
            ),
          ],
        ),
      ),
    );
  }
}
