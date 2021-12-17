# mobil_client

A new Flutter project.

## Getting Started

<!-- web打包 -->
flutter build web --web-renderer html 
<!-- 打包apk -->
flutter build apk --no-tree-shake-icons --no-sound-null-safety
<!-- 打包不同架构apk -->
flutter build apk --no-tree-shake-icons --target-platform android-arm,android-arm64,android-x64 --split-per-abi

<!-- model生成.g.dart文件 -->
(1)一次性编译： flutter packages pub run build_runner build
(2)后台自动编译： flutter packages pub run build_runner watch
flutter packages pub run build_runner clean
flutter packages pub run build_runner build --delete-conflicting-outputs
<!-- json_serializable 自动生成工具： -->
https://caijinglong.github.io/json2dart/index.html
<!-- 适配 -->
import 'package:flutter_screenutil/flutter_screenutil.dart';
<!-- 运行web -->
flutter run -d chrome --web-port=8080 --web-hostname=127.0.0.1
<!-- 测试下载地址 -->
http://hcm2q.gyxza3.yjruhu.com/a31/rj_cf1/juyc.apk

 pod install --repo-update