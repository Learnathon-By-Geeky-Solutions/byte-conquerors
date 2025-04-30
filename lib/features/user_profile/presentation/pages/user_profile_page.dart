// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../bloc/user_profile_bloc.dart';

// class UserProfilePage extends StatelessWidget {
//   const UserProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('User Profile')),
//       body: BlocBuilder<UserProfileBloc, UserProfileState>(
//         builder: (context, state) {
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 DropdownButton<String>(
//                   value: state.gender.isEmpty ? null : state.gender,
//                   hint: const Text('Select Gender'),
//                   onChanged: (value) {
//                     if (value != null) {
//                       context.read<UserProfileBloc>().add(UpdateGender(value));
//                     }
//                   },
//                   items: ['Male', 'Female', 'Other'].map((String gender) {
//                     return DropdownMenuItem<String>(
//                       value: gender,
//                       child: Text(gender),
//                     );
//                   }).toList(),
//                 ),
//                 DropdownButton<String>(
//                   value: state.helpType.isEmpty ? null : state.helpType,
//                   hint: const Text('Select Help Type'),
//                   onChanged: (value) {
//                     if (value != null) {
//                       context.read<UserProfileBloc>().add(UpdateHelpType(value));
//                     }
//                   },
//                   items: ['Therapy', 'Counseling', 'Advice'].map((String type) {
//                     return DropdownMenuItem<String>(
//                       value: type,
//                       child: Text(type),
//                     );
//                   }).toList(),
//                 ),
//                 DropdownButton<String>(
//                   value: state.mood.isEmpty ? null : state.mood,
//                   hint: const Text('Select Mood'),
//                   onChanged: (value) {
//                     if (value != null) {
//                       context.read<UserProfileBloc>().add(UpdateMood(value));
//                     }
//                   },
//                   items: ['😊', '😐', '😢'].map((String mood) {
//                     return DropdownMenuItem<String>(
//                       value: mood,
//                       child: Text(mood),
//                     );
//                   }).toList(),
//                 ),
//                 Slider(
//                   value: state.sleepHours.toDouble(),
//                   min: 0,
//                   max: 12,
//                   divisions: 12,
//                   label: '${state.sleepHours}h',
//                   onChanged: (value) {
//                     context.read<UserProfileBloc>().add(UpdateSleepHours(value.toInt()));
//                   },
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     context.read<UserProfileBloc>().add(SubmitProfile());
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Profile Submitted')),
//                     );
//                   },
//                   child: const Text('Submit'),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
