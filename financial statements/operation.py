import os
##os.system("clear")

print ("1 : 재무제표")
print ("2 : 시가총액")
print ("3 : 종목코드")

OPTION = input()

if OPTION == "1":
    os.system("python financial_statements.py")
elif OPTION == "2":
    os.system("python CAP.py")
elif OPTION == "3":
    os.system("python KRX_KOSPI_KOSDAQ_code.py")
