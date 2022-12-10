import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gymfinder/models/gym_save_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddImages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddImagesState();
  }
}

class _AddImagesState extends State<AddImages> {
  final _picker = ImagePicker();
  final List<_Image> images = [];
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
              image: images[index],
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
              print("here");
              XFile? image =
                  await _picker.pickImage(source: ImageSource.gallery);
              // image
              var bytes = await image?.readAsBytes();
              if (bytes == null) {
                print("null");
                return;
              }
              var name = image?.name;
              print("path ${image?.path}# name ${name}");
              setState(() {
                images.add(_Image(name!, bytes));
              });
              Provider.of<NewGymModel>(context, listen: false)
                  .addImage(name!, bytes);
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
  final _Image image;
  final int index;
  final Function onDelete;
  const _MyImage(
      {super.key,
      required this.image,
      required this.index,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.memory(key: ValueKey(image.name), image.bytes, fit: BoxFit.cover),
        Positioned(
            right: 0,
            top: 0,
            child: IconButton(
                onPressed: () => onDelete(), icon: Icon(Icons.cancel)))
      ],
    );
  }
}

class _Image {
  final String name;
  final Uint8List bytes;

  _Image(this.name, this.bytes);
}
