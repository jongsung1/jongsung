import all_companys_list as C ####### 종목 코드 리스트
import test_companys_list as T ####### 구동 테스트를 위한 종목 코드 샘플 리스트

####### 설정 값
SIGNIFICANT_FIGURE = 3 ## 유효숫자 - ROUND 에서 사용

####### 필터링 조건
FILTER = input("필터 값 적용 (Y)/(N) : ")
if FILTER == "Y" or FILTER == "y":    
    DIFFERNCE_FILTER = 0 ## 괴리 값(적정가 - 현재가) 필터 - 필터값 이상인 종목 엑셀 저장
    EPS_FILTER = 0 ## EPS 필터 - 필터값 이상인 종목 엑셀 저장
    PSR_FILTER = 3 ## PSR 필터 - 필터 값 이하인 종목 엑셀 저장
    PBR_FILTER = 2 ## PBR 필터 - 필터 값 이하인 종목 엑셀 저장
    DEBT_FILTER = 100 ## 부채비율 필터 - 필터 값 이하인 종목 엑셀 저장
    QUICK_RATIO_FILTER = 100 ## 당좌비율 필터 - 필터 값 이상인 종목 엑셀 저장

    print(f" EPS {EPS_FILTER} 이상 PSR {PSR_FILTER} 이하 PBR {PBR_FILTER} 이하 부채비율 {DEBT_FILTER} 이하 당좌비율 {QUICK_RATIO_FILTER} 이상 종목")
else:
    FILTER = "N"
    
## MODE 값이 T일 경우 test_companys 참조 C 일 경우(TESTMODE = N) companys 참조 - default -> test
## 테스트시 Y / 실사용시 N 
TESTMODE = input("테스트 리스트로 진행 (Y)/(N) : ") 
if TESTMODE == "Y" or TESTMODE == "y":
    MODE = T
elif TESTMODE == "N" or TESTMODE == "n":
    MODE = C
else:
    MODE = T


####### 컬럼 정의
COL_COMPANY = 1             ## 회사명
COL_CAP = 2                 ## 시가총액
COL_SALES = 3               ## 매출
COL_PROFITS = 4             ## 영업이익
COL_DEBT = 5                ## 부채비율
COL_QUICK_RATIO = 6         ## 당좌비율
COL_RESERVE_RATIO = 7       ## 유보율
COL_DIVIDEND_RATIO = 8      ## 배당률
COL_ROE = 9                 ## ROE
COL_PER = 10                ## PER
COL_PBR = 11                ## PBR
COL_EPS = 12                ## EPS
COL_PSR = 13                ## PSR
COL_PRICE = 14              ## 현재가
COL_TARGETPRICE = 15        ## 적정주가
COL_DIFFERNCE = 16          ## 괴리
COL_DIFFERNCE_RATIO = 17    ## 괴리율
COL_URL = 18                ## URL
COL_PRICE_FIRST = 19        ## 액면가