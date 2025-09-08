
import 'StatusThemeType.dart';

enum MessageType {
  error(StatusThemeType.red),
  success(StatusThemeType.green),
  prompt(StatusThemeType.blue),
  warning(StatusThemeType.orange);

  const MessageType(this.themeType);

  final StatusThemeType themeType;
}
