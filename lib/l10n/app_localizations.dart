import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('ja'),
    Locale('ko'),
  ];

  /// No description provided for @appTagline.
  ///
  /// In ko, this message translates to:
  /// **'인플루언서 캠페인의 궤도'**
  String get appTagline;

  /// No description provided for @continueWithApple.
  ///
  /// In ko, this message translates to:
  /// **'Apple로 계속하기'**
  String get continueWithApple;

  /// No description provided for @continueWithGoogle.
  ///
  /// In ko, this message translates to:
  /// **'Google로 계속하기'**
  String get continueWithGoogle;

  /// No description provided for @orDivider.
  ///
  /// In ko, this message translates to:
  /// **'또는'**
  String get orDivider;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In ko, this message translates to:
  /// **'캠페인과 인플루언서를 잇는 가장 빠른 길'**
  String get welcomeSubtitle;

  /// No description provided for @login.
  ///
  /// In ko, this message translates to:
  /// **'로그인'**
  String get login;

  /// No description provided for @signupWithEmail.
  ///
  /// In ko, this message translates to:
  /// **'이메일로 회원가입'**
  String get signupWithEmail;

  /// No description provided for @email.
  ///
  /// In ko, this message translates to:
  /// **'이메일'**
  String get email;

  /// No description provided for @passwordHint6.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호 (6자 이상)'**
  String get passwordHint6;

  /// No description provided for @passwordConfirm.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호 확인'**
  String get passwordConfirm;

  /// No description provided for @passwordMin6.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호는 6자 이상이어야 합니다.'**
  String get passwordMin6;

  /// No description provided for @passwordMismatch.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호가 일치하지 않아요.'**
  String get passwordMismatch;

  /// No description provided for @haveAccount.
  ///
  /// In ko, this message translates to:
  /// **'이미 계정이 있어요'**
  String get haveAccount;

  /// No description provided for @continueLabel.
  ///
  /// In ko, this message translates to:
  /// **'계속하기'**
  String get continueLabel;

  /// No description provided for @signup.
  ///
  /// In ko, this message translates to:
  /// **'회원가입'**
  String get signup;

  /// No description provided for @profileStepTitle.
  ///
  /// In ko, this message translates to:
  /// **'프로필을 알려주세요'**
  String get profileStepTitle;

  /// No description provided for @signupMethodTitle.
  ///
  /// In ko, this message translates to:
  /// **'가입 방법을 선택하세요'**
  String get signupMethodTitle;

  /// No description provided for @signupTitle.
  ///
  /// In ko, this message translates to:
  /// **'이메일과 비밀번호로\n계정을 만들어주세요'**
  String get signupTitle;

  /// No description provided for @profileSetup.
  ///
  /// In ko, this message translates to:
  /// **'프로필 설정'**
  String get profileSetup;

  /// No description provided for @onboardingTitle.
  ///
  /// In ko, this message translates to:
  /// **'어떤 목적으로\n사용하실 건가요?'**
  String get onboardingTitle;

  /// No description provided for @roleCompany.
  ///
  /// In ko, this message translates to:
  /// **'회사 · 브랜드'**
  String get roleCompany;

  /// No description provided for @roleCompanyDesc.
  ///
  /// In ko, this message translates to:
  /// **'캠페인을 등록하고 인플루언서를 모집해요'**
  String get roleCompanyDesc;

  /// No description provided for @roleInfluencer.
  ///
  /// In ko, this message translates to:
  /// **'인플루언서'**
  String get roleInfluencer;

  /// No description provided for @roleInfluencerDesc.
  ///
  /// In ko, this message translates to:
  /// **'TikTok을 연동하고 캠페인에 지원해요'**
  String get roleInfluencerDesc;

  /// No description provided for @companyName.
  ///
  /// In ko, this message translates to:
  /// **'회사명'**
  String get companyName;

  /// No description provided for @nickname.
  ///
  /// In ko, this message translates to:
  /// **'닉네임'**
  String get nickname;

  /// No description provided for @contactOptional.
  ///
  /// In ko, this message translates to:
  /// **'연락처 (선택)'**
  String get contactOptional;

  /// No description provided for @start.
  ///
  /// In ko, this message translates to:
  /// **'시작하기'**
  String get start;

  /// No description provided for @selectRole.
  ///
  /// In ko, this message translates to:
  /// **'역할을 선택해주세요.'**
  String get selectRole;

  /// No description provided for @enterCompanyName.
  ///
  /// In ko, this message translates to:
  /// **'회사명을 입력해주세요.'**
  String get enterCompanyName;

  /// No description provided for @enterNickname.
  ///
  /// In ko, this message translates to:
  /// **'닉네임을 입력해주세요.'**
  String get enterNickname;

  /// No description provided for @navCampaigns.
  ///
  /// In ko, this message translates to:
  /// **'캠페인'**
  String get navCampaigns;

  /// No description provided for @navExplore.
  ///
  /// In ko, this message translates to:
  /// **'둘러보기'**
  String get navExplore;

  /// No description provided for @navMyApplications.
  ///
  /// In ko, this message translates to:
  /// **'내 지원'**
  String get navMyApplications;

  /// No description provided for @navSettlement.
  ///
  /// In ko, this message translates to:
  /// **'정산'**
  String get navSettlement;

  /// No description provided for @navNotifications.
  ///
  /// In ko, this message translates to:
  /// **'알림'**
  String get navNotifications;

  /// No description provided for @navProfile.
  ///
  /// In ko, this message translates to:
  /// **'프로필'**
  String get navProfile;

  /// No description provided for @navBoard.
  ///
  /// In ko, this message translates to:
  /// **'게시판'**
  String get navBoard;

  /// No description provided for @boardAll.
  ///
  /// In ko, this message translates to:
  /// **'전체'**
  String get boardAll;

  /// No description provided for @boardCatFree.
  ///
  /// In ko, this message translates to:
  /// **'자유'**
  String get boardCatFree;

  /// No description provided for @boardCatQuestion.
  ///
  /// In ko, this message translates to:
  /// **'질문'**
  String get boardCatQuestion;

  /// No description provided for @boardCatTip.
  ///
  /// In ko, this message translates to:
  /// **'꿀팁'**
  String get boardCatTip;

  /// No description provided for @boardCatReview.
  ///
  /// In ko, this message translates to:
  /// **'리뷰'**
  String get boardCatReview;

  /// No description provided for @boardWrite.
  ///
  /// In ko, this message translates to:
  /// **'글쓰기'**
  String get boardWrite;

  /// No description provided for @boardCategory.
  ///
  /// In ko, this message translates to:
  /// **'카테고리'**
  String get boardCategory;

  /// No description provided for @boardBody.
  ///
  /// In ko, this message translates to:
  /// **'본문'**
  String get boardBody;

  /// No description provided for @boardTitleHint.
  ///
  /// In ko, this message translates to:
  /// **'제목을 입력하세요'**
  String get boardTitleHint;

  /// No description provided for @boardBodyHint.
  ///
  /// In ko, this message translates to:
  /// **'자유롭게 이야기를 나눠보세요'**
  String get boardBodyHint;

  /// No description provided for @boardEmpty.
  ///
  /// In ko, this message translates to:
  /// **'아직 게시글이 없어요.\n첫 글을 남겨보세요!'**
  String get boardEmpty;

  /// No description provided for @boardComments.
  ///
  /// In ko, this message translates to:
  /// **'댓글'**
  String get boardComments;

  /// No description provided for @boardNoComments.
  ///
  /// In ko, this message translates to:
  /// **'아직 댓글이 없어요.'**
  String get boardNoComments;

  /// No description provided for @boardCommentHint.
  ///
  /// In ko, this message translates to:
  /// **'댓글을 입력하세요'**
  String get boardCommentHint;

  /// No description provided for @like.
  ///
  /// In ko, this message translates to:
  /// **'좋아요'**
  String get like;

  /// No description provided for @deletePost.
  ///
  /// In ko, this message translates to:
  /// **'게시글 삭제'**
  String get deletePost;

  /// No description provided for @myBookmarks.
  ///
  /// In ko, this message translates to:
  /// **'내 찜'**
  String get myBookmarks;

  /// No description provided for @bookmark.
  ///
  /// In ko, this message translates to:
  /// **'찜'**
  String get bookmark;

  /// No description provided for @bookmarksEmpty.
  ///
  /// In ko, this message translates to:
  /// **'아직 찜한 캠페인이 없어요.'**
  String get bookmarksEmpty;

  /// No description provided for @sortLatest.
  ///
  /// In ko, this message translates to:
  /// **'최신순'**
  String get sortLatest;

  /// No description provided for @sortPopular.
  ///
  /// In ko, this message translates to:
  /// **'인기순'**
  String get sortPopular;

  /// No description provided for @darkMode.
  ///
  /// In ko, this message translates to:
  /// **'다크 모드'**
  String get darkMode;

  /// No description provided for @pushNotifications.
  ///
  /// In ko, this message translates to:
  /// **'푸시 알림'**
  String get pushNotifications;

  /// No description provided for @pushBlockedMessage.
  ///
  /// In ko, this message translates to:
  /// **'알림이 꺼져 있어요. 기기 설정에서 알림을 켜주세요.'**
  String get pushBlockedMessage;

  /// No description provided for @openSettings.
  ///
  /// In ko, this message translates to:
  /// **'설정 열기'**
  String get openSettings;

  /// No description provided for @logout.
  ///
  /// In ko, this message translates to:
  /// **'로그아웃'**
  String get logout;

  /// No description provided for @deleteAccount.
  ///
  /// In ko, this message translates to:
  /// **'회원탈퇴'**
  String get deleteAccount;

  /// No description provided for @deleteAccountWarning.
  ///
  /// In ko, this message translates to:
  /// **'계정과 모든 데이터(캠페인·지원·게시글 등)가 영구 삭제되며 복구할 수 없어요. 정말 탈퇴하시겠어요?'**
  String get deleteAccountWarning;

  /// No description provided for @withdraw.
  ///
  /// In ko, this message translates to:
  /// **'탈퇴'**
  String get withdraw;

  /// No description provided for @cancel.
  ///
  /// In ko, this message translates to:
  /// **'취소'**
  String get cancel;

  /// No description provided for @language.
  ///
  /// In ko, this message translates to:
  /// **'언어'**
  String get language;

  /// No description provided for @tiktokConnect.
  ///
  /// In ko, this message translates to:
  /// **'TikTok 연동'**
  String get tiktokConnect;

  /// No description provided for @tiktokConnectDesc.
  ///
  /// In ko, this message translates to:
  /// **'팔로워 통계 연동 / 관리'**
  String get tiktokConnectDesc;

  /// No description provided for @tiktokLinkTitle.
  ///
  /// In ko, this message translates to:
  /// **'TikTok 계정을 연동하세요'**
  String get tiktokLinkTitle;

  /// No description provided for @tiktokLinkDesc.
  ///
  /// In ko, this message translates to:
  /// **'본인 인증과 팔로워 통계를 가져와\n캠페인 지원 시 포트폴리오로 보여줘요.'**
  String get tiktokLinkDesc;

  /// No description provided for @tiktokLinkCta.
  ///
  /// In ko, this message translates to:
  /// **'TikTok 연동하기'**
  String get tiktokLinkCta;

  /// No description provided for @tiktokNotConfigured.
  ///
  /// In ko, this message translates to:
  /// **'TikTok 앱 설정이 아직 안 됐어요 (관리자 설정 필요).'**
  String get tiktokNotConfigured;

  /// No description provided for @tiktokNoCode.
  ///
  /// In ko, this message translates to:
  /// **'인증 코드를 받지 못했어요.'**
  String get tiktokNoCode;

  /// No description provided for @tiktokLinked.
  ///
  /// In ko, this message translates to:
  /// **'TikTok 연동 완료!'**
  String get tiktokLinked;

  /// No description provided for @tiktokCanceled.
  ///
  /// In ko, this message translates to:
  /// **'연동이 취소됐어요.'**
  String get tiktokCanceled;

  /// No description provided for @statFollowers.
  ///
  /// In ko, this message translates to:
  /// **'팔로워'**
  String get statFollowers;

  /// No description provided for @statFollowing.
  ///
  /// In ko, this message translates to:
  /// **'팔로잉'**
  String get statFollowing;

  /// No description provided for @statLikes.
  ///
  /// In ko, this message translates to:
  /// **'좋아요'**
  String get statLikes;

  /// No description provided for @statVideos.
  ///
  /// In ko, this message translates to:
  /// **'영상'**
  String get statVideos;

  /// No description provided for @refreshStats.
  ///
  /// In ko, this message translates to:
  /// **'통계 새로고침'**
  String get refreshStats;

  /// No description provided for @tiktokUnlink.
  ///
  /// In ko, this message translates to:
  /// **'연동 해제'**
  String get tiktokUnlink;

  /// No description provided for @accountTypeCompany.
  ///
  /// In ko, this message translates to:
  /// **'회사'**
  String get accountTypeCompany;

  /// No description provided for @accountTypeInfluencer.
  ///
  /// In ko, this message translates to:
  /// **'인플루언서'**
  String get accountTypeInfluencer;

  /// No description provided for @editProfile.
  ///
  /// In ko, this message translates to:
  /// **'프로필 편집'**
  String get editProfile;

  /// No description provided for @loginMethod.
  ///
  /// In ko, this message translates to:
  /// **'로그인 방법'**
  String get loginMethod;

  /// No description provided for @save.
  ///
  /// In ko, this message translates to:
  /// **'저장'**
  String get save;

  /// No description provided for @changePhoto.
  ///
  /// In ko, this message translates to:
  /// **'사진 변경'**
  String get changePhoto;

  /// No description provided for @menu.
  ///
  /// In ko, this message translates to:
  /// **'메뉴'**
  String get menu;

  /// No description provided for @profileUpdated.
  ///
  /// In ko, this message translates to:
  /// **'프로필이 변경되었어요.'**
  String get profileUpdated;

  /// No description provided for @authInvalidCredentials.
  ///
  /// In ko, this message translates to:
  /// **'이메일 또는 비밀번호가 올바르지 않아요.'**
  String get authInvalidCredentials;

  /// No description provided for @authEmailInUse.
  ///
  /// In ko, this message translates to:
  /// **'이미 가입된 이메일이에요.'**
  String get authEmailInUse;

  /// No description provided for @authNetwork.
  ///
  /// In ko, this message translates to:
  /// **'네트워크 연결을 확인해주세요.'**
  String get authNetwork;

  /// No description provided for @authGeneric.
  ///
  /// In ko, this message translates to:
  /// **'문제가 발생했어요. 잠시 후 다시 시도해주세요.'**
  String get authGeneric;

  /// No description provided for @authCanceled.
  ///
  /// In ko, this message translates to:
  /// **'로그인이 취소되었어요.'**
  String get authCanceled;

  /// No description provided for @emailConfirmSent.
  ///
  /// In ko, this message translates to:
  /// **'확인 메일을 보냈어요. 메일 인증 후 로그인해주세요.'**
  String get emailConfirmSent;

  /// No description provided for @newCampaign.
  ///
  /// In ko, this message translates to:
  /// **'새 캠페인'**
  String get newCampaign;

  /// No description provided for @next.
  ///
  /// In ko, this message translates to:
  /// **'다음'**
  String get next;

  /// No description provided for @register.
  ///
  /// In ko, this message translates to:
  /// **'등록하기'**
  String get register;

  /// No description provided for @wizardTypeTitle.
  ///
  /// In ko, this message translates to:
  /// **'어떤 캠페인인가요?'**
  String get wizardTypeTitle;

  /// No description provided for @wizardTypeSub.
  ///
  /// In ko, this message translates to:
  /// **'진행할 캠페인 유형을 선택해주세요.'**
  String get wizardTypeSub;

  /// No description provided for @typeDelivery.
  ///
  /// In ko, this message translates to:
  /// **'배송형'**
  String get typeDelivery;

  /// No description provided for @typeDeliveryDesc.
  ///
  /// In ko, this message translates to:
  /// **'제품을 보내고 리뷰를 받아요'**
  String get typeDeliveryDesc;

  /// No description provided for @typeVisit.
  ///
  /// In ko, this message translates to:
  /// **'방문형'**
  String get typeVisit;

  /// No description provided for @typeVisitDesc.
  ///
  /// In ko, this message translates to:
  /// **'매장 방문 후 콘텐츠를 만들어요'**
  String get typeVisitDesc;

  /// No description provided for @typePress.
  ///
  /// In ko, this message translates to:
  /// **'기자단'**
  String get typePress;

  /// No description provided for @typePressDesc.
  ///
  /// In ko, this message translates to:
  /// **'보도·홍보성 콘텐츠를 제작해요'**
  String get typePressDesc;

  /// No description provided for @wizardInfoTitle.
  ///
  /// In ko, this message translates to:
  /// **'캠페인을 소개해주세요'**
  String get wizardInfoTitle;

  /// No description provided for @wizardInfoSub.
  ///
  /// In ko, this message translates to:
  /// **'제목과 카테고리를 입력해주세요.'**
  String get wizardInfoSub;

  /// No description provided for @fieldTitle.
  ///
  /// In ko, this message translates to:
  /// **'제목'**
  String get fieldTitle;

  /// No description provided for @categoryOptional.
  ///
  /// In ko, this message translates to:
  /// **'카테고리 (선택)'**
  String get categoryOptional;

  /// No description provided for @wizardRewardTitle.
  ///
  /// In ko, this message translates to:
  /// **'어떤 혜택을 제공하나요?'**
  String get wizardRewardTitle;

  /// No description provided for @wizardRewardSub.
  ///
  /// In ko, this message translates to:
  /// **'제공 혜택과 모집 조건을 입력해주세요.'**
  String get wizardRewardSub;

  /// No description provided for @rewardOptional.
  ///
  /// In ko, this message translates to:
  /// **'제공 혜택 (선택)'**
  String get rewardOptional;

  /// No description provided for @amountWon.
  ///
  /// In ko, this message translates to:
  /// **'지급액(원)'**
  String get amountWon;

  /// No description provided for @recruitCountLabel.
  ///
  /// In ko, this message translates to:
  /// **'모집 인원'**
  String get recruitCountLabel;

  /// No description provided for @minFollowersLabel.
  ///
  /// In ko, this message translates to:
  /// **'최소 팔로워 수'**
  String get minFollowersLabel;

  /// No description provided for @wizardDeadlineTitle.
  ///
  /// In ko, this message translates to:
  /// **'언제까지 모집하나요?'**
  String get wizardDeadlineTitle;

  /// No description provided for @wizardDeadlineSub.
  ///
  /// In ko, this message translates to:
  /// **'지원 마감일을 선택해주세요. (선택)'**
  String get wizardDeadlineSub;

  /// No description provided for @pickDeadline.
  ///
  /// In ko, this message translates to:
  /// **'마감일 선택하기'**
  String get pickDeadline;

  /// No description provided for @wizardDetailTitle.
  ///
  /// In ko, this message translates to:
  /// **'캠페인을 자세히 설명해주세요'**
  String get wizardDetailTitle;

  /// No description provided for @wizardDetailSub.
  ///
  /// In ko, this message translates to:
  /// **'소개와 콘텐츠 가이드를 입력해주세요. (선택)'**
  String get wizardDetailSub;

  /// No description provided for @intro.
  ///
  /// In ko, this message translates to:
  /// **'소개'**
  String get intro;

  /// No description provided for @contentGuide.
  ///
  /// In ko, this message translates to:
  /// **'콘텐츠 가이드'**
  String get contentGuide;

  /// No description provided for @wizardReviewTitle.
  ///
  /// In ko, this message translates to:
  /// **'거의 다 됐어요!'**
  String get wizardReviewTitle;

  /// No description provided for @wizardReviewSub.
  ///
  /// In ko, this message translates to:
  /// **'입력한 내용을 확인하고 등록해주세요.'**
  String get wizardReviewSub;

  /// No description provided for @publishNow.
  ///
  /// In ko, this message translates to:
  /// **'바로 발행하기'**
  String get publishNow;

  /// No description provided for @publishNowDesc.
  ///
  /// In ko, this message translates to:
  /// **'끄면 작성중(draft)으로 저장돼요'**
  String get publishNowDesc;

  /// No description provided for @summaryType.
  ///
  /// In ko, this message translates to:
  /// **'유형'**
  String get summaryType;

  /// No description provided for @summaryReward.
  ///
  /// In ko, this message translates to:
  /// **'혜택'**
  String get summaryReward;

  /// No description provided for @summaryRecruit.
  ///
  /// In ko, this message translates to:
  /// **'모집'**
  String get summaryRecruit;

  /// No description provided for @summaryDeadline.
  ///
  /// In ko, this message translates to:
  /// **'마감'**
  String get summaryDeadline;

  /// No description provided for @notSet.
  ///
  /// In ko, this message translates to:
  /// **'미설정'**
  String get notSet;

  /// No description provided for @enterTitle.
  ///
  /// In ko, this message translates to:
  /// **'제목을 입력해주세요.'**
  String get enterTitle;

  /// No description provided for @markAllRead.
  ///
  /// In ko, this message translates to:
  /// **'모두 읽음'**
  String get markAllRead;

  /// No description provided for @noNotifications.
  ///
  /// In ko, this message translates to:
  /// **'새로운 알림이 없어요.'**
  String get noNotifications;

  /// No description provided for @tryAgainLater.
  ///
  /// In ko, this message translates to:
  /// **'잠시 후 다시 시도해주세요'**
  String get tryAgainLater;

  /// No description provided for @retry.
  ///
  /// In ko, this message translates to:
  /// **'다시 시도'**
  String get retry;

  /// No description provided for @deletePostConfirm.
  ///
  /// In ko, this message translates to:
  /// **'정말 삭제할까요? 되돌릴 수 없어요.'**
  String get deletePostConfirm;

  /// No description provided for @delete.
  ///
  /// In ko, this message translates to:
  /// **'삭제'**
  String get delete;

  /// No description provided for @timeJustNow.
  ///
  /// In ko, this message translates to:
  /// **'방금'**
  String get timeJustNow;

  /// No description provided for @mySettlements.
  ///
  /// In ko, this message translates to:
  /// **'내 정산'**
  String get mySettlements;

  /// No description provided for @settlementsEmpty.
  ///
  /// In ko, this message translates to:
  /// **'아직 정산 내역이 없어요.'**
  String get settlementsEmpty;

  /// No description provided for @campaignFallback.
  ///
  /// In ko, this message translates to:
  /// **'캠페인'**
  String get campaignFallback;

  /// No description provided for @brandFallback.
  ///
  /// In ko, this message translates to:
  /// **'브랜드'**
  String get brandFallback;

  /// No description provided for @timeMinutesAgo.
  ///
  /// In ko, this message translates to:
  /// **'{count}분 전'**
  String timeMinutesAgo(int count);

  /// No description provided for @timeHoursAgo.
  ///
  /// In ko, this message translates to:
  /// **'{count}시간 전'**
  String timeHoursAgo(int count);

  /// No description provided for @timeDaysAgo.
  ///
  /// In ko, this message translates to:
  /// **'{count}일 전'**
  String timeDaysAgo(int count);

  /// No description provided for @wonAmount.
  ///
  /// In ko, this message translates to:
  /// **'{amount}원'**
  String wonAmount(String amount);

  /// No description provided for @wizardInfoSubImage.
  ///
  /// In ko, this message translates to:
  /// **'대표 이미지·제목·카테고리를 입력해주세요.'**
  String get wizardInfoSubImage;

  /// No description provided for @wizardThumbnailOptional.
  ///
  /// In ko, this message translates to:
  /// **'대표 이미지 (선택)'**
  String get wizardThumbnailOptional;

  /// No description provided for @wizardTitleHint.
  ///
  /// In ko, this message translates to:
  /// **'예) 신상 립밤 체험단 모집'**
  String get wizardTitleHint;

  /// No description provided for @wizardCategoryHint.
  ///
  /// In ko, this message translates to:
  /// **'예) 뷰티, 푸드, 패션'**
  String get wizardCategoryHint;

  /// No description provided for @wizardAddThumbnail.
  ///
  /// In ko, this message translates to:
  /// **'대표 이미지 추가'**
  String get wizardAddThumbnail;

  /// No description provided for @wizardChange.
  ///
  /// In ko, this message translates to:
  /// **'변경'**
  String get wizardChange;

  /// No description provided for @wizardRewardHint.
  ///
  /// In ko, this message translates to:
  /// **'예) 제품 무료 제공'**
  String get wizardRewardHint;

  /// No description provided for @wizardDescHint.
  ///
  /// In ko, this message translates to:
  /// **'캠페인 소개'**
  String get wizardDescHint;

  /// No description provided for @wizardGuideHint.
  ///
  /// In ko, this message translates to:
  /// **'인플루언서가 지켜야 할 가이드'**
  String get wizardGuideHint;

  /// No description provided for @wizardRecruitCount.
  ///
  /// In ko, this message translates to:
  /// **'{count}명'**
  String wizardRecruitCount(int count);

  /// No description provided for @wizardPublishNowDesc.
  ///
  /// In ko, this message translates to:
  /// **'체크하면 인플루언서에게 바로 노출돼요.\n해제하면 작성중(draft)으로 저장돼요.'**
  String get wizardPublishNowDesc;

  /// No description provided for @campaignFormDelete.
  ///
  /// In ko, this message translates to:
  /// **'캠페인 삭제'**
  String get campaignFormDelete;

  /// No description provided for @campaignFormEditTitle.
  ///
  /// In ko, this message translates to:
  /// **'캠페인 수정'**
  String get campaignFormEditTitle;

  /// No description provided for @campaignFormTitleHint.
  ///
  /// In ko, this message translates to:
  /// **'캠페인 제목'**
  String get campaignFormTitleHint;

  /// No description provided for @campaignFormCategoryHint.
  ///
  /// In ko, this message translates to:
  /// **'예) 뷰티, 푸드'**
  String get campaignFormCategoryHint;

  /// No description provided for @campaignFormReward.
  ///
  /// In ko, this message translates to:
  /// **'제공 혜택'**
  String get campaignFormReward;

  /// No description provided for @campaignFormDeadline.
  ///
  /// In ko, this message translates to:
  /// **'마감일'**
  String get campaignFormDeadline;

  /// No description provided for @campaignFormPickDate.
  ///
  /// In ko, this message translates to:
  /// **'날짜 선택'**
  String get campaignFormPickDate;

  /// No description provided for @campaignFormSave.
  ///
  /// In ko, this message translates to:
  /// **'저장하기'**
  String get campaignFormSave;

  /// No description provided for @campaignDetailTitle.
  ///
  /// In ko, this message translates to:
  /// **'캠페인 상세'**
  String get campaignDetailTitle;

  /// No description provided for @campaignDetailRewardLabel.
  ///
  /// In ko, this message translates to:
  /// **'제공'**
  String get campaignDetailRewardLabel;

  /// No description provided for @campaignDetailPeopleCount.
  ///
  /// In ko, this message translates to:
  /// **'{count}명'**
  String campaignDetailPeopleCount(int count);

  /// No description provided for @campaignDetailMinFollowers.
  ///
  /// In ko, this message translates to:
  /// **'최소 팔로워'**
  String get campaignDetailMinFollowers;

  /// No description provided for @campaignDetailIntroSection.
  ///
  /// In ko, this message translates to:
  /// **'캠페인 소개'**
  String get campaignDetailIntroSection;

  /// No description provided for @campaignDetailApplySuccess.
  ///
  /// In ko, this message translates to:
  /// **'지원이 완료됐어요!'**
  String get campaignDetailApplySuccess;

  /// No description provided for @campaignDetailAlreadyApplied.
  ///
  /// In ko, this message translates to:
  /// **'이미 지원한 캠페인이에요.'**
  String get campaignDetailAlreadyApplied;

  /// No description provided for @campaignDetailCancelSuccess.
  ///
  /// In ko, this message translates to:
  /// **'지원을 취소했어요.'**
  String get campaignDetailCancelSuccess;

  /// No description provided for @campaignDetailDeleteTitle.
  ///
  /// In ko, this message translates to:
  /// **'캠페인 삭제'**
  String get campaignDetailDeleteTitle;

  /// No description provided for @campaignDetailDeleteConfirm.
  ///
  /// In ko, this message translates to:
  /// **'이 캠페인을 삭제할까요? 지원 내역도 함께 사라지며 되돌릴 수 없어요.'**
  String get campaignDetailDeleteConfirm;

  /// No description provided for @campaignDetailDeleteSuccess.
  ///
  /// In ko, this message translates to:
  /// **'캠페인을 삭제했어요.'**
  String get campaignDetailDeleteSuccess;

  /// No description provided for @campaignDetailApply.
  ///
  /// In ko, this message translates to:
  /// **'지원하기'**
  String get campaignDetailApply;

  /// No description provided for @campaignDetailCancelApply.
  ///
  /// In ko, this message translates to:
  /// **'지원취소하기'**
  String get campaignDetailCancelApply;

  /// No description provided for @campaignDetailStatusAccepted.
  ///
  /// In ko, this message translates to:
  /// **'선정됐어요 ✓'**
  String get campaignDetailStatusAccepted;

  /// No description provided for @campaignDetailStatusSubmitted.
  ///
  /// In ko, this message translates to:
  /// **'제출 완료'**
  String get campaignDetailStatusSubmitted;

  /// No description provided for @campaignDetailStatusCompleted.
  ///
  /// In ko, this message translates to:
  /// **'완료'**
  String get campaignDetailStatusCompleted;

  /// No description provided for @campaignDetailStatusRejected.
  ///
  /// In ko, this message translates to:
  /// **'미선정'**
  String get campaignDetailStatusRejected;

  /// No description provided for @campaignDetailStatusApplied.
  ///
  /// In ko, this message translates to:
  /// **'지원 완료'**
  String get campaignDetailStatusApplied;

  /// No description provided for @campaignDetailViewApplicants.
  ///
  /// In ko, this message translates to:
  /// **'지원자 보기'**
  String get campaignDetailViewApplicants;

  /// No description provided for @campaignDetailEdit.
  ///
  /// In ko, this message translates to:
  /// **'수정'**
  String get campaignDetailEdit;

  /// No description provided for @campaignDetailClose.
  ///
  /// In ko, this message translates to:
  /// **'마감하기'**
  String get campaignDetailClose;

  /// No description provided for @campaignDetailPublish.
  ///
  /// In ko, this message translates to:
  /// **'발행하기'**
  String get campaignDetailPublish;

  /// No description provided for @campaignCardRewardFallback.
  ///
  /// In ko, this message translates to:
  /// **'제공 혜택'**
  String get campaignCardRewardFallback;

  /// No description provided for @campaignCardApplicantCount.
  ///
  /// In ko, this message translates to:
  /// **'지원 {count}명'**
  String campaignCardApplicantCount(int count);

  /// No description provided for @campaignCardRecruitCount.
  ///
  /// In ko, this message translates to:
  /// **'모집 {count}명'**
  String campaignCardRecruitCount(int count);

  /// No description provided for @applyMyApplicationsTitle.
  ///
  /// In ko, this message translates to:
  /// **'내 지원 현황'**
  String get applyMyApplicationsTitle;

  /// No description provided for @applyEmpty.
  ///
  /// In ko, this message translates to:
  /// **'아직 지원한 캠페인이 없어요.'**
  String get applyEmpty;

  /// No description provided for @applyFavoritesSection.
  ///
  /// In ko, this message translates to:
  /// **'⭐ 즐겨찾기'**
  String get applyFavoritesSection;

  /// No description provided for @applyPin.
  ///
  /// In ko, this message translates to:
  /// **'즐겨찾기'**
  String get applyPin;

  /// No description provided for @applyUnpin.
  ///
  /// In ko, this message translates to:
  /// **'즐겨찾기 해제'**
  String get applyUnpin;

  /// No description provided for @applyCancelAction.
  ///
  /// In ko, this message translates to:
  /// **'지원취소'**
  String get applyCancelAction;

  /// No description provided for @applyCancelTitle.
  ///
  /// In ko, this message translates to:
  /// **'지원 취소'**
  String get applyCancelTitle;

  /// No description provided for @applyCancelConfirm.
  ///
  /// In ko, this message translates to:
  /// **'이 캠페인 지원을 취소할까요? 되돌릴 수 없어요.'**
  String get applyCancelConfirm;

  /// No description provided for @applyNo.
  ///
  /// In ko, this message translates to:
  /// **'아니요'**
  String get applyNo;

  /// No description provided for @applyResubmitContent.
  ///
  /// In ko, this message translates to:
  /// **'콘텐츠 다시 제출'**
  String get applyResubmitContent;

  /// No description provided for @applySubmitContent.
  ///
  /// In ko, this message translates to:
  /// **'콘텐츠 제출하기'**
  String get applySubmitContent;

  /// No description provided for @applyLeaveReview.
  ///
  /// In ko, this message translates to:
  /// **'캠페인 리뷰 남기기'**
  String get applyLeaveReview;

  /// No description provided for @applyRatingTitle.
  ///
  /// In ko, this message translates to:
  /// **'캠페인 평가'**
  String get applyRatingTitle;

  /// No description provided for @applySubmitTitle.
  ///
  /// In ko, this message translates to:
  /// **'콘텐츠 제출'**
  String get applySubmitTitle;

  /// No description provided for @applyContentUrlHint.
  ///
  /// In ko, this message translates to:
  /// **'콘텐츠 URL (예: TikTok 링크)'**
  String get applyContentUrlHint;

  /// No description provided for @applyNoteHint.
  ///
  /// In ko, this message translates to:
  /// **'메모 (선택)'**
  String get applyNoteHint;

  /// No description provided for @applySubmit.
  ///
  /// In ko, this message translates to:
  /// **'제출'**
  String get applySubmit;

  /// No description provided for @applyContentUrlRequired.
  ///
  /// In ko, this message translates to:
  /// **'콘텐츠 URL을 입력해주세요.'**
  String get applyContentUrlRequired;

  /// No description provided for @applicantsTitle.
  ///
  /// In ko, this message translates to:
  /// **'지원자'**
  String get applicantsTitle;

  /// No description provided for @applicantsEmpty.
  ///
  /// In ko, this message translates to:
  /// **'아직 지원자가 없어요.'**
  String get applicantsEmpty;

  /// No description provided for @applicantsSettleDone.
  ///
  /// In ko, this message translates to:
  /// **'정산 등록 완료'**
  String get applicantsSettleDone;

  /// No description provided for @applicantsReject.
  ///
  /// In ko, this message translates to:
  /// **'미선정'**
  String get applicantsReject;

  /// No description provided for @applicantsAccept.
  ///
  /// In ko, this message translates to:
  /// **'선정'**
  String get applicantsAccept;

  /// No description provided for @applicantsSettle.
  ///
  /// In ko, this message translates to:
  /// **'정산하기'**
  String get applicantsSettle;

  /// No description provided for @applicantsRatingTitle.
  ///
  /// In ko, this message translates to:
  /// **'인플루언서 평가'**
  String get applicantsRatingTitle;

  /// No description provided for @applicantsReview.
  ///
  /// In ko, this message translates to:
  /// **'리뷰'**
  String get applicantsReview;

  /// No description provided for @applicantsSettleAmountTitle.
  ///
  /// In ko, this message translates to:
  /// **'정산 금액'**
  String get applicantsSettleAmountTitle;

  /// No description provided for @applicantsAmountHint.
  ///
  /// In ko, this message translates to:
  /// **'금액(원)'**
  String get applicantsAmountHint;

  /// No description provided for @applicantsWonSuffix.
  ///
  /// In ko, this message translates to:
  /// **'원'**
  String get applicantsWonSuffix;

  /// No description provided for @applicantsConfirm.
  ///
  /// In ko, this message translates to:
  /// **'확인'**
  String get applicantsConfirm;

  /// No description provided for @ratingTitleDefault.
  ///
  /// In ko, this message translates to:
  /// **'리뷰 남기기'**
  String get ratingTitleDefault;

  /// No description provided for @ratingSubmitted.
  ///
  /// In ko, this message translates to:
  /// **'리뷰가 등록됐어요!'**
  String get ratingSubmitted;

  /// No description provided for @ratingCommentHint.
  ///
  /// In ko, this message translates to:
  /// **'후기 (선택)'**
  String get ratingCommentHint;

  /// No description provided for @ratingSubmit.
  ///
  /// In ko, this message translates to:
  /// **'등록'**
  String get ratingSubmit;

  /// No description provided for @onboardCancelTitle.
  ///
  /// In ko, this message translates to:
  /// **'가입을 취소할까요?'**
  String get onboardCancelTitle;

  /// No description provided for @onboardCancelBody.
  ///
  /// In ko, this message translates to:
  /// **'지금 나가면 로그아웃되고 처음 화면으로 돌아갑니다.'**
  String get onboardCancelBody;

  /// No description provided for @onboardLeave.
  ///
  /// In ko, this message translates to:
  /// **'나가기'**
  String get onboardLeave;

  /// No description provided for @onboardCompanyNameHint.
  ///
  /// In ko, this message translates to:
  /// **'예) 오비트 코스메틱'**
  String get onboardCompanyNameHint;

  /// No description provided for @onboardNicknameHint.
  ///
  /// In ko, this message translates to:
  /// **'예) 오비트지기'**
  String get onboardNicknameHint;

  /// No description provided for @homeBrowseCampaigns.
  ///
  /// In ko, this message translates to:
  /// **'캠페인 둘러보기'**
  String get homeBrowseCampaigns;

  /// No description provided for @homeSearchCampaigns.
  ///
  /// In ko, this message translates to:
  /// **'캠페인 검색'**
  String get homeSearchCampaigns;

  /// No description provided for @homeEmptyFiltered.
  ///
  /// In ko, this message translates to:
  /// **'조건에 맞는 캠페인이 없어요.\n필터를 바꿔보세요!'**
  String get homeEmptyFiltered;

  /// No description provided for @homeEmptyFeed.
  ///
  /// In ko, this message translates to:
  /// **'진행 중인 캠페인이 없어요.\n곧 새로운 캠페인이 올라올 거예요!'**
  String get homeEmptyFeed;

  /// No description provided for @homeMyCampaigns.
  ///
  /// In ko, this message translates to:
  /// **'내 캠페인'**
  String get homeMyCampaigns;

  /// No description provided for @homeEmptyMyCampaigns.
  ///
  /// In ko, this message translates to:
  /// **'아직 등록한 캠페인이 없어요.\n첫 캠페인을 만들어보세요!'**
  String get homeEmptyMyCampaigns;

  /// No description provided for @campaignTypeDelivery.
  ///
  /// In ko, this message translates to:
  /// **'배송형'**
  String get campaignTypeDelivery;

  /// No description provided for @campaignTypeVisit.
  ///
  /// In ko, this message translates to:
  /// **'방문형'**
  String get campaignTypeVisit;

  /// No description provided for @campaignTypePress.
  ///
  /// In ko, this message translates to:
  /// **'기자단'**
  String get campaignTypePress;

  /// No description provided for @campaignStatusDraft.
  ///
  /// In ko, this message translates to:
  /// **'작성중'**
  String get campaignStatusDraft;

  /// No description provided for @campaignStatusOpen.
  ///
  /// In ko, this message translates to:
  /// **'모집중'**
  String get campaignStatusOpen;

  /// No description provided for @campaignStatusClosed.
  ///
  /// In ko, this message translates to:
  /// **'마감'**
  String get campaignStatusClosed;

  /// No description provided for @campaignStatusCompleted.
  ///
  /// In ko, this message translates to:
  /// **'완료'**
  String get campaignStatusCompleted;

  /// No description provided for @appStatusPending.
  ///
  /// In ko, this message translates to:
  /// **'심사중'**
  String get appStatusPending;

  /// No description provided for @appStatusAccepted.
  ///
  /// In ko, this message translates to:
  /// **'선정'**
  String get appStatusAccepted;

  /// No description provided for @appStatusRejected.
  ///
  /// In ko, this message translates to:
  /// **'미선정'**
  String get appStatusRejected;

  /// No description provided for @appStatusSubmitted.
  ///
  /// In ko, this message translates to:
  /// **'제출완료'**
  String get appStatusSubmitted;

  /// No description provided for @appStatusCompleted.
  ///
  /// In ko, this message translates to:
  /// **'완료'**
  String get appStatusCompleted;

  /// No description provided for @settleStatusPending.
  ///
  /// In ko, this message translates to:
  /// **'정산대기'**
  String get settleStatusPending;

  /// No description provided for @settleStatusProcessing.
  ///
  /// In ko, this message translates to:
  /// **'처리중'**
  String get settleStatusProcessing;

  /// No description provided for @settleStatusPaid.
  ///
  /// In ko, this message translates to:
  /// **'지급완료'**
  String get settleStatusPaid;

  /// No description provided for @password.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호'**
  String get password;

  /// No description provided for @showPassword.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호 표시'**
  String get showPassword;

  /// No description provided for @hidePassword.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호 숨기기'**
  String get hidePassword;

  /// No description provided for @lightMode.
  ///
  /// In ko, this message translates to:
  /// **'라이트 모드'**
  String get lightMode;

  /// No description provided for @anonymous.
  ///
  /// In ko, this message translates to:
  /// **'익명'**
  String get anonymous;

  /// No description provided for @serverError.
  ///
  /// In ko, this message translates to:
  /// **'서버가 잠시 불안정해요. 잠시 후 다시 시도해주세요.'**
  String get serverError;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'ja', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
