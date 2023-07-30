import 'package:atelier03_local_data_storage/data/shared_prefs.dart';
import 'package:atelier03_local_data_storage/models/font_size.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  List<int> colors = [
    0xFF455A64,
    0xFFFFC107,
    0XFF673AB7,
    0xFFF57C00,
    0xFF795548
  ];
  SPSettings settings = SPSettings();
  final List<FontSize> fontSizes = [
    FontSize('small', 12),
    FontSize('medium', 16),
    FontSize('large', 20),
    FontSize('extra-large', 24)
  ];

  @override
  void initState() {
    settings.init().then((value) {
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Color(settingColor),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Choose a font size for the App',
            style: TextStyle(
              fontSize: fontSize,
            ),
          ),
          DropdownButton(
              items: getDropdownMenuItems(),
              value: fontSize.toString(),
              onChanged: changeSize),
          const Text('App Main Color'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => setColor(colors[0]),
                child: ColorSquare(colors[0]),
              ),
              GestureDetector(
                onTap: () => setColor(colors[1]),
                child: ColorSquare(colors[1]),
              ),
              GestureDetector(
                onTap: () => setColor(colors[2]),
                child: ColorSquare(colors[2]),
              ),
              GestureDetector(
                onTap: () => setColor(colors[3]),
                child: ColorSquare(colors[3]),
              ),
              GestureDetector(
                onTap: () => setColor(colors[4]),
                child: ColorSquare(colors[4]),
              )
            ],
          )
        ],
      ),
    );
  }

  void setColor(int color) {
    setState(() {
      settingColor = color;
      settings.setColor(color);
    });
  }

  List<DropdownMenuItem<String>> getDropdownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    for (FontSize fontSize in fontSizes) {
      items.add(DropdownMenuItem(
        value: fontSize.size.toString(),
        child: Text(fontSize.name),
      ));
    }
    return items;
  }

  void changeSize(String? newSize) {
    setState(() {
      fontSize = double.parse(newSize ?? '16');
      settings.setFontSize(double.parse(newSize ?? '16'));
    });
  }
}

class ColorSquare extends StatelessWidget {
  final int colorCode;
  ColorSquare(this.colorCode);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          color: Color(colorCode)),
    );
  }
}
