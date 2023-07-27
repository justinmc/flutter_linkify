import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Link Demo'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  static const String url = 'https://www.example.com';
  static const String text = 'www.example123.co.uk\nasdf://subdomain.example.net\nsubdomain.example.net\nftp.subdomain.example.net\nhttp://subdomain.example.net\nhttps://subdomain.example.net\nhttp://example.com/\nhttps://www.example.org/\nftp://subdomain.example.net\nexample.com\nsubdomain.example.io\nwww.example123.co.uk\nhttp://example.com:8080/\nhttps://www.example.com/path/to/resource\nhttp://www.example.com/index.php?query=test#fragment\nhttps://subdomain.example.io:8443/resource/file.html?search=query#result\n"example.com"\n\'example.com\'\n(example.com)\nsubsub.www.example.com\nhttps://subsub.www.example.com';

  void _onTapUrl (String urlString) async {
    Uri uri = Uri.parse(urlString);
    if (uri.host.isEmpty) {
      uri = Uri.parse('https://$urlString');
    }
    if (!await launchUrl(uri)) {
      throw 'Could not launch $urlString.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Builder(
        builder: (BuildContext context) {
          final List<InlineSpan> spans = <InlineSpan>[
            TextSpan(
              text: '$url?q=0\n',
              style: DefaultTextStyle.of(context).style,
              children: <InlineSpan>[
                TextSpan(
                  text: 'https://www.ex ftp://subdomain.example.com https://www.ex',
                  children: <InlineSpan>[
                    TextSpan(
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        decoration: TextDecoration.combine(<TextDecoration>[
                          TextDecoration.lineThrough,
                          TextDecoration.underline,
                        ]),
                      ),
                      text: 'ample.com?q=1 ex',
                    ),
                    const TextSpan(
                      text: 'ample.com?q=2',
                    ),
                  ],
                ),
              ],
            ),
            TextSpan(
              text: '\nhttps://',
              style: DefaultTextStyle.of(context).style,
              children: <InlineSpan>[
                TextSpan(
                  text: 'www.',
                  children: <InlineSpan>[
                    TextSpan(
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        decoration: TextDecoration.combine(<TextDecoration>[
                          TextDecoration.lineThrough,
                          TextDecoration.underline,
                        ]),
                      ),
                      text: 'ex',
                    ),
                    const TextSpan(
                      text: 'ample',
                    ),
                    const TextSpan(
                      text: '.com?q=3\nex',
                    ),
                  ],
                ),
              ],
            ),
            TextSpan(
              style: DefaultTextStyle.of(context).style,
              text: 'ample.com?q=4',
            ),
            TextSpan(
              style: DefaultTextStyle.of(context).style,
              text: '\nex',
            ),
            TextSpan(
              style: DefaultTextStyle.of(context).style,
              text: 'ample.com?q=5',
            ),
          ];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: ListView(
              children: <Widget>[
                LinkedText(
                  onTap: _onTapUrl,
                  spans: spans,
                ),
                const SizedBox(
                  height: 64.0,
                ),
                RichText(
                  text: TextSpan(
                    children: spans,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                LinkedText(
                  onTap: _onTapUrl,
                  text: text,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
