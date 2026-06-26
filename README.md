# Orbit

인플루언서 캠페인 마케팅 앱. **회사**는 캠페인을 등록·관리하고 지원자를 심사하며,
**개인 인플루언서**는 TikTok 계정을 연동해 본인인증 + 팔로워 통계를 노출하고 캠페인에 지원한다.

## 기술 스택
- **Flutter** (fvm `stable`) · **Clean Architecture** (feature-first) · **Riverpod** (수동 provider DI)
- **Dio + Retrofit** — 앱은 Supabase Edge Functions HTTP API만 호출
- **freezed / json_serializable / retrofit_generator** (build_runner), **go_router**, **flutter_web_auth_2**
- **백엔드**: Supabase Edge Functions (Deno). **RLS는 끔** — 권한은 함수 내 JWT+역할 검증, `service_role`로 DB 접근
- **인증**: Supabase Auth(GoTrue)가 JWT 발급 → Dio `AuthInterceptor`가 실어서 함수 호출

> **AWS 이전 경계**: `core/network`(Dio baseUrl + AuthInterceptor)와 `auth` data layer만 Supabase에 의존.
> 이전 시 이 둘만 교체(예: Cognito + Lambda)하면 도메인/프레젠테이션은 그대로.

## 아키텍처 메모
- **DI = 100% Riverpod provider 그래프** (get_it 없음). 레포 provider의 반환 타입은 도메인 인터페이스 → 구현체 주입.
- 코드젠 충돌로 `riverpod_generator`는 미사용(수동 `Provider`/`AsyncNotifierProvider`). freezed/json/retrofit 코드젠은 사용.
- **보안**: RLS를 끈 대신 `anon`/`authenticated`의 직접 테이블 권한을 revoke(마이그레이션 `harden_revoke_direct_access`) → 데이터는 오직 엣지함수(service_role)로만 접근.

## 프로젝트 구조
```
lib/
  core/            # config, network(dio/interceptor/guard), error, router, theme, usecase, providers
  features/
    auth/          # 가입(역할선택)·로그인·세션·온보딩  [data/domain/presentation]
    tiktok/        # OAuth 연동 + 통계
    campaign/      # 캠페인 CRUD(회사) / 피드·필터·상세(인플루언서)
    application/   # 지원 / 심사(수락·거절) / 콘텐츠 제출
    settlement/    # 정산 등록·조회
    review/        # 상호 평점
    notification/  # 인앱 알림센터
    home/          # 역할별 홈 셸
supabase/functions/  # _shared(cors/respond/admin/auth/crypto) + 도메인별 함수
```

## 백엔드
**테이블**: profiles, companies, influencers, tiktok_accounts, campaigns, campaign_images,
applications, submissions, reviews, settlements, device_tokens, notifications.
이벤트(지원/심사/제출/정산) 발생 시 DB 트리거가 `notifications`를 자동 생성.

**Edge Functions** (`{SUPABASE_URL}/functions/v1/...`):
| 함수 | 역할 |
|---|---|
| `profile` | me / complete(온보딩) / update |
| `tiktok` | authorize-url / callback / refresh-stats / unlink |
| `campaigns` | 피드·상세·생성·수정·삭제·발행/마감 |
| `applications` | 지원 / 내지원 / 지원자목록 / 심사 / 콘텐츠제출 |
| `settlements` | 생성 / 상태변경 / 내정산 / 캠페인별 |
| `reviews` | 생성 / 조회 |
| `notifications` | 목록 / 읽음 / 디바이스등록 |

## 실행
```bash
cp .env.example .env                 # 값 채우기 (현재 프로젝트 값은 .env에 이미 있음)
fvm flutter pub get
fvm dart run build_runner build      # 코드젠
fvm flutter run                      # 시뮬레이터/디바이스
```
환경값은 루트 **`.env`** 에서 로드(`flutter_dotenv`, `main()`에서 `dotenv.load`). `.env`는 gitignore,
`.env.example`만 커밋. 키는 공개용 클라이언트 키라 번들에 포함돼도 안전. `lib/core/config/env.dart`가 접근 지점.

## 설정 체크리스트 (운영자)
1. **이메일 확인 끄기 (권장)** — Supabase 대시보드 → Authentication → Sign In/Providers → Email → **Confirm email OFF**.
   켜져 있으면 가입 시 세션이 안 나오고(메일 인증 대기) 발송 rate limit에 걸릴 수 있음.
2. **TikTok 연동** — [developers.tiktok.com](https://developers.tiktok.com)에서 앱 생성 후 Edge Function 시크릿 설정:
   `TIKTOK_CLIENT_KEY`, `TIKTOK_CLIENT_SECRET`, `TIKTOK_REDIRECT_URI`(예: `orbit://tiktok`), `TOKEN_ENCRYPTION_KEY`(base64 32byte).
   - `user.info.stats`(팔로워 수) 스코프는 TikTok 심사 승인 필요. 승인 전엔 basic/profile만 채워짐.
   - 모바일 리다이렉트용 커스텀 스킴 `orbit://`를 iOS Info.plist / Android intent-filter에 등록(`flutter_web_auth_2` 콜백).
3. **FCM 푸시 발송** — 인앱 알림센터는 이미 동작. 실제 단말 푸시 발송은 Firebase 프로젝트 + `firebase_messaging` 연동
   (google-services.json / GoogleService-Info.plist) 및 발송용 함수(서비스계정) 추가가 필요.

## 검증
- 모든 Edge Function은 가입→JWT→호출 전체 체인 + 역할/소유권 가드까지 e2e 검증됨.
- `fvm flutter analyze` 무경고, `fvm flutter test` 통과.
