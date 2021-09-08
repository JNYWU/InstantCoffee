import 'package:readr_app/models/member.dart';

abstract class EditMemberContactInfoState {}

class EditMemberContactInfoInitState extends EditMemberContactInfoState {}

class MemberLoading extends EditMemberContactInfoState {}

class MemberLoaded extends EditMemberContactInfoState {
  final Member member;
  MemberLoaded({this.member});
}

class MemberLoadedError extends EditMemberContactInfoState {
  final error;
  MemberLoadedError({
    this.error,
  });
}