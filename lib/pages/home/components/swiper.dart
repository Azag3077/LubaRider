import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/colors.dart';
import 'divider.dart';

class SwiperView extends ConsumerStatefulWidget {
  const SwiperView({
    required this.contents,
    super.key,
  });

  final List contents;

  @override
  ConsumerState<SwiperView> createState() => _SwiperViewState();
}

class _SwiperViewState extends ConsumerState<SwiperView> {
  late final PageController _controller;
  late final List<GlobalKey> _keys;

  double _height = 0;

  double get _spacing => 16.0;

  double get _getViewportFraction {
    if (widget.contents.length == 1) return 1;

    final width = MediaQuery.of(context).size.width;
    final rWidth = width - _spacing * 2;
    return rWidth / width;
  }

  @override
  void initState() {
    super.initState();
    _keys = List.generate(widget.contents.length, (_) => GlobalKey());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller = PageController(viewportFraction: _getViewportFraction);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _getHeight(BuildContext ctx, int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final keyCtx = _keys[index].currentContext;
      final renderBox = keyCtx?.findRenderObject() as RenderBox?;
      final height = renderBox?.size.height;

      if (height != null && _height != height) {
        _height = height;

        if (ctx is Element) ctx.markNeedsBuild();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: PageView.builder(
        controller: PageController(viewportFraction: _getViewportFraction),
        itemCount: widget.contents.length,
        itemBuilder: (_, int index) {
          _getHeight(context, index);
          return Column(
            // It is very important to wrap child with column.
            // Otherwise the height will not be retrieved.
            children: <Widget>[
              SwiperContainer(key: _keys[index]),
            ],
          );
        },
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.text,
    required this.isLoading,
  });

  final bool isLoading;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4.0,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            color: AppColors.containerBg,
            shape: BoxShape.circle,
          ),
          child: isLoading
              ? Image.asset(
                  ImageAssetNames.loading,
                  width: 18.0,
                  height: 18.0,
                )
              : const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 18.0,
                ),
        ),
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 11.0,
          ),
        ),
      ],
    );
  }
}

class SwiperContainer extends StatelessWidget {
  const SwiperContainer({super.key});

  double get _spacing => 16.0;

  Widget _buildContainerText(
    String text, {
    IconData? leftIcon,
    Color bgColor = AppColors.containerBg,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 3.0,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        spacing: 4.0,
        children: <Widget>[
          if (leftIcon != null)
            Icon(
              leftIcon,
              size: 14.0,
              color: AppColors.containerFg,
            ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w500,
              color: AppColors.containerFg,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: EdgeInsets.only(right: _spacing),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: AppColors.greyOutline,
        ),
      ),
      child: Column(
        spacing: 12.0,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Row(
          //   spacing: 6.0,
          //   children: <Widget>[
          //     _buildContainerText('DHL'),
          //     _buildContainerText('6', bgColor: AppColors.yellow700),
          //     _buildContainerText('ID:R4567'),
          //     const Spacer(),
          //     _buildContainerText('6 mins', leftIcon: Icons.access_time),
          //   ],
          // ),
          Row(
            spacing: 8.0,
            children: <Widget>[
              Image.asset(
                ImageAssetNames.plate,
                width: 40.0,
                height: 40.0,
              ),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Food',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      'Tracking number: #245789098',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 11.0,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                style: IconButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: const EdgeInsets.all(6.0),
                  minimumSize: Size.zero,
                  iconSize: 20.0,
                ),
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
          const Row(
            children: <Widget>[
              CustomIconButton(
                isLoading: false,
                text: 'Accepted',
              ),
              DashDivider(),
              CustomIconButton(
                isLoading: true,
                text: 'Pickup',
              ),
              DashDivider(),
              CustomIconButton(
                isLoading: true,
                text: 'Delivered',
              ),
            ],
          ),
          Row(
            spacing: 2.0,
            children: <Widget>[
              Image.asset(
                ImageAssetNames.location,
                color: AppColors.secText,
                width: 16.0,
              ),
              const Expanded(
                child: Text(
                  r'12 Avenue Street, Lagos Yaba',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13.0,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
