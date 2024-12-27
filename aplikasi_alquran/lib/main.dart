import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_alquran/pages/welcome.dart';
import 'package:aplikasi_alquran/provider/auth_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoginProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Al-Quran App',
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false, // Menghilangkan label debug
      theme: ThemeData.light(), // Tema terang
      darkTheme: ThemeData.dark(), // Tema gelap
      home: const WelcomePage(), // Halaman pertama adalah WelcomePage
    );
  }
}
