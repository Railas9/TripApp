import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../providers/city_provider.dart';

class ActivityFormImagePicker extends StatefulWidget {
  Function updateUrl;
  ActivityFormImagePicker({Key? key, required this.updateUrl}) : super(key: key);


  @override
  State<ActivityFormImagePicker> createState() => _ActivityFormImagePickerState();
}

class _ActivityFormImagePickerState extends State<ActivityFormImagePicker> {
  File? deviceImage;
  final picked = ImagePicker();
  Future<void> pickImage(ImageSource source) async{
    try{
      XFile? pickedImage = await picked.pickImage(source: source);
      if(pickedImage != null && mounted){
        deviceImage = File(pickedImage.path);
        final url = await Provider.of<CityProvider>(context, listen: false).uploadImage(deviceImage!);
        widget.updateUrl(url);
        setState(() {});
      }
    }catch(e){
      rethrow;
    }

  }


  @override
  Widget build(BuildContext context) {
    return
      Column(
       children:[
         Row(
          children: [
            TextButton.icon(onPressed: (){pickImage(ImageSource.gallery);}, icon: const Icon(Icons.photo_library_outlined), label: const Text("Gallerie"),),
            TextButton.icon(onPressed: (){pickImage(ImageSource.camera);}, icon: const Icon(Icons.camera_alt_outlined), label: const Text("Camera"),),
          ],
        ),
         SizedBox(
           width: double.infinity,
         child: deviceImage != null ?
         Image.file(deviceImage!, fit: BoxFit.cover,) : const Text("Aucune image") ,)
       ]
      );

  }
}
