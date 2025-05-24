import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/photo_bloc/photo_bloc.dart';
// import '../models/photo.dart';
import '../services/api_service.dart';
import 'photo_detail_screen.dart';

class PhotoListScreen extends StatelessWidget {
  const PhotoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Photos')),
      body: BlocProvider(
        create: (context) =>
            PhotoBloc(apiService: ApiService())..add(FetchPhotos()),
        child: BlocBuilder<PhotoBloc, PhotoState>(
          builder: (context, state) {
            if (state is PhotoInitial || state is PhotoLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PhotoError) {
              return Center(child: Text(state.error));
            } else if (state is PhotoLoaded) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: state.photos.length,
                itemBuilder: (context, index) {
                  final photo = state.photos[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhotoDetailScreen(photo: photo),
                        ),
                      );
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.network(
                              photo.thumbnailUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              photo.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
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
