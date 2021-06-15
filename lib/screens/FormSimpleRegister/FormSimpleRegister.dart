import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:finance/state/StateCreditCardSimpleRegister.dart';
import 'package:finance/state/StateSystem.dart';
import 'package:finance/utils/Constants.dart';
import 'package:finance/utils/HelpFunctions.dart';
import 'package:finance/widgets/Button.dart';
import 'package:finance/widgets/InputTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class FormSimpleRegister extends StatelessWidget {

  final borderRadius = 16.0;
  final minDate = DateTime(2019);

  final simpleRegister;

  FormSimpleRegister({this.simpleRegister});

  final formSimpleRegisterLabelCheckBox = 'formSimpleRegisterLabelCheckBox'.tr;
  final formSimpleRegisterLabelDescription = 'formSimpleRegisterLabelDescription'.tr;
  final formSimpleRegisterLabelPrice = 'formSimpleRegisterLabelPrice'.tr;
  final formSimpleRegisterLabelCalendar = 'formSimpleRegisterLabelCalendar'.tr;
  final formSimpleRegisterLabelInstallments = 'formSimpleRegisterLabelInstallments'.tr;
  final formSimpleRegisterValidationDescription = 'formSimpleRegisterValidationDescription'.tr;
  final formSimpleRegisterAddButton = 'formSimpleRegisterAddButton'.tr;
  final formSimpleRegisterCancelButton = 'formSimpleRegisterCancelButton'.tr;
  final formSimpleRegisterTextExpense = 'formSimpleRegisterTextExpense'.tr;
  final formSimpleRegisterTextIncome = 'formSimpleRegisterTextIncome'.tr;
  final currency = 'currency'.tr;

  @override
  Widget build(BuildContext context) {

    final StateCreditCardSimpleRegister _stateCreditCardSimpleRegister = Get.put(
        StateCreditCardSimpleRegister(idCreditCard: "default", isCredit: false, simpleRegisterInitialData: simpleRegister)
    );

    StateSystem _stateSystem = Get.find();

    return Scaffold(
      backgroundColor: Get.theme.backgroundColor,
      appBar: AppBar(
        actions: [
          Visibility(
            visible: simpleRegister != null,
              child: IconButton(
            icon: Icon(Icons.delete),
            onPressed: (){
              _stateSystem.removeSimpleRegister(simpleRegister);
            },
          ))
        ],
        title: Obx(() => Text(_stateCreditCardSimpleRegister.isIncome.value == Constants.INCOME ? formSimpleRegisterTextIncome : formSimpleRegisterTextExpense, style: TextStyle(
          color: Colors.white
        ),),),
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
                key: _stateCreditCardSimpleRegister.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(formSimpleRegisterLabelCheckBox, style: TextStyle(
                              fontSize: 16
                            ),)
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(flex: 1,child: Obx(() => InkWell(
                              onTap: (){_stateCreditCardSimpleRegister.changeBox(Constants.INCOME);},
                              child: Row(
                                children: [
                                  Checkbox(value: _stateCreditCardSimpleRegister.isIncome.value == Constants.INCOME, onChanged: (val){_stateCreditCardSimpleRegister.changeBox(Constants.INCOME);}),
                                  Text(formSimpleRegisterTextIncome)
                                ],
                              ),
                            ))),
                            Expanded(child: Obx(() => InkWell(
                              onTap: (){_stateCreditCardSimpleRegister.changeBox(Constants.EXPENSE);},
                              child: Row(
                                children: [
                                  Checkbox(value: _stateCreditCardSimpleRegister.isIncome.value == Constants.EXPENSE, onChanged: (val){_stateCreditCardSimpleRegister.changeBox(Constants.EXPENSE);}),
                                  Text(formSimpleRegisterTextExpense)
                                ],
                              ),
                            )))
                          ],
                        )
                      ],
                    ),
                    Obx(() => InputTextFormField(
                      maxLength: 20,
                      controller: _stateCreditCardSimpleRegister.controllerName.value,
                      keyboardType: TextInputType.text,
                      labelText: formSimpleRegisterLabelDescription,
                      defaultValidator: (value) {
                        if (value == '' || value == ' ') {
                          return formSimpleRegisterValidationDescription;
                        }
                        return null;
                      },
                    )),
                    Obx(() => InputTextFormField(
                      labelText: formSimpleRegisterLabelInstallments,
                      controller: _stateCreditCardSimpleRegister.controllerInstallments.value,
                      maxLength: 3,
                      onChange: (vale){
                        _stateCreditCardSimpleRegister.controllerInstallments.refresh();
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                    )),
                    Obx(() => InputTextFormField(
                        onChange: (_){
                          _stateCreditCardSimpleRegister.controllerPrice.refresh();
                        },
                      controller: _stateCreditCardSimpleRegister.controllerPrice.value,
                      maxLength: 12,
                      labelText: formSimpleRegisterLabelPrice,
                      keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          CurrencyTextInputFormatter(
                            decimalDigits: 2,
                            symbol: currency, // or to remove symbol set ''.
                          )
                        ]
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(() => Row(
                      children: [
                        Text("${_stateCreditCardSimpleRegister.installments}", style: TextStyle(fontSize: 16),),
                        Text(" x "),
                        Text("${HelpFunctions.formatCurrency(value: _stateCreditCardSimpleRegister.price, name: currency)}", style: TextStyle(fontSize: 16),),
                        Text(" = "),
                        Text("${HelpFunctions.formatCurrency(value: _stateCreditCardSimpleRegister.total, name: currency)}", style: TextStyle(fontSize: 16),),
                      ],
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(formSimpleRegisterLabelCalendar, style: TextStyle(
                            fontSize: 16
                        ),),
                        Container(
                          height: 250,
                          child: SfDateRangePicker(
                            initialSelectedDate: _stateCreditCardSimpleRegister.dateTime,
                              minDate: minDate,
                              view: DateRangePickerView.year,
                              allowViewNavigation: false,
                              selectionColor: Get.theme.primaryColor,
                              onSelectionChanged: (DateRangePickerSelectionChangedArgs e){
                                _stateCreditCardSimpleRegister.changeSelectedDate(e);
                              },
                              monthCellStyle: DateRangePickerMonthCellStyle(

                              ),
                              yearCellStyle: DateRangePickerYearCellStyle(
                                todayCellDecoration: BoxDecoration(
                                    color: Get.theme.primaryColor,
                                    border: Border.all(color: Colors.white, width: 1),
                                    shape: BoxShape.circle
                                ),
                                todayTextStyle: const TextStyle(color: Colors.white),
                              )
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Button(
                          onTap: (){
                          },
                          buttonColor: Colors.red,
                          buttonTitle: formSimpleRegisterCancelButton,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Button(
                          onTap: (){
                            _stateCreditCardSimpleRegister.validate();
                          },
                          buttonColor: Get.theme.primaryColor,
                          buttonTitle: formSimpleRegisterAddButton,
                        ),
                      ],
                    )
                  ],),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
