import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/album.dart';
import '../../services/api_service.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final ApiService apiService;

  AlbumBloc({required this.apiService}) : super(AlbumInitial()) {
    on<FetchAlbums>((event, emit) async {
      emit(AlbumLoading());
      try {
        final albums = await apiService.fetchAlbums();
        emit(AlbumLoaded(albums: albums));
      } catch (e) {
        emit(AlbumError(error: e.toString()));
      }
    });
  }
}
