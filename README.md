# 🚚 LOADLOGIX 

![logo.jpg](./etc/assets/logo.png)

## 🌀 프로젝트 개요
### LOADLOGIX 는 배송기사를 위한 물류 적재 최적화 통합 서비스입니다 
<h3><strong>삼성 청년 SW 아카데미 자율 프로젝트</strong></h3>

<strong>📅 2024.04.08 - 2024.05.20 (6주)</strong>

## 🌀 팀원

### 📍 Backend

|<div style="text-align: center;">![신예지](/etc/assets/신예지.png)</div>|<div style="text-align: center;">![정건준](/etc/assets/정건준.jpg)</div>|<div style="text-align: center;">![백성욱](/etc/assets/백성욱.jpg)</div>|<div style="text-align: center;">![윤정인](/etc/assets/윤정인.jpg)</div>|
|:--:|:--:|:--:|:--:|
|팀장 신예지|정건준|백성욱|윤정인|
|PM<br>Anylogic 로직 및 UI 구현<br> 백엔드 공통 코드 작성, 리팩토링<br>백엔드 API 개발<br>Vue 관리자 페이지 프론트 개발|백엔드 총괄<br>경로 알고리즘 구현 및 최적화<br>백엔드 개발 및 리팩토링<br>적재/경로 알고리즘 연동 API<br>CI / CD|CI / CD<br>적재 알고리즘 구현 및 최적화<br>파이썬 자바 통신 구현<br>백엔드 적재 API 구현|Anylogic UI 설계<br>백엔드 API 개발<br>Vue 관리자 페이지 프론트 개발<br>UCC|

### 📍 Frontend

|<div style="text-align: center;">![김보경](/etc/assets/김보경.jpg)</div>|<div style="text-align: center;">![류진호](/etc/assets/류진호.jpg)</div>|<div style="text-align: center;">![문경림](/etc/assets/문경림.jpg)</div>|
|:--:|:--:|:--:|
|김보경|류진호|문경림|
|프론트엔드 리드<br>컴포넌트 설계<br>UI/UX 디자인<br>대시보드 페이지 구현<br>JIRA 일정관리<br>프론트엔드, 애니로직, 백엔드 API 통신 연결|프론트엔드 개발 및 리펙토링<br>프론트 프로젝트 골조 작성<br>3D 페이지 시뮬레이션 구현<br>API 통신 구조 및 스토어 구조 구현<br>랜딩 컴포넌트, 및 페이지 전체 컴포넌트 구현|와이어 프레임 구성 및 작성<br>할당받은 택배 적재 기능, 화물차량 규격 기능 개발|


## 🌀 프로젝트 기획 배경

현재, 물류 공장에서 일하시는 택배 기사님들은 많은 시간을 소요하여 물건을 화물차에 테트리스처럼 쌓아 올립니다.

- 택배 기사님 나름대로의 정리 방식이 있습니다.
- 정리 기준 [주소 (동, 건물), 규격, 무게] 를 고려하여 물건을 쌓아 올립니다.

따라서 LOADLOGIX는 배송 기사에게 할당 된 택배들의 우선순위를 설정하여 컨베이어 벨트에서 차례대로 내보내고, 트럭에 적재하는 3D 시뮬레이션을 보여주어 물건을 분류하고 쌓는 시간을 줄입니다.

## 🌀 프로젝트 목표

LOADLOGIX의 목표는 시뮬레이터, 알고리즘, 3D 모델링을 통한 완벽한 스마트 물류 적재 시스템을 구축하는 것이었습니다.

1. **시뮬레이터 :**  Anylogic을 사용해 물류 공장을 구축했습니다. 택배 물품을 생성하고, 저장소에 저장한 후 해당 기사 앞으로 일정 개수 이상의 택배가 쌓이면 알고리즘 처리를 시작합니다. 알고리즘 처리가 완료된 택배들은 우선순위대로 저장소에서 꺼내져 컨베이어 벨트를 통해 배송기사의 트럭 앞까지 운반됩니다.
2. **알고리즘  :** 3D Bin Packing 알고리즘으로 택배들의 주소, 규격, 무게 등을 고려해 배송기사 트럭에 적재할수 있는 최적의 시나리오를 연산합니다.
3. **3D 모델링 :** Three.dart를 사용해 알고리즘 연산이 된 택배들을 적재한 모습을 3D로 나타내어 배송 기사들에게 효율적인 가이드라인을 제시합니다.

## 🌀 주요기능

### 배송기사 페이지

- **📍 스마트 배송 관리 대시보드**
    - 배송대기 버튼을 통해 애니로직의 배송상품 적재 준비 상태를 확인할 수 있습니다.
    - 애니로직에서 적재 준비가 완료된 경우 3D 적재 시뮬레이션을 확인할 수 있습니다.
    - 배송기사 관련 정보를 확인할 수 있습니다.
    - 최근 7일 간 배송상품 개수를 그래프로 제공합니다.

    ![스마트배송대시보드](./etc/assets/스마트배송관리대시보드.gif)


    - 지도상에서 구역의 방문 순서를 볼 수 있습니다.
    - 배송기사에게 할당된 구역의 정보가 표시됩니다.

    ![구역정보](./etc/assets/구역표시.gif)


    - 당일 할당받은 배송상품을 방문 순서별로 조회할 수 있습니다.

    ![할당받은택배조회](./etc/assets/할당받은택배조회.gif)

    

- **📍 3D 적재 시뮬레이션**
    - 알고리즘을 통해 적재된 데이터를 3D로 확인할 수 있습니다.
    - 시뮬레이션 컨트롤 센터에서 구역별 통계 데이터를 조회할 수 있습니다.

     ![적재시뮬레이션](./etc/assets/적재시뮬레이션.gif)


    - 구역별, 상품별로 필터링해서 선택된 상품만을 3D로 조회할 수 있습니다.

     ![선택상품](./etc/assets/선택상품.gif)


    - 시뮬레이션 화면에서 레이트레이싱을 통해 상품을 선택하여 세부 정보를 확인할 수 있습니다.

    ![물품선택](./etc/assets/물품선택.gif)


    - 제어 센터에서 적재 높이, 투명도 조절을 통해  적재 상태를 볼 수 있습니다.

    ![높이](./etc/assets/높이.gif)
    ![투명도](./etc/assets/투명도.gif)



    - 하단의 재생바 오버레이를 통해 재생, 일시정지, 재생속도 조절, 되감기 기능을 사용해 시뮬레이션의 상태를 조절할 수 있습니다.

    ![재생바](./etc/assets/재생바.gif)


### 관리자 페이지

- **📍 관리자 대시보드**
    - 실시간 전체 물품의 개수를 확인할 수 있습니다.
    - 실시간 전체 입고 물품의 개수를 확인할 수 있습니다.
    - 실시간 전체 출고 물품의 개수를 확인할 수 있습니다.
    - 택배 상자 규격별 택배 개수를 확인할 수 있습니다.
    - 물류 창고의 각 저장소에 저장된 물품의 개수를 실시간으로 확인할 수 있습니다.
    - 구역 당 물품 할당 개수를 설정할 수 있습니다.
    - 기사 전용 사이트로 이동할 수 있습니다.

    ![관리자대시보드](./etc/assets/관리자대시보드.gif)


- **📍 실시간 입고/출고**
    - 실시간으로 입고되는 물품의 정보를 확인할 수 있습니다.
    - 실시간으로 출고되는 물품의 정보를 확인할 수 있습니다.

    ![입출고](./etc/assets/입출고.gif)


- **📍 배송기사 리스트**
    - 배송기사들의 정보를 확인할 수 있습니다
    - 배송기사들의 준비 상태를 실시간으로 확인할 수 있습니다.

    ![배송기사](./etc/assets/배송기사.gif)


## 🌀 개발환경

### 📍 Frontend

<p><strong>Flutter</strong></p>
    <div>
    <img src="https://img.shields.io/badge/Flutter 3.19.5-02569B?style=for-the-badge&logo=Flutter&logoColor=white">
    <img src="https://img.shields.io/badge/Dart 3.3.3-0175C2?style=for-the-badge&logo=Dart&logoColor=white">
    <img src="https://img.shields.io/badge/DevTools 2.31.1-0A0A0A?style=for-the-badge&logo=dev.to&logoColor=white">
    <img src="https://img.shields.io/badge/Three_dart 0.0.16-0175C2?style=for-the-badge&logo=Dart&logoColor=white">
    <img src="https://img.shields.io/badge/Google_maps_flutter 2.2.8-4285F4?style=for-the-badge&logo=Google Maps&logoColor=white">
    <img src="https://img.shields.io/badge/Google_maps_flutter_web: ^0.5.7-4285F4?style=for-the-badge&logo=Google Maps&logoColor=white">
    </div>

### 📍 Backend

<p><strong>Java</strong></p>
    <div>
    <img src="https://img.shields.io/badge/Java OpenJDK 21-000000?style=for-the-badge&logo=OpenJDK&logoColor=white">
    <img src="https://img.shields.io/badge/Spring Boot 3.2.5-6DB33F?style=for-the-badge&logo=Spring Boot&logoColor=white">
    <img src="https://img.shields.io/badge/Spring Data JPA-6DB33F?style=for-the-badge&logo=Spring Boot&logoColor=white">
    <img src="https://img.shields.io/badge/Lombok-6DB33F?style=for-the-badge&logo=Spring Boot&logoColor=white">
    <img src="https://img.shields.io/badge/Gradle 8.7-02303A?style=for-the-badge&logo=Gradle&logoColor=white">
    </div>

### 📍 Database
<img src="https://img.shields.io/badge/MySQL 8.0.34-4479A1?style=for-the-badge&logo=MySQL&logoColor=white">

### 📍 UI / UX
<img src="https://img.shields.io/badge/Figma-F24E1E?style=for-the-badge&logo=Figma&logoColor=white">

### 📍 IDE
<div>
<img src="https://img.shields.io/badge/IntelliJ IDEA 2023.3.3-000000?style=for-the-badge&logo=IntelliJ IDEA&logoColor=white">
<img src="https://img.shields.io/badge/Visual Studio Code 1.89.1-007ACC?style=for-the-badge&logo=Visual Studio Code&logoColor=white">

</div>

### 📍 INFRA
<div>
<img src="https://img.shields.io/badge/Jenkins-D24939?style=for-the-badge&logo=Jenkins&logoColor=white">
<img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=Docker&logoColor=white">
<img src="https://img.shields.io/badge/Docker-compose-2496ED?style=for-the-badge&logo=Docker&logoColor=white">
<img src="https://img.shields.io/badge/NginX-009639?style=for-the-badge&logo=NGINX&logoColor=white">
<img src="https://img.shields.io/badge/Potainer-13BEF9?style=for-the-badge&logo=Portainer&logoColor=white">
</div>

### 📍 형상 / 이슈관리
<div>
<img src="https://img.shields.io/badge/Gitlab-FC6D26?style=for-the-badge&logo=GitLab&logoColor=white">
<img src="https://img.shields.io/badge/Jira-0052CC?style=for-the-badge&logo=Jira&logoColor=white">
</div>

### 📍 기타 툴
<img src="https://img.shields.io/badge/Postman 11.1.2-FF6C37?style=for-the-badge&logo=Postman&logoColor=white">

## 🌀 ERD

![erd.PNG](./etc/assets/erd.png)

## 🌀 서비스 아키텍처

![Untitled](./etc/assets/service_architecture.png)
