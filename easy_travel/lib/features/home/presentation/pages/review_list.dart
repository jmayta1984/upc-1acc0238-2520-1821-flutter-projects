import 'package:easy_travel/core/enums/status.dart';
import 'package:easy_travel/features/home/domain/review.dart';
import 'package:easy_travel/features/home/presentation/blocs/review_list_bloc.dart';
import 'package:easy_travel/features/home/presentation/blocs/review_list_state.dart';
import 'package:easy_travel/features/home/presentation/widgets/review_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewList extends StatelessWidget {
  const ReviewList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocSelector<
        ReviewListBloc,
        ReviewListState,
        (Status, List<Review>, String?)
      >(
        selector: (state) => (state.status, state.reviews, state.message),
        builder: (context, state) {
          final (status, reviews, message) = state;
          switch (status) {
            case Status.loading:
              return Center(child: CircularProgressIndicator());
      
            case Status.success:
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  return ReviewCard(review: review);
                },
              );
            default:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
