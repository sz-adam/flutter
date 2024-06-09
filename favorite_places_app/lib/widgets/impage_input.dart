import 'dart:io'; // lehetővé teszi a fájlkezelést.

import 'package:flutter/material.dart'; 
import 'package:image_picker/image_picker.dart'; 

class ImageInput extends StatefulWidget { 
  const ImageInput({super.key,required this.onPickImage}); 

  final void Function(File image) onPickImage;
  

  @override
  State<ImageInput> createState() { 
    return _ImageInputState(); 
  }
}

class _ImageInputState extends State<ImageInput> { 
  File? _selectedImage; // változó, amely tárolja a kiválasztott képet.

  void _takePicture() async {
    final imagePicker = ImagePicker(); // Létrehoz egy új ImagePicker példányt.
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera, // A kép forrását a kamerára állítja.
      maxWidth: 600, // A maximális szélességet 600 pixelen belülre korlátozza.
    );

    if (pickedImage == null) { // Ha a felhasználó nem készít képet, a függvény visszatér.
      return;
    }

    setState(() { // Frissíti a widget állapotát.
      _selectedImage = File(pickedImage.path); // A kiválasztott képet beállítja a _selectedImage változóban.
    });
    widget.onPickImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      icon: const Icon(Icons.camera),
      label: const Text('Take Picture'), 
      onPressed: _takePicture, 
    );

    if (_selectedImage != null) { // Ha van kiválasztott kép...
      content = GestureDetector( // Létrehoz egy GestureDetector-t, amely lehetővé teszi a képre történő kattintást.
        onTap: _takePicture, // Ha a képre kattintanak, újra meghívja a _takePicture függvényt.
        child: Image.file(
          _selectedImage!, // Megjeleníti a kiválasztott képet.
          fit: BoxFit.cover, // A kép kitölti a rendelkezésre álló helyet megtartva az arányokat.
          width: double.infinity, // A kép szélessége a rendelkezésre álló helyhez igazodik.
          height: double.infinity, // A kép magassága a rendelkezésre álló helyhez igazodik.
        ),
      );
    }

    return Container( 
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      height: 250, 
      width: double.infinity, 
      alignment: Alignment.center, 
      child: content,
    );
  }
}
