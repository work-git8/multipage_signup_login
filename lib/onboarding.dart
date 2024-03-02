import 'package:flutter/material.dart';

import 'content_model.dart';
import 'custom_scaffold.dart';

int currentIndex = 0;

int index = 0;

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        itemCount: contents.length,
        onPageChanged: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (_, i) {
          return CustomScaffold(
            color: contents[i].color!,
            title: contents[i].title!,
            description: contents[i].description!,
            image: contents[i].image!,
            length: contents.length,
            index: i,
            currentIndex: i,
          );
        });
  }
}
