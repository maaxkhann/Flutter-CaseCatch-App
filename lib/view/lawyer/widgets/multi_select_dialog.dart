import 'package:catch_case/constants/textstyles.dart';
import 'package:flutter/material.dart';

class MultiSelectDialog extends StatefulWidget {
  final List<String> items;
  final List<String> selectedItems;

  const MultiSelectDialog({
    Key? key,
    required this.items,
    required this.selectedItems,
  }) : super(key: key);

  @override
  State<MultiSelectDialog> createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  final List<String> selectedItems = [];

  @override
  void initState() {
    super.initState();
    selectedItems.addAll(widget.selectedItems);
  }

  void itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedItems.add(itemValue);
      } else {
        selectedItems.remove(itemValue);
      }
    });
  }

  void cancel() {
    Navigator.pop(context);
  }

  void submit() {
    Navigator.pop(context, selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Choose',
        style: kBody1Black,
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items.map((item) {
            return CheckboxListTile(
              value: selectedItems.contains(item),
              title: Text(item),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (isChecked) => itemChange(item, isChecked!),
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => cancel(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => submit(),
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
