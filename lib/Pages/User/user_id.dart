import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyableID extends StatelessWidget {
  final String id;

  const CopyableID(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('id: '),
        SelectableText(id),
        IconButton(
          icon: const Icon(
            Icons.copy,
            color: Colors.grey,
          ),
          onPressed: () async {
            final data = ClipboardData(text: id);
            await Clipboard.setData(data);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 1),
                content: Text('コピーしました'),
              ),
            );
          },
        ),
      ],
    );
  }
}
