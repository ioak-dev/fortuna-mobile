import 'package:flutter/material.dart';

class CategoryIcon extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final bool selected;

  const CategoryIcon({
    required this.icon,
    required this.label,
    this.selected = false,
    this.color,
    super.key,
  });

  @override
  State<CategoryIcon> createState() => _CategoryIconState();
}

class _CategoryIconState extends State<CategoryIcon> {
  late bool selected = widget.selected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() {
        selected = !selected;
      }),
      child: Container(
        color: selected ? Colors.grey.shade200 : null,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color: widget.color,
              ),
              Text(widget.label,
                  style:
                      TextStyle()), // Todo: Use a condensed font/ make font condensed
            ]),
      ),
    );
  }
}
