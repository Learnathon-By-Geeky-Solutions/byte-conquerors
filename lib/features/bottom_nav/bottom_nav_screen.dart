import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_space/components/package_dependency_wrapper.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';
import 'package:soul_space/core/utils/app_dimens.dart';
import 'package:soul_space/features/feature_name/presentation/chat/screen/chat_page.dart';
import 'package:soul_space/features/feature_name/presentation/home/pages/home_page.dart';
import 'package:soul_space/gen/assets.gen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  static final globalKey = GlobalKey<_BottomNavScreenState>();

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 0;

  /// Screens list
  final List<Widget> _screens = const [
    HomeScreen(),
    ChatPage(),
    HomeScreen(),
    Placeholder()
  ];

  @override
  void initState() {
    super.initState();
  }

  /// Function to change tab dynamically
  void changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _screens[_currentIndex],
      bottomNavigationBar: Stack(
        children: [
          SizedBox(
            height: Platform.isAndroid ? AppDimens.height80 : null,
            child: Theme(
              data: Theme.of(context).copyWith(
                  splashFactory: NoSplash.splashFactory,
                  highlightColor: Colors.transparent),
              child: BottomNavigationBar(
                backgroundColor: AppColors.foundationWhite,
                type: BottomNavigationBarType.fixed,
                currentIndex: _currentIndex,
                selectedItemColor: AppColors.primaryColor.shade500,
                unselectedItemColor: AppColors.neutralColor.shade500,
                selectedLabelStyle: TextStyle(
                  color: AppColors.primaryColor.shade500,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
                unselectedLabelStyle: TextStyle(
                  color: AppColors.neutralColor.shade400,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
                onTap: (int index) {
                  _currentIndex = index;
                  setState(() {});
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Wrapper.setSVGImage(
                        imagePath: _currentIndex == 0
                            ? Assets.icons.navHomeSelected
                            : Assets.icons.navHomeUnselected,
                        height: AppDimens.height24,
                        width: AppDimens.height24,
                        colorFilter: ColorFilter.mode(
                            _currentIndex == 0
                                ? AppColors.primaryColor.shade500
                                : AppColors.neutralColor.shade600,
                            BlendMode.srcIn)),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Wrapper.setSVGImage(
                        imagePath: Assets.icons.navChatSelected,
                        height: AppDimens.height24,
                        width: AppDimens.height24,
                        colorFilter: ColorFilter.mode(
                            _currentIndex == 1
                                ? AppColors.primaryColor.shade500
                                : AppColors.neutralColor.shade600,
                            BlendMode.srcIn)),
                    label: 'Chat',
                  ),
                  BottomNavigationBarItem(
                    icon: Wrapper.setSVGImage(
                        imagePath: _currentIndex == 2
                            ? Assets.icons.navNewsSelected
                            : Assets.icons.navNewsUnselected,
                        height: AppDimens.height24,
                        width: AppDimens.height24,
                        colorFilter: ColorFilter.mode(
                            _currentIndex == 2
                                ? AppColors.primaryColor.shade500
                                : AppColors.neutralColor.shade600,
                            BlendMode.srcIn)),
                    label: 'News',
                  ),
                  BottomNavigationBarItem(
                    icon: Wrapper.setSVGImage(
                        imagePath: _currentIndex == 3
                            ? Assets.icons.navProfileSelected
                            : Assets.icons.navProfileUnselected,
                        height: AppDimens.height24,
                        width: AppDimens.height24,
                        colorFilter: ColorFilter.mode(
                            _currentIndex == 3
                                ? AppColors.primaryColor.shade500
                                : AppColors.neutralColor.shade600,
                            BlendMode.srcIn)),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: ((MediaQuery.of(context).size.width / 4 * _currentIndex) +
                AppDimens.radius17),
            width: AppDimens.width64,
            child: Container(
              height: AppDimens.height4,
              decoration: ShapeDecoration(
                color: AppColors.primaryColor.shade500,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(AppDimens.radius40),
                    bottomRight: Radius.circular(AppDimens.radius40),
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
