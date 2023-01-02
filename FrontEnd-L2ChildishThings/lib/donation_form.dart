import 'package:flutter/material.dart';
import 'package:mypart/app_bar.dart';
import 'package:mypart/credi_card_page.dart';
import 'package:mypart/item_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:form_validator/form_validator.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

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

  void _onChanged(dynamic val) => debugPrint(val.toString());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title:'Donation Form'),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FormBuilder(
                key: _formKey,
                // enabled: false,
                onChanged: () {
                  _formKey.currentState!.save();
                  debugPrint(_formKey.currentState!.value.toString());
                },
                autovalidateMode: AutovalidateMode.disabled,


                skipDisabled: true,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 15),

                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.always,
                      name: 'fname',
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        suffixIcon: _fnameHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _fnameHasError = !(_formKey.currentState?.fields['fname']
                              ?.validate() ??
                              false);
                        });
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
                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.always,
                      name: 'lname',
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        suffixIcon: _lnameHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _lnameHasError = !(_formKey.currentState?.fields['lname']
                              ?.validate() ??
                              false);
                        });
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
                      decoration: const InputDecoration(
                        labelText: 'Purpose of Donation',
                      ),
                      initialValue: null,
                      name: 'pur[ose',
                      onChanged: _onChanged,
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()]),
                      options:
                      ['For Financial Support', 'For Charity']
                          .map((lang) => FormBuilderFieldOption(
                        value: lang,
                        child: Text(lang),
                      ))
                          .toList(growable: false),
                      controlAffinity: ControlAffinity.trailing,
                    ),
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
                          _fnameHasError = !(_formKey.currentState?.fields['fname']
                              ?.validate() ??
                              false);
                        });
                      },
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([

                        FormBuilderValidators.max(70),
                      ]),
                      // initialValue: '12',

                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),

                    FormBuilderCheckbox(
                      name: 'accept_terms',
                      initialValue: false,
                      onChanged: _onChanged,
                      title: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'I have read and agree to the ',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: 'Terms and Conditions',
                              style: TextStyle(color: Colors.blue),

                              // Flutter doesn't allow a button inside a button
                              // https://github.com/flutter/flutter/issues/31437#issuecomment-492411086
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
                      onChanged: _onChanged,
                    ),

                    FormBuilderChoiceChip<String>(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                          labelText:
                          'Payment Method:'),
                      name: 'payment_method',
                      initialValue: 'Visa',
                      options: const [
                        FormBuilderChipOption(
                          value: 'Visa',
                          avatar: CircleAvatar(backgroundImage: AssetImage("Asset/visa.jpg"), ),
                        ),
                        FormBuilderChipOption(
                          value: 'Master',
                          avatar: CircleAvatar(backgroundImage:AssetImage("Asset/master.jpg")),
                        ),
                        FormBuilderChipOption(
                          value: 'American Express',
                          avatar: CircleAvatar(backgroundImage:AssetImage("Asset/ae.jpg")),
                        ),
                        FormBuilderChipOption(
                          value: 'Genie',
                          avatar: CircleAvatar(backgroundImage:AssetImage("Asset/genie.jpg")),
                        ),

                      ],
                      onChanged: _onChanged,
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.saveAndValidate() ?? false) {
                          debugPrint(_formKey.currentState?.value.toString());
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context)=> CreditCardPage()));
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
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

    );
  }
}
