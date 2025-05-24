import 'package:flutter/material.dart';
import '../models/album.dart';

class AlbumDetailScreen extends StatelessWidget {
  final Album album;

  const AlbumDetailScreen({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    const Color cardColor = Color(0xFF22223B);
    const Color accentColor = Color(0xFF9D4EDD);
    const Color textColor = Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: Text('Album ${album.id}'),
        backgroundColor: accentColor,
        foregroundColor: textColor,
      ),
      backgroundColor: cardColor.withOpacity(0.96),
      body: Center(
        child: Card(
          color: cardColor,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'User ID: ${album.userId}',
                  style: const TextStyle(fontSize: 18, color: textColor),
                ),
                const SizedBox(height: 8),
                Text(
                  'Album ID: ${album.id}',
                  style: const TextStyle(fontSize: 18, color: textColor),
                ),
                const SizedBox(height: 8),
                Text(
                  album.title,
                  style: TextStyle(
                    fontSize: 22,
                    color: accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
