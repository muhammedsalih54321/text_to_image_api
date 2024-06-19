part of 'ai_bloc.dart';

@immutable
sealed class AiEvent {}
class FetchaiEvent extends AiEvent{
  final String text;

  FetchaiEvent({required this.text});
}
