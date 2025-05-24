import 'package:go_router/go_router.dart';
import '../screens/album_list_screen.dart';
import '../screens/album_detail_screen.dart';
import '../screens/photo_list_screen.dart';
import '../screens/photo_detail_screen.dart';
import '../models/album.dart';
import '../models/photo.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const AlbumListScreen()),
    GoRoute(
      path: '/albums',
      builder: (context, state) => const AlbumListScreen(),
    ),
    GoRoute(
      path: '/photos',
      builder: (context, state) => const PhotoListScreen(),
    ),
    GoRoute(
      path: '/album/:id',
      builder: (context, state) {
        final album = state.extra as Album;
        return AlbumDetailScreen(album: album);
      },
    ),
    GoRoute(
      path: '/photo/:id',
      builder: (context, state) {
        final photo = state.extra as Photo;
        return PhotoDetailScreen(photo: photo);
      },
    ),
  ],
);
