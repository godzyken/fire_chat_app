import 'package:fire_chat_app/generated/json/base/json_convert_content.dart';

class MessageEntity with JsonConvert<MessageEntity> {
	String? authorId;
	String? id;
	String? status;
	String? text;
	double? timestamp;
	String? type;
	double? height;
	String? imageName;
	double? size;
	String? uri;
	double? width;
	String? fileName;
	String? mimeType;
}
