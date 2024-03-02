import 'dart:ui';

class BoardingContent {
  String? image;
  String? title;
  String? description;
  Color? color;

  BoardingContent({this.image, this.title, this.description, this.color});
}

List<BoardingContent> contents = [
  BoardingContent(
      title: 'Quality',
      image: 'assets/images/img_1.png',
      color: Color.fromRGBO(94, 162, 95, 1),
      description: "Sell your farm fresh products directly to "
          "consumers, cutting out the middleman and "
          "reducing emissions of the global supply chain."),
  BoardingContent(
      title: 'Convenient',
      image: 'assets/images/img_2.png',
      color: Color.fromRGBO(213, 113, 91, 1),
      description: "Our team of delivery drivers will make sure"
          "your orders are picked up on time and"
          "promptly delivered to your customers."),
  BoardingContent(
      title: 'Local',
      image: 'assets/images/img_3.png',
      color: Color.fromRGBO(248, 197, 105, 1),
      description: "We love the earth and know you do too! Join us"
          "in reducing our local carbon footprint one order"
          "at a time. "),
];
