import 'package:flutter/material.dart';

import '../models/post.dart';
import '../services/api_service.dart';

class SamplePage extends StatefulWidget {
  const SamplePage({super.key});

  @override
  State<SamplePage> createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  final ApiService _apiService = ApiService();

  // The list lives in state (instead of a FutureBuilder) so items can be
  // removed from it when the trash button is pressed.
  List<Post> _posts = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final posts = await _apiService.fetchPosts();
      if (!mounted) return;
      setState(() {
        _posts = posts;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = '$e';
        _isLoading = false;
      });
    }
  }

  Future<void> _deletePost(Post post) async {
    final messenger = ScaffoldMessenger.of(context);

    try {
      await _apiService.deletePost(post.id);
      if (!mounted) return;
      setState(() {
        _posts.removeWhere((p) => p.id == post.id);
      });
      messenger.showSnackBar(
        SnackBar(content: Text('Post #${post.id} deleted')),
      );
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('Could not delete post #${post.id}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 70),
              const SizedBox(height: 16),
              const Text(
                'Unable to load data',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(_error!, textAlign: TextAlign.center),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _loadPosts,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadPosts,
      child: _posts.isEmpty
          // ListView (not Center) so pull-to-refresh still works when empty.
          ? ListView(
              children: const [
                SizedBox(height: 200),
                Center(child: Text('No posts left. Pull down to reload.')),
              ],
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                final post = _posts[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Post #${post.id}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          post.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(post.body),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          // Trash ElevatedButton that deletes this item
                          child: ElevatedButton(
                            onPressed: () => _deletePost(post),
                            child: const Icon(Icons.delete),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
