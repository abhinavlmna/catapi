import 'package:catsapi/catprovider.dart';
import 'package:catsapi/cats.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  Homescreen({super.key});

  @override
  State<Homescreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Homescreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final catProvider = Provider.of<CatProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Cats in the world'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(13),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Search here'),
              onSubmitted: (query) {
                catProvider.fetchCats(query);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: catProvider.cats.length,
                itemBuilder: (BuildContext context, int index) {
                  Cats cats = catProvider.cats[index];
                  return ListTile(
                    title: Text('${cats.name}'),
                    leading: Image.network('${cats.image}'),
                  );
                }),
            // child: FutureBuilder<List<Cats>>(
            //     future: fetchCats(),
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return Center(child: CircularProgressIndicator());
            //       } else if (snapshot.hasError) {
            //         return Center(
            //           child: Text('${snapshot.error}'),
            //         );
            //       } else {
            //         List<Cats> cats = snapshot.data!;
            //         return ListView.builder(
            //             itemCount: catProvider.cats.length,
            //             itemBuilder: (BuildContext context, int index) {
            //               Cats cats = catProvider.cats[index];
            //               return ListTile(
            //                 title: Text('${cats.name}'),
            //                 leading: Image.network('${cats.image}'),
            //               );
            //             });
            //       }
            //     })
          )
        ],
      ),
    );
  }
}
