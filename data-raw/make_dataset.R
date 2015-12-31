#make_dataset.R
#
# Filter and preprocess unfiltered.data for the tempcycles package

library(devtools)

load("data-raw/unfiltered.data.alldata.final.rda")
filtered.data <- subset(unfiltered.data,
                        c.all.redfit.passed == TRUE)

filtered.data$region                                      <- "Temperate"
filtered.data$region[which(abs(filtered.data$lat) >= 60)] <- "Polar"
filtered.data$region[which(abs(filtered.data$lat) < 25)]  <- "Tropical"
northern <- which(filtered.data$lat > 0)
southern <- which(filtered.data$lat < 0)
filtered.data$region[northern] <- paste("North",
                                        filtered.data$region[northern])
filtered.data$region[southern] <- paste("South",
                                        filtered.data$region[southern])
filtered.data$region <- as.factor(filtered.data$region)

tempcyclesdata                <- filtered.data[,c(1:2,5:8)]
tempcyclesdata$region         <- filtered.data$region
tempcyclesdata$shore_dist_km  <- filtered.data$shore.dist.m / 1000
tempcyclesdata$start_date     <- filtered.data$start.date
tempcyclesdata$end_date       <- filtered.data$end.date
tempcyclesdata$num_samp       <- filtered.data$n.samples
tempcyclesdata$Ta_mean        <- filtered.data$Ta.mean
tempcyclesdata$Ta_min         <- filtered.data$Ta.min
tempcyclesdata$Ta_max         <- filtered.data$Ta.max
tempcyclesdata$Ta_var         <- filtered.data$Ta.var
tempcyclesdata$Ta_slope       <- filtered.data$Ta.slope
tempcyclesdata$Ta_int         <- filtered.data$Ta.int
tempcyclesdata$DTC            <- filtered.data$day.amp
tempcyclesdata$ATC            <- filtered.data$year.amp
tempcyclesdata$DTC_red        <- filtered.data$dtc.red.corr.samp
tempcyclesdata$ATC_red        <- filtered.data$atc.red.corr.samp
tempcyclesdata$day_phase      <- filtered.data$day.phase
tempcyclesdata$year_phase     <- filtered.data$year.phase
tempcyclesdata$lnDA           <- filtered.data$ratio
tempcyclesdata$lnDA_red       <- filtered.data$lnDA.red.corr.samp
tempcyclesdata$mean_resid     <- filtered.data$sum.resid.persamp
tempcyclesdata$mean_resid_red <- filtered.data$resid.t.red.persamp.corr.samp

use_data(tempcyclesdata,
         overwrite = TRUE)
