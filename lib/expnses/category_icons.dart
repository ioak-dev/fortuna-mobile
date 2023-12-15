import 'package:flutter/material.dart';

class CategoryIcon extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final Function? onTap;
  final Color? backgroundColor;

  const CategoryIcon({
    required this.icon,
    required this.label,
    this.color,
    this.backgroundColor,
    this.onTap,
    super.key,
  });

  @override
  State<CategoryIcon> createState() => _CategoryIconState();
}

class _CategoryIconState extends State<CategoryIcon> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() {
        widget.onTap?.call();
      }),
      child: Container(
        color: widget.backgroundColor,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color: widget.color,
              ),
              Text(
                widget.label,
                textScaleFactor: 0.7,
                textAlign: TextAlign.center,
                style: TextStyle(),
              ), // Todo: Use a condensed font/ make font condensed
            ]),
      ),
    );
  }
}
