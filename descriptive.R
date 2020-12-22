setwd("C:/Users/SHYAM KRISHNAN K/Desktop/project-6")
getwd()
library("readxl") 
Demand <- read_excel("Demand.xlsx")

dim(Demand)
str(Demand)
colSums(is.na(Demand))

attach(Demand)
str(Demand)
summary(Demand)


################## Time series object creation ###############
itemA <- ts(Demand[,3], start=c(2002,1), frequency=12)
itemB <- ts(Demand[,4], start=c(2002,1), frequency=12)

itemA
View(itemA)

itemB
View(itemB)

plot(itemA, main='Time Series Plot - ItemA')
plot(itemB, main='Time Series Plot - ItemB')

monthplot(itemA, main='Monthly subplot - Item A')
monthplot(itemB, main='Monthly subplot - Item B')

################# decomposition #####################
#constant seasonality
itemADec<-stl(itemA[,1], s.window='p') 
plot(itemADec)
itemADec


itemBDec<-stl(itemB[,1], s.window='p')
plot(itemBDec)
itemBDec

#seasonality changes
itemADec7<-stl(itemA[,1], s.window=7)
plot(itemADec7)
itemADec7

itemBDec7<-stl(itemB[,1], s.window=7)
plot(itemBDec7)
itemBDec7

DeseasonsalesA <- (itemADec7$time.series[,2]+itemADec7$time.series[,3])
ts.plot(DeseasonsalesA, itemA, col=c("red", "blue"), main="Comparison of Sales and Deseasonalized Sales")

DeseasonsalesB <- (itemBDec7$time.series[,2]+itemBDec7$time.series[,3])
ts.plot(DeseasonsalesB, itemB, col=c("red", "blue"), main="Comparison of Sales and Deseasonalized Sales")

logitemB <- log(itemB)
logitemBDec <- stl(logitemB[,1], s.window="p")
logitemBDec$time.series[1:12,1]
itemBSeason <- exp(logitemBDec$time.series[1:12,1])
plot(itemBSeason, type="l")

################################################
##### test for stationarity
#install.packages('tseries')
library(tseries)
adf.test(itemA)
adf.test(itemB)

adf.test(Demand)

#################### spliting the data set ----itemA
Atrain <- window(itemA, start=c(2002,1), end=c(2015,10), frequency=12)
ATest <- window(itemA, start=c(2015,11), frequency=12)

#################### spliting the data set ----itemB
Btrain <- window(itemB, start=c(2002,1), end=c(2015,10), frequency=12)
BTest <- window(itemB, start=c(2015,11), frequency=12)

################# forecasting ITEM A
#install.packages('fpp2')
library(fpp2)
####### Method 1: naive decomposition
Atrain7<-stl(Atrain[,1], s.window=7)
fcst.A.stl <- forecast(Atrain7, method="rwdrift", h=21)

Vec<- cbind(ATest,fcst.A.stl$mean)
ts.plot(Vec, col=c("blue", "red"), main="Sales forecast: Actual vs Forecast")
MAPE <- mean(abs(Vec[,1]-Vec[,2])/Vec[,1])
MAPE

#forecast for future
fcst.A.future <- forecast(itemADec7, method="rwdrift", h=17)
plot(fcst.A.future)

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
A.fc<-hw(Atrain,h=21)
plot(A.fc)
A.fc$model
A.fc$mean

Vec<- cbind(ATest,A.fc$mean)
ts.plot(Vec, col=c("blue", "red"), main="Sales forecast: Actual vs Forecast")
MAPE <- mean(abs(Vec[,1]-Vec[,2])/Vec[,1])
MAPE

hw.A.future <- hw(itemA,h=17)
plot(fcst.A.future)

####### Method 2: holt winters model itemB######################
B.fc<-hw(Btrain,h=21)
plot(B.fc)
B.fc$model
B.fc$mean

Vec<- cbind(BTest,B.fc$mean)
ts.plot(Vec, col=c("blue", "red"), main="Sales forecast: Actual vs Forecast")
MAPE <- mean(abs(Vec[,1]-Vec[,2])/Vec[,1])
MAPE

hw.B.future <- hw(itemB,h=17)
plot(fcst.B.future)

