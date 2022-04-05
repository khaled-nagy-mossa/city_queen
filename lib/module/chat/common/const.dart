import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ConstChatData {
  const ConstChatData();

  static const messagesPaginationLimit = 20;

  ///collections names
  static const collectionName = 'chat';
  static const messagesCollectionName = 'conversation';

  ///fields names
  static const usersIdsField = 'users_ids';
  static const roomIdField = 'room_id';
  static const usersField = 'users';
  static const messageField = 'message';
  static const dateField = 'date';
  static const userIdField = 'user_id';
  static const finalMessageField = 'final_message';
  static const countField = 'count';
  static const idField = 'id';
  static const nameField = 'name';
  static const avatarField = 'avatar';

  /// an instance using the default [FirebaseApp].
  static final fireStore = FirebaseFirestore.instance;

  /// to return chat collection reference
  static final chatCollectionReference = fireStore.collection(
    ConstChatData.collectionName,
  );
}
