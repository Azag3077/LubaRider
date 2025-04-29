import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../components/buttons.dart';
import '../../../../components/textfields.dart';
import '../../../../core/validators.dart';
import '../../components/image_picker.dart';
import '../../components/vehicle_type_selector.dart';
import 'provider.dart';

class VerificationDetailsPageView extends ConsumerWidget {
  const VerificationDetailsPageView({
    super.key,
    required this.formKey,
    required this.vehicleBrandFieldKey,
  });

  final GlobalKey<FormState> formKey;
  final GlobalKey<FormFieldState<String>> vehicleBrandFieldKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(verificationDetailsPageViewProvider);
    final notifier = ref.read(verificationDetailsPageViewProvider.notifier);

    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: AutofillGroup(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Verification Details',
                style: textTheme.headlineMedium,
              ),
              const SizedBox(height: 24.0),
              ImagePickerContainer(
                imagePath: state.license,
                labelText: 'Upload a picture of your Driver’s License',
                onSaved: notifier.updateLicense,
                validator: Validator.name,
              ),
              const SizedBox(height: 16.0),
              VehicleTypeSelector(
                labelText: 'Vehicle type',
                type: state.vehicleType,
                onSaved: (value) =>
                    notifier.updateVehicleType(vehicleBrandFieldKey, value),
                validator: (value) => Validator.name(value?.name),
              ),
              const SizedBox(height: 16.0),
              IgnorePointer(
                ignoring: state.vehicleType == null,
                child: Opacity(
                  opacity: state.vehicleType == null ? .55 : 1,
                  child: SelectionButton<String>(
                    fieldKey: vehicleBrandFieldKey,
                    labelText: 'Vehicle Brand',
                    hintText: 'Select brand',
                    initialValue: state.vehicleBrand,
                    bottomSheetItems: state.vehicleType?.brands ?? [],
                    textBuilder: (text) => text,
                    validator: Validator.name,
                    onSaved: notifier.updateVehicleBrand,
                  ),
                ),
              ),
              CustomTextField(
                labelText: 'Vehicle Registration Number',
                initialValue: state.vehicleRegNum,
                onChanged: notifier.updateVehicleRegNum,
                hintText: 'Enter vehicle registration number',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textInputAction: TextInputAction.next,
                validator: Validator.name,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
