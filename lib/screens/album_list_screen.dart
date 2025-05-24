import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/album_bloc/album_bloc.dart';
// import '../models/album.dart';
import '../services/api_service.dart';

// Widget for a single album item with photo on the left and title on the right
class AlbumListTile extends StatelessWidget {
  final dynamic
  album; // Replace dynamic with your Album model type if available

  const AlbumListTile({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: album.thumbnailUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                album.thumbnailUrl,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image_not_supported),
              ),
            )
          : const Icon(Icons.photo_album, size: 48),
      title: Text(
        album.title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/album/${album.id}', arguments: album);
      },
    );
  }
}

class AlbumListScreen extends StatelessWidget {
  const AlbumListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Albums')),
      body: BlocProvider(
        create: (context) =>
            AlbumBloc(apiService: ApiService())..add(FetchAlbums()),
        child: BlocBuilder<AlbumBloc, AlbumState>(
          builder: (context, state) {
            if (state is AlbumInitial || state is AlbumLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AlbumError) {
              return Center(child: Text(state.error));
            } else if (state is AlbumLoaded) {
              return ListView.builder(
                itemCount: state.albums.length,
                itemBuilder: (context, index) {
                  final album = state.albums[index];
                  return ListTile(
                    title: Text(album.title),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/album/${album.id}',
                        arguments: album,
                      );
                    },
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
