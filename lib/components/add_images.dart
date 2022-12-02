import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddImagesState();
  }
}

class _AddImagesState extends State<AddImages> {
  final _picker = ImagePicker();
  final List<Uint8List> images = [];
  Uint8List? bytes;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.count(
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: [
        for (var image in images) Image.memory(image, fit: BoxFit.cover),
        Container(
          color: Colors.white,
          child: Center(
              child: ElevatedButton(
            onPressed: () async {
              XFile? image =
                  await _picker.pickImage(source: ImageSource.gallery);
              var bytes = await image?.readAsBytes();
              setState(() {
                if (bytes != null) images.add(bytes);
              });
            },
            style: ElevatedButton.styleFrom(
                shape: CircleBorder(), backgroundColor: Colors.grey),
            child: Icon(Icons.add),
          )),
        ),
      ],
    ));
  }
}



//   Widget build(BuildContext context) {
//     return Container(
//         child: Column(
//       children: [
//         ElevatedButton(
//           onPressed: () async {
//             XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//             print(image?.path);
//             final b = await image?.readAsBytes();
//             setState(() {
//               bytes = b;
//             });
//           },
//           child: Text("add"),
//         ),
//         if (bytes != null)
//           SizedBox(
//             width: 100,
//             height: 100,
//             child: Image.memory(bytes!, fit: BoxFit.cover),
//           )
//       ],
//     ));
//   }
// }
