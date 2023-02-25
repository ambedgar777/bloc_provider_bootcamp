import 'package:bloc_provider_bootcamp/logic/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  final String title;
  final Color color;

  const SettingsScreen({super.key, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Screen'),
      ),
      body: BlocListener<SettingsCubit, SettingsState>(
        listener: (context, state) {
          final notificationSnackBar = SnackBar(
            duration: const Duration(milliseconds: 700),
            content: Text(
              'App ${state.appNotifications.toString().toUpperCase()} Email ${state.emailNotifications.toString().toUpperCase()}',
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(notificationSnackBar);
        },
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return Column(
              children: [
                SwitchListTile(
                  value: state.appNotifications,
                  onChanged: (newValue) {
                    context
                        .read<SettingsCubit>()
                        .toggleAppNotifications(newValue);
                  },
                  title: const Text('App Notifications'),
                ),
                SwitchListTile(
                  value: state.emailNotifications,
                  onChanged: (newValue) {
                    context
                        .read<SettingsCubit>()
                        .toggleEmailNotifications(newValue);
                  },
                  title: const Text('Email Notifications'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
