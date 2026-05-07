import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/data/repositories/auth_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PersonalInformationViewModel extends Notifier<RegisteredUser?> {
  @override
  RegisteredUser? build() {
    final currentUser = ref.watch(authRepositoryProvider);
    return currentUser is RegisteredUser ? currentUser : null;
  }
}

final personalInformationViewModelProvider = NotifierProvider(
  PersonalInformationViewModel.new,
);
