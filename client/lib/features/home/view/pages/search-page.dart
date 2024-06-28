import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightAngle/core/core.dart';
import 'package:nightAngle/features/search/viewmodel/song-view-model.dart';

// Mock data for demonstration
final items = [
  'Apple',
  'Banana',
  'Cherry',
  'Date',
  'Elderberry',
  'Fig',
  'Grape',
  'Honeydew',
];

// Search State Provider
final searchProvider = StateProvider<String>((ref) => '');

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(searchProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Pallete.cardColor,
                ),
                onSubmitted: (value) {
                  ref.read(searchProvider.notifier).state = value;

                  // Call the search function
                },
              ),
              const SizedBox(height: 16),

              // Display the search results when the search query is not empty

              ref
                  .watch(
                    getSearchResultsProvider(searchQuery),
                  )
                  .when(
                      data: (data) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(data[index].song_name),
                              subtitle: Text(data[index].artist),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  data[index].thumbnail_url,
                                ),
                              ),
                            );
                          },
                        );
                      },
                      error: (e, s) => Text(''),
                      loading: () => Loader())
            ],
          ),
        ),
      ),
    );
  }
}
