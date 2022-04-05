import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';

abstract class FirebaseCoreHelper {
  const FirebaseCoreHelper();

  static Future<String> initial() async {
    try {
      final result = await _initializeWithOptionsObject();

      if (result != null && result.isNotEmpty) {
        final res = await _defaultInitialize();

        if (res != null && res.isNotEmpty) throw res;
      }

      return null;
    } catch (e) {
      log('Exception in FirebaseCoreHelper.initial : $e');
      return e.toString();
    }
  }

  static const _name = 'Upsale';

  static FirebaseOptions get _firebaseOptions {
    return const FirebaseOptions(
      apiKey: 'AIzaSyANuEFWCUFVybUrNM8gmKsGY3tQOqUkO88',
      authDomain: 'upsale-1751c.firebaseapp.com',
      projectId: 'upsale-1751c',
      storageBucket: 'upsale-1751c.appspot.com',
      messagingSenderId: '409998046026',
      appId: '1:409998046026:web:ff2b7062e8275c3df687b3',
      measurementId: 'G-ZJ99YH3T9H',
    );
  }

  static Future<String> _initializeWithOptionsObject() async {
    try {
      final app =
          await Firebase.initializeApp(name: _name, options: _firebaseOptions);

      if (app == null) throw 'not initialized';

      return null;
    } catch (e) {
      log('Exception in FirebaseCoreHelper.initializeWithOptionsObject : $e');
      return e.toString();
    }
  }

  static Future<String> _defaultInitialize() async {
    try {
      final app = await Firebase.initializeApp();

      if (app == null) throw 'not initialized';

      return null;
    } catch (e) {
      log('Exception in FirebaseCoreHelper.defaultInitialize : $e');
      return e.toString();
    }
  }
}
