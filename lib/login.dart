import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  final bool isDarkMode;
  final String currentLanguage;
  final String greeting;
  final Function(bool) onThemeChanged;
  final Function(String) onLanguageChanged;

  const LoginScreen({
    super.key,
    required this.isDarkMode,
    required this.currentLanguage,
    required this.greeting,
    required this.onThemeChanged,
    required this.onLanguageChanged,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _languageButton(
    String label,
    String langCode,
    String flagAsset,
    bool isSelected,
  ) {
    return ElevatedButton.icon(
      onPressed: () => widget.onLanguageChanged(langCode),
      icon: SvgPicture.asset(
        flagAsset,
        height: 20,
        errorBuilder: (context, error, stackTrace) {
          print('Error loading flag: $error');
          return Icon(
            Icons.flag,
            size: 20,
            color: isSelected ? Colors.white : Colors.orange,
          );
        },
      ),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.orange : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        side: const BorderSide(color: Colors.orange),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: isSelected ? 4 : 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Log in',
                style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(color: Colors.orange, thickness: 2),
            const SizedBox(height: 20),
            Center(child: SvgPicture.asset('assets/logo.svg', height: 60)),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            SvgPicture.asset('assets/flags/en.svg', height: 30),
            Center(
              child: Text(
                widget.greeting,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  _isLoading
                      ? null
                      : () async {
                        setState(() => _isLoading = true);
                        try {
                          final username = _usernameController.text.trim();
                          final password = _passwordController.text.trim();

                          if (username.isEmpty || password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please enter both username and password',
                                ),
                              ),
                            );
                          } else {
                            // Add delay to simulate network request
                            await Future.delayed(const Duration(seconds: 1));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Login successful')),
                            );
                          }
                        } finally {
                          setState(() => _isLoading = false);
                        }
                      },
              child:
                  _isLoading
                      ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                      : const Text('Log in'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _languageButton(
                  'EN',
                  'en',
                  'assets/flags/en.svg',
                  widget.currentLanguage == 'en',
                ),
                _languageButton(
                  'FR',
                  'fr',
                  'assets/flags/fr.svg',
                  widget.currentLanguage == 'fr',
                ),
                _languageButton(
                  'KH',
                  'kh',
                  'assets/flags/kh.svg',
                  widget.currentLanguage == 'kh',
                ),
              ],
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              value: widget.isDarkMode,
              onChanged: widget.onThemeChanged,
              title: const Text('Dark Mode'),
            ),
          ],
        ),
      ),
    );
  }
}
