import 'package:country_state_city/models/country.dart';
import 'package:country_state_city/utils/country_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/spinner.dart';
import '../../../core/constants/colors.dart';
import '../../../core/extensions/num_duration.dart';
import '../../../core/routers/router.dart';

final countriesFutureProvider =
    FutureProvider<List<Country>>((_) => getAllCountries());

final _searchStateProvider = StateProvider.autoDispose<String>((_) => '');

class CountryBottomSheet extends ConsumerWidget {
  CountryBottomSheet({
    super.key,
    this.selectedCountry,
    required this.onSelected,
  }) : _selectedCountryValueNotifier = ValueNotifier(selectedCountry);

  final Country? selectedCountry;
  final ValueChanged<Country> onSelected;
  final ValueNotifier<Country?> _selectedCountryValueNotifier;

  Future<void> _onSelected(BuildContext context, Country country) async {
    _selectedCountryValueNotifier.value = country;
    onSelected(country);

    await Future.delayed(300.milliseconds);
    if (!context.mounted) return;
    pop(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countriesAsyncValue = ref.watch(countriesFutureProvider);
    final search = ref.watch(_searchStateProvider);
    final searchNotifier = ref.read(_searchStateProvider.notifier);

    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Select your country',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              IconButton(
                onPressed: () => pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          TextField(
            onChanged: (text) => searchNotifier.state = text,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                CupertinoIcons.search,
                color: Colors.blueGrey,
              ),
              prefixIconConstraints: const BoxConstraints(minWidth: 56.0),
              hintText: 'Search by name or code...',
              hintStyle: const TextStyle(
                fontSize: 14.0,
                color: Colors.blueGrey,
                fontWeight: FontWeight.normal,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 13.0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Theme.of(context).highlightColor,
                  width: 1.6,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 1.6,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          Flexible(
            child: DraggableScrollableSheet(
              snap: true,
              expand: false,
              minChildSize: 0.5,
              shouldCloseOnMinExtent: false,
              builder: (_, ScrollController scrollController) {
                return countriesAsyncValue.when(
                  data: (countries) {
                    if (countries.isEmpty) {
                      return const Center(
                        child: Text('No data'),
                      );
                    }

                    final sorted = countries
                        .where((c) =>
                            c.name
                                .toLowerCase()
                                .contains(search.toLowerCase()) ||
                            c.phoneCode.contains(search))
                        .toList();

                    if (sorted.isEmpty) {
                      return Center(
                        child: Text('No country with name or code [$search]'),
                      );
                    }
                    return ValueListenableBuilder<Country?>(
                      valueListenable: _selectedCountryValueNotifier,
                      builder: (context, selectedCountry, _) {
                        return ListView.separated(
                          itemCount: sorted.length,
                          controller: scrollController,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 10.0),
                          itemBuilder: (BuildContext context, int index) {
                            final country = sorted.elementAt(index);
                            final isSelected =
                                country.isoCode == selectedCountry?.isoCode;
                            return CountryRadioListTile(
                              country: country,
                              onPressed: () => _onSelected(context, country),
                              isSelected: isSelected,
                            );
                          },
                        );
                      },
                    );
                  },
                  error: (_, __) =>
                      const Center(child: Text('Error loading country')),
                  loading: () => const Center(child: AppSpinner()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CountryRadioListTile extends StatelessWidget {
  const CountryRadioListTile({
    super.key,
    required this.country,
    required this.isSelected,
    required this.onPressed,
  });

  final Country country;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      elevation: 0,
      height: 56.0,
      padding: const EdgeInsets.all(12.0),
      color: isSelected ? AppColors.primary.withValues(alpha: .15) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.grey.shade300,
          width: 1.2,
        ),
      ),
      child: Row(
        children: <Widget>[
          Text(
            country.flag,
            style: const TextStyle(fontSize: 24.0),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              '${country.name} (${phoneCode(country)})',
              style: TextStyle(
                color: Colors.blueGrey.shade700,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
          ),
          IgnorePointer(
            child: Radio(
              value: isSelected,
              groupValue: true,
              onChanged: (_) {},
              visualDensity: const VisualDensity(
                horizontal: -4.0,
                vertical: -4.0,
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              fillColor: WidgetStatePropertyAll(
                isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.grey.shade400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String phoneCode(Country country) {
    if (country.phoneCode.startsWith('+')) {
      return country.phoneCode;
    }
    return '+${country.phoneCode}';
  }
}
