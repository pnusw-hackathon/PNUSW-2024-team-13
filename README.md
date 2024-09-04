### 1. 프로젝트 소개
#### 1.1. 개발배경 및 필요성
<img width="500px" height="300px" src="https://github.com/user-attachments/assets/f28f8a12-7314-4dc7-b389-01ed07a50cf5"/>
<img width="500px" height="300px" src="https://github.com/user-attachments/assets/0510c913-1802-4b4e-b951-13606a841f66"/>

- 한국의 IP카메라 취약점 노출 순위는 6위로 매우 취약한 나라이다.
- 대한민국 65세 이상 고령층 가구 수가 2017년 7백만 명에서 2023년 9백만 명으로 증가하였다. 그중 1인 가구 수가 2017년 134만 명에서 2023년 199만 명으로 48.5% 증가하였으며 계속해서 늘어나는 추세이다. 특히, 부산은 고령인구 비중이 22.2%로 타 도시에 비해 상위권에 위치해있다.
- 일본의 재택클리닉 재활의학과 “카마가이치 리에 전문의”에 따르면 일본에서 65세 이상의 재택의료 수요가 2042년 3900만 명에 도달할 전망이며 2019년 기준 27.4%가 단독세대이며 이들은 통원에 어려움을 겪는다고 한다. 또한, 고령화 진전에 따라 일본 재택의료 요구도가 점점 높아지고 있으며 이를 위해 일상적 요양 지원, 증상 급변 시 대응, 퇴원 지원, 케어 등이 요구되고 있다"라며 "고령자 지원을 위해선 간호 서비스 및 의료서비스의 연계가 필수적이라 한다.
- 통계청에 따르면 독거노인의 비율은 과거부터 꾸준히 증가하여, 현재에는 노인 5명 중 1명이 독거노인이며 지속적으로 증가할 것이라 전망하였다.
<br/>

#### 1.2. 개발목표 및 주요내용
 개발목표   
  - '사생활을 보호하되, 지속적인 관찰을 통한 독거노인들의 고독사 방지'   
  - 고독사 및 고령화로 인한 사회적인 문제가 발생하고 있다. 이를 해결하기 위하여 HPE(Human Pose Estimation)기술이 도입된 카메라를 이용해 특정 장소에서 환자, 독거노인 등 관리가 필요한 대상을 단순 센서를 기반으로 예측하는 기존 방식과 달리 실시간으로 확인하고, 스켈레톤으로 나타내 사생활을 보호하며 위급 시 긴급전화를 이용해 신고한다.

주요내용
   1. 관찰 서비스
         - 독거노인의 행동을 일거수 일투족 감시하는 서비스이다. 
해당 서비스의 핵심적인 기능이며, 관찰자로 하여금 환자의 상태를 확인할 수 있도록 한다.
   2. 녹화 서비스
         - 녹화된 영상을 통해 독거노인의 특정 행동 패턴 등을 파악할 수 있어 문제가 될 만한 행동 등을 사전에 제지할 수 있다.
   3. 긴급전화 서비스
         - 상황 발생시 앱내 긴급통화 버튼을 이용하여 신속한 신고 및 대처가 가능하다. 
<br/>

#### 1.3. 세부내용
	1. 관찰 서비스
 	   - 앱의 가장 핵심적인 카메라를 이용한 영상 제공 서비스이다. 카메라를 통한 실시간 영상을 제공하되, 이는 스켈레톤 형태로 나타나며 관찰자의 행동 및 상황을 파악할 수 있게 한다.
	2. 녹화 서비스
           - 녹화된 영상을 통해 독거노인의 특정 행동 패턴 등을 파악할 수 있어 문제가 될 만한 행동 등을 사전에 제지할 수 있으며, 불필요한 저장공간을 차지하지 않을 수 있다.
	3. 긴급전화 서비스
	   - 앱 내 긴급전화 버튼을 통해 바로 전화 화면으로 넘어가 유관기관에 전파할 수 있게하는 서비스이다.

  기능요구사항
- 모듈 외형 모델링
- 스마트폰과 게이트웨이 간의 통신 구현
- 자세 추론 모델 학습
- 스마트폰 애플리케이션 UI 작성
사용자 요구사항
-  가격이 저렴할 것
-  설치 및 사용이 편하며 유지보수가 잘될 것
-  시스템의 정확도가 높을 것
-  인식 및 처리 속도가 빠를 것
<br/>

#### 1.4. 기존 서비스(상품) 대비 차별성
1. 개선된 IP 카메라를 이용한 사생활 보호
   - 기존 방식의 카메라는 영상을 있는 그대로 송출하지만, 해당 기계는 영상 내 사람을 스켈레톤 방식으로 표현하여 송출한다.
   - 이를 통해 원할 때만 실제 영상으로 송출함으로 사생활 보호에 용이하다.
2. 센서가 아닌 카메라 사용
   - 기존 IP카메라의 단점을 해결하기 위해 센서를 사용한 제품들이 다수 있지만, 해당 센서의 오작동으로 제기능을 하지못하는 경우가 종종 있었다.
   - 단점을 해결하기보단 보완하는 방향으로 카메라를 통해 사용자가 직접 판단하여 좀 더 정확한 확인이 가능하고, 센서를 보조 장치로 사용할 경우 더 정확하게 상황을 판단할 수 있다.
> 기존 IP카메라와 달리 스켈레톤 방식으로 24시간 송출과 사생활 보호를 하고 센서기반 시스템과 달리 카메라 사용으로 정확성 확보.
<br/>

#### 1.5. 사회적가치 도입 계획
> 1. 서비스 범위 확대
>   - 고독사 위험이 있는 노인들의 집 뿐만 아니라 1인 가구나 환자가 있는 병원, 요양원 등에 설치 등 서비스 범위를 확대할 것이다.
>   - 목욕탕, 어린이집, 화장실 등 CCTV 설치 불가 구역등으로 확장함으로써 치안 및 공공질서 유지를 지원할 수 있다.
> 2. 건강 관련 헬스 어플리케이션과의 연계
    - 현대인들이 많이 착용하는 스마트워치 등과 같은 센서 기반의 생체 감지 장치와의 연동을 통해 좀 더 정확한 정보 확인이 가능할 것이다.
<br/>


### 2.상세설계
#### 2.1. 시스템 구성도
<img width="600px" alt="시스템 구성도" src="https://github.com/user-attachments/assets/37d3e48c-bf96-41b0-884b-0bad6fcd801b">
<br/>

#### 2.3. 사용기술
| 이름                  | 버전    |
|:---------------------:|:-------:|
| Python                | 3.8.0   |
| Django                | 3.2.9   |
| Django Rest Framework | 3.12.0  |
| Node.js               | 16.16.0 |
| Vue.js                | 2.5.13  |
<br/>


### 3. 개발결과
[코딩역량강화플랫폼 Online Judge](http://10.125.121.115:8080/)를 예시로 작성하였습니다.
#### 3.1. 전체시스템 흐름도
- IA(Information Architecture)
  > 정보나 시스템의 구조를 도식화하여 보여줍니다. <br/>
  <img width="600px" alt="IA" src="https://github.com/user-attachments/assets/ab97b877-0a6a-44dd-a1e1-a7c55bffaf7c" />
<br/>


- 시스템 플로우 차트
  > 설치부터 애플리케이션 사용까지의 흐름도를 보여줍니다. 
  <img width="800px" alt="시스템 플로우 차트" src="https://github.com/user-attachments/assets/39f8ecdf-ce3b-4102-b318-e108a84ea77f" />

  


#### 3.2. 기능설명
##### ` 메인 페이지 `
- 상단 배너
  - 3초에 마다 자동으로 내용이 넘어갑니다. <br/>
    ![상단 배너](https://github.com/pnuswedu/SW-Hackathon-2024/assets/34933690/4640389f-dcaf-4b78-916e-188c8e9c6ee7)

- 공지사항
  - 최근 5개의 공지사항을 보여줍니다.
  - 발행된지 일주일이 안 된 공지사항은 new라는 mark표시를 해줍니다.
  - 공지사항 글을 클릭하면 해당 공지사항 게시글로 이동합니다.
  - 상단의 더보기 버튼을 클릭하면 공지사항 페이지로 이동합니다.<br/>
    <img width="600px" alt="공지사항" src="https://github.com/pnuswedu/SW-Hackathon-2024/assets/34933690/7c425946-ff06-4b32-8b18-4119cc86e308">

- 이번 주 보너스 문제
  - 이번 주의 보너스 점수를 주는 문제를 보여줍니다.
  - 문제를 클릭하면, 해당 문제의 게시글로 이동합니다. <br/>
    <img width="600px" alt="이번 주 보너스 문제" src="https://github.com/pnuswedu/SW-Hackathon-2024/assets/34933690/5c603984-8cf6-4524-84a6-5410bb6a8cbf">

- 실시간 랭킹
  - 상위 랭킹 10명의 유저를 보여줍니다.
  - 상단의 더보기 버튼을 클릭하면 전체 랭킹 페이지로 이동합니다.<br/>
    <img width="200px" alt="실시간 랭킹" src="https://github.com/pnuswedu/SW-Hackathon-2024/assets/34933690/8492e285-5423-4c00-bc46-400cbe733d35">
<br/>

##### ` 문제 페이지 `
- 문제 목록
  - 사용자가 설정한 한 번에 보여줄 문제 갯수 만큼 한 화면에 문제를 띄워줍니다.
  - 검색창에서 문제의 제목 및 번호로 문제를 검색할 수 있습니다.
  - 난이도, 영역, 카테고리 별로 문제를 볼 수 있습니다.
  - 상단의 shuffle 이모지를 클릭하면 랜덤으로 선택된 문제 푸는 페이지로 이동합니다.
  - 목록에서 문제를 클릭하면 해당 문제를 푸는 페이지로 이동합니다.
    ![문제 목록](https://github.com/pnuswedu/SW-Hackathon-2024/assets/34933690/95afd0db-b5a7-4628-ac9c-164513a9e51b)
<br/>


#### 3.3. 기능명세서
<img width="200px" alt="실시간 랭킹" src="https://github.com/pnuswedu/SW-Hackathon-2024/assets/34933690/97ad3fea-f90a-437a-b611-3fb8cd24070e" />

|라벨|이름|상세|
|:---:|:----------------------------:|:---|
| S1  | 부산대학교 웹메일              | - 부산대 웹메일 형식인지 검증 <br/>- 중복되는 이메일인지 검증 |
| S2  | 부산대학교 웹메일 인증 코드 전송| - 클릭 시 인증 코드 메일로 전송 |
| S3  | 메일 인증 코드                 | - 인증 요청 버튼 클릭 후 활성화 <br/>- 유효시간 5분|
| S4  | 메일 인증 코드 확인            | - 인증코드 검증 |
| S5  | 닉네임                        | - 4 ~ 12자 영어, 숫자, '_' 가능 |
| S6  | 단과대학 선택                  | -부산대학교 단과대학 리스트 보여주기 |
| S7  | 학과 선택                     | - 단과대학 안의 학과 리스트 보여주기 |
| S8  | 비밀번호                      | - 입력 시 텍스트 보이지 않도록 •로 표현해주기 <br/>- 6자 이상 20자 이하, 영어와 숫자 조합 필수 |
| S9  | 비밀번호 확인                  | - 입력 시 텍스트 보이지 않도록 •로 표현해주기 <br/>- 비밀번호와 동일한 지 검증 |
| S10 | 회원가입 완료                  | - 비어 있는 입력 칸이 없는지 검증 <br/>-메일 인증 완료했는지 확인 <br/>-조건을 만족하면 회원가입 성공|
| S11 | 로그인                        | - 클릭 시 로그인 모달로 전환 |

<br/>

#### 3.4. 디렉토리 구조
```
├── build/                      # webpack 설정 파일
├── config/                     # 프로젝트 설정 파일
├── deplay/                     # 배포 설정 파일
├── src/                        # 소스 코드
│   ├── assets/                 # 이미지, 폰트 등의 정적 파일
│   ├── pages/                  # 화면에 나타나는 페이지
│   │   ├── page1/              # 페이지1
│   │   ├── page2/              # 페이지2
│   │   ├── components/         # 여러 페이지에서 공통적으로 사용되는 컴포넌트
│   ├── router/                 # 라우터
│   ├── store/                  # global state store
│   ├── styles/                 # 스타일
│   ├── utils/                  # 유틸리티
├── static/                     # 정적 파일
```
<br/>



#### 3.4. 산업체 자문내용 
- 산업체 자문내용
  
        소속: 에프에이리눅스(주)
        직위: 수석연구원
        성명: 고OO
  
   FeedBack
   - 가격과 정확도 두마리 토끼를 모두 잡는 건 쉽지 않으니 많은 고민 필요
   - 앱과 Gateway 통신 구현 방안
   - 적용 가능한 센서 예시

1. 가격과 정확도 두마리 토끼를 모두 잡는 건 쉽지 않으니 많은 고민 필요
 <img width="300px" height="150px" src="https://github.com/user-attachments/assets/829b4fd6-5aa6-440d-9182-d767685dda0b">
 <img width="300px" height="150px" src="https://github.com/user-attachments/assets/5a900cc7-9350-430d-87b4-dd3abf3ae7a8">



- MPJPE에서 140~200mm의 값 / PCK@0.5에서 Accuracy가 60~70%대의 값을 보임 => 성능상 문제 많음, 모델 채용 불가
- Tensorflow의 PoseNet 사용
- 상대적으로 저렴하지만 처리속도가 빠른 RasberryPi 이용

2. 앱과 Gateway 통신 구현 방안
- 정확도 향상위해 하나의 공간에 복수 GW 운용
3. 적용 가능한 센서 예시
 <img width="150px" height="150px" src="https://github.com/user-attachments/assets/277c9122-3217-4897-a155-1cfb691a5a7f">
 <img width="150px" height="150px" src="https://github.com/user-attachments/assets/7d372254-a175-444e-a014-64ba4963f3cc">


 - 맥박수 모니터 센서 모듈 및 심박심장박동 센서
 - 웨어러블 압전 센서(혈압 센서) 등 스마트워치에 이용되는 센서와의 연동


	






### 4. 설치 및 사용 방법
**필요 패키지**
- 위의 사용 기술 참고

```bash
$ git clone https://github.com/test/test.git
$ cd test/frontend
$ npm i
$ export NODE_ENV="development" # windows: set NODE_ENV=development
$ npm run build:dll
$ export TARGET="http://localhost:8000"  # windows: set NODE_ENV=http://localhost:8000
$ npm run dev
```
<br/>


### 5. 소개 및 시연영상
[<img width="700px" alt="소개 및 시연영상" src="https://github.com/pnuswedu/SW-Hackathon-2024/assets/34933690/162132cd-9af5-4154-9b9a-41c96cf5e8fd" />](https://www.youtube.com/watch?v=EfEgTrm5_u4)

<br/>

### 6. 팀 소개
| 하규승 | 이수빈 | 김효준 |
|:-------:|:-------:|:-------:|
|<img width="100px" alt="MEMBER1" src="https://github.com/pnuswedu/SW-Hackathon-2024/assets/34933690/f5b5df2a-e174-437d-86b2-a5a23d9ee75d" /> | <img width="100px" alt="MEMBER2" src="https://github.com/pnuswedu/SW-Hackathon-2024/assets/34933690/fe4e8910-4565-4f3f-9bd1-f135e74cb39d" /> | <img width="100px" alt="MEMBER3" src="https://github.com/pnuswedu/SW-Hackathon-2024/assets/34933690/675d8471-19b9-4abc-bf8a-be426989b318" /> |
| hgs6417@pusan.ac.kr | mirr422@gmail.com | hj001113@naver.com |
| 프론트앤드 개발 | 인프라 구축 <br/> 백앤드 개발 | DB 설계 <br/> 백앤드 개발 |


<br/>


### 7. 해커톤 참여 후기
- 하규승
  > "SW 개발"을 중점으로 한 해커톤인줄 알았지만, "창업" 중점이라 당황스러웠습니다. 첫 해커톤이라 인원배분, 시간, 비용등의 다양한 문제를 마주했고, 이를 해결해나가며 과제가 아닌 대회로써의 새로운 경험을 할 수 있어 좋았습니다. 특히, 수많은 회의과정에서 서로 전공이 달라 다양한 관점에서 문제를 바라보는 능력을 기를 수 있는 좋은 기회였습니다. 똑같은 아이디어일지라도 그곳에서 누군가 가치 창출을, 누군가는 구현 가능성을, 누군가는 비용적인 측면에서 접근하는 것을 보고 사람의 관점은 배경지식에 따라 크게 바뀔 수 있음을 체감하였습니다. 그리고 구현과정에서 예상치 못한 문제를 맞닥뜨렸고, 이를 해결하는 과정에서 평소 배우기만 했던 딥러닝 지식을 응용해 볼 수 있어 좋았습니다. 마지막으로 못난 팀장 끝까지 따라와준 나머지 2명에게 너무 고맙고, 이번 경험이 저에게도, 다른 모두에게도 뜻깊은 경험이 되었으면 좋겠습니다.
- 이수빈(항공우주공학과)
  > 학부과정을 거치면서 다양한 프로그래밍 언어를 접해보아 쉽게 이해 가능할 줄 알았으나 처음 사용해보는 프로그램, 처음 해보는 앱 개발등 생각보다 어려운 경험이였으나 이번 해커톤 대회의 취지에 맞게 전공자의 도움을 받고 같은 비전공자 동료와 어려움을 공유하면서 개발 과정을 경험해보았습니다. 이를 통해 SW에 대한 이해와 다른 전공분야를 가지고 있는 동료들과의 협업이라는 소중한 경험을 할 수 있었습니다.
- 김효준(기계공학부)
  > 비전공자로서 SW를 기반으로한 해커톤 참여는 새로운 경험이었습니다. 방학기간 3명 정도의 인원이면 충분하다 생각한 주제가 시간을 거듭할수록 충분치 않음을 느꼈습니다. 하지만 그런 촉박한 시간임에도 불구하고 노력해준 팀원들이 너무 감사할 따름입니다. 
 제작하는 일련의 과정들을 통해 팀원간의 소통 및 협업의 중요성을 느꼈으며 흔히들 말하는 ‘팀 프로젝트’에 필요한 역량을 함량할 수 있는 좋은 기회였습니다.
저희 팀의 경우 3명 다 각기 다른 전문공학분야들을 전공하였기 때문에 각각 다른 배경과 지식을 가지고 있었고, 각 전공을 살려 역할을 배분하였습니다. 또한, 모르는 부분등을 서로 알려주며 자신의 전공지식을 강화하고 다른 분야의 전공지식에 대해 알 수 있는 흔치않은 기회였습니다.
해당 경험은 앞으로 여러 프로젝트들을 진행함에 있어 큰 도움이 될 것이라 생각합니다. 
<br/>
](https://docs.google.com/document/d/1UTN5kixtRh9GRrV2aLkkBU4yX_5XfR97b_t-PQm0Aqs/edit)

### 참고 문헌 및 자료
1. 이소미,”또 다시 터진 IP 카메라 해킹 영상 유출 사태, 그간 어떤 사건 있었나“,보안뉴스,2024.01.02, [https://m.boannews.com/html/detail.html?idx=125345](https://m.boannews.com/html/detail.html?idx=125345)
2. 김영애,”중국 해커, 국내 IP 카메라 해킹.. 4,500개 사생활 영상, 텔레그램에노출“,보안뉴스,2023.12.30, [https://m.boannews.com/html/detail.html?idx=125342](https://m.boannews.com/html/detail.html?idx=125342)
3. 이지운,”혼자 쓸쓸히 '고독사' 작년 3378명…50, 60대 남성이 절반“, 동아일보,2022,1215, [https://news.nate.com/view/20221215n00615](https://news.nate.com/view/20221215n00615)
4. 김승직,”재택의료 환자 150만명 육박...인프라 없인 입원-사망 악순환 우려“,메디컬타임즈,2023,11,08, [www.medicaltimes.com/Main/News/NewsView.html?ID=1156113](www.medicaltimes.com/Main/News/NewsView.html?ID=1156113)

사용 dataset
<br/>
1.[https://sc3d.imar.ro/humansc3d](https://sc3d.imar.ro/humansc3d)
<br/>
2.[https://ci3d.imar.ro/chi3d](https://ci3d.imar.ro/chi3d)
<br/>
3.[https://paperswithcode.com/dataset/human3-6m](https://paperswithcode.com/dataset/human3-6m)

