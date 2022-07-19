import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {

  UserImagePicker(this.imagePickFn);

  // ignore: empty_constructor_bodies
  final void Function(File pickedImage) imagePickFn;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  final ImagePicker _picker = ImagePicker();
  File? _pickedImage;
  _pickImage() async {
    final pickedImageFile = await _picker.pickImage(source: ImageSource
        .camera, imageQuality: 50,
        maxWidth: 150);
    setState(() {
      _pickedImage = File(pickedImageFile!.path);
    });
    widget.imagePickFn(File(pickedImageFile!.path));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      CircleAvatar(radius: 40,
      backgroundImage: _pickedImage!= null?FileImage(_pickedImage!):null,),
      // ignore: deprecated_member_use
      TextButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('Add Profile Photo')),
    ],);
  }
}
