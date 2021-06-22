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
  'signOutErrorSavingFileOnDrive':
      "An error occured while saving the data on Drive. Try signing out and then signing in again! \nIf the error appears again, please contact the developer.",
  'signOutNoNetWorking':
      "You aren't connected to a network. Do you want to try later with a stable connection or sign out without saving a backup file?",
  'signOutButtonTryLater': 'To try later',
  'signOutButtonWithoutSaving': 'Sign Out'
};

const Map<String, String> bottomBar = {
  'bottomHome': 'Home',
  'bottomCheckRegistersMonth': 'Summary',
  'bottomSettings': 'Settings'
};

const Map<String, String> formSimpleRegister = {
  'formSimpleRegisterLabelCheckBox': 'Income or expense?',
  'formSimpleRegisterLabelDescription': 'Description',
  'formSimpleRegisterLabelPrice': 'Price by installment',
  'formSimpleRegisterLabelCalendar': 'Which month will you start paying it?',
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
  'noNetwork': 'You need to be connected to the internet!'
};

const Map<String, String> resumeCreditCard = {
  'resumeCreditCardTitle': 'Credit Card',
  'resumeCreditCardLabelRegisterInstallment': 'First installment: ',
  'resumeCreditCardNoRegisters':
      "Ops! You don't have an invoice for this month!"
};

const Map<String, String> onBoardingPage = {
  'onBoardingPageTitle1': 'Minimalist App',
  'onBoardingPageTitle2': "We care about your money!",
  'onBoardingPageBody1':
      "Are you still using paper to register your income and expenses? Say goodbye to this old method, Wallep will help you manage your finances!",
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
  'messageNoSimpleRegisterHome': 'Press the plus button to add a record.',
  'messageIndicator': 'Loading...',
  'cardSimpleRegisterExpense': 'Expense',
  'cardSimpleRegisterIncome': 'Income',
  'messageDontHaveAnyCheck':
      "Ops! You don't have any income or expense for this month",
  'messageUploadFile': 'Uploading file...',
  'dialogUploadFileSuccess': 'File saved!',
  'currency': '\$ ',
  'contact': 'Contact',
  'subject': '[Wallep]-',
  'loginButton': 'Login with google',
  'dialogRemoveCreditCardMessage':
      'If you delete this credit card you will delete all its records together! Do you want to continue?',
  'CalendarTitle': 'Calendar',
  ...bottomBar,
  ...formCreditCard,
  ...formSimpleRegister,
  ...resumeCreditCard,
  ...onBoardingPage,
  ...signOut,
  ...invoiceCredit
};
