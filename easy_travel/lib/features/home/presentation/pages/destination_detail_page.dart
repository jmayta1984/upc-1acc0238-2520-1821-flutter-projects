import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_travel/features/home/data/review_service.dart';
import 'package:easy_travel/features/home/domain/destination.dart';
import 'package:easy_travel/features/home/presentation/blocs/review_list_bloc.dart';
import 'package:easy_travel/features/home/presentation/blocs/review_list_event.dart';
import 'package:easy_travel/features/home/presentation/pages/review_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DestinationDetailPage extends StatelessWidget {
  const DestinationDetailPage({super.key, required this.destination});
  final Destination destination;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: destination.id,
            child: CachedNetworkImage(
              imageUrl: destination.posterPath,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            destination.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(destination.city),
          Text(destination.country),

          Text(destination.overview),

          BlocProvider(
            create: (context) =>
                ReviewListBloc(reviewService: ReviewService())
                  ..add(GetReviews(destination.id)),
            child: ReviewList(),
          ),
        ],
      ),
    );
  }
}
