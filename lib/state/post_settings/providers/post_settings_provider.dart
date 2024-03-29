import 'package:hooks_riverpod/hooks_riverpod.dart';


import '../models/post_setting.dart';
import '../notifiers/post_settings_notifier.dart';

final postSettingProvider =
    StateNotifierProvider<PostSettingNotifier, Map<PostSetting, bool>>(
  (ref) => PostSettingNotifier(),
);
