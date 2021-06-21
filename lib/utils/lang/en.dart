const Map<String, String> formCreditCard = {
  'formTitleCreditCard': 'Credit card',
  'labelTextDescriptionFormCreditCard': 'Description',
  'defaultValidatorDescriptionFormCreditCard': 'You need add a description',
  'labelLimitDescriptionFormCreditCard': 'Limit',
  'cancelButtonFormCreditCard': 'Cancel',
  'addButtonFormCreditCard': 'Add',
  'confirmEditButtonFormCreditCard': 'Edit',
};

const Map<String, String> invoiceCredit = {
  'invoiceCreditCardTitle': 'Invoice',
  'invoiceCreditBills': 'Bills'
};

const Map<String, String> signOut = {
  'signOutErrorSavingFileOnDrive': "It wasn't possible to save the data on drive. You Should try later or you can sign out without saving! \nIf the error appears again, contact the dev before you sign out.",
  'signOutNoNetWorking': "You aren't connected to the network. You should try later or you can sign out without saving!",
  'signOutButtonTryLater': 'To try later',
  'signOutButtonWithoutSaving': 'Sign Out'
};

const Map<String, String> bottomBar = {
  'bottomHome': 'Home',
  'bottomCheckRegistersMonth': 'Check',
  'bottomSettings': 'Settings'
};

const Map<String, String> formSimpleRegister = {
  'formSimpleRegisterLabelCheckBox': 'Income or expense?',
  'formSimpleRegisterLabelDescription': 'Description',
  'formSimpleRegisterLabelPrice': 'Price by installment',
  'formSimpleRegisterLabelCalendar': 'Which month will you start to pay?',
  'formSimpleRegisterLabelInstallments': 'Installments',
  'formSimpleRegisterValidationDescription': 'You need add a description',
  'formSimpleRegisterAddButton': 'Add',
  'formSimpleRegisterCancelButton': 'Cancel',
  'formSimpleRegisterTextExpense': 'Expense',
  'formSimpleRegisterTextIncome': 'Income'
};

const Map<String, String> errors = {
  'tryAgainMsg':
  'Please try again. If the problem persists, contact the developer.',
  'noNetwork': 'You need to be connected on network!'
};

const Map<String, String> resumeCreditCard = {
  'resumeCreditCardTitle': 'Credit Card',
  'resumeCreditCardLabelRegisterInstallment': 'First installment: ',
  'resumeCreditCardNoRegisters': "Ops! You don't have an invoice for this month!"
};

const Map<String, String> onBoardingPage = {
  'onBoardingPageTitle1': 'Minimalist App',
  'onBoardingPageTitle2': "We care about your money!",
  'onBoardingPageBody1': "You still using paper to registers your expenses and income? So, Wallep will help you about your finances!",
  'onBoardingPageBody2': "Take control of your finances with Wallep!",
  'onBoardingPageSkipButton': 'Skip',
  'onBoardingPageEnterButton': 'Login'
};

const Map<String, String> en = {
  'darkMode': 'Dark Mode',
  'language': 'Language',
  'tryAgainMsg':
  'Please try again. If the problem persists, contact the developer.',
  'titlePageSettings': "Settings",
  'backup': 'Backup on Google Drive',
  'textComponentSignOut': 'Sign out',
  'about': 'About',
  'appVersion': 'Version 1.0',
  'thanksTo': 'Special Thanks',
  'licenses': 'Licenses',
  'textSummarySalary': 'Salary',
  'titleDialogSalary': 'Salary',
  'labelDialogSalary': 'Inform your salary',
  'labelInputDialogSalary': 'Salary',
  'buttonCancelDialogSalary': 'Cancel',
  'buttonConfirmDialogSalary': 'Confirm',
  'textSummaryAccountBalance': 'Account Balance',
  'textSummaryIncome': 'Income',
  'textSummaryExpense': 'Expense',
  'titleHomeSummaryChart': 'Statistics',
  'titleHomeCreditCards': 'Credit cards',
  'titleHomeIncomesAndExpenses': 'Incomes and Expenses',
  'messageNoCreditCardHome': 'Press the plus button to add a credit card.',
  'messageNoSimpleRegisterHome': 'Press the plus button to add a record',
  'messageIndicator': 'Loading...',
  'cardSimpleRegisterExpense': 'Expense',
  'cardSimpleRegisterIncome': 'Income',
  'messageDontHaveAnyCheck': "Ops!You don't have any income or expense to this month",
  'messageUploadFile': 'Uploading file...',
  'dialogUploadFileSuccess': 'File saved!',
  'currency': '\$ ',
  'contact': 'Contact',
  'subject': '[Wallep]-',
  'loginButton': 'Login with google',
  'dialogRemoveCreditCardMessage': 'If you delete this credit card you gonna delete all record together!',
  'CalendarTitle': 'Calendar',
  ...bottomBar,
  ...formCreditCard,
  ...formSimpleRegister,
  ...resumeCreditCard,
  ...onBoardingPage,
  ...signOut,
  ...invoiceCredit
};