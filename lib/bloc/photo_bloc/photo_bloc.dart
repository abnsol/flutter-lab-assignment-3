import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/photo.dart';
import '../../services/api_service.dart';

part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final ApiService apiService;

  PhotoBloc({required this.apiService}) : super(PhotoInitial()) {
    on<FetchPhotos>((event, emit) async {
      emit(PhotoLoading());
      try {
        final photos = await apiService.fetchPhotos();
        emit(PhotoLoaded(photos: photos));
      } catch (e) {
        emit(PhotoError(error: e.toString()));
      }
    });
  }
}
