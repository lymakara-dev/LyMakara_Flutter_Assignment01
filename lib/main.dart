import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.robotoTextTheme()),
      home: PortfolioScreen(),
    );
  }
}

class PortfolioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Row(
          children: [
            Image.network(
              'https://gic.itc.edu.kh/img/logo.png',
              height: 40,
              width: 40,
            ),
            SizedBox(width: 8),
            Text("GIC-25th", style: GoogleFonts.roboto(fontSize: 20)),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.white, size: 35),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/makara.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Welcome Text
              Text(
                "WELCOME TO MY PORTFOLIO",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 10),

              // Name and Title
              Text(
                "HI I'M",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                "MAKARA LY",
                style: GoogleFonts.roboto(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              Text(
                "4th YEAR IT STUDENT",
                style: GoogleFonts.roboto(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),

              // Description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  "Motivated Computer Science student with a passion for software development and strong foundation of programming. Proficient in C++, Java, HTML, CSS, and JavaScript with hand-on experience in web development front-end such as React.js and Next.js. Aspiring to apply my software development skill in a challenging environment to contribute to innovative projects and continuous learning.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(fontSize: 16, color: Colors.grey),
                ),
              ),
              SizedBox(height: 30),

              // Hire Me Button
              TextButton(
                onPressed: () async {
                  const telegramUrl =
                      'tg://resolve?domain=lymakaraa'; // Replace 'username' with the Telegram username
                  if (await canLaunchUrl(Uri.parse(telegramUrl))) {
                    await launchUrl(Uri.parse(telegramUrl));
                  } else {
                    const fallbackUrl = 'https://t.me/lymakaraa';
                    if (await canLaunchUrl(Uri.parse(fallbackUrl))) {
                      await launchUrl(Uri.parse(fallbackUrl));
                    } else {
                      throw 'Could not launch Telegram';
                    }
                  }
                },
                child: SizedBox(
                  width: double.infinity, // Makes the button full width
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      // horizontal: 25,
                    ),
                    alignment: Alignment.center, // Centers the text
                    child: const Text(
                      'Hire Me',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight:
                            FontWeight.bold, // Makes the text more prominent
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Download CV Button
              OutlinedButton(
                onPressed: openLocalCV,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.orange,
                    width: 2,
                  ), // Border color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                ),
                child: SizedBox(
                  width: double.infinity, // Full-width button
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical:
                          12, // Increased padding for better touch experience
                      horizontal: 25,
                    ),
                    alignment: Alignment.center, // Centers the content
                    child: Row(
                      mainAxisSize:
                          MainAxisSize.max, // Ensure it takes full width
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Center content
                      children: [
                        const Text(
                          "Download CV",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.download, color: Colors.orange),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<String> copyCVToLocal() async {
  // Get the app's document directory
  Directory directory = await getApplicationDocumentsDirectory();
  String filePath = '${directory.path}/LYMAKARA-CV.pdf';

  // Check if the file already exists
  File file = File(filePath);
  if (!await file.exists()) {
    // Load file from assets
    ByteData data = await rootBundle.load('assets/LYMAKARA-CV.pdf');
    List<int> bytes = data.buffer.asUint8List();

    // Write the file to local storage
    await file.writeAsBytes(bytes);
    print('CV copied to: $filePath');
  }
  return filePath;
}

Future<void> openLocalCV() async {
  String filePath = await copyCVToLocal();
  OpenFile.open(filePath);
}
