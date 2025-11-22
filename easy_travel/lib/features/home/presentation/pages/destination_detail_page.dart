import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_travel/features/home/domain/destination.dart';
import 'package:easy_travel/features/home/presentation/blocs/review_list_bloc.dart';
import 'package:easy_travel/features/home/presentation/blocs/review_list_event.dart';
import 'package:easy_travel/features/home/presentation/pages/review_list.dart';
import 'package:easy_travel/features/home/presentation/widgets/review_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DestinationDetailPage extends StatelessWidget {
  const DestinationDetailPage({super.key, required this.destination});
  final Destination destination;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_comment),
        onPressed: () => _addReview(context),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: destination.id,
            child: CachedNetworkImage(
              imageUrl: destination.posterPath,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  destination.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('City: ${destination.city}'),
                Text('Country: ${destination.country}'),

                Text(destination.overview),
              ],
            ),
          ),

          ReviewList(),
        ],
      ),
    );
  }

  void _addReview(BuildContext context) {
    int rating = 0;
    String comment = '';
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<ReviewListBloc>().add(
                SubmitReview(
                  comment: comment,
                  rating: rating,
                  id: destination.id,
                ),
              );
            },
            child: Text('Submit'),
          ),
        ],
        content: SingleChildScrollView(
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Leave a comment',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                onChanged: (value) => comment = value,
                decoration: InputDecoration(
                  hint: Text('Review'),
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              ReviewRating(onRatingSelected: (value) => rating = value),
            ],
          ),
        ),
      ),
    );
  }
}
