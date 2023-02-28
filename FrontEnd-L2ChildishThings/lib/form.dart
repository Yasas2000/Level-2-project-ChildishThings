// import 'package:flutter/material.dart';
// import 'package:mypart/app_bar.dart';
// import 'package:reactive_forms/reactive_forms.dart';
//
// class Form extends StatefulWidget {
//   const Form({Key? key, required Container child}) : super(key: key);
//
//   @override
//   State<Form> createState() => _FormState();
// }
//
// class _FormState extends State<Form> {
// final GlobalKey<FormState> _formKey=GlobalKey <FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(title: 'Donation Form',),
//       body: SingleChildScrollView(
//         child:Form(
//           key: _formKey,
//          child: Container(
//          margin: const EdgeInsets.all(24.0),
//           child: Column(
//             children: <Widget>[
//               TextFormField(
//                 maxLength: 20,
//                 decoration: InputDecoration(
//                   hintText: 'Name',
//                   labelText: 'Name',
//                 ),
//                 validator: (text){
//                   if(text?.isEmpty ?? false){
//                     return 'Name cannot be empty';
//                   }
//                   return null;
//                 },
//               )
//             ],
//           ),
//         ),
//     ),
//       ),
//     );
//   }
// }
// class Validations{
//   static String? namevalidate (String text){
//  if(text.isEmpty){
//    return 'Enter a name';
//  }
//  if(text.contains(ValidationMessage.email,))
//  return null ;
//   }
// }
