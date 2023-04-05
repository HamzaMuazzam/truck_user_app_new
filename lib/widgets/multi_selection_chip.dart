import 'package:flutter/material.dart';

class MultiSelectChip extends StatefulWidget {
  final List<dynamic> chipsDataList;
  final Function(List) onSelectionChanged;
  final List<dynamic> initChoices;
  const MultiSelectChip(
      {Key? key,
      required this.onSelectionChanged,
      required this.chipsDataList,
      this.initChoices = const <String>[]})
      : super(key: key);
  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  _buildChoiceList() {
    List<Widget> choices = [];
    for (var item in widget.chipsDataList) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          backgroundColor: Colors.white,
          side: BorderSide(width: 1, color: Colors.grey),
          label: Text(
            item,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          selectedColor: Colors.grey,
          selected: widget.initChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              widget.initChoices.contains(item)
                  ? widget.initChoices.remove(item)
                  : widget.initChoices.add(item);
              widget.onSelectionChanged(widget.initChoices); // +added
            });
          },
        ),
      ));
    }
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
