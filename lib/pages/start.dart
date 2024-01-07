import 'package:flutter/material.dart';
import 'package:test/pages/exhibitor/home_exhibitor.dart';
import 'package:test/pages/organizer/home_organizer.dart';
import 'package:test/pages/visitor/home_visitor.dart';

class StartPage extends StatelessWidget {
  // const StartPage({super.key});
  const StartPage(this.username, {super.key});

  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () => moveToPage(context, const VisitorHomePage()),
              child: const Text("Use as Visitor"),
            ),
            OutlinedButton(
              onPressed: () => moveToPage(context, const ExhibitorHomePage()),
              child: const Text("Use as Exhibitor"),
            ),
            OutlinedButton(
              onPressed: () => moveToPage(context, const OrganizerHomePage()),
              child: const Text("Use as Organizer"),
            ),
          ],
        ),
      ),
    );
  }
}

void moveToPage(BuildContext context, Widget targetPage) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => targetPage));
}
