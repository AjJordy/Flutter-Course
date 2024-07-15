import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Lugares'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return Consumer<GreatPlaces>(
            builder: (context, greatPlaces, child) {
              if (greatPlaces.itemsCount == 0) {
                return child ?? Container();
              } else {
                return ListView.builder(
                  itemBuilder: (context, i) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: FileImage(
                        greatPlaces.itemByIndex(i).image,
                      ),
                    ),
                    title: Text(
                      greatPlaces.itemByIndex(i).title,
                    ),
                    subtitle: Text(
                      greatPlaces.itemByIndex(i).location?.address ?? "",
                    ),
                    onTap: () {},
                  ),
                  itemCount: greatPlaces.itemsCount,
                );
              }
            },
            child: const Center(
              child: Text('Nenhum local cadastrado'),
            ),
          );
        },
      ),
    );
  }
}
