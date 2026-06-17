
install.packages("tidyverse")
install.packages("nycflights13")

library(tidyverse)
library(nycflights13) # veri seti 


filter(flights, month == 1, day == 1)

(dec25<-filter(
  flights, 
  month == 12, 
  day == 25
  ))
view(dec25)


filter(
  flights,
  month==11 | month==12
)


filter(
  flights,
  arr_delay<=120, dep_delay<=120
)


filter(
  flights,
  arr_delay>=120
)


filter(
  flights,
  dest=="IAH"|dest=="HOU"
)

airlines

filter(
  flights,
  carrier %in% airlines$carrier[grepl("American|United|Delta", airlines$name)]
)





filter(
  flights,
  month>=7, month<=9
  )


filter(
  flights,
  arr_delay>120, dep_delay<=0
)



arrange(
  flights,
  desc(day)
)

head(
  arrange(
    flights,
    desc(distance/air_time)
  )
)




flights_sml<-select(
  flights,
  year:day,
  dep_delay,
  arr_delay,
  distance,
  air_time
)

view(flights_sml)


flights_sml<- mutate(
  flights_sml,
  gain=dep_delay-arr_delay,
  speed=distance/air_time*60
)


summarise(
  flights,
  delay=mean(dep_delay, na.rm=TRUE)
)



by_day<- group_by(
  flights,
  year,month,day
)

by_day


summarise(
  by_day,
  delay=mean(dep_delay, na.rm=TRUE)
)


by_dest<- group_by(flights,dest)

by_dest


delay_dest<- summarise(
  by_dest,
  count=n(),
  dist=mean(distance, na.rm=TRUE),
  delay=mean(arr_delay, na.rm=TRUE)
)

view(delay_dest)



# %>%

delays<-flights %>%
  group_by(dest) %>%
  summarise(
    count=n(),
    dist=mean(distance, na.rm=TRUE),
    delay=mean(arr_delay, na.rm=TRUE)
  )

view(delays)



not_cancelled<-flights%>%
  filter(!is.na(dep_delay),!is.na(arr_delay))



number_carrier<-not_cancelled %>%
  group_by(dest) %>%
  summarise(carries=n_distinct(carrier)) %>%
  arrange(desc(carries))

view(number_carrier)


not_cancelled %>%
  group_by(year, month,day)%>%
  summarise(
    first=min(dep_time),
    last=max(dep_time)
  )

install.packages("wooldridge")

library("wooldridge")


ceosal1<- ceosal1

rs<-lm(
  salary ~ roe,
  data=ceosal1
)


plot(
  ceosal1$roe,
  ceosal1$salary,
  xlab = "Return on equity",
  ylab = "CEO Salary",
  ylim = c(0,4000)
)




wage1<-wage1
lm(
  wage~educ,
  data=wage1
)






















