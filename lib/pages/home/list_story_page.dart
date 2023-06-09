import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storys_apps/data/model/list_story.dart';
import 'package:storys_apps/data/result_state.dart';
import 'package:storys_apps/pages/home/card_list_stories.dart';
import 'package:storys_apps/provider/auth_provider.dart';
import 'package:storys_apps/provider/list_data_provider.dart';
import 'package:storys_apps/utils/style.dart';
import 'package:storys_apps/widget/load_data_error.dart';

class ListStoryPage extends StatefulWidget {
  final Function() onLogout;
  final Function(ListStory) onTapped;
  final List<ListStory>? provider;
  final Function() onPressed;

  const ListStoryPage({
    Key? key,
    required this.onLogout,
    required this.onTapped,
    required this.onPressed,
    this.provider,
  }) : super(key: key);

  @override
  State<ListStoryPage> createState() => _ListStoryPageState();
}

class _ListStoryPageState extends State<ListStoryPage> {
  Future<void> _onRefresh() async {
    Provider.of<DataListProvider>(
      context,
      listen: false,
    ).fetchList();
  }

  @override
  Widget build(BuildContext context) {
    final authWatch = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Stroy Apps'),
        actions: [
          IconButton(
            onPressed: () async {
              final scaffoldMessenger = ScaffoldMessenger.of(context);
              final authRead = context.read<AuthProvider>();
              final result = await authRead.logout();
              if (result) {
                widget.onLogout();
                scaffoldMessenger.showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Logout"),
                  ),
                );
              }
            },
            icon: authWatch.isLoadingLogout
                ? const CircularProgressIndicator(
                    color: secondaryColor,
                  )
                : const Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
          )
        ],
      ),
      body: SafeArea(
              child: RefreshIndicator(
                backgroundColor: secondaryColor,
                onRefresh: _onRefresh,
                child: _buildList(),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_circle_outline),
        onPressed: () => widget.onPressed(),
      ),
    );
  }

  Widget _buildList() {
    return Consumer<DataListProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: secondaryColor,
            ),
          );
        }
        if (provider.state == ResultState.error) {
          return LoadDataError(
            title: 'Problem Occured',
            subtitle:
                provider.storiesResults?.message ?? 'Something Went Wrong',
            bgColor: Colors.red,
            onTap: _onRefresh,
          );
        }
        if (provider.state == ResultState.hasData) {
          return Stack(
            children: [
              ListView.builder(
                controller: provider.scrollController,
                itemCount: provider.listStory.length,
                itemBuilder: (context, index) {
                  var stories = provider.listStory;
                  return GestureDetector(
                    onTap: () => widget.onTapped(stories[index]),
                    child: CardListStories(
                      stories: stories[index],
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              if (provider.isScrollLoading)
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(secondaryColor),
                      strokeWidth: 2,
                    ),
                  ),
                ),
            ],
          );
        } else {
          return Center(
            child: Material(
              child: Text(provider.storiesResults?.message ?? ''),
            ),
          );
        }
      },
    );
  }
}
