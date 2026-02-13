import 'package:flutter/material.dart';
import 'package:segment/features/home/data/data_sources/user_auth_datasource_impl.dart';
import 'package:segment/features/home/data/repositories/user_auth_repository_impl.dart';
import 'package:segment/features/home/domain/entities/segment_response_entity.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<SegmentResponseEntity> segments = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final repository = UserAuthRepositoryImpl(
        dataSource: UserAuthDataSourceImpl(),
      );
      try {
        final result = await repository.getSegments();
        if (mounted) {
          setState(() {
            segments = result;
            isLoading = false;
          });
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("$e")));
          setState(() {
            isLoading = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Segments')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
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
    );
  }
}
