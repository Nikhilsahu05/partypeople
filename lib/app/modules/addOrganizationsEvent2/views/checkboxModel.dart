import 'package:flutter/material.dart';

class CheckBoxModel extends StatefulWidget {
  var title;
  CheckBoxModel({this.title});

  @override
  State<CheckBoxModel> createState() => _CheckBoxModelState();
}

class _CheckBoxModelState extends State<CheckBoxModel> {
  bool? checkbox = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.1,
      height: 30,
      decoration: BoxDecoration(
          color: checkbox == false ? Colors.white : Colors.red,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              color: checkbox == false ? Colors.red : Colors.transparent)),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Row(
          children: [
            Checkbox(
                value: checkbox,
                onChanged: (value) {
                  setState(() {
                    checkbox = value;
                  });
                }),
            SizedBox(
                width: 80,
                child: Text(
                  '${widget.title}',
                  softWrap: true,
                ))
          ],
        ),
      ),
    );
  }
}
