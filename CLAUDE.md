# Orbit — 작업 가이드 (CLAUDE.md)

인플루언서 캠페인 마케팅 앱. **회사**가 캠페인 등록·심사, **인플루언서**가 TikTok 연동 + 캠페인 지원.

## 아키텍처
- Flutter + **Clean Architecture(feature-first)** + **Riverpod 코드젠 DI**(`@riverpod`, get_it 없음).
  - **`riverpod_generator 4.0.4` + `riverpod_annotation 4.0.3`** 사용 → **Flutter 3.44.4 필수**(meta 1.18/analyzer 12; 3.41.x에선 analyzer 충돌로 안 됨). 생성 ref 타입 `Ref`. provider 이름=함수/클래스명+`Provider`. 주입 seam인 `sharedPreferencesProvider`만 수동.
  - freezed/json_serializable/retrofit 코드젠도 사용(build_runner).
  - Riverpod 3.x: `AsyncValue.value`(nullable), `.valueOrNull` 없음.
  - retrofit API는 `Future<dynamic>` 반환(매핑 버그 회피), 레포가 `{data:...}` 봉투 언랩.
- 네트워킹: **Dio + Retrofit → Supabase Edge Functions 만 호출**. `core/network`(DioClient/AuthInterceptor/RetryInterceptor)만 Supabase 의존 = AWS 이전 경계.
  - `RetryInterceptor`: 502/503/504/네트워크 오류 자동 재시도(엣지함수 콜드스타트 502 대응).
- 백엔드: **Edge Functions(Deno), RLS 끔**. anon/authenticated 직접 grant revoke → 데이터는 service_role 엣지함수로만. 권한은 `_shared/auth.ts`에서 JWT+역할 검증.
- 인증: Supabase Auth(JWT) → Dio가 실어 보냄. **`auth.users` auto-confirm 트리거**로 가입 즉시 세션(이메일 확인 우회, MVP).

## 테마 / 디자인
- 브랜드색은 **앱 아이콘 그라데이션에서 추출**: `#FF6079 → #E43354`. `AppColors.primary=#FB4D68`, `primaryDark=#E43354`, `brandGradient`.
- 중립색(텍스트/배경/서피스/보더)은 **`AppPalette` ThemeExtension** → `context.palette.X`로 접근(라이트/다크 적응). 새 위젯은 `context.palette` 사용(`AppColors.background` 같은 const 중립색 쓰지 말 것).
- **다크모드**: `themeModeProvider`(shared_preferences 영속), 프로필 화면 토글. light/dark = `AppTheme.light/dark`.
- 앱 아이콘: `assets/icon/app_icon.svg`→`app_icon.png`, `flutter_launcher_icons`.

## i18n (다국어) — 지원 언어
**한국어(ko) · 영어(en) · 일본어(ja) · 스페인어(es)** 4개 지원.
- 방식: `flutter_localizations` + gen-l10n(ARB). `lib/l10n/app_{ko,en,ja,es}.arb`, `context.l10n.<key>`.
- `MaterialApp.router`에 `localizationsDelegates` + `supportedLocales: [ko, en, ja, es]`.
- 모든 사용자 노출 문자열은 ARB 키로(하드코딩 금지). 기준 로케일=ko.

## 개발/실행 워크플로
- Flutter는 **fvm 3.44.4**(`.fvmrc`). `fvm flutter ...`. (codegen 위해 3.44+ 필요)
- 코드젠: `fvm dart run build_runner build`.
- 검증: `fvm flutter analyze`(무경고 유지) + `fvm flutter test`.
- **기기 실행은 릴리즈로**: `fvm flutter run --release -d <iPhone udid>` — 실기기 debug는 VM Service 연결 실패로 앱이 꺼짐(릴리즈는 디버거 불필요). 기기: `00008120-000059C61E90A01E`.
- 환경값: 루트 `.env`(`flutter_dotenv`). Supabase 프로젝트 ref `fjrghrxzflhliggrojlp`.

## 운영자 설정(외부 계정 필요)
- TikTok: developers.tiktok.com 앱 + 함수 시크릿(`TIKTOK_CLIENT_KEY/SECRET/REDIRECT_URI`, `TOKEN_ENCRYPTION_KEY`). `user.info.stats`는 심사 승인.
- FCM 푸시 발송: Firebase 프로젝트(인앱 알림은 DB 트리거로 이미 동작).
