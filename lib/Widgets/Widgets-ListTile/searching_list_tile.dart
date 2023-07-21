import 'package:flutter/material.dart';

class SearchingForListTile extends StatelessWidget {
  const SearchingForListTile({
    super.key,
    required this.songs,
    required this.i,
  });

  final List songs;
  final int i;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      width: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: LinearGradient(colors: [
          Theme.of(context).colorScheme.shadow,
          Theme.of(context).colorScheme.onSecondary,
          Theme.of(context).colorScheme.shadow
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: SingleChildScrollView(
        child: Center(
          child: ListTile(
            subtitle: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    songs[i]["primaryArtists"],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child:
                      Text(songs[i]["label"], overflow: TextOverflow.ellipsis),
                )
              ],
            ),
            leading: SizedBox(
              height: 60,
              width: 60,
              child: Image.network(
                songs[i]["image"][2]["link"],
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                songs[i]["name"],
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
