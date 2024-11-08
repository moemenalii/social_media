abstract class registerState {}

class InitialState extends registerState{}

class LoadingRegisteState extends registerState{}

class SuccessRegisteState extends registerState{}

class ErorrRegisterState extends registerState{
  final error;
  ErorrRegisterState(this.error);

}


class SuccessCreatUserState extends registerState{
  final uId;

  SuccessCreatUserState(this.uId);
}

class ErorrCreatUserState extends registerState{
  final error;

  ErorrCreatUserState(this.error);
}
