import 'package:flutter/material.dart';
import 'package:travelapp/screens/Journey/all_journeys_screen.dart';


class CustomSearchDelegate extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: (){
        query='';
      }, icon: const Icon(Icons.clear))
    ];
    // TODO: implement buildActions
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      close(context, null);
      //close the page and go back
    }, icon: const Icon(Icons.arrow_back));
    // TODO: implement buildLeading
  }

  @override
  Widget buildResults(BuildContext context) {
   return MyJourneyScreen(query: query);
    // TODO: implement buildResults
  }

  @override
  Widget buildSuggestions(BuildContext context) {
   return MyJourneyScreen(query: query);
    // TODO: implement buildSuggestions
  }

}