import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:segment/features/home/presentation/provider/segment_provider.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final segmentAsyncValue = ref.watch(segmentProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Segments')),
      body: segmentAsyncValue.when(
        data: (segments) => ListView.builder(
          itemCount: segments.length,
          itemBuilder: (context, index) {
            final segment = segments[index];
            return ExpansionTile(
              title: Text(segment.name ?? 'Unknown'),
              subtitle: segment.description != null
                  ? Text(segment.description!)
                  : null,
              children: (segment.subSegments ?? []).map((sub) {
                return ListTile(
                  title: Text(sub.name ?? 'Unknown'),
                  subtitle: sub.description != null
                      ? Text(sub.description!)
                      : null,
                  contentPadding: const EdgeInsets.only(left: 32.0),
                );
              }).toList(),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
