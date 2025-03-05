import 'package:flutter/widgets.dart';
import 'package:soul_space/features/profile/presentation/widgets/choose_gender.dart';
import 'package:soul_space/features/profile/presentation/widgets/choose_helptype.dart';
import 'package:soul_space/features/profile/presentation/widgets/choose_mood.dart';
import 'package:soul_space/features/profile/presentation/widgets/choose_sleephour.dart';

class ChooseAdditionalInfo {
  List<Widget> chooseAdditionalInfo = [
    ChooseGender(),
    ChooseMood(),
    ChooseSleephour(),
    ChooseHelptype(),
  ];
}
