import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/album_bloc/album_bloc.dart';
import '../services/api_service.dart';

class AlbumListTile extends StatelessWidget {
  final dynamic
  album; // Replace dynamic with your Album model type if available

  const AlbumListTile({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color cardColor = Color(0xFF22223B);
    const Color accentColor = Color(0xFF9D4EDD);
    const Color textColor = Colors.white;

    return Card(
      color: cardColor,
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/album/${album.id}', arguments: album);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 64,
            child: Row(
              children: [
                album.thumbnailUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          album.thumbnailUrl,
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.image_not_supported,
                            size: 48,
                            color: accentColor,
                          ),
                        ),
                      )
                    : Icon(Icons.photo_album, size: 48, color: accentColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    album.title,
                    style: TextStyle(
                      fontSize: 16,
                      color: accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AlbumListScreen extends StatelessWidget {
  const AlbumListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color cardColor = Color(0xFF22223B);
    const Color accentColor = Color(0xFF9D4EDD);
    const Color textColor = Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums'),
        backgroundColor: accentColor,
        foregroundColor: textColor,
      ),
      backgroundColor: cardColor.withOpacity(0.96),
      body: BlocProvider(
        create: (context) =>
            AlbumBloc(apiService: ApiService())..add(FetchAlbums()),
        child: BlocBuilder<AlbumBloc, AlbumState>(
          builder: (context, state) {
            if (state is AlbumInitial || state is AlbumLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AlbumError) {
              return Center(
                child: Text(
                  state.error,
                  style: const TextStyle(color: textColor),
                ),
              );
            } else if (state is AlbumLoaded) {
              return ListView.builder(
                itemCount: state.albums.length,
                itemBuilder: (context, index) {
                  final album = state.albums[index];
                  return AlbumListTile(album: album);
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
