// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'OneShare';

  @override
  String get navShare => '分享';

  @override
  String get navWeb => '网页';

  @override
  String get navDownloading => '下载中';

  @override
  String get navSettings => '设置';

  @override
  String get navDownloads => '下载';

  @override
  String get trayShow => '显示 OneShare';

  @override
  String get trayExit => '退出';

  @override
  String get serviceTitle => 'OneShare 服务';

  @override
  String get serviceContent => '正在初始化 OneShare 后台服务';

  @override
  String get channelName => 'OneShare 前台服务';

  @override
  String get channelDescription => '此频道用于重要通知。';

  @override
  String get settingsLanguage => '语言';

  @override
  String get languageSystem => '系统默认';

  @override
  String get settingsAppearance => '外观';

  @override
  String get settingsDarkMode => '深色模式';

  @override
  String get settingsDarkModeSubtitle => '启用应用程序的深色主题';

  @override
  String get settingsAppFont => '应用字体';

  @override
  String get settingsFontUsageNotice => '字体使用须知';

  @override
  String get settingsFontUsageContent =>
      '亲爱的用户：\n\n此字体源自游戏《学园偶像大师》。\n\n这是来自 GitHub 项目 gakuen-imas-localify 的修改版字体，支持中文、日文、英文与其他语言。\n\n使用此字体无需开发者向万代南梦宫娱乐公司授权。\n\n本应用程序仅将此字体用于非商业目的；请谨慎选择。';

  @override
  String get cancel => '取消';

  @override
  String get confirm => '确认';

  @override
  String get settingsDownloads => '下载';

  @override
  String get settingsDownloadFolder => '下载文件夹';

  @override
  String get settingsNotSet => '未设置';

  @override
  String get settingsNetworkConnections => '网络连接';

  @override
  String get settingsAddConnection => '添加连接';

  @override
  String get settingsAddConnectionSubtitle =>
      '连接到 OpenList, SMB, SFTP 或 WebDAV';

  @override
  String get settingsNoNetworkConnections => '未添加网络连接。';

  @override
  String get settingsConnectionType => '类型';

  @override
  String get settingsConnectionName => '名称';

  @override
  String get settingsConnectionHost => '主机 (IP/域名)';

  @override
  String get settingsConnectionPort => '端口 (0 = 默认)';

  @override
  String get settingsConnectionPath => '路径 (远程)';

  @override
  String get settingsConnectionUsername => '用户名';

  @override
  String get settingsConnectionPassword => '密码';

  @override
  String get add => '添加';

  @override
  String get settingsAbout => '关于';

  @override
  String get settingsAboutOneShare => '关于 OneShare';

  @override
  String get settingsAboutSubtitle => '版本、开发者和许可证';

  @override
  String get required => '必填';

  @override
  String get welcomeSkip => '跳过';

  @override
  String get welcomeNext => '下一步';

  @override
  String get welcomeTitle => '欢迎使用 OneShare！';

  @override
  String welcomeVersion(String version) {
    return '版本 $version';
  }

  @override
  String get welcomeChooseLanguage => '选择您的首选语言';

  @override
  String get welcomeUseSystemLanguage => '使用系统语言';

  @override
  String welcomeCurrentLocale(String locale) {
    return '当前：$locale';
  }

  @override
  String get welcomeSelectLanguage => '选择语言';

  @override
  String get welcomeFeature1Title => '跨平台分享';

  @override
  String get welcomeFeature1Desc =>
      '在 Android、iOS、Windows、Linux 和 macOS 之间无缝传输文件。';

  @override
  String get welcomeFeature2Title => '多种协议';

  @override
  String get welcomeFeature2Desc => '支持 WebDAV、SSH/SFTP 和 SMB，实现灵活的文件管理。';

  @override
  String get welcomeFeature3Title => '响应式设计';

  @override
  String get welcomeFeature3Desc => '美观、自适应的界面，在移动端和桌面端都能完美运行。';

  @override
  String get welcomeAllSet => '设置完成！';

  @override
  String get welcomeSetupComplete => '您已完成设置。';

  @override
  String get welcomeSwipeUp => '上滑进入应用';

  @override
  String get welcomeClickToEnter => '按任意键或单击进入应用';

  @override
  String get welcomeWhatsNew => '更新内容';

  @override
  String get welcomeLogPerformance => '性能提升';

  @override
  String get welcomeLogBugFixes => '错误修复和稳定性增强';

  @override
  String get welcomeLogUI => '界面优化，提升用户体验';

  @override
  String get welcomeContinue => '继续';

  @override
  String get notifyChannelTextName => '文本消息';

  @override
  String get notifyChannelTextDesc => '接收到的文本消息通知';

  @override
  String get notifyChannelFileName => '文件传输';

  @override
  String get notifyChannelFileDesc => '文件传输请求通知';

  @override
  String notifyTitleText(String senderName) {
    return '$senderName 发送了一条消息';
  }

  @override
  String notifyTitleFile(String senderName) {
    return '$senderName 发送了一个文件请求';
  }

  @override
  String get notifyActionReject => '拒绝';

  @override
  String get notifyActionCopy => '复制';

  @override
  String get notifyActionShare => '分享';

  @override
  String get notifyActionAccept => '接收';

  @override
  String bubbleReceiveFile(String senderName) {
    return '接收来自 $senderName 的文件？';
  }

  @override
  String bubbleReceiveText(String senderName) {
    return '$senderName 发送了一条消息：';
  }

  @override
  String get bubbleAcceptSaveAs => '接收并另存为...';

  @override
  String get bubbleNoFiles => '无文件信息';

  @override
  String bubbleMoreFiles(int count) {
    return '+ $count 个更多文件';
  }

  @override
  String get bubbleCopied => '消息已复制到剪贴板';

  @override
  String get bubbleReject => '拒绝';

  @override
  String get settingsSound => '声音设置';

  @override
  String get settingsSoundSubtitle => '管理音效';

  @override
  String get soundDownloadComplete => '下载完成';

  @override
  String get soundDownloadFailed => '下载失败';

  @override
  String get soundError => '错误';

  @override
  String get soundNewEvent => '新事件';

  @override
  String get soundNotice => '通知';

  @override
  String get soundDeviceFound => '发现设备';

  @override
  String get soundShareReceived => '接收分享';

  @override
  String get soundSystemNotify => '系统通知';

  @override
  String get preview => '预览';

  @override
  String get settingsNotification => '通知';

  @override
  String get settingsInAppNotifyTest => '在应用内测试通知';

  @override
  String get settingsSystemNotifyTest => '系统通知测试';

  @override
  String get settingsSystemNotifyMobileOnly => '此功能仅在移动端（Android/iOS）可用。';
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class AppLocalizationsZhHant extends AppLocalizationsZh {
  AppLocalizationsZhHant() : super('zh_Hant');

  @override
  String get appTitle => 'OneShare';

  @override
  String get navShare => '分享';

  @override
  String get navWeb => '網頁';

  @override
  String get navDownloading => '下載中';

  @override
  String get navSettings => '設定';

  @override
  String get navDownloads => '下載';

  @override
  String get trayShow => '顯示 OneShare';

  @override
  String get trayExit => '退出';

  @override
  String get serviceTitle => 'OneShare 服務';

  @override
  String get serviceContent => '正在初始化 OneShare 背景服務';

  @override
  String get channelName => 'OneShare 前台服務';

  @override
  String get channelDescription => '此頻道用於重要通知。';

  @override
  String get settingsLanguage => '語言';

  @override
  String get languageSystem => '系統預設';

  @override
  String get welcomeSkip => '略過';

  @override
  String get welcomeNext => '下一步';

  @override
  String get welcomeTitle => '歡迎使用 OneShare！';

  @override
  String welcomeVersion(String version) {
    return '版本 $version';
  }

  @override
  String get welcomeChooseLanguage => '選擇您的偏好語言';

  @override
  String get welcomeUseSystemLanguage => '使用系統語言';

  @override
  String welcomeCurrentLocale(String locale) {
    return '目前：$locale';
  }

  @override
  String get welcomeSelectLanguage => '選擇語言';

  @override
  String get welcomeFeature1Title => '跨平台分享';

  @override
  String get welcomeFeature1Desc =>
      '在 Android、iOS、Windows、Linux 和 macOS 之間無縫傳輸檔案。';

  @override
  String get welcomeFeature2Title => '多種通訊協定';

  @override
  String get welcomeFeature2Desc => '支援 WebDAV、SSH/SFTP 和 SMB，實現靈活的檔案管理。';

  @override
  String get welcomeFeature3Title => '響應式設計';

  @override
  String get welcomeFeature3Desc => '美觀、自適應的介面，在行動裝置和桌面端都能完美運作。';

  @override
  String get welcomeAllSet => '設定完成！';

  @override
  String get welcomeSetupComplete => '您已完成設定。';

  @override
  String get welcomeSwipeUp => '上滑進入應用程式';

  @override
  String get welcomeWhatsNew => '更新內容';

  @override
  String get welcomeLogPerformance => '效能提升';

  @override
  String get welcomeLogBugFixes => '錯誤修復和穩定性增強';

  @override
  String get welcomeLogUI => '介面優化，提升使用者體驗';

  @override
  String get welcomeContinue => '繼續';
}
