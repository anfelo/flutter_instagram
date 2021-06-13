import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/models/models.dart';
import 'package:flutter_instagram/repositories/repositories.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final UserRepository _userRepository;

  SearchCubit({@required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SearchState.initial());

  void searchUsers(String query) async {
    emit(state.copyWith(status: SearchStatus.loading));
    try {
      final users = await _userRepository.searchUsers(query: query);
      emit(
        state.copyWith(
          status: SearchStatus.loaded,
          users: users,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SearchStatus.error,
          failure:
              const Failure(message: 'Something went wrong. Please try again.'),
        ),
      );
    }
  }

  void clearSearch() {
    emit(state.copyWith(status: SearchStatus.initial, users: []));
  }
}
