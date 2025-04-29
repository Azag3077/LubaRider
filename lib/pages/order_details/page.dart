import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/constants/assets.dart';
import '../../core/constants/colors.dart';
import '../../models/order.dart';
import 'ongoing/bottom_sheet.dart';
import 'pending/bottom_sheet.dart';
import 'provider.dart';

class OrderDetailsPage extends ConsumerWidget {
  const OrderDetailsPage(this.order, {super.key});

  final Order order;

  static const routeName = '/order-details';

  static const _initialCameraPosition = CameraPosition(target: LatLng(0, 0));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(orderDetailsPageProvider.notifier);

    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        onMapCreated: notifier.onMapCreated,
        onTap: notifier.goToLocation,
        onCameraMove: notifier.onCameraMove,
        onCameraIdle: notifier.onCameraIdle,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: FloatingActionButton(
          onPressed: () {},
          shape: const CircleBorder(),
          backgroundColor: AppColors.text,
          child: Image.asset(ImageAssetNames.send),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(12.0),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(0, -.5),
              blurRadius: 2.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Column(
          spacing: 18.0,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            /// The Drag Handle
            Container(
              width: 100.0,
              height: 7.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.5),
                color: AppColors.greyOutline,
              ),
            ),

            /// The Main Content
            if (order.status.isPending)
              PendingBottomSheet(order)
            else
              OngoingBottomSheet(order)
          ],
        ),
      ),
    );
  }
}
