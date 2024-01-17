

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mot/constants.dart';

class ColorOptionsSection extends StatefulWidget {
  @override
  _ColorOptionsSectionState createState() => _ColorOptionsSectionState();
}

class _ColorOptionsSectionState extends State<ColorOptionsSection> {
  Color? selectedColor;

  void selectColor(Color color) {
    setState(() {
      selectedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          ColorOptionWidget(
            color: Color(0xff4D4D4D),
            isSelected: selectedColor == Color(0xff4D4D4D),
            onSelect: () => selectColor(Color(0xff4D4D4D)),
          ),
          ColorOptionWidget(
            color: Color(0xff375F90),
            isSelected: selectedColor == Color(0xff375F90),
            onSelect: () => selectColor(Color(0xff375F90)),
          ),
          ColorOptionWidget(
            color: Color(0xff008954),
            isSelected: selectedColor == Color(0xff008954),
            onSelect: () => selectColor(Color(0xff008954)),
          ),
          ColorOptionWidget(
            color: Color(0xff000000),
            isSelected: selectedColor == Color(0xff000000),
            onSelect: () => selectColor(Color(0xff000000)),
          ),
          ColorOptionWidget(
            color: kPrimaryColor,
            isSelected: selectedColor == kPrimaryColor,
            onSelect: () => selectColor(kPrimaryColor),
          ),
          // Add more ColorOptionWidgets here
        ],
      ),
    );
  }
}

class ColorOptionWidget extends StatefulWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onSelect;

  const ColorOptionWidget({
    Key? key,
    required this.color,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<ColorOptionWidget> createState() => _ColorOptionWidgetState();
}

class _ColorOptionWidgetState extends State<ColorOptionWidget> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final selectedDecoration = BoxDecoration(
      color: widget.isSelected ? Colors.grey[700] : Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: widget.isSelected ? Colors.white : Colors.transparent,
        width: 2,
      ),
    );

    final hoverDecoration = BoxDecoration(
      color: isHovered ? Colors.grey[600] : Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: isHovered ? Colors.white : Colors.transparent,
        width: 2,
      ),
    );

    return GestureDetector(
      onTap: widget.onSelect,
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          width: 50,
          height: 50,
          padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.symmetric(horizontal: 3.0),
          decoration: widget.isSelected ? selectedDecoration : hoverDecoration,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: widget.color,
                radius: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
