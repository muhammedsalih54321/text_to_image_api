import 'package:bloc/bloc.dart';
import 'package:image_to_text_ai/Repository/Api/Ai_api/ai_api.dart';
import 'package:image_to_text_ai/Repository/Model/ai_model.dart';
import 'package:meta/meta.dart';

part 'ai_event.dart';
part 'ai_state.dart';

class AiBloc extends Bloc<AiEvent, AiState> {
  late Almodel aimodel;
  AiApi aiApi=AiApi();
  AiBloc() : super(AiInitial()) {
    on<FetchaiEvent>((event, emit) async{
    emit(Aiblocloading());
    try {
      aimodel= await aiApi.getAi(event.text);
      emit(Aiblocloaded());
    } catch (e) {
      print(e);
      emit(Aiblocerror());
    }
    });
  }
}
