import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/data/clrs.dart';
import 'app/routes/app_pages.dart';
import 'app/widgets/helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  ErrorWidget.builder = (details) => errorScreen(details);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: AppClrs.kFFFBF4,
            progressIndicatorTheme: ProgressIndicatorThemeData(
              color: AppClrs.k2B5374,
            ),
          ),
          title: "Health Guide",
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.INITIAL,
          builder: EasyLoading.init(),
          getPages: AppPages.routes,
        );
      },
    ); // dir
  }
}
