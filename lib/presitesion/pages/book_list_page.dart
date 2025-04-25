import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../flavors.dart';
import '../cubit/book_cubit.dart';
import 'widgets/book_item.dart';

class BookListPage extends StatefulWidget {
   BookListPage({super.key , required this.flavor});
  String flavor ;
  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      context.read<BookCubit>().fetchBooks(query: _searchController.text.trim());
    }
  }

  void _onSearch() {
    final cubit = context.read<BookCubit>();
    final newQuery = _searchController.text.trim();
    cubit.fetchBooks(query: newQuery.isEmpty ? null : newQuery);
  }

  void _clearSearch() {
    _searchController.clear();
    _onSearch();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title:  Text(Flavors.appBarText() )),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search books...',
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(

                      icon: const Icon(Icons.clear),
                      onPressed: _clearSearch,
                    )
                        : IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: _onSearch,
                    ),
                  ),
                  onChanged: (_) => setState(() {

                  }),
                  onSubmitted: (_) => _onSearch(),
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: BlocBuilder<BookCubit, BookState>(
                builder: (context, state) {
                  if (state is BookError) {
                    return Center(child: Text(state.message));
                  } else if (state is BookLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is BookLoaded) {
                    if (state.books.isEmpty) {
                      return const Center(child: Text('لا توجد نتائج لهذا البحث.'));
                    }
                    return ListView.builder(
                      controller: _scrollController,
                      // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      //   crossAxisCount: 2, // Two columns
                      //   crossAxisSpacing: 8.0, // Horizontal spacing between items
                      //   mainAxisSpacing: 8.0, // Vertical spacing between items
                      //   childAspectRatio: 0.7, // Height-to-width ratio for book items
                      // ),
                      itemCount: state.books.length,
                      itemBuilder: (context, index) {
                        return BookItem(book: state.books[index]);
                      },
                    ) ;
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

