setwd("C:/Users/SHYAM KRISHNAN K/Desktop/project-6")
getwd()
library("readxl") 
Demand <- read_excel("Demand.xlsx")

itemB <- ts(Demand[,4], start=c(2002,1), frequency=12)
itemB

plot(itemB)
monthplot(itemB)



#seasonality changes
itemBDec7<-stl(itemB[,1], s.window=7)
plot(itemBDec7, main='Decomposition - Item B')
itemBDec7

DeseasonsalesB <- (itemBDec7$time.series[,2]+itemBDec7$time.series[,3])
ts.plot(DeseasonsalesB, itemB, col=c("red", "blue"), main="Comparison of Sales and Deseasonalized Sales")


##### test for stationarity
library(tseries)
adf.test(itemB)

#################### spliting the data set ----itemB
Btrain <- window(itemB, start=c(2002,1), end=c(2015,10), frequency=12)
BTest <- window(itemB, start=c(2015,11), frequency=12)

################# forecasting ITEM B
#install.packages('fpp2')
library(fpp2)

####### Method 1: naive decomposition
Btrain7<-stl(Btrain[,1], s.window=7)
fcst.B.stl <- forecast(Btrain7, method="rwdrift", h=21)

Vec<- cbind(BTest,fcst.B.stl$mean)
ts.plot(Vec, col=c("blue", "red"), main="Sales forecast: Actual vs Forecast")
MAPE <- mean(abs(Vec[,1]-Vec[,2])/Vec[,1])
MAPE

#forecast for future
fcst.B.future <- forecast(itemBDec7, method="rwdrift", h=17)
plot(fcst.B.future)

####### Method 2: holt winters model itemA ######################
B.fc<-hw(Btrain,h=21)
B.fc$model
B.fc$mean
plot(B.fc)

Vec<- cbind(BTest,B.fc$mean)
ts.plot(Vec, col=c("blue", "red"), main="Sales forecast: Actual vs Forecast")
MAPE <- mean(abs(Vec[,1]-Vec[,2])/Vec[,1])
MAPE

hw.B.future <- hw(itemB,h=17)
plot(hw.B.future)
hw.B.future

###########
B.fcm<-hw(Btrain,seasonal = 'm',h=21)
plot(B.fcm)
B.fcm$model
B.fcm$mean

Vecm<- cbind(BTest,B.fcm$mean)
ts.plot(Vecm, col=c("blue", "red"), main="Sales forecast: Actual vs Forecast")
MAPE <- mean(abs(Vecm[,1]-Vecm[,2])/Vecm[,1])
MAPE

hwm.B.future <- hw(itemB,seasonal = 'm',h=17)
plot(hwm.B.future)



