import 'package:flutter/material.dart';

class SwitchTile extends StatefulWidget {
  const SwitchTile({
    super.key,
    this.title,
    this.trueDescription,
    this.falseDescription,
    this.leading,
    // this.isThreeLine = false,
    this.initState = true,
    required this.onChanged,
  });

  final bool initState;
  final Widget? leading;
  final Widget? title;
  final Widget? trueDescription;
  final Widget? falseDescription;
  // final bool isThreeLine;
  final Function(bool)? onChanged;

  @override
  State<SwitchTile> createState() => _SwitchTileState();
}

class _SwitchTileState extends State<SwitchTile> {
  _toggleSwitch(bool value) {
    setState(() {
      toggleStatus = value;
    });
    widget.onChanged?.call(value);
  }

  late bool toggleStatus;

  @override
  void initState() {
    super.initState();
    toggleStatus = widget.initState;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _toggleSwitch(!toggleStatus),
      child: ListTile(
        leading: SizedBox(
          height: double.infinity,
          child: widget.leading,
        ),
        title: widget.title,
        subtitle: toggleStatus == true
            ? widget.trueDescription
            : widget.falseDescription,
        trailing: Switch(
          value: toggleStatus,
          onChanged: (value) => _toggleSwitch(value),
        ),
      ),
    );
  }
}
