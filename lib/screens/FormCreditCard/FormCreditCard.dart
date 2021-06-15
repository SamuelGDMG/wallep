import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:finance/state/StateFormCreditCard.dart';
import 'package:finance/widgets/Button.dart';
import 'package:finance/widgets/InputTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FormCreditCard extends StatelessWidget {

  final borderRadius = 16.0;
  final title = "formTitleCreditCard".tr;
  final labelTextDescriptionFormCreditCard = 'labelTextDescriptionFormCreditCard'.tr;
  final defaultValidatorDescriptionFormCreditCard = 'defaultValidatorDescriptionFormCreditCard'.tr;
  final labelLimitDescriptionFormCreditCard = 'labelLimitDescriptionFormCreditCard'.tr;
  final cancelButtonFormCreditCard = 'cancelButtonFormCreditCard'.tr;
  final addButtonFormCreditCard = 'addButtonFormCreditCard'.tr;
  final minDate = DateTime(2019);

  final currency = 'currency'.tr;

  final creditCard;

  FormCreditCard({this.creditCard});

  @override
  Widget build(BuildContext context) {

    final StateFormCreditCard _stateFormCreditCard = Get.put(StateFormCreditCard(creditCard: creditCard));

    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(
          color: Colors.white
        ),),
      ),
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(12),
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            elevation: 3,
            shadowColor: Get.theme.primaryColor,
            child: Padding(
            padding: const EdgeInsets.all(14),
              child: Form(
                  key: _stateFormCreditCard.formKey,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => InputTextFormField(
                        maxLength: 20,
                        controller: _stateFormCreditCard.controllerName.value,
                        keyboardType: TextInputType.text,
                        labelText: labelTextDescriptionFormCreditCard,
                        defaultValidator: (value) {
                          if (value == '' || value == ' ') {
                            return defaultValidatorDescriptionFormCreditCard;
                          }
                          return null;
                        },
                      )),
                      Obx(() => InputTextFormField(
                          controller: _stateFormCreditCard.controllerCreditLimit.value,
                          maxLength: 12,
                          labelText: labelLimitDescriptionFormCreditCard,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            CurrencyTextInputFormatter(
                              decimalDigits: 2,
                              symbol: currency, // or to remove symbol set ''.
                            )
                          ]
                      )),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Button(
                            onTap: (){
                            },
                            buttonColor: Colors.red,
                            buttonTitle: cancelButtonFormCreditCard,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Button(
                            onTap: (){
                              _stateFormCreditCard.validate();
                            },
                            buttonColor: Get.theme.primaryColor,
                            buttonTitle: addButtonFormCreditCard,
                          ),
                        ],
                      )
                    ],
                  )
              ),
            ),
          )
        ),
      ),
    );
  }
}
