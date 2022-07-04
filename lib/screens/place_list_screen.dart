import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import '../providers/great_places.dart';
import './place_details_screen.dart';

class PlaceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Places"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routName);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatePlaces>(context).FectAndSeyPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatePlaces>(
                child: Center(child: Text("No Places Added Yet")),
                builder: (ctx, greatePlace, ch) => greatePlace.items.length <= 0
                    ? ch
                    : ListView.builder(
                        itemCount: greatePlace.items.length,
                        itemBuilder: (ctx, i) => ListTile(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              PlaceDetailScreen.routeName,
                              arguments: greatePlace.items[i].Id,
                            );
                          },
                          leading: CircleAvatar(
                            backgroundImage: FileImage(
                              greatePlace.items[i].image,
                            ),
                          ),
                          title: Text(greatePlace.items[i].title),
                          subtitle: Text(greatePlace.items[i].location.address),
                        ),
                      ),
              ),
      ),
    );
  }
}
