import 'package:flutter/material.dart';
import '../models/photo.dart';

class PhotoDetailScreen extends StatelessWidget {
  final Photo photo;

  const PhotoDetailScreen({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Photo ${photo.id}')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(photo.url),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Album ID: ${photo.albumId}'),
                  const SizedBox(height: 8),
                  Text('Title: ${photo.title}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
