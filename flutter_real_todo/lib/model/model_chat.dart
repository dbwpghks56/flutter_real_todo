import 'package:get/get.dart';

class RxChatModel {
  final id = 0.obs;
  final chatRoomId = 0.obs;
  final memberId = 0.obs;
  final message = "".obs;
  final region = "".obs;
  final regDate = [].obs;
}

class ChatModel {
  ChatModel(id, chatRoomId, memberId, message, region, regDate);

  final rx = RxChatModel();

  get id => rx.id.value;
  set id(value) => rx.id.value = value;

  get chatRoomId => rx.chatRoomId.value;
  set chatRoomId(value) => rx.chatRoomId.value = value;

  get memberId => rx.memberId.value;
  set memberId(value) => rx.memberId.value = value;

  get message => rx.message.value;
  set message(value) => rx.message.value = value;

  get region => rx.region.value;
  set region(value) => rx.region.value = value;

  get regDate => rx.regDate.value;
  set regDate(value) => rx.regDate.value = value;

}
