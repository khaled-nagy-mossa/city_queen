import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/config/api.dart';
import '../model/notification.dart';

class NotificationItem extends StatelessWidget {
  final UserNotification notification;
  final VoidCallback onDelete;

  const NotificationItem({
    @required this.notification,
    @required this.onDelete,
  })  : assert(notification != null),
        assert(onDelete != null);

  @override
  Widget build(BuildContext context) {
    try {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0.1,
              blurRadius: 7,
            ),
          ],
        ),
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: ListTile(
              leading: _leading(),
              title: Text(notification.title),
              subtitle: Text(notification.text),
              trailing: _trailing(),
            ),
          ),
        ),
      );
    } catch (e) {
      log('Exception in NotificationItem : $e');
      return const SizedBox();
    }
  }

  Widget _leading() {
    try {
      return Container(
        constraints: const BoxConstraints(
          maxHeight: 55.0,
          maxWidth: 55.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: const Color(0xFFF1F1F3),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(API.imageUrl(notification.image)),
          ),
        ),
      );
    } catch (e) {
      log('Exception in NotificationItem._leading : $e');
      return const SizedBox();
    }
  }

  Widget _trailing() {
    try {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat.jm().format(notification.sentDate),
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            DateFormat('yyyy-MM-dd').format(notification.sentDate),
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      );
    } catch (e) {
      log('Exception in NotificationItem._trailing : $e');
      return const SizedBox();
    }
  }
}
