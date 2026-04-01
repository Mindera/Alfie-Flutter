import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/data/repositories/auth_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PersonalInformationViewModel extends Notifier<User?> {
  @override
  User? build() {
    return ref.watch(authRepositoryProvider);
  }
}

final personalInformationViewModelProvider = NotifierProvider(
  PersonalInformationViewModel.new,
);
