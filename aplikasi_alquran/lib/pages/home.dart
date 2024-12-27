import 'package:aplikasi_alquran/pages/surahdetailpage.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_alquran/pages/login.dart';
import 'package:aplikasi_alquran/provider/auth_provider.dart';
import 'package:aplikasi_alquran/pages/surah_edit.dart'; // Halaman edit surah
import 'package:provider/provider.dart';

class BerandaPage extends StatefulWidget {
  final String role; // Peran pengguna (misalnya "admin" atau "user")
  final String name;

  const BerandaPage({
    super.key,
    required this.role,
    required this.name,
  });

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  final List<Map<String, String>> surahList = [
    {"name": "Al-Fatiha", "arabic": "ٱلْفَاتِحَةُ", "meaning": "Pembukaan"},
    {"name": "Al-Baqarah", "arabic": "ٱلْبَقَرَةُ", "meaning": "Sapi Betina"},
    {
      "name": "Ali Imran",
      "arabic": "آلِ عِمْرَانَ",
      "meaning": "Keluarga Imran"
    },
  ];

  String searchQuery = '';

  Future<void> _logout() async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final success = await loginProvider.logout();

    if (success) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loginProvider.errorMessage)),
      );
    }
  }

  void _addSurah() async {
    if (widget.role != 'admin') return; // Hanya admin yang boleh menambah
    final newSurah = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => const SurahEditPage(isEdit: false),
      ),
    );

    if (newSurah != null) {
      setState(() {
        surahList.add({"name": newSurah, "arabic": "", "meaning": ""});
      });
    }
  }

  void _editSurah(String surahName) async {
    if (widget.role != 'admin') return; // Hanya admin yang boleh mengedit
    final updatedSurah = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => SurahEditPage(isEdit: true, surahName: surahName),
      ),
    );

    if (updatedSurah != null) {
      setState(() {
        final index =
            surahList.indexWhere((surah) => surah['name'] == surahName);
        if (index != -1) {
          surahList[index]['name'] = updatedSurah;
        }
      });
    }
  }

  void _deleteSurah(String surahName) {
    if (widget.role != 'admin') return; // Hanya admin yang boleh menghapus
    setState(() {
      surahList.removeWhere((surah) => surah['name'] == surahName);
    });
  }

  void _openSurahDetail(Map<String, dynamic> surah) {
    // Tentukan ayat berdasarkan nama surah
    List<Map<String, String>> ayat = [];
    if (surah['name'] == 'Al-Fatiha') {
      ayat = [
        {
          "arabic": "ٱلْحَمْدُ لِلَّهِ رَبِّ ٱلْعَـٰلَمِينَ",
          "translation": "Segala puji bagi Allah, Tuhan semesta alam."
        },
        {
          "arabic": "ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ",
          "translation": "Yang Maha Pengasih, Maha Penyayang."
        },
        {
          "arabic": "مَـٰلِكِ يَوْمِ ٱلدِّينِ",
          "translation": "Pemilik Hari Pembalasan."
        },
        {
          "arabic": "إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ",
          "translation":
              "Hanya kepada-Mu kami menyembah, dan hanya kepada-Mu kami memohon pertolongan."
        },
        {
          "arabic": "ٱهْدِنَا ٱلصِّرَٰطَ ٱلْمُسْتَقِيمَ",
          "translation": "Tunjukilah kami jalan yang lurus."
        },
        {
          "arabic": "صِرَٰطَ ٱلَّذِينَ أَنْعَمْتَ عَلَيْهِمْ",
          "translation":
              "Yaitu jalan orang-orang yang telah Engkau beri nikmat,"
        },
        {
          "arabic": "غَيْرِ ٱلْمَغْضُوبِ عَلَيْهِمْ وَلَا ٱلضَّآلِّينَ",
          "translation":
              "bukan jalan mereka yang dimurkai, dan bukan pula jalan mereka yang sesat."
        },
      ];
    } else if (surah['name'] == 'Al-Baqarah') {
      ayat = [
        {"arabic": "الم", "translation": "Alif Lam Mim."},
        {
          "arabic":
              "ذَٰلِكَ ٱلْكِتَٰبُ لَا رَيْبَ ۛ فِيهِ ۛ هُدًۭى لِّلْمُتَّقِينَ",
          "translation":
              "Kitab ini tidak ada keraguan padanya, petunjuk bagi mereka yang bertakwa."
        },
        {
          "arabic":
              "ٱلَّذِينَ يُؤْمِنُونَ بِٱلْغَيْبِ وَيُقِيمُونَ ٱلصَّلَوٰةَ وَمِمَّا رَزَقْنَٰهُمْ يُنفِقُونَ",
          "translation":
              "Yaitu mereka yang beriman kepada yang gaib, mendirikan salat, dan menginfakkan sebagian rezeki yang Kami berikan kepada mereka."
        },
        {
          "arabic":
              "وَٱلَّذِينَ يُؤْمِنُونَ بِمَآ أُنزِلَ إِلَيْكَ وَمَآ أُنزِلَ مِن قَبْلِكَ وَبِٱلْأٓخِرَةِ هُمْ يُوقِنُونَ",
          "translation":
              "Dan mereka yang beriman kepada apa yang telah diturunkan kepadamu dan kepada apa yang telah diturunkan sebelumnya, serta yakin akan adanya akhirat."
        },
        {
          "arabic":
              "أُو۟لَٰٓئِكَ عَلَىٰ هُدًۭى مِّن رَّبِّهِمْ ۖ وَأُو۟لَٰٓئِكَ هُمُ ٱلْمُفْلِحُونَ",
          "translation":
              "Mereka itulah yang berada di atas petunjuk dari Tuhan mereka, dan mereka itulah orang-orang yang beruntung."
        },
        {
          "arabic":
              "إِنَّ ٱلَّذِينَ كَفَرُوا۟ سَوَآءٌ عَلَيْهِمْ ءَأَنذَرْتَهُمْ أَمْ لَمْ تُنذِرْهُمْ لَا يُؤْمِنُونَ",
          "translation":
              "Sesungguhnya orang-orang yang kafir, sama saja bagi mereka, apakah kamu beri peringatan atau tidak kamu beri peringatan, mereka tidak akan beriman."
        },
        {
          "arabic":
              "خَتَمَ ٱللَّهُ عَلَىٰ قُلُوبِهِمْ وَعَلَىٰ سَمْعِهِمْ ۖ وَعَلَىٰٓ أَبْصَٰرِهِمْ غِشَٰوَةٌۭ ۖ وَلَهُمْ عَذَابٌ عَظِيمٌۭ",
          "translation":
              "Allah telah mengunci hati dan pendengaran mereka, dan penglihatan mereka ditutup. Bagi mereka siksa yang amat berat."
        },
        {
          "arabic":
              "وَمِنَ ٱلنَّاسِ مَن يَقُولُ ءَامَنَّا بِٱللَّهِ وَبِٱلْيَوْمِ ٱلْـَٔاخِرِ وَمَا هُم بِمُؤْمِنِينَ",
          "translation":
              "Di antara manusia ada yang berkata, 'Kami beriman kepada Allah dan Hari Akhir,' padahal mereka itu bukan orang-orang yang beriman."
        },
        {
          "arabic":
              "يُخَٰدِعُونَ ٱللَّهَ وَٱلَّذِينَ ءَامَنُوا۟ ۚ وَمَا يَخْدَعُونَ إِلَّآ أَنفُسَهُمْ وَمَا يَشْعُرُونَ",
          "translation":
              "Mereka hendak menipu Allah dan orang-orang yang beriman, padahal mereka hanya menipu diri sendiri tanpa mereka sadari."
        },
        {
          "arabic":
              "فِى قُلُوبِهِم مَّرَضٌۭ فَزَادَهُمُ ٱللَّهُ مَرَضًۭا ۖ وَلَهُمْ عَذَابٌ أَلِيمٌۢ بِمَا كَانُوا۟ يَكْذِبُونَ",
          "translation":
              "Dalam hati mereka ada penyakit, lalu Allah menambah penyakitnya itu; dan bagi mereka azab yang pedih karena mereka berdusta."
        },
      ];
    } else if (surah['name'] == 'Ali Imran') {
      ayat = [
        {"arabic": "الم", "translation": "Alif Lam Mim."},
        {
          "arabic": "ٱللَّهُ لَآ إِلَٰهَ إِلَّا هُوَ ٱلْحَىُّ ٱلْقَيُّومُ",
          "translation":
              "Allah, tidak ada Tuhan selain Dia, Yang Maha Hidup, Yang terus-menerus mengurus (makhluk-Nya)."
        },
        {
          "arabic":
              "نَزَّلَ عَلَيْكَ ٱلْكِتَٰبَ بِٱلْحَقِّ مُصَدِّقًۭا لِّمَا بَيْنَ يَدَيْهِ وَأَنزَلَ ٱلتَّوْرَىٰةَ وَٱلْإِنجِيلَ",
          "translation":
              "Dia menurunkan Al-Qur'an kepadamu dengan sebenar-benarnya, membenarkan kitab-kitab sebelumnya, dan Dia menurunkan Taurat dan Injil."
        },
        {
          "arabic":
              "مِن قَبْلُ هُدًۭى لِّلنَّاسِ وَأَنزَلَ ٱلْفُرْقَانَ ۗ إِنَّ ٱلَّذِينَ كَفَرُوا۟ بِـَٔايَٰتِ ٱللَّهِ لَهُمْ عَذَابٌۭ شَدِيدٌۭ ۗ وَٱللَّهُ عَزِيزٌۭ ذُو ٱنتِقَامٍۢ",
          "translation":
              "Sebelum (Al-Qur'an) itu, menjadi petunjuk bagi manusia, dan Dia menurunkan Al-Furqan. Sesungguhnya orang-orang yang kafir terhadap ayat-ayat Allah akan mendapat azab yang berat; dan Allah Maha Perkasa lagi mempunyai balasan."
        },
        {
          "arabic":
              "إِنَّ ٱللَّهَ لَا يَخْفَىٰ عَلَيْهِ شَىْءٌۭ فِى ٱلْأَرْضِ وَلَا فِى ٱلسَّمَآءِ",
          "translation":
              "Sesungguhnya bagi Allah tidak ada sesuatu pun yang tersembunyi di bumi maupun di langit."
        },
      ];
    }

    // Pindah ke halaman detail
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SurahDetailPage(
          name: surah['name']!,
          arabic: surah['arabic']!,
          meaning: surah['meaning']!,
          ayat: ayat,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Informasi Pengguna
            Text(
              'Nama: ${widget.name}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Role: ${widget.role}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            // Pencarian Surah
            TextField(
              decoration: InputDecoration(
                labelText: 'Cari Surah...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
              },
            ),
            const SizedBox(height: 16),

            // Daftar Surah
            Expanded(
              child: ListView.builder(
                itemCount: surahList
                    .where((surah) => surah['name']!
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase()))
                    .length,
                itemBuilder: (context, index) {
                  final filteredSurah = surahList
                      .where((surah) => surah['name']!
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()))
                      .toList();
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        filteredSurah[index]['name']!,
                        style: const TextStyle(fontSize: 18),
                      ),
                      onTap: () => _openSurahDetail(filteredSurah[index]),
                      trailing: widget.role ==
                              'admin' // Tombol hanya untuk admin
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () =>
                                      _editSurah(filteredSurah[index]['name']!),
                                  tooltip: 'Edit Surah',
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () => _deleteSurah(
                                      filteredSurah[index]['name']!),
                                  tooltip: 'Hapus Surah',
                                ),
                              ],
                            )
                          : null,
                    ),
                  );
                },
              ),
            ),

            // Tombol tambah hanya untuk admin
            if (widget.role == 'admin')
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _addSurah,
                  icon: const Icon(Icons.add),
                  label: const Text('Tambah Surah'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
