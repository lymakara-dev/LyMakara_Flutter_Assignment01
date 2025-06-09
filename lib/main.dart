import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  String _language = 'en';

  final Map<String, Map<String, String>> localizedStrings = {
    'en': {
      'greeting': 'Hello!',
      'login': 'Log in',
      'username': 'Username',
      'password': 'Password',
      'loginButton': 'Log in',
      'darkMode': 'Dark Mode',
      'emptyFields': 'Please enter both username and password',
      'loginSuccess': 'Login successful',
    },
    'fr': {
      'greeting': 'Salut!',
      'login': 'Se connecter',
      'username': 'Nom d\'utilisateur',
      'password': 'Mot de passe',
      'loginButton': 'Se connecter',
      'darkMode': 'Mode sombre',
      'emptyFields': 'Veuillez saisir le nom d\'utilisateur et le mot de passe',
      'loginSuccess': 'Connexion réussie',
    },
    'kh': {
      'greeting': 'សួស្តី!',
      'login': 'ចូល',
      'username': 'ឈ្មោះអ្នកប្រើ',
      'password': 'ពាក្យសម្ងាត់',
      'loginButton': 'ចូល',
      'darkMode': 'របៀបងងឹត',
      'emptyFields': 'សូមបញ្ចូលឈ្មោះអ្នកប្រើនិងពាក្យសម្ងាត់',
      'loginSuccess': 'ការចូលជោគជ័យ',
    },
  };

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _themeMode =
          prefs.getBool('darkMode') ?? false ? ThemeMode.dark : ThemeMode.light;
      _language = prefs.getString('language') ?? 'en';
    });
  }

  Future<void> _updateTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', isDark);
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  Future<void> _updateLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', lang);
    setState(() {
      _language = lang;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Assignment',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: LoginScreen(
        isDarkMode: _themeMode == ThemeMode.dark,
        currentLanguage: _language,
        translations: localizedStrings[_language]!,
        onThemeChanged: _updateTheme,
        onLanguageChanged: _updateLanguage,
      ),
    );
  }
}
