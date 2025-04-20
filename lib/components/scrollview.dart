import 'package:flutter/material.dart';

class PaginatedScrollView<T> extends StatelessWidget {
  const PaginatedScrollView({
    super.key,
    required this.totalCount,
    required this.itemBuilder,
    this.separatorBuilder,
    this.fetching,
    this.separatorGap,
    required this.onFetch,
    required this.onRefresh,
    required this.data,
    this.threshold = 200.0,
  });

  final int totalCount;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final Widget? fetching;
  final double? separatorGap;
  final RefreshCallback onFetch;
  final RefreshCallback onRefresh;
  final List<T> data;
  final double threshold;

  bool get _fetchComplete => data.length >= totalCount;

  int get _itemCount => data.length + (_fetchComplete ? 0 : 1);

  bool _onNotificationPredicate(ScrollNotification notification) {
    final pixels = notification.metrics.pixels;
    final limit = notification.metrics.maxScrollExtent - threshold;

    if (pixels >= limit && !_fetchComplete) onFetch();

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      notificationPredicate: _onNotificationPredicate,
      child: ListView.separated(
        itemCount: _itemCount,
        padding: const EdgeInsets.all(12.0),
        separatorBuilder: separatorBuilder ??
            (_, __) => SizedBox(height: separatorGap ?? 12.0),
        itemBuilder: (BuildContext context, int index) {
          if (!_fetchComplete && index >= data.length) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: fetching ??
                    SizedBox.square(
                      dimension: 24.0,
                      child: CircularProgressIndicator(
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        strokeWidth: 2.4,
                      ),
                    ),
              ),
            );
          }

          return itemBuilder(context, index);
        },
      ),
    );
  }
}
