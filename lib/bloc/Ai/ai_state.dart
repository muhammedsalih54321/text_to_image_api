part of 'ai_bloc.dart';

@immutable
sealed class AiState {}

final class AiInitial extends AiState {}
class Aiblocloading extends AiState {}
class Aiblocloaded extends AiState {}
class Aiblocerror extends AiState {}
