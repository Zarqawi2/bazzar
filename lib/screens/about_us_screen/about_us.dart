import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Aboutus extends StatelessWidget {
  const Aboutus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "دەربارە",
          style: TextStyle(color: Colors.black, fontFamily: 'speda'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Container(
            padding: EdgeInsets.zero,
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 253, 136, 46),
                borderRadius: BorderRadius.circular(100)),
            child: Image.asset('assets/images/b.jpg'),
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.top + 10,
          ),
          Text(
            'هێندە شت ڕوو دەدات لە ژیانی ڕۆژانەماندا کە بە دەگمەن کاتمان بەردەست دەبێت بۆ ئەنجام دانی ئەو شتانەی کە مەبەستمانە. لە بازاڕ ئێمە لەوە تێدەگەین و دەمانەوێت لە دڵەڕاوکێ دوورت بخەینەوە بۆ ئەوەی کاتی زیاترت هەبێت بۆ خۆشی بینین لەو ساتانەی کە گرگن لە لات. \nلەگەڵ بازاڕ: فرۆشتنی زیاتر، کڕیاری زیاتر، سەرچاوەی زیاتر بەڕەنجێکی کەمتر. ئامادەیت کارەکەت بگەیەنیتە ئاستیکی بەرزتر؟ هەر ئێستا ببە بە هاوبەشی بازاڕ',
            textDirection: TextDirection.rtl,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {},
                child: IconButton(
                  onPressed: () {
                    launchUrl(
                        Uri.parse('https://www.facebook.com/halabjai007'));
                  },
                  icon: Icon(
                    FontAwesomeIcons.facebook,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: IconButton(
                  onPressed: () {
                    launchUrl(Uri.parse(
                        'https://instagram.com/_ba4rha4m?igshid=MmIzYWVlNDQ5Yg=='));
                  },
                  icon: Icon(
                    FontAwesomeIcons.instagram,
                    color: Colors.purpleAccent,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: IconButton(
                  onPressed: () {
                    launchUrl(Uri.parse('https://github.com/Zarqawi2'));
                  },
                  icon: Icon(
                    FontAwesomeIcons.github,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              'All Resived by Barham - 2023',
              style: TextStyle(color: Colors.black26, fontFamily: 'roboto'),
            ),
          )
        ]),
      ),
    );
  }
}
