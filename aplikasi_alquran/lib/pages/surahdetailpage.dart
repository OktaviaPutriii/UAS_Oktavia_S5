import 'package:flutter/material.dart';

class SurahDetailPage extends StatelessWidget {
  final String name;
  final String arabic;
  final String meaning;
  final List<Map<String, String>> ayat; // Tambahan: daftar ayat

  const SurahDetailPage({
    super.key,
    required this.name,
    required this.arabic,
    required this.meaning,
    required this.ayat, // Parameter daftar ayat
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Nama surah dan artinya
            Text(
              arabic,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 16),
            Text(
              meaning,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            const Divider(thickness: 1),
            const SizedBox(height: 16),

            // Daftar Ayat
            const Text(
              "Ayat-ayat:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: ayat.length,
              itemBuilder: (context, index) {
                final ayah = ayat[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${index + 1}. ${ayah['arabic']}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        ayah['translation']!,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
