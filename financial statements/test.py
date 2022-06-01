
import pandas_datareader as pdr
from datetime import datetime
import pandas as pd
from mpl_finance import candlestick2_ohlc
import matplotlib.ticker as ticker
import matplotlib.pyplot as plt


#* 데이터를 가져올 날짜 설정 2020-01-01 ~ 현재까지
start_date = datetime(2020,1,1)
end_date = datetime.now()
#* yahoo finance 에서 코스피 데이터 가져오기

# kospi_df = pdr.get_data_yahool * KS11", start_date, end date) ## 340/

# yahoo finance 에서 삼성전자 데이터 가져오기
base_df = pdr.get_data_yahoo("005930.KS", start_date, end_date) ## HIT!
base_df.info


# 가공할 데이터셋에 복사 (원본 base_df 변경없이 유지)
df = pd.DataFrame(data = base_df)

#* 지수 이동평균선 데이터 가공
df['MA5'] = df['Close'].rolling(5).mean()
df['MA10'] = df['Close'].rolling(10).mean()
df['MA20'] = df['Close'].rolling(20).mean()
df['MA60'] = df['Close'].rolling(60). mean()
df['MA120'] = df['Close'].rolling(120).mean()

# 최근 30일 기준 데이터 iloc[0:30] -> 30 변경
df = df.sort_values(by='Date', ascending = False).iloc[0:30].sort_values(by='Date')

fig = plt.figure(figsize=(20,10))
ax = fig.add_subplot(111)
index = df.index.astype('str')

# 이동평균선
ax.plot(index, df['MA5'], label = 'MA5', linewidth = 0.7, color = 'g')
ax.plot(index, df['MA20'], label = 'MA20', linewidth = 0.7, color = 'r')
ax.plot(index, df['MA60'], label = 'MA60', linewidth = 0.7, color = 'orange')
ax.plot(index, df['MA120'], label = 'MA120', linewidth = 0.7, color = 'purple')

#|* X축 티커 설정 - 최대 15
ax.xaxis.set_major_locator(ticker.MaxNLocator(30))

#* 그래프 title X-Y 축 라벨 설정
ax.set_title('samsung', fontsize = 22)
ax.set_ylabel('price', fontsize = 16)
ax.set_xlabel('date', fontsize = 6)

# 캔들차트 셋팅
candlestick2_ohlc(ax,
                    df['Open'],
                    df['High'],
                    df['Low'],
                    df ['Close'],
                    width=1, colorup='r', colordown='b')

ax. legend()
plt.grid()
plt.show()
