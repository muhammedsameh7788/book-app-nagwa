import 'package:flutter/material.dart';

import '../../../domain/entity/book.dart';

class BookItem extends StatefulWidget {
  final Book book;
  const BookItem({super.key, required this.book});

  @override
  State<BookItem> createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {

    final textPainter = TextPainter(
      text: TextSpan(
        text: widget.book.description,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      maxLines: 3,
      textDirection: TextDirection.ltr,
    )
    ..layout(maxWidth: MediaQuery.of(context).size.width / _calculateCrossAxisCount(context) +20);

    final showSeeMore = textPainter.didExceedMaxLines;
    return Card(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.book.imageUrl != null &&
                widget.book.imageUrl!.isNotEmpty)
              Image.network(
                  widget.book.imageUrl!,width: 100, height: 150, fit: BoxFit.fill),
            SizedBox(width :MediaQuery.of(context).size.width *0.05),
            SizedBox(
              width:MediaQuery.of(context).size.width *0.55 ,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 8),
                  SizedBox(
                    height:MediaQuery.of(context).size.height*0.1 ,
                    child: Text(widget.book.title, style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  Text(widget.book.authors.join(', '), style: const TextStyle(
                      fontSize: 14, fontStyle: FontStyle.italic)),
                  const SizedBox(height: 8),
                  if (widget.book.description != null)


                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (expanded || !showSeeMore)
                        // Show full text when expanded or no truncation needed
                          Text(
                            widget.book.description !,
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        else
                        // Show truncated text with "See More" inline
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.end,
                            children: [
                              Text(
                                widget.book.description !,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              InkWell(
                                onTap: () => setState(() => expanded = !expanded),
                                child: Text(
                                  'See More',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        if (expanded && showSeeMore)
                        // Show "See Less" below when expanded
                          InkWell(
                            onTap: () => setState(() => expanded = !expanded),
                            child: Text(
                              'See Less',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                              ),
                            ),
                          ),
                      ],
                    ),


                ],
              ),
            ),
          ],
        ),
      ),
    );

    // Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Text(
    //       widget.book.description!,
    //
    //       maxLines: expanded ? null : 3,
    //       overflow: expanded ? TextOverflow.visible : TextOverflow.ellipsis,
    //     ),
    //     InkWell(
    //       onTap: () => setState(() => expanded = !expanded),
    //       child: Text(
    //         expanded ? 'See Less' : 'See More',
    //         style: const TextStyle(color: Colors.blue),
    //       ),
    //     ),
    //   ],
    // ),
  }
  int _calculateCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 4;
    if (width > 600) return 3;
    return 2;
  }


}
