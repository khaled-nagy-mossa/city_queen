import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softgrow/util/app_localization.dart';

import 'common/app_bloc_observer.dart';
import 'common/assets/assets.dart';
import 'common/config/api.dart';
import 'common/const/app_data.dart';
import 'common/firebase/fcm.dart';
import 'common/firebase/firebase_core_helper.dart';
import 'common/firebase/local_notification.dart';
import 'common/service.dart';
import 'common/theme.dart';
import 'module/auth/auth_bloc_consumer.dart';
import 'module/auth/cubit/auth/cubit.dart';
import 'module/cart/cart_bloc_consumer.dart';
import 'module/cart/cubit/cart_cubit.dart';
import 'module/chat/cubit/chat/cubit.dart';
import 'module/chat/model/chat_user.dart';
import 'module/favourite/cubit/favourites_cubit.dart';
import 'module/favourite/favourite_bloc_consumer.dart';
import 'module/home/view/home.dart';
import 'module/profile/account_bloc_consumer.dart';
import 'module/profile/cubit/account/cubit.dart';
import 'module/splash_screen/view/check_internet_screen.dart';
import 'widget/internet_connection_listener.dart';
import 'package:get/get.dart';

String locale;

Future<void> main() async {
  AppService.turnOnEnhancedProtection();

  Bloc.observer = AppBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseCoreHelper.initial();

  await AppService.setupSystemChrome();

  final _auth = AuthCubit();

  FCM.setupBackgroundMessages();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  locale = sharedPreferences.getString("LANG") ?? 'en';

  runApp(MultiBlocProvider(providers: [
    BlocProvider.value(value: _auth),
    BlocProvider<CartCubit>(create: (context) {
      return CartCubit(authCubit: _auth);
    }),
    BlocProvider<FavouritesCubit>(create: (context) {
      return FavouritesCubit(authCubit: _auth);
    }),
    BlocProvider<AccountCubit>(create: (context) {
      return AccountCubit(authCubit: _auth);
    }),
    BlocProvider(
      create: (context) {
        final userData = AuthCubit.get(context)?.user?.data;
        return ChatCubit(
          chatUser: ChatUser(
            name: userData?.name,
            id: userData?.id?.toString(),
            avatar: API.imageUrl(userData?.avatar),
          ),
        );
      },
    ),
  ], child: const MyApp()));
  // Setting Locale from storage
}

class MyApp extends StatefulWidget {
  const MyApp();
  @override
  _MyAppState createState() => _MyAppState();
}

final _navigatorKey = GlobalKey<NavigatorState>();

class _MyAppState extends State<MyApp> {
  // use to change application language

  @override
  void initState() {
    super.initState();
    //use future and duration zero to use context --> don't use didChangeDependencies plz
    Future<void>.delayed(Duration.zero).then((value) {
      LocalNotificationService.initial(
          // _navigatorKey.currentState.overlay.context,
          );
      FCM.setupListener();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: _navigatorKey,
      title: AppData.appName,
      translations: Messages(),
      locale: Locale(locale),
      debugShowCheckedModeBanner: false,
      home: const StartViewInApplication(),
      builder: (context, widget) {
        return Builder(builder: (context) {
          if (Platform.isAndroid || Platform.isIOS) {
            return InternetConnectionListener(widget: widget);
          } else {
            return widget;
          }
        });
      },
      theme: AppTheme.light(),
    );
  }
}

///Update this StatelessWidget and change location
class StartViewInApplication extends StatelessWidget {
  const StartViewInApplication({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckInternetScreen(
      child: CartBlocConsumer(
        navigatorKey: _navigatorKey,
        child: AccountBlocConsumer(
          child: FavouriteBlocConsumer(
            navigatorKey: _navigatorKey,
            child: AuthBlocConsumer(
              allowUnauthorizedAccess: false,
              navigatorKey: _navigatorKey,
              child: const HomeView(),
            ),
          ),
        ),
      ),
    );
  }
}

///keytool -list -v -keystore "C:\Users\Shehab\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android
///   SHA1: BC:41:4A:05:6B:3C:5C:32:B5:57:04:2A:5C:A2:2D:1E:D9:E8:7F:39
///    SHA256: 84:A5:39:10:02:4A:DC:21:BE:FC:53:04:42:33:67:D6:79:4B:3C:71:D4:7F:A7:63:0B:16:3D:6B:C1:0B:00:16
///Signature algorithm name: SHA1withR
