# 공공 와이파이 프로젝트
 - 내 좌표(위도, 경도)를 중심으로 가장 가까운 곳에 있는 공공 와이파이 정보 20개를 찾을 수 있는 프로젝트
 - 내 위치를 자동으로 불러올 수 도 있고, 좌표를 직접 입력할 수 있음

# 실행 환경 
 - IntelliJ IDEA Ultimate
 - Language : JAVA (JDK : corretto 21.0.2)
 - Generator : Jakarta EE
 - Template : Web Application
 - Build System : maven
 - Server : Tomcat 10.1.24
 - DataBase : MariaDB (E2C 서버)

# 페이지 설명
### index.jsp (메인 홈)
- 메인 페이지, 좌표를 입력한 후 "근처 wifi 정보 보기" 클릭 시 가까운 순으로 20개의 와이파이 정보를 출력
- "내 위치 가져오기"는 javascript를 이용해서 구현
- "근처 wifi 정보 보기"는 DB table에서 정보를 가지고 옴 (WifiDto.java)
- 와이파이 이름을 클릭 시 세부 페이지(detail.jsp)로 접속할 수 있으며 북마크 그룹을 추가한 경우 북마크에 추가할 수 있음(add-to-bookmark.jsp)

### history.jsp (위치 히스토리 목록)
- "근처 wifi 정보 보기"를 클릭할 때마다 좌표와 시간을 기록해서 보여줌.(history.jsp, HistoryDto.java)
- 최근에 조회한 좌표값이 가장 위로 가도록 정렬
- 삭제 기능을 구현함. (history-delete.jsp)

### load-wifi.jsp (Open API 와이파이 정보 가져오기)
- 서울시 오픈 API에서 정보를 가지고 옴. (load-wifi.jsp)
- 전체 데이터 개수를 확인 한 후, for문을 반복하여 1000개 단위로 데이터를 저장함 (getWifiInfo.java)

### bookmark-list.jsp (북마크 보기)
- 와피파이 세부 페이지(detail.jsp)에서 원하는 북마크 그룹을 선택한 후 추가할 수 있음
- 삭제 기능을 구현함(bookmark-list-delete.jsp, bookmark-list-delete-submit.jsp)
- 데이터는 BookmarkListDto.java를 이용해서 전달
- 와이파이명을 href로 설정해놓았으나 과제 설명에서 클릭 시 어디로 가야하는지 나와있지 않아 실제 이동하지는 않음

### bookmark-group.jsp (북마크 그룹관리)
- 북마크 그룹을 추가, 수정, 삭제할 수 있음(bookmark-group-add.jsp, bookmark-group-delete.jsp, bookmark-group-edit.jsp)
- 각각의 추가, 수정, 삭제는 bookmark-group-add(delete, edit)-submit.jsp에서 alert를 이용해서 완료내역을 보여줌
- 데이터는 BookmarkDto.java를 이용해서 전달
- 북마크 그룹은 "순서" 항목을 오름차순으로 정렬함

### ConnectDB
- maria DB 관련하여 CRUD 기능을 수행함
- E2C 서버에 올려져 있는 mariaDB를 사용