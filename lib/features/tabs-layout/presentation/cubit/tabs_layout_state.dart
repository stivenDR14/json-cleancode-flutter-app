import 'package:equatable/equatable.dart';

import '../../domain/entities/slot_class.dart';

abstract class TabsLayoutState extends Equatable {
  const TabsLayoutState();

  @override
  List<Object> get props => [];
}

class TabsLayoutLoading extends TabsLayoutState {}

class TabsLayoutLoaded extends TabsLayoutState {
  final SlotData slots;

  const TabsLayoutLoaded({required this.slots});

  @override
  List<Object> get props => [slots];
}

class TabsLayoutError extends TabsLayoutState {
  final String message;

  const TabsLayoutError({required this.message});
}
