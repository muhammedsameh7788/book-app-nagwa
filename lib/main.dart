import 'package:book_app/presitesion/cubit/book_cubit.dart';
import 'package:book_app/presitesion/pages/book_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection.dart';
import 'core/theme/app_theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const BookApp());
}

class BookApp extends StatelessWidget {
  const BookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Listing App',
      theme: AppTheme.lightTheme,
      home: BlocProvider(
        create: (_) => getIt<BookCubit>()..fetchBooks(),
        child: const BookListPage(),
      ),
    );
  }
}
