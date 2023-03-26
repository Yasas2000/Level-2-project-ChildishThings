import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:frontend/app_bar.dart';
import 'package:frontend/credi_card_page.dart';
import 'package:frontend/item_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:form_validator/form_validator.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/payment.dart';

import 'homepage.dart';

// Widget _fnaame(_fnameHasError,_formKey,_state(),var _fname) {
//
// }
class Details{
   String fname;
   String lname;
   String email;
   Double amount;
   String? comment;
   String purpose;
   String method;
   String? duration;
   String? period;
   Details(this.fname,this.lname,this.email,this.amount,this.comment,this.purpose,this.method,this.duration,this.period);

}

class DonationForm extends StatefulWidget {
  const DonationForm({Key? key}) : super(key: key);

  @override
  State<DonationForm> createState() => _DonationFormState();
}

class _DonationFormState extends State<DonationForm> {

  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final _formKey = GlobalKey<FormBuilderState>();
  bool _fnameHasError = false;
  bool _lnameHasError = false;
  bool _emailHasError = false;
  bool _amountHasError= false;
  bool _recurHasError=false;
  bool _duraHasError=false;
   void _state(){
    setState(() {
      _fnameHasError = !(_formKey.currentState?.fields['fname']
          ?.validate() ?? false);
    });
  }

  late String _lname;
  late String _fname;
  late String _email;
  late String _amount;
  late String? _comment;
  late String _purpose;
  var _method;
  late String? _duration=null;
  late String? _period=null;


  //void _onChanged(dynamic val) => debugPrint(val.toString());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
            title: 'Donation Form',
            leadingIcon:IconButton(
            icon: Icon(Icons.home),
             iconSize: 40,
             color: Colors.deepOrange,
             onPressed:(){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                HomePage()
            ));
          },
        )),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child:
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    FormBuilder(
                      key: _formKey,
                      // enabled: false,
                      // onChanged: () {
                      //   _formKey.currentState!.save();
                      //   //debugPrint(_formKey.currentState!.value.toString());
                      // },
                      autovalidateMode: AutovalidateMode.disabled,


                      skipDisabled: true,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: FormBuilderTextField (
                              autovalidateMode: AutovalidateMode.always,
                              name: 'fname',
                              decoration: InputDecoration(
                                labelText: 'First Name',
                                suffixIcon: _fnameHasError
                                    ? const Icon(Icons.error, color: Colors.red)
                                    : const Icon(Icons.check, color: Colors.green),
                              ),
                              onChanged: (val) {
                                _state();
                              },
                              onSaved: (text){
                                _fname=text!;
                              },
                              // valueTransformer: (text) => num.tryParse(text),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.max(70),
                              ]),
                              // initialValue: '12',

                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          Expanded(child: FormBuilderTextField(
                            autovalidateMode: AutovalidateMode.always,
                            name: 'lname',

                            onChanged: (val) {
                              setState(() {
                                _lnameHasError = !(_formKey.currentState?.fields['lname']
                                    ?.validate() ??
                                    false);
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                              suffixIcon: _lnameHasError
                                  ? const Icon(Icons.error, color: Colors.red)
                                  : const Icon(Icons.check, color: Colors.green),
                            ),
                            onSaved: (val){
                              _lname=val!;
                            },
                            // valueTransformer: (text) => num.tryParse(text),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.max(70),
                            ]),
                            // initialValue: '12',

                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          ), )
                        ],
                      ),


                          FormBuilderTextField(
                            autovalidateMode: AutovalidateMode.always,
                            name: 'email',
                            decoration: InputDecoration(
                              labelText: 'E-mail',
                              suffixIcon: _emailHasError
                                  ? const Icon(Icons.error, color: Colors.red)
                                  : const Icon(Icons.check, color: Colors.green),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _emailHasError = !(_formKey.currentState?.fields['email']
                                    ?.validate() ??
                                    false);
                              });
                            },
                            onSaved: (val){
                              _email=val!;
                            },
                            // valueTransformer: (text) => num.tryParse(text),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.email(),
                              FormBuilderValidators.max(70),
                            ]),
                            // initialValue: '12',

                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          ),
                          FormBuilderTextField(
                            autovalidateMode: AutovalidateMode.always,
                            name: 'amount',

                            decoration: InputDecoration(
                              labelText: 'Amount',floatingLabelAlignment: FloatingLabelAlignment.start,
                              prefixIconConstraints: BoxConstraints.tightFor(height: 3),
                              prefixIcon: Icon(Icons.currency_rupee),
                              suffixIcon: _amountHasError
                                  ? const Icon(Icons.error, color: Colors.red)
                                  : const Icon(Icons.check, color: Colors.green),
                            ),
                            onChanged: (val) {
                              setState(() {
                                _amountHasError = !(_formKey.currentState?.fields['amount']
                                    ?.validate() ??
                                    false);
                              });
                            },
                            onSaved: (val){
                              _amount=val!;
                            },
                            // valueTransformer: (text) => num.tryParse(text),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.numeric(),
                              FormBuilderValidators.max(double.infinity),
                            ]),
                            // initialValue: '12',

                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                          ),
                          FormBuilderRadioGroup<String>(
                              name: 'purpose',
                              decoration: const InputDecoration(
                                labelText: 'Pupose of donation'
                              ),
                              initialValue: null,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required()
                              ]),
                              options:
                              ['For Charity','For Financial Help']
                                  .map((e) => FormBuilderFieldOption(
                                value: e,
                                child: Text(e),)).toList(growable: false),
                                onSaved: (context){
                              _purpose=context!;
                                },),
                          FormBuilderRadioGroup<String>(
                            decoration: const InputDecoration(
                              labelText: 'Type of Payment',
                            ),
                            initialValue: null,
                            name: 'top',
                            //onChanged: _onChanged,
                            validator: FormBuilderValidators.compose(
                                [FormBuilderValidators.required()]),
                            options:
                            ['One time Payment', 'Save Payment','Recurrant']
                                .map((lang) => FormBuilderFieldOption(
                              value: lang,
                              child: Text(lang),
                            ))
                                .toList(growable: false),
                            controlAffinity: ControlAffinity.trailing,
                            onSaved: (val){

                            _method=val;
                            },
                            onChanged: (val){
                              setState((){
                                _method=val!;
                              });
                            },
                          ),
                          Visibility(
                              visible: _method=='Recurrant',
                              child: Row(
                                crossAxisAlignment:CrossAxisAlignment.center ,
                                children: [
                                  Expanded(child:FormBuilderDropdown(
                                    name: 'Recurrance time',
                                    decoration: InputDecoration(
                                        labelText: 'Recurrance Period',
                                        suffixIcon: _recurHasError?const Icon(Icons.error,color: Colors.red)
                                            :const Icon(Icons.check,color: Colors.green,)
                                    ),
                                    onChanged: (val){
                                      setState(() {
                                        _recurHasError=!(_formKey.currentState?.fields['Recurrance time']?.validate() ?? false);
                                      });
                                    },
                                    items:List.generate(12, (index) => index + 1)
                                        .map((month) => DropdownMenuItem(
                                      value: month,
                                      child: Text('$month'),
                                    )).toList() ,
                                    onSaved: (val){
                                      _period=val?.toString();
                                    },
                                    validator: FormBuilderValidators.compose(
                                      [FormBuilderValidators.required(),]

                                    ),
                                  ) ),
                                  Expanded(child:FormBuilderDropdown(
                                    name: 'Duration',
                                    decoration: InputDecoration(
                                        labelText: 'Duration in years',
                                        suffixIcon: _duraHasError?const Icon(Icons.error,color: Colors.red)
                                            :const Icon(Icons.check,color: Colors.green,)
                                    ),
                                    onChanged: (val){
                                      setState(() {
                                        _duraHasError=!(_formKey.currentState?.fields['Duration']?.validate() ?? false);
                                      });
                                    },
                                    onSaved: (val){
                                      _duration=val?.toString();
                                    },
                                    items:List.generate(100, (index) => index + 1)
                                        .map((month) => DropdownMenuItem(
                                      value: month,
                                      child: Text('$month'),
                                    )).toList() ,
                                    validator: FormBuilderValidators.compose(
                                        [FormBuilderValidators.required(),]

                                    ),
                                  ) ),

                                ],
                              )),

                          FormBuilderTextField(
                            autovalidateMode: AutovalidateMode.always,
                            name: 'comment',
                            decoration: InputDecoration(
                              labelText: 'Comments',
                              suffixIcon: _fnameHasError
                                  ? const Icon(Icons.error, color: Colors.red)
                                  : const Icon(Icons.check, color: Colors.green),
                            ),
                            onChanged: (val) {
                              setState(() {
                                _fnameHasError = !(_formKey.currentState?.fields['comment']
                                    ?.validate() ??
                                    false);
                              });
                            },
                            onSaved: (val){
                              _comment=val;
                            },
                            // valueTransformer: (text) => num.tryParse(text),
                            validator: FormBuilderValidators.compose([

                              //FormBuilderValidators.required(),
                              FormBuilderValidators.max(70),
                            ]),
                            // initialValue: '12',

                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          ),

                          FormBuilderCheckbox(
                            name: 'accept_terms',
                            initialValue: false,
                            //onChanged: _onChanged,
                            title: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'I have read and agree to the ',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  TextSpan(


                                    text: 'Terms and Conditions',
                                    style: TextStyle(color: Colors.orange),

                                    /*
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        print('launch url');
                                      },
                                    */
                                  ),
                                ],
                              ),
                            ),
                            validator: FormBuilderValidators.equal(
                              true,
                              errorText:
                              'You must accept terms and conditions to continue',
                            ),
                          ),




                          FormBuilderSwitch(
                            title: const Text('I Accept the terms and conditions'),
                            name: 'accept_terms_switch',
                            initialValue: true,
                            validator: FormBuilderValidators.equal(
                              true,
                              errorText:
                              'You must accept terms and conditions to continue',
                            ),
                            //onChanged: _onChanged,
                          ),

                          // FormBuilderChoiceChip<String>(
                          //   autovalidateMode: AutovalidateMode.onUserInteraction,
                          //   decoration: const InputDecoration(
                          //       labelText:
                          //       'Payment Method:'),
                          //   name: 'payment_method',
                          //   initialValue: 'Visa',
                          //   options: const [
                          //     FormBuilderChipOption(
                          //       value: 'Visa',
                          //       avatar: CircleAvatar(backgroundImage: AssetImage("Asset/visa.jpg"), ),
                          //     ),
                          //     FormBuilderChipOption(
                          //       value: 'Master',
                          //       avatar: CircleAvatar(backgroundImage:AssetImage("Asset/master.jpg")),
                          //     ),
                          //     FormBuilderChipOption(
                          //       value: 'American Express',
                          //       avatar: CircleAvatar(backgroundImage:AssetImage("Asset/ae.jpg")),
                          //     ),
                          //     FormBuilderChipOption(
                          //       value: 'Genie',
                          //       avatar: CircleAvatar(backgroundImage:AssetImage("Asset/genie.jpg")),
                          //     ),
                          //
                          //   ],
                          //   //onChanged: _onChanged,
                          // ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            style:ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
                            onPressed: () async{
                              if (_formKey.currentState?.validate() ?? false) {
                                 _formKey.currentState?.save();
                                 Details d=Details(_fname,_lname,_email,_amount as Double,_comment,_purpose,_method,_duration,_period);
                                 print(d.duration);
                                 print(d.comment);
                                 print(d.period);


                                //debugPrint(_formKey.currentState?.value.toString());

                                // try {
                                //   var url='http://10.0.2.2:3000/submit';
                                //   final response = await http.post(
                                //     Uri.parse(url),
                                //     body: {'fname': _fname,'lname':_lname, 'email': _email},
                                //   );
                                //   print('${response.body}');
                                //   print('${response.statusCode}');
                                //   if (response.statusCode == 200) {
                                //
                                //   } else {
                                //
                                //   }
                                // } catch (e) {
                                //  print(e);
                                // }
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context)=> Payment(d)));
                              } else {
                                debugPrint(_formKey.currentState?.value.toString());
                                debugPrint('validation failed');
                              }
                            },
                            child: const Text(
                              'Submit',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              _formKey.currentState?.reset();
                            },
                            // color: Theme.of(context).colorScheme.secondary,
                            child: Text(
                              'Reset',
                              style: TextStyle(
                                  color: Colors.deepOrange),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),



      ),
    );
  }
}
