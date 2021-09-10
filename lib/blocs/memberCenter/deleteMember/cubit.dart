import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readr_app/blocs/memberCenter/deleteMember/state.dart';
import 'package:readr_app/services/memberService.dart';

class DeleteMemberCubit extends Cubit<DeleteMemberState> {
  DeleteMemberCubit() : super(DeleteMemberInitState());

  void deleteMember() async {
    print('Get member details');
    emit(DeleteMemberLoading());
    FirebaseAuth auth = FirebaseAuth.instance;
    String token = await auth.currentUser.getIdToken();
    MemberService memberService = MemberService();
    bool deleteSuccess = await memberService.deleteMember(auth.currentUser.uid, token);
    if(deleteSuccess) {
      await auth.signOut();
      emit(DeleteMemberSuccess());
    } else {
      emit(DeleteMemberError());
    }
  }
}