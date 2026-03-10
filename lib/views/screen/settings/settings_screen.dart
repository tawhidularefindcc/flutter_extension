import 'package:flutter/material.dart';
import 'package:flutter_extension/helper/route_helper.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

enum _SettingsPage {
  main,
  privacyExplanation,
  dataDisclaimer,
  privacyPolicy,
  helpFaq,
  sendFeedback,
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  _SettingsPage _currentPage = _SettingsPage.main;

  bool _darkMode = true;
  bool _pushNotifications = true;
  bool _anonymousAnalytics = true;

  int _rating = 1;
  String _selectedCategory = 'Data issue';
  final TextEditingController _feedbackController = TextEditingController();
  final List<bool> _expandedFaq = List<bool>.filled(7, false);

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F7),
      body: Column(
        children: [
          if (_currentPage == _SettingsPage.main) _buildMainHeader(),
          if (_currentPage != _SettingsPage.main)
            _SubHeader(
              title: _titleForPage(_currentPage),
              onBack: () => setState(() => _currentPage = _SettingsPage.main),
            ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 26.h),
              child: _buildPageBody(),
            ),
          ),
        ],
      ),
    );
  }

  String _titleForPage(_SettingsPage page) {
    switch (page) {
      case _SettingsPage.privacyExplanation:
        return 'Privacy Explanation';
      case _SettingsPage.dataDisclaimer:
        return 'Data Source Disclaimer';
      case _SettingsPage.privacyPolicy:
        return 'Privacy Policy';
      case _SettingsPage.helpFaq:
        return 'Help & FAQ';
      case _SettingsPage.sendFeedback:
        return 'Send Feedback';
      case _SettingsPage.main:
        return 'Settings';
    }
  }

  Widget _buildPageBody() {
    switch (_currentPage) {
      case _SettingsPage.main:
        return _buildMainSettingsBody();
      case _SettingsPage.privacyExplanation:
      case _SettingsPage.privacyPolicy:
        return _buildPrivacyContent();
      case _SettingsPage.dataDisclaimer:
        return _buildDataDisclaimerContent();
      case _SettingsPage.helpFaq:
        return _buildHelpFaqContent();
      case _SettingsPage.sendFeedback:
        return _buildFeedbackContent();
    }
  }

  Widget _buildMainHeader() {
    final double topInset = MediaQuery.paddingOf(context).top;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, topInset + 10.h, 16.w, 22.h),
      decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
      child: Column(
        children: [
          Row(
            children: [
              _HeaderBackButton(
                onTap: () async {
                  final bool popped = await Navigator.of(context).maybePop();
                  if (!popped && mounted) {
                    setState(() {});
                  }
                },
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Settings',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Preferences & privacy',
                      style: TextStyle(
                        color: const Color(0xCCFFFFFF),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.bookmark_rounded, color: Colors.white, size: 24.sp),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 10.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F4FA),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: const Color(0xFFD3DBE7)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 42.w,
                      height: 42.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDDE5F0),
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Icon(
                        Icons.person_outline_rounded,
                        size: 18.sp,
                        color: const Color(0xFF556786),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Guest User',
                            style: TextStyle(
                              color: const Color(0xFF11131A),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Data stored locally',
                            style: TextStyle(
                              color: const Color(0xFF6E7C98),
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(8.r),
                      onTap: () => Get.toNamed(AppRoutes.signInScreen),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.w,
                          vertical: 2.h,
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/settings_signin.svg',
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Sign In',
                              style: TextStyle(
                                color: const Color(0xFF1084B2),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Container(height: 1, color: const Color(0xFFD2DBE7)),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Want to sync across devices?',
                        style: TextStyle(
                          color: const Color(0xFF647492),
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(8.r),
                      onTap: () => Get.toNamed(AppRoutes.signInScreen),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.w,
                          vertical: 2.h,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Create account',
                              style: TextStyle(
                                color: const Color(0xFF1084B2),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: const Color(0xFF1084B2),
                              size: 16.sp,
                            ),
                          ],
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
    );
  }

  Widget _buildMainSettingsBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Appearance & Language'),
        _settingsCard(
          children: [
            _settingsRow(
              icon: 'language',
              iconColor: const Color(0xFF286BC4),
              iconBg: const Color(0xFFE4EAF4),
              title: 'Language',
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'English (US)',
                    style: TextStyle(
                      color: const Color(0xFF11131A),
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: const Color(0xFF11131A),
                    size: 18.sp,
                  ),
                ],
              ),
            ),
            _rowDivider(),
            _settingsRow(
              icon: 'theme',
              iconColor: const Color(0xFF286BC4),
              iconBg: const Color(0xFFE4EAF4),
              title: 'Dark mode',
              trailing: _buildCupertinoSwitch(
                value: _darkMode,
                onChanged: (value) => setState(() => _darkMode = value),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        _sectionTitle('Notifications'),
        _settingsCard(
          children: [
            _settingsRow(
              icon: 'notification',
              iconColor: const Color(0xFF2AA39D),
              iconBg: const Color(0xFFE3F0F0),
              title: 'Push notifications',
              trailing: _buildCupertinoSwitch(
                value: _pushNotifications,
                onChanged: (value) =>
                    setState(() => _pushNotifications = value),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        _sectionTitle('Privacy & Data'),
        _settingsCard(
          children: [
            _settingsRow(
              icon: 'privacy_explain',
              iconColor: const Color(0xFF2AA862),
              iconBg: const Color(0xFFE4EFEA),
              title: 'Privacy explanation',
              trailing: _trailingTextButton('Read'),
              onTap: () => setState(
                () => _currentPage = _SettingsPage.privacyExplanation,
              ),
            ),
            _rowDivider(),
            _settingsRow(
              icon: 'datasource',
              iconColor: const Color(0xFF2E6CB9),
              iconBg: const Color(0xFFE4EAF4),
              title: 'Data source disclaimer',
              trailing: _trailingTextButton('Read'),
              onTap: () =>
                  setState(() => _currentPage = _SettingsPage.dataDisclaimer),
            ),
            _rowDivider(),
            _settingsRow(
              icon: 'privacy_policy',
              iconColor: const Color(0xFF74849E),
              iconBg: const Color(0xFFE4EAF4),
              title: 'Privacy Policy',
              trailing: _trailingTextButton('Read'),
              onTap: () =>
                  setState(() => _currentPage = _SettingsPage.privacyPolicy),
            ),
            _rowDivider(),
            _settingsRow(
              icon: 'anonymous',
              iconColor: const Color(0xFF2AA39D),
              iconBg: const Color(0xFFE3F0F0),
              title: 'Anonymous analytics',
              subtitle: 'Help improve the app',
              trailing: _buildCupertinoSwitch(
                value: _anonymousAnalytics,
                onChanged: (value) =>
                    setState(() => _anonymousAnalytics = value),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        _sectionTitle('Support'),
        _settingsCard(
          children: [
            _settingsRow(
              icon: 'faq',
              iconColor: const Color(0xFF2AA39D),
              iconBg: const Color(0xFFE3F0F0),
              title: 'Help & FAQ',
              trailing: _trailingTextButton('Open'),
              onTap: () => setState(() => _currentPage = _SettingsPage.helpFaq),
            ),
            _rowDivider(),
            _settingsRow(
              icon: 'feedback',
              iconColor: const Color(0xFFF0A11E),
              iconBg: const Color(0xFFF6EEE0),
              title: 'Send feedback',
              trailing: _trailingTextButton('Open'),
              onTap: () =>
                  setState(() => _currentPage = _SettingsPage.sendFeedback),
            ),
            _rowDivider(),
            _settingsRow(
              icon: 'about',
              iconColor: const Color(0xFF6F809D),
              iconBg: const Color(0xFFE4EAF4),
              title: 'About TuacasaAqui',
              trailing: _trailingTextButton('v1.0.0'),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
          decoration: BoxDecoration(
            color: const Color(0xFFDDE3ED),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            'All territorial data is sourced from official national statistics and government databases. Scores are macro-level indicators and should not replace professional advice.',
            style: TextStyle(
              color: const Color(0xFF677799),
              fontSize: 16.sp,
              height: 1.2,
            ),
          ),
        ),
        SizedBox(height: 120.h),
        _dangerButton(
          text: 'Log Out',
          icon: 'assets/icons/logout.svg',
          color: const Color(0xFFE21B1B),
          textColor: Colors.white,
        ),
        SizedBox(height: 12.h),
        _dangerButton(
          text: 'Account Delate',
          icon: null,
          color: const Color(0xFFE3E7ED),
          textColor: const Color(0xFFE21B1B),
        ),
      ],
    );
  }

  Widget _buildPrivacyContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _noteCard(),
        SizedBox(height: 14.h),
        _plainParagraph(
          'TuacasaAqui is built on a privacy-by-design foundation.',
        ),
        SizedBox(height: 10.h),
        _boldLeadParagraph(
          lead: 'What we collect (Guest mode)',
          text: 'Nothing. All data stays on your device.',
        ),
        SizedBox(height: 14.h),
        _boldLeadParagraph(
          lead: 'What we collect (Signed-in)',
          text:
              'Email address for authentication • Your saved zones, guides, and wizard answers — synced to your account',
        ),
        SizedBox(height: 14.h),
        _boldLeadParagraph(
          lead: 'What we never do',
          text:
              'We never sell your data • We never track your location in the background • We never share data with advertisers',
        ),
        SizedBox(height: 14.h),
        _boldLeadParagraph(
          lead: 'Third-party services',
          text:
              'Analytics are anonymised and aggregated. No personally identifiable data is shared with third parties.',
        ),
        SizedBox(height: 14.h),
        _boldLeadParagraph(
          lead: 'Data retention',
          text:
              'You can delete your account at any time and all data will be permanently erased within 30 days.',
        ),
      ],
    );
  }

  Widget _buildDataDisclaimerContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _noteCard(),
        SizedBox(height: 14.h),
        _plainParagraph(
          'All territorial data used in TuacasaAqui comes from official, publicly available sources.',
        ),
        SizedBox(height: 14.h),
        _boldLeadParagraph(
          lead: 'Primary sources',
          text:
              'National Statistics Institutes (INE, INE-ES, Destatis, INSEE, ISTAT) • Eurostat regional statistics • Municipal government open-data portals • Ministry of Education school density data • Ministry of Transport public-transit coverage data',
        ),
        SizedBox(height: 14.h),
        _boldLeadParagraph(
          lead: 'Update frequency',
          text:
              'We never sell your data • We never track your location in the background • We never share data with advertisers',
        ),
        SizedBox(height: 14.h),
        _boldLeadParagraph(
          lead: 'Important disclaimer',
          text:
              'KPI scores are macro-level indicators calculated at the district or parish level. They represent statistical averages and should not replace professional advice — including that of licensed real-estate agents, lawyers, or financial advisors.',
        ),
        SizedBox(height: 14.h),
        _boldLeadParagraph(
          lead: 'Data retention',
          text:
              'You can delete your account at any time and all data will be permanently erased within 30 days.',
        ),
        SizedBox(height: 14.h),
        _plainParagraph(
          'TuacasaAqui does not endorse any specific neighbourhood or property.',
        ),
      ],
    );
  }

  Widget _buildHelpFaqContent() {
    const List<String> questions = [
      'Is TuacasaAqui free to use?',
      'Where does the data come from?',
      'Where does the data come from?',
      'Does the app store my personal data?',
      'How are fit scores calculated?',
      'Can I export my results?',
      'How do I delete my account and data?',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: const Color(0xFFE4F1E7),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFCEE3D2)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 17.sp,
                color: const Color(0xFF32B05A),
              ),
              SizedBox(width: 4.w),
              Text(
                'Frequently asked questions about TuacasaAqui.',
                style: TextStyle(
                  color: const Color(0xFF657595),
                  fontSize: 17 / 2,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        ...List<Widget>.generate(questions.length, (index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: _faqTile(
              question: questions[index],
              expanded: _expandedFaq[index],
              onTap: () => setState(() {
                _expandedFaq[index] = !_expandedFaq[index];
              }),
            ),
          );
        }),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F5F7),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFD4DAE4)),
          ),
          child: Text(
            'Still need help? support@tuacasaaqui.com',
            style: TextStyle(
              color: const Color(0xFF737373),
              fontSize: 18 / 2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeedbackContent() {
    const List<String> categories = [
      'Bug report',
      'Feature request',
      'Data issue',
      'UX feedback',
      'Other',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How would you rate TuacasaAqui?',
          style: TextStyle(
            color: const Color(0xFF6F6F6F),
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: List<Widget>.generate(5, (index) {
            final bool selected = _rating > index;
            return InkWell(
              onTap: () => setState(() => _rating = index + 1),
              child: Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: Icon(
                  Icons.star_rounded,
                  size: 35 / 2,
                  color: selected
                      ? const Color(0xFFE6C334)
                      : const Color(0xFFD2D5DB),
                ),
              ),
            );
          }),
        ),
        SizedBox(height: 12.h),
        Text(
          'Category',
          style: TextStyle(
            color: const Color(0xFF11131A),
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 10.w,
          runSpacing: 8.h,
          children: categories.map((category) {
            final bool selected = _selectedCategory == category;
            return InkWell(
              borderRadius: BorderRadius.circular(8.r),
              onTap: () => setState(() => _selectedCategory = category),
              child: Container(
                width: category == 'Data issue'
                    ? 112.w
                    : category == 'Feature request'
                    ? 122.w
                    : 112.w,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  gradient: selected ? AppColors.primaryGradient : null,
                  color: selected ? null : const Color(0xFFF3F5F7),
                  border: Border.all(color: const Color(0xFFD5DBE5)),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: selected ? Colors.white : const Color(0xFF7787A4),
                    fontSize: 16 / 2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 12.h),
        Text(
          'Category',
          style: TextStyle(
            color: const Color(0xFF11131A),
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFD5DBE5)),
          ),
          child: TextField(
            controller: _feedbackController,
            maxLines: 6,
            decoration: InputDecoration(
              hintText: 'Tell us what you think...',
              hintStyle: TextStyle(
                color: const Color(0xFFB2B2B2),
                fontSize: 15.sp,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 10.h),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
          decoration: BoxDecoration(
            color: const Color(0xFFE4F1E7),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFCEE3D2)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 17.sp,
                color: const Color(0xFF32B05A),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  'Please add a rating, category, and message to continue.',
                  style: TextStyle(
                    color: const Color(0xFF657595),
                    fontSize: 17 / 2,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: () {},
          child: Ink(
            width: double.infinity,
            height: 60.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              gradient: AppColors.primaryGradient,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.send_outlined, color: Colors.white, size: 20.sp),
                SizedBox(width: 10.w),
                Text(
                  'Send feedback',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28 / 2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _faqTile({
    required String question,
    required bool expanded,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFD0D8E2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    question,
                    style: TextStyle(
                      color: const Color(0xFF11131A),
                      fontSize: 34 / 2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Icon(
                  expanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  size: 20.sp,
                  color: const Color(0xFF11131A),
                ),
              ],
            ),
            if (expanded) ...[
              SizedBox(height: 8.h),
              Text(
                'This answer will be added in final content.',
                style: TextStyle(
                  color: const Color(0xFF677799),
                  fontSize: 15 / 2,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _plainParagraph(String text) {
    return Text(
      text,
      style: TextStyle(
        color: const Color(0xFF5E5E5E),
        fontSize: 18 / 2,
        height: 1.45,
      ),
    );
  }

  Widget _boldLeadParagraph({required String lead, required String text}) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: const Color(0xFF5E5E5E),
          fontSize: 18 / 2,
          height: 1.45,
        ),
        children: [
          TextSpan(
            text: '$lead ',
            style: const TextStyle(
              color: Color(0xFF11131A),
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(text: text),
        ],
      ),
    );
  }

  Widget _noteCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8FA),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFD4DAE4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30.w,
            height: 30.w,
            decoration: BoxDecoration(
              color: const Color(0xFFE4EFEA),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.shield_outlined,
              color: const Color(0xFF2AA862),
              size: 16.sp,
            ),
          ),
          SizedBox(width: 10.w),
          const Expanded(
            child: Text(
              'This document explains how TuacasaAqui handles your data and sources its information.',
              style: TextStyle(
                color: Color(0xFF666666),
                fontSize: 18 / 2,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _trailingTextButton(String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: TextStyle(
            color: const Color(0xFF11131A),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 2.w),
        Icon(
          Icons.arrow_forward_ios_rounded,
          size: 12.sp,
          color: const Color(0xFF11131A),
        ),
      ],
    );
  }

  Widget _dangerButton({
    required String text,
    required String? icon,
    required Color color,
    required Color textColor,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: () {},
      child: Ink(
        width: double.infinity,
        height: 54.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              SvgPicture.asset(icon, height: 23.sp),
              SizedBox(width: 8.w),
            ],
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCupertinoSwitch({
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SizedBox(
      height: 28.h,
      child: FittedBox(
        child: Switch(
          value: value,
          activeTrackColor: const Color(0xFF15C357),
          inactiveTrackColor: const Color(0xFFCBD5E1),
          inactiveThumbColor: Colors.white,
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _rowDivider() {
    return Container(height: 1, color: const Color(0xFFD4DAE4));
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        text,
        style: TextStyle(
          color: const Color(0xFF11131A),
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _settingsCard({required List<Widget> children}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FB),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFD0D8E2)),
      ),
      child: Column(children: children),
    );
  }

  Widget _settingsRow({
    required String icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    Widget? trailing,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(14.r),
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
        child: Row(
          children: [
            Image.asset(
              'assets/icons/settings_$icon.png',
              width: 36.w,
              height: 36.w,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: const Color(0xFF11131A),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: const Color(0xFF6D7C98),
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }
}

class _SubHeader extends StatelessWidget {
  const _SubHeader({required this.title, required this.onBack});

  final String title;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final double topInset = MediaQuery.paddingOf(context).top;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, topInset + 10.h, 16.w, 20.h),
      decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
      child: Row(
        children: [
          _HeaderBackButton(onTap: onBack),
          SizedBox(width: 12.w),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30 / 2,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderBackButton extends StatelessWidget {
  const _HeaderBackButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.r),
      onTap: onTap,
      child: Container(
        width: 34.w,
        height: 34.w,
        decoration: BoxDecoration(
          color: const Color(0xFFE7EDF4),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 16.sp,
          color: const Color(0xFF1A2A3E),
        ),
      ),
    );
  }
}
