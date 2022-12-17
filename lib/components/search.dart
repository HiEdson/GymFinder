import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<String> SearchTerms=[
    'gym1', 'gym2','gym3',
  ];
  @override
  List<Widget> buildActions(BuildContext context){
    return[
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed:(){
          query = '' ;
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context){
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context){
    List<String> matchQuery=[];
    for (var gym in SearchTerms){
      if(gym.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(gym);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context,index){
        var result =matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
  @override
  Widget buildSuggestions(BuildContext context){
    List<String> matchQuery=[];
    for (var gym in SearchTerms){
      if(gym.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(gym);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context,index){
        var result =matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

}

