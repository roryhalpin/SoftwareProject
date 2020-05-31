library(tsbox)
library(TTS)


##############
kings <- scan("http://robjhyndman.com/tsdldata/misc/kings.dat", skip=3)
kings

kingsts <- ts(kings)
kingsts


##############
births <- scan("http://robjhyndman.com/tsdldata/data/nybirths.dat")
births

birthsts <- ts(births, frequency=12, start=c(1946,1))
birthsts


#############
souvenir <- scan("http://robjhyndman.com/tsdldata/data/fancy.dat")
souvenir

souvenirts <- ts(souvenir, frequency = 12, start=c(1986,1))
souvenirts

#############
plot.ts(kingsts)
plot.ts(birthsts)

logsouvenirts <- log(souvenirts)
plot.ts(logsouvenirts)

kingstSMA3 <- SMA(kingsts, n=3)
plot.ts(kingstSMA3)

#############
birthstimeseriescomponents <- decompose(birthsts)
plot(birthstimeseriescomponents)

birthstimeseriesseasonallyadjusted <- birthsts - birthstimeseriescomponents$seasonal
plot(birthstimeseriesseasonallyadjusted)

#############
rain <- scan("http://robjhyndman.com/tsdldata/hurst/precip1.dat",skip=1)

rainseries <- ts(rain,start=c(1813))
plot.ts(rainseries)

rainseriesforecasts <- HoltWinters(rainseries, beta=FALSE, gamma=FALSE)
rainseriesforecasts
rainseriesforecasts$fitted
