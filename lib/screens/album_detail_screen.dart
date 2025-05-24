import 'package:flutter/material.dart';
import '../models/album.dart';

class AlbumDetailScreen extends StatelessWidget {
  final Album album;

  const AlbumDetailScreen({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Album ${album.id}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User ID: ${album.userId}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text('Album ID: ${album.id}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Title: ${album.title}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
