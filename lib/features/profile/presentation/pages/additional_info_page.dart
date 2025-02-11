import 'package:flutter/material.dart';
import 'package:soul_space/components/rounded_icon_button.dart';
import 'package:soul_space/features/profile/data/datasources/choose_additional_info.dart';
import 'package:soul_space/features/profile/presentation/pages/profile_page.dart';

class AdditionalInfoPage extends StatefulWidget {
  const AdditionalInfoPage({super.key});

  @override
  State<AdditionalInfoPage> createState() => _AdditionalInfoPageState();
}

class _AdditionalInfoPageState extends State<AdditionalInfoPage> {
  final List<Widget> chooseadditionalInfo =
      ChooseAdditionalInfo().chooseAdditionalInfo;
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: PageView.builder(
                    itemCount: chooseadditionalInfo.length,
                    onPageChanged: (value) {
                      setState(() {
                        currentindex = value;
                      });
                    },
                    controller: pageController,
                    itemBuilder: (context, index) {
                      return chooseadditionalInfo[index];
                    }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedIconButton(
                  icon: Icons.arrow_forward_outlined,
                  onTap: () {
                    if (currentindex < chooseadditionalInfo.length - 1) {
                      pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
