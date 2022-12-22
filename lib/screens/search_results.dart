import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymfinder/components/dark_image.dart';
import 'package:gymfinder/components/gym_component.dart';

class SearchResults extends StatefulWidget {
  final String search;
  const SearchResults(this.search);
  @override
  State<StatefulWidget> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  var search = "";
  List<Map> allGyms = [];
  List<Map> filteredGyms = [];
  @override
  void initState() {
    search = widget.search;
    init();
    super.initState();
  }

  Future<void> init() async {
    var gyms = await getGyms();
    var filtered = filterGyms(gyms, search);
    setState(() {
      allGyms = gyms;
      filteredGyms = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      DarkImage(
        alpha: 80,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.jpeg"),
                fit: BoxFit.cover),
          ),
        ),
      ),
      CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            leadingWidth: 30,
            title: Padding(
              padding: EdgeInsets.symmetric(horizontal: 1, vertical: 3),
              child: SizedBox(
                  height: 40,
                  child: TextFormField(
                    initialValue: search,
                    onChanged: (value) {
                      search = value;
                      filteredGyms = filterGyms(allGyms, search);
                      setState(() {
                        search = search;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)),
                      suffixIcon: IconButton(
                          color: Colors.black,
                          icon: Icon(Icons.search),
                          onPressed: () {}),
                      hintText: 'Enter name',
                      filled: true, //<-- SEE HERE
                      fillColor: Colors.white,
                    ),
                  )),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                  filteredGyms.isEmpty
                      ? "No gyms found"
                      : "search results for $search",
                  style: TextStyle(color: Colors.white)),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                for (var gym in filteredGyms)
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: GymComp(gym, key: ValueKey(gym["id"])),
                  )
              ]),
            ),
          )
        ],
      )
    ]));
  }
}

final db = FirebaseFirestore.instance;
Future<List<Map>> getGyms() async {
  List<Map> gyms = [];
  var ref = await db.collection("gyms").get();
  ref.docs.forEach((doc) {
    var data = doc.data();
    gyms.add({...data, "id": doc.id});
  });
  // db.collection("gyms").where("name", in)
  return gyms;
}

List<Map> filterGyms(List<Map> allGyms, String search) {
  return allGyms
      .where((gym) =>
          gym['name'].toString().toLowerCase().contains(search.toLowerCase()))
      .toList();
}
