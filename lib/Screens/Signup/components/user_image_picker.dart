import 'dart:io';

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
      if(_pickedImage!= null)
        CircleAvatar(radius: 40,
      backgroundImage: _pickedImage!= null?FileImage(_pickedImage!):null,),
      // ignore: deprecated_member_use
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.purple, // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: () { _pickImage();},
        child: Text('Upload Picture'),
      )

    ],);
  }
}
