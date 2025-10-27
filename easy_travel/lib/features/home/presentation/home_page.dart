import 'package:easy_travel/features/home/domain/destination.dart';
import 'package:easy_travel/features/home/presentation/blocs/destinations_bloc.dart';
import 'package:easy_travel/features/home/presentation/blocs/destinations_event.dart';
import 'package:easy_travel/features/home/presentation/blocs/destinations_state.dart';
import 'package:easy_travel/features/home/presentation/destination_card.dart';
import 'package:easy_travel/features/home/presentation/destination_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _categories = [
    'All',
    'Beach',
    'Adventure',
    'Cultural',
    'City',
  ];

  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    context.read<DestinationsBloc>().add(
      GetDestinationsByCategory(category: _selectedCategory),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 48,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              String category = _categories[index];
              return FilterChip(
                label: Text(category),
                onSelected: (value) {
                  setState(() {
                    _selectedCategory = category;
                    context.read<DestinationsBloc>().add(
                      GetDestinationsByCategory(category: _selectedCategory),
                    );
                  });
                },
                selected: category == _selectedCategory,
              );
            },
          ),
        ),
        Expanded(
          child: BlocBuilder<DestinationsBloc, DestinationsState>(
            builder: (context, state) {
              if (state is DestinationsLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is DestinationsSuccesState) {
                return ListView.builder(
                  itemCount: state.destinations.length,
                  itemBuilder: (context, index) {
                    Destination destination = state.destinations[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DestinationDetailPage(destination: destination),
                          ),
                        );
                      },
                      child: DestinationCard(destination: destination),
                    );
                  },
                );
              } else {
                return const Center();
              }
            },
          ),
        ),
      ],
    );
  }
}
