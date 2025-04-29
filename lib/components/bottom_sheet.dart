import 'package:flutter/material.dart';

import '../core/extensions/num_duration.dart';
import '../core/routers/router.dart';

class CustomBottomSheet<T> extends StatefulWidget {
  const CustomBottomSheet({
    super.key,
    required this.title,
    this.items,
    this.selected,
    required this.onSelected,
    this.isLoading = true,
    this.buildText,
  });

  final String title;
  final List<T>? items;
  final T? selected;
  final ValueChanged<T> onSelected;
  final bool isLoading;
  final Function(T)? buildText;

  @override
  State<CustomBottomSheet<T>> createState() => _CustomBottomSheetState<T>();
}

class _CustomBottomSheetState<T> extends State<CustomBottomSheet<T>> {
  final _isSelected = ValueNotifier<T?>(null);

  Future<void> _onSelected(T item) async {
    _isSelected.value = item;
    widget.onSelected(item);
    await Future.delayed(200.ms);

    if (mounted) pop(context, item);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: 18.0, color: Colors.grey.shade700),
          ),
          const SizedBox(height: 15.0),
          if (widget.isLoading || widget.items == null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SizedBox.square(
                  dimension: 32.0,
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.grey.shade200,
                  ),
                ),
              ),
            )
          else
            Flexible(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                shrinkWrap: true,
                itemCount: widget.items!.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10.0),
                itemBuilder: (BuildContext context, int index) {
                  final item = widget.items!.elementAt(index);
                  return ValueListenableBuilder<T?>(
                    valueListenable: _isSelected,
                    builder: (context, isSelected, _) {
                      return MaterialButton(
                        onPressed: () => _onSelected(item),
                        elevation: 0,
                        padding: const EdgeInsets.all(12.0),
                        color: (isSelected ?? widget.selected) == item
                            ? Theme.of(context)
                                .primaryColor
                                .withValues(alpha: .15)
                            : null,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1.2,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              widget.buildText?.call(item) ?? item.toString(),
                              style: TextStyle(
                                color: Colors.blueGrey.shade700,
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                              ),
                            ),
                            IgnorePointer(
                              child: Radio(
                                value: item,
                                groupValue: isSelected ?? widget.selected,
                                onChanged: (_) {},
                                visualDensity: const VisualDensity(
                                  horizontal: -4,
                                  vertical: -4.0,
                                ),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                fillColor: WidgetStatePropertyAll(
                                  (isSelected ?? widget.selected) == item
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey.shade400,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
