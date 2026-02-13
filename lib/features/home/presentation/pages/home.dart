import 'package:flutter/material.dart';
import 'package:segment/features/home/domain/entities/segment_response_entity.dart';
import 'package:segment/user_auth.dart';

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
      segments = await UserAuth().getSegment(context);
      if (mounted) {
        setState(() {
          isLoading = false;
        });
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
