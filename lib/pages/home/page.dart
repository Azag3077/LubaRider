import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/place_holders.dart';
import '../../components/textfields.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/colors.dart';
import 'components/home_card.dart';
import 'components/swiper.dart';
import 'provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(homePageProvider.notifier);

    const titleStyle = TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
    );

    return Scaffold(
      // appBar: AppBar(
      //   leading: const Center(
      //     child: ProfileImage(),
      //   ),
      //   titleSpacing: 0.0,
      //   title: InkWell(
      //     onTap: () => notifier.onLocation(context),
      //     child: const Column(
      //       spacing: 4.0,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: <Widget>[
      //         Text(
      //           'John Doe',
      //           style: TextStyle(
      //             fontWeight: FontWeight.w600,
      //             fontSize: 16.0,
      //           ),
      //         ),
      //         Text(
      //           r'Bagada 31 ashimowo street',
      //           style: TextStyle(
      //             fontWeight: FontWeight.normal,
      //             fontSize: 11.0,
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      //   actions: <Widget>[
      //     IconButton(
      //       onPressed: () => notifier.onBellIcon(context),
      //       style: IconButton.styleFrom(
      //         backgroundColor: AppColors.orderFood,
      //         foregroundColor: AppColors.primary,
      //       ),
      //       icon: const Icon(CupertinoIcons.bell),
      //     ),
      //     const SizedBox(width: 4.0),
      //   ],
      //   bottom: PreferredSize(
      //     preferredSize: const Size.fromHeight(160.0),
      //     child: Container(
      //       padding: const EdgeInsets.all(14.0),
      //       margin: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
      //       decoration: BoxDecoration(
      //         color: AppColors.containerBg1,
      //         borderRadius: BorderRadius.circular(8.0),
      //         image: const DecorationImage(
      //           image: AssetImage(ImageAssetNames.transparentBox),
      //           alignment: Alignment.topRight,
      //         ),
      //       ),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: <Widget>[
      //           const Text(
      //             'Track your shipment',
      //             style: TextStyle(
      //               fontWeight: FontWeight.w500,
      //               color: Colors.white,
      //               fontSize: 19.0,
      //             ),
      //           ),
      //           const SizedBox(height: 10.0),
      //           const Text(
      //             'Please enter your tracking number',
      //             style: TextStyle(
      //               fontWeight: FontWeight.w500,
      //               color: Colors.white,
      //               fontSize: 13.0,
      //             ),
      //           ),
      //           const SizedBox(height: 13.0),
      //           CustomTextField(
      //             prefixIcon: Image.asset(ImageAssetNames.search),
      //             hintText: 'Search parcel, order no, tracking no...',
      //             canRequestFocus: false,
      //             onTap: notifier.onTapSearchField,
      //             margin: EdgeInsets.zero,
      //             fillColor: Colors.white,
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // children: <Widget>[
          //   InkWell(
          //     onTap: () {},
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(
          //         vertical: 4.0,
          //         horizontal: 16.0,
          //       ),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: <Widget>[
          //           const Text('Current Delivery', style: titleStyle),
          //           Text(
          //             'See more',
          //             style: titleStyle.copyWith(
          //               color: AppColors.primary,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          //   const SizedBox(height: 6.0),
          //   const SwiperView(
          //     contents: [1, 2, 3],
          //   ),
          //   const Padding(
          //     padding: EdgeInsets.only(left: 16.0, top: 16.0),
          //     child: Text('Service', style: titleStyle),
          //   ),
          //   GridView(
          //     padding: const EdgeInsetsDirectional.symmetric(
          //       horizontal: 16.0,
          //       vertical: 10.0,
          //     ),
          //     shrinkWrap: true,
          //     physics: const NeverScrollableScrollPhysics(),
          //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2,
          //       mainAxisSpacing: 8.0,
          //       crossAxisSpacing: 8.0,
          //       childAspectRatio: 1.5,
          //     ),
          //     children: <Widget>[
          //       HomeCard(
          //         onPressed: () => notifier.onOrderFood(context),
          //         imageAssetName: ImageAssetNames.plate,
          //         text: 'Food pickup & Order',
          //         bgColor: AppColors.orderFood,
          //       ),
          //       HomeCard(
          //         onPressed: () => notifier.onGrocery(context),
          //         imageAssetName: ImageAssetNames.grocery,
          //         text: 'Grocery',
          //         bgColor: const Color(0x26007AFF),
          //       ),
          //       HomeCard(
          //         onPressed: () => notifier.onPharmaceutical(context),
          //         imageAssetName: ImageAssetNames.redCross,
          //         text: 'Pharmaceutical',
          //         bgColor: AppColors.red50,
          //       ),
          //       HomeCard(
          //         onPressed: () => notifier.onMore(context),
          //         imageAssetName: ImageAssetNames.moreDots,
          //         text: 'More',
          //         bgColor: AppColors.yellow50,
          //       ),
          //     ],
          //   ),
          // ],
        ),
      ),
    );
  }
}
