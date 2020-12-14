//Flutter Modal Bottom Sheet
//Modified by Suvadeep Das
//Based on https://gist.github.com/andrelsmoraes/9e4af0133bff8960c1feeb0ead7fd749

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselWithIndicator extends StatefulWidget {
  List<Widget> items;
  CarouselWithIndicator({
    @required this.items,
  });
  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CarouselSlider(
        items: widget.items,
        autoPlay: false,
        viewportFraction: 1.0,
        aspectRatio: 2.0,
        onPageChanged: (index) {
          setState(() {
            _current = index;
          });
        },
      ),
      Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.items.map<Widget>((imgList) {
              var index = widget.items.indexOf(imgList);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? Colors.white
                        : Color.fromRGBO(0, 0, 0, 0.4),
                    border: Border.all(
                      color: _current == index ? Colors.white : Colors.white70,
                    )),
              );
            }).toList(),
          ))
    ]);
  }
}
