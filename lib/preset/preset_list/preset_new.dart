import 'package:flutter/material.dart';

class PresetNew extends StatefulWidget {
  const PresetNew({Key? key}) : super(key: key);

  @override
  State<PresetNew> createState() => _PresetNewState();
}

class _PresetNewState extends State<PresetNew> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      alignment: Alignment.topLeft,
      child: Column(children: [
        TextField(),
        SizedBox(
          height: 40,
        ),
        ButtonBar(
          children: [
            ElevatedButton(onPressed: () {}, child: Text("Cancel")),
            ElevatedButton(onPressed: () {}, child: Text("Save"))
          ],
        )
      ]),
    );
  }
}
