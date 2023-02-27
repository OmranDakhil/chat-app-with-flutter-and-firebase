import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:phone_number/phone_number.dart';

class ContactsInfo {
  final PhoneNumberUtil phoneNumberUtil;

  ContactsInfo({required this.phoneNumberUtil});

   Map<String, String>? _contacts;

  Future<Map<String, String>?> fetchContacts() async {
    if (_contacts != null) return _contacts;
    if (!await FlutterContacts.requestPermission(readonly: true)) return null;
    // String? myNumber=FirebaseAuth.instance.currentUser!.phoneNumber;
    // PhoneNumber phoneNumber1= await PhoneNumberUtil().parse(myNumber!);
    String myCode = "SY"; //phoneNumber1.regionCode;
    Map<String, String>? finalContacts = {};
    final contacts = await FlutterContacts.getContacts();
    for (Contact contact in contacts) {
      Contact? cont = await FlutterContacts.getContact(contact.id);
      PhoneNumber phoneNumber = await phoneNumberUtil
          .parse(cont!.phones.first.number, regionCode: myCode);
      if (FirebaseAuth.instance.currentUser!.phoneNumber! != phoneNumber.e164) {
        finalContacts.addAll({phoneNumber.e164: cont.displayName});
      }
    }
    _contacts=finalContacts;
    return finalContacts;
  }
  Future<String?> mapNumberToName(String number)async{
    Map<String,String>? contacts=await fetchContacts();
    if(contacts!=null)
      {
        if(contacts.containsKey(number)) {
          return contacts[number];
        }
        else{
          return number;
        }
      }
    else {
      return number;
    }
  }
}
