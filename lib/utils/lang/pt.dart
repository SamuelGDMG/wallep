const Map<String, String> formCreditCard = {
  'formTitleCreditCard': 'Cartão de crédito',
  'labelTextDescriptionFormCreditCard': 'Descrição',
  'defaultValidatorDescriptionFormCreditCard':
      'Você precisa adicionar uma descrição',
  'labelLimitDescriptionFormCreditCard': 'Limite',
  'cancelButtonFormCreditCard': 'Cancelar',
  'addButtonFormCreditCard': 'Adicionar',
  'confirmEditButtonFormCreditCard': 'Editar',
};

const Map<String, String> resumeCreditCard = {
  'resumeCreditCardTitle': 'Cartão de crédito',
  'resumeCreditCardLabelRegisterInstallment': 'Primeira parcela: ',
  'resumeCreditCardNoRegisters': "Ops! Você não tem uma fatura para este mês!"
};

const Map<String, String> invoiceCredit = {
  'invoiceCreditCardTitle': 'Fatura',
  'invoiceCreditBills': 'Contas'
};

const Map<String, String> errors = {
  'noNetwork': 'Você precisa estar conectado à internet!'
};

const Map<String, String> onBoardingPage = {
  'onBoardingPageTitle1': 'App minimalista',
  'onBoardingPageTitle2': "Nós nos preocupamos com seu dinheiro!",
  'onBoardingPageBody1':
      "Você ainda está usando papel para registrar suas renda e despesas? Diga adeus à este método, Wallep vai te ajudar a gerenciar suas finanças!",
  'onBoardingPageBody2': "Assuma o controle de suas finanças com Wallep!",
  'onBoardingPageSkipButton': 'Pular',
  'onBoardingPageEnterButton': 'Entrar'
};

const Map<String, String> signOut = {
  'signOutErrorSavingFileOnDrive':
      "Não foi possível salvar os dados no Drive. Tente sair e logar novamente! \nSe o erro aparecer de novo, entre em contato com o desenvolvedor.",
  'signOutNoNetWorking':
      "Você não está conectado à internet. Gostaria de tentar mais tarde ou sair sem salvar?",
  'signOutButtonTryLater': 'Tentar mais tarde',
  'signOutButtonWithoutSaving': 'Sair sem salvar'
};

const Map<String, String> formSimpleRegister = {
  'formSimpleRegisterLabelCheckBox': 'Despesa ou renda?',
  'formSimpleRegisterLabelDescription': 'Descrição',
  'formSimpleRegisterLabelPrice': 'Valor/Parcela',
  'formSimpleRegisterLabelCalendar': 'Data da primeira parcela',
  'formSimpleRegisterLabelInstallments': 'Parcelas',
  'formSimpleRegisterValidationDescription':
      'Você precisa adicionar uma descrição',
  'formSimpleRegisterAddButton': 'Adicionar',
  'formSimpleRegisterCancelButton': 'Cancelar',
  'formSimpleRegisterTextExpense': 'Despesa',
  'formSimpleRegisterTextIncome': 'Renda'
};

const Map<String, String> bottomBar = {
  'bottomHome': 'Principal',
  'bottomCheckRegistersMonth': 'Resumo',
  'bottomSettings': 'Configurações'
};

const Map<String, String> pt = {
  'darkMode': 'Modo Escuro',
  'language': 'Idioma',
  'tryAgainMsg':
      'Por favor, tente novamente. Se o problemar persistir, contate o desenvolvedor.',
  'titlePageSettings': "Configurações",
  'backup': 'Salvar no Google Drive',
  'textComponentSignOut': 'Deslogar',
  'about': 'Sobre',
  'appVersion': 'Versão 1.0',
  'thanksTo': 'Agradecimentos',
  'licenses': 'Licenças',
  'noCreditCards':
      "Pressione o botão de adição para adicionar um cartão de crédito.",
  'textSummarySalary': 'Salário',
  'titleDialogSalary': 'Salário',
  'labelDialogSalary': 'Informe seu salário',
  'labelInputDialogSalary': 'Salário',
  'buttonCancelDialogSalary': 'Cancelar',
  'buttonConfirmDialogSalary': 'Alterar',
  'textSummaryAccountBalance': 'Saldo da conta',
  'textSummaryIncome': 'Renda',
  'textSummaryExpense': 'Despesa',
  'titleHomeSummaryChart': 'Estatistica',
  'titleHomeCreditCards': 'Cartões de crédito',
  'titleHomeIncomesAndExpenses': 'Rendas e despesas',
  'messageNoCreditCardHome':
      'Pressione o botão para adicionar o seu primeiro cartão de crédito.',
  'messageNoSimpleRegisterHome':
      'Pressione o botão para cadastrar uma despesa ou renda.',
  'cardSimpleRegisterExpense': 'Despesa',
  'cardSimpleRegisterIncome': 'Renda',
  'messageDontHaveAnyCheck':
      "Ops! Você não tem despesas ou rendas cadastradas nesse mês.",
  'messageUploadFile': 'Salvando arquivo...',
  'dialogUploadFileSuccess': 'Arquivo salvo!',
  'messageIndicator': 'Carregando...',
  'contact': 'Contato',
  'currency': 'R\$ ',
  'subject': '[Wallep]-',
  'loginButton': 'Entrar com GOOGLE',
  'dialogRemoveCreditCardMessage':
      'Se você excluir este cartão de crédito, você excluirá todos os registros relacionados à ele! Deseja continuar?',
  'CalendarTitle': 'Calendário',
  ...bottomBar,
  ...formCreditCard,
  ...formSimpleRegister,
  ...onBoardingPage,
  ...signOut,
  ...invoiceCredit,
  ...resumeCreditCard
};
