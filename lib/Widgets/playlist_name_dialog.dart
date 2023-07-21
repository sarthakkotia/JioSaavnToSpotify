import 'package:flutter/material.dart';

class PlaylistNameDialog extends StatefulWidget {
  const PlaylistNameDialog({super.key});

  @override
  State<PlaylistNameDialog> createState() => _PlaylistNameDialogState();
}

class _PlaylistNameDialogState extends State<PlaylistNameDialog> {
  final _formKey = GlobalKey<FormState>();
  String text = "New Playlist";
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        title: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "title can't be a blank value";
            }
            return null;
          },
          onSaved: (newValue) async {
            text = newValue!;
          },
          autocorrect: true,
          autovalidateMode: AutovalidateMode.always,
          enableSuggestions: true,
          initialValue: text,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Playlist Name"),
            contentPadding:
                EdgeInsets.only(top: 0, left: 10, right: 5, bottom: 0),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                final isvalid = _formKey.currentState!.validate();
                if (isvalid == false) {
                  return;
                }
                _formKey.currentState?.save();
                Navigator.of(context).pop(text);
              },
              child: const Text("OK"))
        ],
      ),
    );
  }
}
