import 'package:soul_space/core/config/assets/app_vectors.dart';
import 'package:soul_space/features/onboarding/domain/models/onboarding_content.dart';

class OnboardingContentList {
  List<OnboardingContent> onboardingContent = [
    OnboardingContent(
      title: "Begin Your Journey",
      description:
          "Begin your path to better mental health with SOUL SPACE. Our personalized assessments and insights will help you understand your emotions and guide you toward a healthier, more balanced mindset",
      vectorPath: AppVectors.sapiensStanding,
    ),
    OnboardingContent(
      title: "Take the First Step",
      description:
          "Soul Space is here to guide you every step of the way. Through simple, interactive assessments and customized recommendations, we’ll help you uncover your mental health patterns and empower you to make positive changes. Let’s get started on the path to emotional resilience!",
      vectorPath: AppVectors.sapiensRunning,
    ),
    OnboardingContent(
      title: "Empower Your Mind",
      description:
          "Welcome aboard! SOUL SPACE offers a comprehensive, easy-to-use platform to assess, track, and improve your mental health. Our goal is to support you in understanding your mind and cultivating lasting emotional well-being. Let’s explore your inner strength!",
      vectorPath: AppVectors.sapiensCycling,
    ),
  ];
}
