import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momnotebook/cubit/cubit/auth_cubit_cubit.dart';
import 'package:momnotebook/services/wrapper/on_wait.dart';
import 'package:momnotebook/widgets/add_baby/add_baby.dart';
import 'package:momnotebook/widgets/dashboard/home_dashboard.dart';
import 'package:momnotebook/widgets/splashScreen/splashScreen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubitCubit, AuthCubitState>(
      builder: (context, state) {
        if (state is AuthCubitInitial) {
          return OnWaitPage();
        } else if (state is AuthCubitNoUser) {
          return SplashScreen();
        } else if (state is AuthCubitNoBaby) {
          return AddBaby();
        } else if (state is AuthCubitUser) {
          return HomeDashboard();
        }
        return Container();
      },
    );
  }
}
