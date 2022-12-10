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
    return SliverGrid.count(
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: [
        for (var index = 0; index < images.length; ++index)
          _MyImage(
              key: ValueKey(images[index].hashCode),
              bytes: images[index],
              index: index,
              onDelete: () {
                setState(() {
                  images.removeAt(index);
                });
              }),
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
    );
  }
}

class _MyImage extends StatelessWidget {
  final Uint8List bytes;
  final int index;
  final Function onDelete;
  const _MyImage(
      {super.key,
      required this.bytes,
      required this.index,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.memory(bytes, fit: BoxFit.cover),
        Positioned(
            right: 0,
            top: 0,
            child: IconButton(
                onPressed: () => onDelete(), icon: Icon(Icons.cancel)))
      ],
    );
  }
}
