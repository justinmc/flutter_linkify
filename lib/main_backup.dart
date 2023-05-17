import 'package:flutter/material.dart';

//import 'package:url_launcher/link.dart';
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  static const String text = 'Check out https://www.flutter.dev, or maybe just flutter.dev or www.flutter.dev. Or if not, just google it: ://www.google.com! Another: www.abc-123.com. Oops I forgot a space.What happens? What about GitHub PRs in Flutter like #125927? Or a Twitter handle like @sundarpichai?';

  void _onTapUrl (String urlString) async {
    Uri uri = Uri.parse(urlString);
    if (uri.host.isEmpty) {
      uri = Uri.parse('https://$urlString');
    }
    if (!await launchUrl(uri)) {
      throw 'Could not launch $urlString.';
    }
  }

  void _onTapTwitterHandle (String linkText) async {
    final String handleWithoutAt = linkText.substring(1);
    Uri uri = Uri.parse('https://www.twitter.com/$handleWithoutAt');
    if (!await launchUrl(uri)) {
      throw 'Could not launch $uri.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Builder(
          builder: (BuildContext context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LinkedText(
                  text: text,
                  // TODO(justinmc): Builder for detected things.
                  // TODO(justinmc): Detector.
                  onTap: _onTapUrl,
                  // TODO(justinmc): Do I need to tell Semantics that this is a link, or does
                  // Link already do that?
                  /*
                  return Link(
                    uri: Uri.parse(uri),
                    builder: (BuildContext context, FollowLink? followLink) {
                      return GestureDetector(
                        onTap: followLink,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Text(
                            uri,
                            style: const TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                  */
                ),
                RichText(
                  text: InlineLinkedText.textLinkers(
                    style: DefaultTextStyle.of(context).style,
                    text: text,
                    textLinkers: <TextLinker>[
                      TextLinker(
                        rangesFinder: TextLinker.urlRangesFinder,
                        linkBuilder: InlineLinkedText.getDefaultLinkBuilder(_onTapUrl),
                      ),
                      TextLinker(
                        rangesFinder: TextLinker.rangesFinderFromRegExp(RegExp(r'@[a-zA-Z0-9]{4,15}')),
                        linkBuilder: (String linkText) {
                          return InlineLink(
                            text: linkText,
                            style: const TextStyle(
                              color: Color(0xff00ffff),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

