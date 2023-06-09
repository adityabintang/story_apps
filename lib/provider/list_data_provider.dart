

import 'package:flutter/cupertino.dart';
import 'package:storys_apps/data/api/api.dart';
import 'package:storys_apps/data/model/list_story.dart';
import 'package:storys_apps/data/model/stories.dart';
import 'package:storys_apps/data/result_state.dart';



class DataListProvider extends ChangeNotifier {
  final Api api;

  DataListProvider({required this.api}){
    fetchList();
    _setControllerListener();

  }

  bool isLoading = false;

  final int _currentSize = 10;
  int _currentPage = 1;
  bool _hasReachedMax = false;
  bool _isScrollLoading = false;

  ResultState state = ResultState.initial;

  StoriesResults? _storiesResults;
  final List<ListStory> _listStory = [];

  StoriesResults? get storiesResults => _storiesResults;

  List<ListStory> get listStory => _listStory;

  ScrollController get scrollController => _scrollController;

  bool get isScrollLoading => _isScrollLoading;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();

  Future<void> fetchList() async {
    try {
      if (_listStory.isEmpty) {
        state = ResultState.loading;
      } else {
        _isScrollLoading = true;
      }
      notifyListeners();

      _storiesResults = await api.getStoriesList(_currentPage, _currentSize);
      if (_storiesResults!.listStory!.isNotEmpty) {
        _listStory.addAll(_storiesResults?.listStory ?? []);
        state = ResultState.hasData;
      } else {
        if (_listStory.isEmpty) {
          state = ResultState.noData;
        } else {
          state = ResultState.hasData;
          _hasReachedMax = true;
        }
      }
      state = ResultState.hasData;

      if (_isScrollLoading) {
        _isScrollLoading = false;
      }

      notifyListeners();
    } catch (e) {
      isLoading = false;
      state = ResultState.error;
      notifyListeners();
      throw Exception('Error fetch list API : $e');
    }
  }


  void _setControllerListener() {
    _scrollController.addListener(() {
      if (_scrollController.offset >=
          scrollController.position.maxScrollExtent) {
        if (!_hasReachedMax) {
          _currentPage++;
          fetchList();
        }
      }
    });
  }
}
