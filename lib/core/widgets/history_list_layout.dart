import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:walak/core/widgets/widgets.dart';

class HistoryListLayout extends StatefulWidget {
  final Widget list;
  final Widget? fab;
  final bool isLoading;
  final TextEditingController searchController;

  const HistoryListLayout({
    Key? key,
    required this.list,
    this.fab,
    this.isLoading = false,
    required this.searchController,
  }) : super(key: key);

  @override
  State<HistoryListLayout> createState() => _HistoryListLayoutState();
}

class _HistoryListLayoutState extends State<HistoryListLayout> {
  bool _showFab = true;

  @override
  Widget build(BuildContext context) {
    const animationDuration = Duration(milliseconds: 300);
    return Stack(
      children: [
        Positioned.fill(
          child: NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              final ScrollDirection direction = notification.direction;
              setState(() {
                if (direction == ScrollDirection.reverse) {
                  _showFab = false;
                } else if (direction == ScrollDirection.forward) {
                  _showFab = true;
                }
              });
              return true;
            },
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  HistoryListAppBar(
                    innerBoxIsScrolled: innerBoxIsScrolled,
                    searchController: widget.searchController,
                  ),
                ];
              },
              body: widget.list,
            ),
          ),
        ),
        if (widget.fab != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            alignment: Alignment.bottomRight,
            child: AnimatedSlide(
              duration: animationDuration,
              offset: _showFab ? Offset.zero : const Offset(0, 2),
              child: widget.fab,
            ),
          ),
        if (widget.isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: SizedBox(
                  width: 42,
                  height: 42,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
