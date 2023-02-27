class TextMessageEntity
{
  final bool isSender;
  final String message;
  final String? createdAt;
  TextMessageEntity( { this.createdAt,required this.isSender, required this.message});


}