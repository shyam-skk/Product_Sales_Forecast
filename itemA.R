setwd("C:/Users/SHYAM KRISHNAN K/Desktop/project-6")
getwd()
library("readxl") 
Demand <- read_excel("Demand.xlsx")

itemA <- ts(Demand[,3], start=c(2002,1), frequency=12)
itemA
plot(itemA)
monthplot(itemA)



#seasonality changes
itemADec7<-stl(itemA[,1], s.window=7)
plot(itemADec7, main='Decomposition - Item A')
itemADec7


DeseasonsalesA <- (itemADec7$time.series[,2]+itemADec7$time.series[,3])
ts.plot(DeseasonsalesA, itemA, col=c("red", "blue"), main="Comparison of Sales and Deseasonalized Sales")

##### test for stationarity
#install.packages('tseries')
library(tseries)
adf.test(itemA)

#################### spliting the data set ----itemA
Atrain <- window(itemA, start=c(2002,1), end=c(2015,10), frequency=12)
ATest <- window(itemA, start=c(2015,11), frequency=12)

####################### forecasting ITEM A #########################
#install.packages('fpp2')
library(fpp2)
################################ Method 1: naive decomposition
Atrain7<-stl(Atrain[,1], s.window=7)
fcst.A.stl <- forecast(Atrain7, method="rwdrift", h=21)
plot(fcst.A.stl)

Vec<- cbind(ATest,fcst.A.stl$mean)
ts.plot(Vec, col=c("blue", "red"), main="Sales forecast: Actual vs Forecast")

MAPE <- mean(abs(Vec[,1]-Vec[,2])/Vec[,1])
MAPE

#forecast for future
fcst.A.future <- forecast(itemADec7, method="rwdrift", h=17)
plot(fcst.A.future)
print(fcst.A.future)
############################### Method 2: holt winters model itemA
A.fc<-hw(Atrain,h=21)
A.fc$model
A.fc$mean
plot(A.fc)

Vec<- cbind(ATest,A.fc$mean)
ts.plot(Vec, col=c("blue", "red"), main="Sales forecast: Actual vs Forecast")
MAPE <- mean(abs(Vec[,1]-Vec[,2])/Vec[,1])
MAPE

hw.A.future <- hw(itemA,h=17)
plot(hw.A.future)


