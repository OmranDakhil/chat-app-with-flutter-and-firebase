import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_me/core/widgets/loading_widget.dart';
import 'package:text_me/features/chat_feature/domain/entities/user_entity.dart';
import 'package:text_me/features/chat_feature/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:text_me/features/chat_feature/presentation/pages/home_page.dart';
import 'package:text_me/features/chat_feature/presentation/widgets/user_information_page_widgets/change_name_or_about_widget.dart';
import 'package:text_me/features/chat_feature/presentation/widgets/user_information_page_widgets/change_photo_widget.dart';
import '../../../../core/util/snackbar_message.dart';
import '../../../../core/widgets/my_button.dart';

class UserInformationPage extends StatelessWidget {
  final MyUser? user;
  final bool withButton;
  const UserInformationPage({Key? key, this.user, required this.withButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  _buildAppBar() => AppBar(
        title: const Text("Profile"),
      );
  Widget _buildBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is ErrorProfileState) {
            SnakBarMessage()
                .showErrorSnakbar(context: context, message: state.message);
          }
        },
        builder: (_, state) {
          if (state is LoadingState) {
            return const LoadingWidget();
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Column(
                          children: [
                            ChangePhotoWidget(
                                imageUrl: user != null && user!.userImageUrl != null
                                    ? user!.userImageUrl
                                    : null),
                            ChangeNameOrAboutWidget(
                              isName: true,
                              nameOrAbout: user != null ? user!.publicName : null,
                            ),
                            ChangeNameOrAboutWidget(
                              isName: false,
                              nameOrAbout: user != null ? user!.about : null,
                            ),


                          ],
                        ),
                      ],
                    ),
                  ),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Visibility(
                      visible: withButton,
                      child: MyButton(
                          text: "continue",
                          color: Colors.blueGrey,
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                builder: (_) => const HomePage()), (route) => false);
                          }),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

//Scaffold(
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 CircleAvatar(
//                   backgroundImage: _image == null ? AssetImage('images/user.png'): Image.file(_image!,
//                     fit: BoxFit.cover,).image,
//                   // backgroundImage: _image == null ? AssetImage('assets/logo2.png'):AssetImage(),
//                   radius: 80,
//                 ),
//                 GestureDetector(onTap:()=> showBottomSheet(context), child: Icon(Icons.camera_alt))
//               ],
//             ),
//             Form(
//                 key: _formstate,
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       decoration: InputDecoration(
//
//                         hintText: 'اكتب اسمك',
//                       ),
//                       onSaved: (val){
//                         name=val;
//
//                       },
//                      maxLength: 15,
//                       maxLines: 1,
//                       textAlign: TextAlign.center,
//                       keyboardType: TextInputType.name,
//                       textDirection: TextDirection.rtl,
//                     ),
//                     SizedBox(height: 50,),
//                     TextFormField(
//                       decoration: InputDecoration(
//
//                         hintText: 'اكتب حالتك',
//                       ),
//                       onSaved: (val){
//                         state=val;
//
//                       },
//                       initialValue: "انا مستخدم جديد",
//                       maxLength: 100,
//                       maxLines: 3,
//                       textAlign: TextAlign.center,
//                       keyboardType: TextInputType.name,
//                       textDirection: TextDirection.rtl,
//
//                     )
//                   ],
//
//             )
//             ),
//             Align(
//               alignment: Alignment.bottomRight,
//               child: MyButton(
//                 text: "حفظ",
//                 color: Colors.deepPurple,
//                 onPressed: ()=> save(),
//               ),
//             ),
//   ]
//         ),
//         // floatingActionButton: FloatingActionButton(
//         //   onPressed: () {},
//         //   child: const Icon(
//         //     Icons.edit,
//         //     color: Colors.white,
//         //   ),
//         // ),
//         // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//       );

  // save() async {
  //   showLoading(context);
  //   var formdata = _formstate.currentState;
  //   if (formdata!.validate()) {
  //     formdata.save();
  //     if (_image != null) {
  //       var rand = Random().nextInt(100000);
  //       var imagename = "$rand" + path.basename(_image!.path);
  //       Reference ref =
  //           FirebaseStorage.instance.ref("images").child("$imagename");
  //       await ref.putFile(_image!);
  //       imageurl = await ref.getDownloadURL();
  //     } else
  //       imageurl = "";
  //     await usersref
  //         .doc(
  //             "+963931644327" /*FirebaseAuth.instance.currentUser!.phoneNumber*/)
  //         .set({
  //       "name": name,
  //       "state": state,
  //       "imageurl": imageurl,
  //       // "userid": FirebaseAuth.instance.currentUser!.uid,
  //       // "userPhone":FirebaseAuth.instance.currentUser!.phoneNumber,
  //     }).then((value) {
  //       Navigator.of(context).pushAndRemoveUntil(
  //         MaterialPageRoute(builder: (context) => ContactsPage()),
  //         (route) => false,
  //       );
  //     }).catchError((e) {
  //       print("================================");
  //       print("$e");
  //       print("================================");
  //     });
  //   }
  // }

}
