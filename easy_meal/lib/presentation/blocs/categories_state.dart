import 'package:easy_meal/core/enums/status.dart';
import 'package:easy_meal/domain/models/category.dart';

class CategoriesState {
  final Status status;
  final List<Category> categories;
  final String? message;

  const CategoriesState({
    this.status = Status.initial,
    this.categories = const [],
    this.message,
  });

  CategoriesState copyWith({
    Status? status,
    List<Category>? categories,
    String? message,
  }) {
    return CategoriesState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      message: message ?? this.message,
    );
  }
}
