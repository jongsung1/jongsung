#! python3
# pandas 이용 KRX 종목정보 xls 파일 읽어오기 참조 홈피
# https://wendys.tistory.com/173
# https://grey-hat.tistory.com/entry/판다스pandas-readhtml-함수로-엑셀파일-읽기-사이트-파일-읽어오기

# dataframe 사용자 list로 정렬하기
# https://stackoverflow.com/questions/63869177/fetch-bitcoin-data-information-through-pandas-datareader

import FinanceDataReader as fdr

import pandas as pd

def main():

    # 한국거래소 상장종목 전체, ETF, ETN, 선물 등등 너무 많음
    df = fdr.StockListing('KRX')
    
    # 1. 결산월이 기입된 주요 상장 종목만 추출하기 위해 filter 함 
    Sdf = df.loc[(df['SettleMonth'].notnull()) & \
                (df['SettleMonth'] != u''), :]
    Sdf.to_excel('KRX_StockListing.xlsx', index=False, encoding='euc-kr')
    

# main 함수 로딩부
if __name__ == '__main__':
    main()
