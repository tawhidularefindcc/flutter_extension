import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/views/base/custom_button.dart';
import 'package:flutter_extension/views/screen/home/analyzing_territories_screen.dart';
import 'package:flutter_extension/views/screen/home/preferences_steps/area_vibe_step.dart';
import 'package:flutter_extension/views/screen/home/preferences_steps/budget_step.dart';
import 'package:flutter_extension/views/screen/home/preferences_steps/commute_preference_step.dart';
import 'package:flutter_extension/views/screen/home/preferences_steps/safety_priority_step.dart';
import 'package:flutter_extension/views/screen/home/preferences_steps/schools_education_step.dart';
import 'package:flutter_extension/views/screen/home/preferences_steps/transport_access_step.dart';
import 'package:get/get.dart';

const int _totalSteps = 7;

const List<String> _countries = ['Portugal'];
const Map<String, List<String>> _citiesByCountry = {
  'Portugal': [
    'Lisbon',
    'Porto',
    'Braga',
    'Faro',
    'Setubal',
    'Coimbra',
    'Aveiro',
  ],
};

class PreferenceStepScreen extends StatefulWidget {
  const PreferenceStepScreen({
    super.key,
    required this.step,
    this.selectedCountry,
    this.selectedCity,
    this.selectedBudget,
    this.selectedSafetyPriority,
    this.selectedSchoolPriority,
    this.selectedTransportPriority,
    this.selectedCommutePreference,
    this.selectedVibe,
  });

  final int step;
  final String? selectedCountry;
  final String? selectedCity;
  final String? selectedBudget;
  final String? selectedSafetyPriority;
  final String? selectedSchoolPriority;
  final String? selectedTransportPriority;
  final String? selectedCommutePreference;
  final String? selectedVibe;

  @override
  State<PreferenceStepScreen> createState() => _PreferenceStepScreenState();
}

class _PreferenceStepScreenState extends State<PreferenceStepScreen> {
  final TextEditingController _countrySearchController =
      TextEditingController();
  final TextEditingController _citySearchController = TextEditingController();

  bool _showCountrySearch = false;
  bool _showCitySearch = false;
  String? _selectedCountry;
  String? _selectedCity;
  String _selectedBudget = 'EUR5k';
  String _selectedSafetyPriority = 'Important';
  String _selectedSchoolPriority = 'Important';
  String _selectedTransportPriority = 'Important';
  String? _selectedCommutePreference;
  String? _selectedVibe;

  int get _safeStep {
    if (widget.step < 1) return 1;
    if (widget.step > _totalSteps) return _totalSteps;
    return widget.step;
  }

  @override
  void initState() {
    super.initState();
    _selectedCountry = widget.selectedCountry;
    _selectedCity = widget.selectedCity;
    if (widget.selectedBudget != null) {
      _selectedBudget = widget.selectedBudget!;
    }
    if (widget.selectedSafetyPriority != null) {
      _selectedSafetyPriority = widget.selectedSafetyPriority!;
    }
    if (widget.selectedSchoolPriority != null) {
      _selectedSchoolPriority = widget.selectedSchoolPriority!;
    }
    if (widget.selectedTransportPriority != null) {
      _selectedTransportPriority = widget.selectedTransportPriority!;
    }
    _selectedCommutePreference = widget.selectedCommutePreference;
    _selectedVibe = widget.selectedVibe;
  }

  @override
  void dispose() {
    _countrySearchController.dispose();
    _citySearchController.dispose();
    super.dispose();
  }

  List<String> get _filteredCountries {
    final String q = _countrySearchController.text.trim().toLowerCase();
    if (q.isEmpty) return _countries;
    return _countries.where((item) => item.toLowerCase().contains(q)).toList();
  }

  List<String> get _filteredCities {
    final String country = _selectedCountry ?? _countries.first;
    final List<String> cities = _citiesByCountry[country] ?? const [];
    final String q = _citySearchController.text.trim().toLowerCase();
    if (q.isEmpty) return cities;
    return cities.where((item) => item.toLowerCase().contains(q)).toList();
  }

  bool get _canContinue {
    if (_safeStep == 1) {
      return _selectedCountry != null && _selectedCity != null;
    }
    if (_safeStep == 2) {
      return _selectedBudget.isNotEmpty;
    }
    return true;
  }

  void _openCountrySearch() {
    setState(() {
      _showCountrySearch = !_showCountrySearch;
      _showCitySearch = false;
    });
  }

  void _openCitySearch() {
    setState(() {
      _selectedCountry ??= _countries.first;
      _showCitySearch = !_showCitySearch;
      _showCountrySearch = false;
    });
  }

  void _selectCountry(String country) {
    setState(() {
      _selectedCountry = country;
      _selectedCity = null;
      _showCountrySearch = false;
      _showCitySearch = false;
      _countrySearchController.clear();
      _citySearchController.clear();
    });
  }

  void _selectCity(String city) {
    setState(() {
      _selectedCountry ??= _countries.first;
      _selectedCity = city;
      _showCitySearch = false;
      _citySearchController.clear();
    });
  }

  void _onContinue() {
    if (_safeStep == 1 && !_canContinue) {
      Get.snackbar(
        'Missing selection',
        'Please select a country and a city to continue.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF1A2336),
        colorText: Colors.white,
      );
      return;
    }

    if (_safeStep < _totalSteps) {
      Get.to(
        () => PreferenceStepScreen(
          step: _safeStep + 1,
          selectedCountry: _selectedCountry,
          selectedCity: _selectedCity,
          selectedBudget: _selectedBudget,
          selectedSafetyPriority: _selectedSafetyPriority,
          selectedSchoolPriority: _selectedSchoolPriority,
          selectedTransportPriority: _selectedTransportPriority,
          selectedCommutePreference: _selectedCommutePreference,
          selectedVibe: _selectedVibe,
        ),
        preventDuplicates: false,
      );
      return;
    }

    Get.to(() => const AnalyzingTerritoriesScreen(), preventDuplicates: false);
  }

  @override
  Widget build(BuildContext context) {
    final _StepMeta meta = _metaForStep(_safeStep);
    final double progress = _safeStep / _totalSteps;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(9),
                          onTap: Get.back,
                          child: Ink(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8EDF4),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 18,
                              color: Color(0xFF5A6174),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Step $_safeStep of $_totalSteps',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF6C7DA1),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Text(
                              'Your Preferences',
                              style: TextStyle(
                                fontSize: 23.5,
                                color: Color(0xFF11131A),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(99),
                      child: SizedBox(
                        height: 8,
                        child: Stack(
                          children: [
                            Container(color: const Color(0xFFE8E8EB)),
                            FractionallySizedBox(
                              widthFactor: progress,
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: AppColors.primaryGradient,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: meta.iconBackground,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(meta.icon, color: meta.iconColor, size: 30),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      meta.title,
                      style: const TextStyle(
                        fontSize: 21.5,
                        color: Color(0xFF11131A),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      meta.subtitle,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color(0xFF67779B),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _buildStepBody(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
              child: _WizardBottom(
                text: _safeStep == _totalSteps
                    ? 'Generate Recommendations'
                    : 'Continue',
                onTap: _onContinue,
                enabled: _canContinue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepBody() {
    switch (_safeStep) {
      case 1:
        return _buildCountryAndCityStep();
      case 2:
        return BudgetStep(
          selectedBudget: _selectedBudget,
          onSelectBudget: (value) {
            setState(() {
              _selectedBudget = value;
            });
          },
        );
      case 3:
        return SafetyPriorityStep(
          selectedPriority: _selectedSafetyPriority,
          onSelectPriority: (value) {
            setState(() {
              _selectedSafetyPriority = value;
            });
          },
        );
      case 4:
        return SchoolsEducationStep(
          selectedPriority: _selectedSchoolPriority,
          onSelectPriority: (value) {
            setState(() {
              _selectedSchoolPriority = value;
            });
          },
        );
      case 5:
        return TransportAccessStep(
          selectedPriority: _selectedTransportPriority,
          onSelectPriority: (value) {
            setState(() {
              _selectedTransportPriority = value;
            });
          },
        );
      case 6:
        return CommutePreferenceStep(
          selectedCommute: _selectedCommutePreference,
          onSelectCommute: (value) {
            setState(() {
              _selectedCommutePreference = value;
            });
          },
        );
      case 7:
        return AreaVibeStep(
          showSummary: true,
          selectedVibe: _selectedVibe,
          onSelectVibe: (value) {
            setState(() {
              _selectedVibe = value;
            });
          },
          selectedCountry: _selectedCountry,
          selectedCity: _selectedCity,
          selectedBudget: _selectedBudget,
          selectedSafetyPriority: _selectedSafetyPriority,
          selectedSchoolPriority: _selectedSchoolPriority,
          selectedTransportPriority: _selectedTransportPriority,
          selectedCommutePreference: _selectedCommutePreference,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildCountryAndCityStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SelectionField(
          value: _selectedCountry ?? 'select A country',
          onTap: _openCountrySearch,
        ),
        if (_showCountrySearch) ...[
          const SizedBox(height: 12),
          _SearchSuggestionPanel(
            controller: _countrySearchController,
            hint: 'Search country',
            suggestions: _filteredCountries,
            onChanged: (_) => setState(() {}),
            onSelect: _selectCountry,
          ),
        ],
        const SizedBox(height: 14),
        const Text(
          'Select city',
          style: TextStyle(
            fontSize: 17,
            color: Color(0xFF11131A),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        _SelectionField(
          value: _selectedCity ?? 'select A city',
          onTap: _openCitySearch,
        ),
        if (_showCitySearch) ...[
          const SizedBox(height: 12),
          _SearchSuggestionPanel(
            controller: _citySearchController,
            hint: 'Search city',
            suggestions: _filteredCities,
            onChanged: (_) => setState(() {}),
            onSelect: _selectCity,
          ),
        ],
        const SizedBox(height: 18),
        const Text(
          'Popular cities',
          style: TextStyle(
            fontSize: 19.5,
            color: Color(0xFF11131A),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        _CityChipRows(selectedCity: _selectedCity, onSelect: _selectCity),
      ],
    );
  }
}

class _SelectionField extends StatelessWidget {
  const _SelectionField({required this.value, required this.onTap});

  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Ink(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF6F85B2)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 17.5,
                  color: Color(0xFF6E7D9E),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              size: 24,
              color: Color(0xFF6E7D9E),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchSuggestionPanel extends StatelessWidget {
  const _SearchSuggestionPanel({
    required this.controller,
    required this.hint,
    required this.suggestions,
    required this.onChanged,
    required this.onSelect,
  });

  final TextEditingController controller;
  final String hint;
  final List<String> suggestions;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD0D7E4)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                const Icon(
                  Icons.search_rounded,
                  size: 18,
                  color: Color(0xFF6B7A97),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: controller,
                    onChanged: onChanged,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFF6B7A97),
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: const TextStyle(
                        fontSize: 17.5,
                        color: Color(0xFF6B7A97),
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                const Icon(
                  Icons.location_on_outlined,
                  size: 22,
                  color: Color(0xFF6B7A97),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFDCE0E8)),
          if (suggestions.isEmpty)
            const Padding(
              padding: EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'No results found',
                  style: TextStyle(fontSize: 16, color: Color(0xFF6B7A97)),
                ),
              ),
            )
          else
            ...suggestions.map(
              (suggestion) => InkWell(
                onTap: () => onSelect(suggestion),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    border: suggestion != suggestions.last
                        ? const Border(
                            bottom: BorderSide(color: Color(0xFFE0E4EB)),
                          )
                        : null,
                  ),
                  child: Text(
                    suggestion,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFF0D79A8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _CityChipRows extends StatelessWidget {
  const _CityChipRows({required this.selectedCity, required this.onSelect});

  final String? selectedCity;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _CityChip(
                'Lisbon',
                selected: selectedCity == 'Lisbon',
                onTap: onSelect,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _CityChip(
                'Porto',
                selected: selectedCity == 'Porto',
                onTap: onSelect,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _CityChip(
                'Braga',
                selected: selectedCity == 'Braga',
                onTap: onSelect,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _CityChip(
                'Faro',
                selected: selectedCity == 'Faro',
                onTap: onSelect,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _CityChip(
                'Setubal',
                selected: selectedCity == 'Setubal',
                onTap: onSelect,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _CityChip(
                'Coimbra',
                selected: selectedCity == 'Coimbra',
                onTap: onSelect,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _CityChip(
                'Aveiro',
                selected: selectedCity == 'Aveiro',
                onTap: onSelect,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }
}

class _CityChip extends StatelessWidget {
  const _CityChip(this.city, {required this.selected, required this.onTap});

  final String city;
  final bool selected;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => onTap(city),
      child: Container(
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: selected ? AppColors.primaryGradient : null,
          color: selected ? null : const Color(0xFFF6F7F9),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? Colors.transparent : const Color(0xFFD9DEE8),
          ),
        ),
        child: Text(
          city,
          style: TextStyle(
            fontSize: 17,
            color: selected ? Colors.white : const Color(0xFF6C7A97),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _WizardBottom extends StatelessWidget {
  const _WizardBottom({
    required this.text,
    required this.onTap,
    required this.enabled,
  });

  final String text;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap: onTap,
      text: text,
      gradient: AppColors.primaryGradient,
      enabled: enabled,
      suffixIcon: text == 'Continue'
          ? const Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
              size: 24,
            )
          : null,
    );
  }
}

class _StepMeta {
  const _StepMeta({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
}

_StepMeta _metaForStep(int step) {
  switch (step) {
    case 1:
      return const _StepMeta(
        title: 'Select country',
        subtitle: 'Choose country and city to explore',
        icon: Icons.public,
        iconColor: Color(0xFF1F63B4),
        iconBackground: Color(0xFFDCE4F0),
      );
    case 2:
      return const _StepMeta(
        title: 'Monthly budget',
        subtitle: 'For rent and living costs',
        icon: Icons.attach_money_rounded,
        iconColor: Color(0xFFF2A000),
        iconBackground: Color(0xFFF3E8D6),
      );
    case 3:
      return const _StepMeta(
        title: 'Safety priority',
        subtitle: 'How important is safety in your area?',
        icon: Icons.shield_outlined,
        iconColor: Color(0xFF24A65D),
        iconBackground: Color(0xFFDDECE5),
      );
    case 4:
      return const _StepMeta(
        title: 'Schools and Education',
        subtitle: 'How important are schools near you?',
        icon: Icons.school_outlined,
        iconColor: Color(0xFF1F63B4),
        iconBackground: Color(0xFFDCE4F0),
      );
    case 5:
      return const _StepMeta(
        title: 'Transport access',
        subtitle: 'How important is public transport?',
        icon: Icons.directions_transit_outlined,
        iconColor: Color(0xFF2AAEA4),
        iconBackground: Color(0xFFD8ECEB),
      );
    case 6:
      return const _StepMeta(
        title: 'Commute preference',
        subtitle: 'How do you prefer to get around?',
        icon: Icons.work_outline_rounded,
        iconColor: Color(0xFF2AAEA4),
        iconBackground: Color(0xFFD8ECEB),
      );
    case 7:
      return const _StepMeta(
        title: 'Area vibe',
        subtitle: 'Quiet residential or lively urban?',
        icon: Icons.volume_up_outlined,
        iconColor: Color(0xFF2AAEA4),
        iconBackground: Color(0xFFD8ECEB),
      );
    default:
      return const _StepMeta(
        title: 'Area vibe',
        subtitle: 'Review your profile and generate recommendations',
        icon: Icons.volume_up_outlined,
        iconColor: Color(0xFF2AAEA4),
        iconBackground: Color(0xFFD8ECEB),
      );
  }
}
