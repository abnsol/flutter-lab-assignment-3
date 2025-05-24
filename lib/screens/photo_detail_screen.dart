import 'package:flutter/material.dart';
import '../models/photo.dart';

class PhotoDetailScreen extends StatelessWidget {
  final Photo photo;

  const PhotoDetailScreen({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    // You can change these colors as you like for your theme!
    const Color cardColor = Color(0xFF22223B); // Dark blue-purple
    const Color accentColor = Color(0xFF9D4EDD); // Lavender
    const Color textColor = Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: Text('Photo ${photo.id}'),
        backgroundColor: accentColor,
        foregroundColor: textColor,
      ),
      backgroundColor: cardColor.withOpacity(0.96),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            color: cardColor,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      photo.url,
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.image_not_supported,
                        size: 120,
                        color: accentColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Album ID: ${photo.albumId}',
                    style: const TextStyle(fontSize: 18, color: textColor),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    photo.title,
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
      ),
    );
  }
}
