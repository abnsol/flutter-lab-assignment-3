import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/photo_bloc/photo_bloc.dart';
import '../services/api_service.dart';
import 'photo_detail_screen.dart';

class PhotoListScreen extends StatelessWidget {
  const PhotoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color cardColor = Color(0xFF22223B);
    const Color accentColor = Color(0xFF9D4EDD);
    const Color textColor = Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Photos'),
        backgroundColor: accentColor,
        foregroundColor: textColor,
      ),
      backgroundColor: cardColor.withOpacity(0.96),
      body: BlocProvider(
        create: (context) =>
            PhotoBloc(apiService: ApiService())..add(FetchPhotos()),
        child: BlocBuilder<PhotoBloc, PhotoState>(
          builder: (context, state) {
            if (state is PhotoInitial || state is PhotoLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PhotoError) {
              return Center(
                child: Text(
                  state.error,
                  style: const TextStyle(color: textColor),
                ),
              );
            } else if (state is PhotoLoaded) {
              return ListView.builder(
                itemCount: state.photos.length,
                itemBuilder: (context, index) {
                  final photo = state.photos[index];
                  return Card(
                    color: cardColor,
                    elevation: 6,
                    margin: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PhotoDetailScreen(photo: photo),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 64,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  photo.thumbnailUrl,
                                  width: 64,
                                  height: 64,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(
                                        Icons.image_not_supported,
                                        size: 64,
                                        color: accentColor,
                                      ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  photo.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: accentColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
