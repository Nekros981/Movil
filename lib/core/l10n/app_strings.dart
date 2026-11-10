enum AppLocale { es, en }

class AppStrings {
  const AppStrings._({
    required this.locale,
    required this.authOfficialGameArchive,
    required this.tabHome,
    required this.tabArchive,
    required this.tabTracks,
    required this.tabProfile,
    required this.officialArchiveLabel,
    required this.homeBannerDescription,
    required this.exploration,
    required this.whatToExplore,
    required this.archiveOverline,
    required this.gameWiki,
    required this.pickWikiSection,
    required this.tracksOverline,
    required this.gameMusic,
    required this.tracksDescription,
    required this.profileOverline,
    required this.yourAccount,
    required this.noName,
    required this.tapPhotoToChange,
    required this.languageOverline,
    required this.languageSpanish,
    required this.languageEnglish,
    required this.nameOverline,
    required this.yourName,
    required this.saveName,
    required this.passwordOverline,
    required this.password,
    required this.enterPassword,
    required this.confirmPassword,
    required this.repeatPassword,
    required this.savePassword,
    required this.logout,
    required this.welcomeBack,
    required this.continueAdventure,
    required this.loginSubtitle,
    required this.email,
    required this.forgotPassword,
    required this.createAccountLink,
    required this.signIn,
    required this.newGame,
    required this.createAccountTitle,
    required this.registerSubtitle,
    required this.name,
    required this.signInLink,
    required this.createAccountButton,
    required this.recoveryOverline,
    required this.recoverAccess,
    required this.recoverSubtitle,
    required this.recoverEmailSent,
    required this.sendResetLink,
    required this.newPasswordTitle,
    required this.updatePasswordSubtitle,
    required this.preparingArchive,
    required this.contentPreparing,
    required this.enterEmail,
    required this.enterValidEmail,
    required this.enterName,
    required this.enterPasswordPrompt,
    required this.passwordRules,
    required this.nameRules,
    required this.confirmPasswordPrompt,
    required this.passwordsDoNotMatch,
    required this.signInToUploadPhoto,
    required this.uploadPhotoFailed,
    required this.updateNameFailed,
    required this.checkEmailConfirm,
    required this.registerFailed,
    required this.loginFailed,
    required this.sendLinkFailed,
    required this.updatePasswordFailed,
    required this.emailAlreadyRegistered,
    required this.invalidCredentials,
    required this.confirmEmailBeforeLogin,
    required this.sessionConfirmFailed,
  });

  final AppLocale locale;

  bool get isEnglish => locale == AppLocale.en;

  final String authOfficialGameArchive;
  final String tabHome;
  final String tabArchive;
  final String tabTracks;
  final String tabProfile;
  final String officialArchiveLabel;
  final String homeBannerDescription;
  final String exploration;
  final String whatToExplore;
  final String archiveOverline;
  final String gameWiki;
  final String pickWikiSection;
  final String tracksOverline;
  final String gameMusic;
  final String tracksDescription;
  final String profileOverline;
  final String yourAccount;
  final String noName;
  final String tapPhotoToChange;
  final String languageOverline;
  final String languageSpanish;
  final String languageEnglish;
  final String nameOverline;
  final String yourName;
  final String saveName;
  final String passwordOverline;
  final String password;
  final String enterPassword;
  final String confirmPassword;
  final String repeatPassword;
  final String savePassword;
  final String logout;
  final String welcomeBack;
  final String continueAdventure;
  final String loginSubtitle;
  final String email;
  final String forgotPassword;
  final String createAccountLink;
  final String signIn;
  final String newGame;
  final String createAccountTitle;
  final String registerSubtitle;
  final String name;
  final String signInLink;
  final String createAccountButton;
  final String recoveryOverline;
  final String recoverAccess;
  final String recoverSubtitle;
  final String recoverEmailSent;
  final String sendResetLink;
  final String newPasswordTitle;
  final String updatePasswordSubtitle;
  final String preparingArchive;
  final String contentPreparing;
  final String enterEmail;
  final String enterValidEmail;
  final String enterName;
  final String enterPasswordPrompt;
  final String passwordRules;
  final String nameRules;
  final String confirmPasswordPrompt;
  final String passwordsDoNotMatch;
  final String signInToUploadPhoto;
  final String uploadPhotoFailed;
  final String updateNameFailed;
  final String checkEmailConfirm;
  final String registerFailed;
  final String loginFailed;
  final String sendLinkFailed;
  final String updatePasswordFailed;
  final String emailAlreadyRegistered;
  final String invalidCredentials;
  final String confirmEmailBeforeLogin;
  final String sessionConfirmFailed;

  static const spanish = AppStrings._(
    locale: AppLocale.es,
    authOfficialGameArchive: 'ARCHIVO OFICIAL DEL VIDEOJUEGO',
    tabHome: 'Inicio',
    tabArchive: 'Archivo',
    tabTracks: 'Pistas',
    tabProfile: 'Perfil',
    officialArchiveLabel: 'ARCHIVO OFICIAL',
    homeBannerDescription:
        'Explora el universo del videojuego: historia, personajes y storyboard.',
    exploration: 'EXPLORACIÓN',
    whatToExplore: '¿Qué quieres explorar?',
    archiveOverline: 'ARCHIVO',
    gameWiki: 'Wiki del juego',
    pickWikiSection: 'Elige una sección para leer su contenido.',
    tracksOverline: 'PISTAS',
    gameMusic: 'Música del juego',
    tracksDescription: 'Reproduce las pistas oficiales de Campus Quest.',
    profileOverline: 'PERFIL',
    yourAccount: 'Tu cuenta',
    noName: 'Sin nombre',
    tapPhotoToChange: 'Toca la foto para cambiarla',
    languageOverline: 'IDIOMA',
    languageSpanish: 'Español',
    languageEnglish: 'Inglés',
    nameOverline: 'NOMBRE',
    yourName: 'Tu nombre',
    saveName: 'Guardar nombre  →',
    passwordOverline: 'CONTRASEÑA',
    password: 'Contraseña',
    enterPassword: 'Ingresa tu contraseña',
    confirmPassword: 'Confirmar contraseña',
    repeatPassword: 'Repite tu contraseña',
    savePassword: 'Guardar contraseña  →',
    logout: 'Cerrar sesión',
    welcomeBack: 'BIENVENIDO DE VUELTA',
    continueAdventure: 'Continúa tu aventura',
    loginSubtitle:
        'Ingresa con tu cuenta para explorar el universo de Campus Quest.',
    email: 'Correo',
    forgotPassword: '¿Olvidaste tu contraseña?',
    createAccountLink: 'Crear cuenta',
    signIn: 'Iniciar sesión  →',
    newGame: 'NUEVA PARTIDA',
    createAccountTitle: 'Crea tu cuenta',
    registerSubtitle:
        'Elige un correo y una contraseña para entrar al archivo.',
    name: 'Nombre',
    signInLink: 'Iniciar sesión',
    createAccountButton: 'Crear cuenta  →',
    recoveryOverline: 'RECUPERACIÓN',
    recoverAccess: 'Recupera tu acceso',
    recoverSubtitle:
        'Te enviaremos un enlace a tu correo para elegir una contraseña nueva.',
    recoverEmailSent:
        'Si el correo está registrado, enviamos un enlace para elegir una contraseña nueva.',
    sendResetLink: 'Enviar enlace  →',
    newPasswordTitle: 'Nueva contraseña',
    updatePasswordSubtitle:
        'Elige una contraseña nueva para volver a entrar al archivo.',
    preparingArchive: 'Preparando tu archivo…',
    contentPreparing: 'Contenido en preparación',
    enterEmail: 'Ingresa tu correo.',
    enterValidEmail: 'Ingresa un correo válido.',
    enterName: 'Ingresa tu nombre.',
    enterPasswordPrompt: 'Ingresa tu contraseña.',
    passwordRules:
        'Usa al menos 6 caracteres: letras, números o signos.',
    nameRules:
        'Empieza con mayúscula, mínimo 5 caracteres y solo letras. '
        'Cada palabra con mayúscula inicial, un espacio entre palabras.',
    confirmPasswordPrompt: 'Confirma tu contraseña.',
    passwordsDoNotMatch: 'Las contraseñas no coinciden.',
    signInToUploadPhoto: 'Inicia sesión para subir tu foto.',
    uploadPhotoFailed: 'No se pudo subir la foto. Intenta de nuevo.',
    updateNameFailed: 'No se pudo actualizar el nombre. Intenta de nuevo.',
    checkEmailConfirm: 'Revisa tu correo para confirmar la cuenta.',
    registerFailed: 'No se pudo crear la cuenta. Intenta de nuevo.',
    loginFailed: 'No se pudo iniciar sesión. Intenta de nuevo.',
    sendLinkFailed: 'No se pudo enviar el enlace. Intenta de nuevo.',
    updatePasswordFailed:
        'No se pudo actualizar la contraseña. Intenta de nuevo.',
    emailAlreadyRegistered: 'Ese correo ya está registrado.',
    invalidCredentials: 'Correo o contraseña incorrectos.',
    confirmEmailBeforeLogin: 'Confirma tu correo antes de iniciar sesión.',
    sessionConfirmFailed:
        'No se pudo confirmar la sesión. Intenta de nuevo.',
  );

  static const english = AppStrings._(
    locale: AppLocale.en,
    authOfficialGameArchive: 'OFFICIAL GAME ARCHIVE',
    tabHome: 'Home',
    tabArchive: 'Archive',
    tabTracks: 'Tracks',
    tabProfile: 'Profile',
    officialArchiveLabel: 'OFFICIAL ARCHIVE',
    homeBannerDescription:
        'Explore the game universe: story, characters, and storyboard.',
    exploration: 'EXPLORE',
    whatToExplore: 'What do you want to explore?',
    archiveOverline: 'ARCHIVE',
    gameWiki: 'Game wiki',
    pickWikiSection: 'Pick a section to read its content.',
    tracksOverline: 'TRACKS',
    gameMusic: 'Game music',
    tracksDescription: 'Play the official Campus Quest tracks.',
    profileOverline: 'PROFILE',
    yourAccount: 'Your account',
    noName: 'No name',
    tapPhotoToChange: 'Tap the photo to change it',
    languageOverline: 'LANGUAGE',
    languageSpanish: 'Español',
    languageEnglish: 'English',
    nameOverline: 'NAME',
    yourName: 'Your name',
    saveName: 'Save name  →',
    passwordOverline: 'PASSWORD',
    password: 'Password',
    enterPassword: 'Enter your password',
    confirmPassword: 'Confirm password',
    repeatPassword: 'Repeat your password',
    savePassword: 'Save password  →',
    logout: 'Sign out',
    welcomeBack: 'WELCOME BACK',
    continueAdventure: 'Continue your adventure',
    loginSubtitle:
        'Sign in to explore the Campus Quest universe.',
    email: 'Email',
    forgotPassword: 'Forgot your password?',
    createAccountLink: 'Create account',
    signIn: 'Sign in  →',
    newGame: 'NEW GAME',
    createAccountTitle: 'Create your account',
    registerSubtitle:
        'Choose an email and password to enter the archive.',
    name: 'Name',
    signInLink: 'Sign in',
    createAccountButton: 'Create account  →',
    recoveryOverline: 'RECOVERY',
    recoverAccess: 'Recover your access',
    recoverSubtitle:
        'We will email you a link to choose a new password.',
    recoverEmailSent:
        'If the email is registered, we sent a link to choose a new password.',
    sendResetLink: 'Send link  →',
    newPasswordTitle: 'New password',
    updatePasswordSubtitle:
        'Choose a new password to return to the archive.',
    preparingArchive: 'Preparing your archive…',
    contentPreparing: 'Content coming soon',
    enterEmail: 'Enter your email.',
    enterValidEmail: 'Enter a valid email.',
    enterName: 'Enter your name.',
    enterPasswordPrompt: 'Enter your password.',
    passwordRules:
        'Use at least 6 characters: letters, numbers, or symbols.',
    nameRules:
        'Start with a capital letter, at least 5 characters, letters only. '
        'Capitalize each word with a single space between words.',
    confirmPasswordPrompt: 'Confirm your password.',
    passwordsDoNotMatch: 'Passwords do not match.',
    signInToUploadPhoto: 'Sign in to upload your photo.',
    uploadPhotoFailed: 'Could not upload the photo. Try again.',
    updateNameFailed: 'Could not update the name. Try again.',
    checkEmailConfirm: 'Check your email to confirm your account.',
    registerFailed: 'Could not create the account. Try again.',
    loginFailed: 'Could not sign in. Try again.',
    sendLinkFailed: 'Could not send the link. Try again.',
    updatePasswordFailed: 'Could not update the password. Try again.',
    emailAlreadyRegistered: 'That email is already registered.',
    invalidCredentials: 'Incorrect email or password.',
    confirmEmailBeforeLogin: 'Confirm your email before signing in.',
    sessionConfirmFailed: 'Could not confirm the session. Try again.',
  );
}
