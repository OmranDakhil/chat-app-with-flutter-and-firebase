import 'package:text_me/features/chat_feature/domain/entities/contact_entity.dart';
import 'package:text_me/features/chat_feature/domain/repositories/chat_repository.dart';

class GetAllContactsUseCase{
  final ChatRepository chatRepository;

  GetAllContactsUseCase({required this.chatRepository});

  Future<List<Contact>?> call()async{
    final Map<String,String>? contacts=await chatRepository.getAllContacts();
    List<Contact>? cont;
    if(contacts!=null) {
      cont=[];
      contacts.forEach((phoneNumber, name) =>cont!.add(Contact(PhoneNumber: phoneNumber, Name: name)));
    }
    return cont;
  }
}