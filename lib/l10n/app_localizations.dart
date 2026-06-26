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
