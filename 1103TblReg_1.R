#Bundan sonraki kısımda bagımlı degiskenimiz yalnızlık bagımsız degiskenimiz ise depresyon olarak sectik

x$occupation <- ifelse(
  x$isco08 %in% c(66666,77777,88888,99999),
  NA,
  x$isco08
)
x$occupation<-factor(
  x$occupation
)



x$hh_income <- ifelse(
  x$hinctnta %in% c(77,88,99),
  NA,
  x$hinctnta
)

x$hh_income <- ifelse(
  x$hh_income %in% c(1,2,3,4),
  "Low Household Income",
  x$hh_income
)
x$hh_income<-ifelse(
  x$hh_income %in% c(5,6,7),
  "Middle Household Income",
  x$hh_income
)

x$hh_income <- ifelse(
  x$hh_income %in% c(8,9,10),
  "High Household Income",
  x$hh_income
)

x$hh_income<-factor(
  x$hh_income,
  levels = c(
    "Low Household Income",
    "Middle Household Income",
    "High Household Income"
  )
)

x$hh_income <- relevel(
  x$hh_income,
  ref = "Low Household Income"
)


x$firm_size <- ifelse(
  x$estsz %in% c(6,7,8,9),
  NA,
  x$estsz
)

x$firm_size <- ifelse(
  x$firm_size %in% c(1,2),
  "Under 25",
  x$firm_size
)

x$firm_size <- ifelse(
  x$firm_size == 3,
  "25 to 99",
  x$firm_size
)

x$firm_size <- ifelse(
  x$firm_size %in% c(4,5),
  "100 or more",
  x$firm_size
)


x$firm_size <- factor(
  x$firm_size,
  levels = c(
    "Under 25",
    "25 to 99",
    "100 or more"
  )
)

x$firm_size <- relevel(
  x$firm_size,
  ref = "Under 25"
)


x$hh_size <- ifelse(
  x$hhmmb %in% c(77,88,99),
  NA,
  x$hhmmb
)

x <- x[x$hh_size!=0,]


x$lonely <- ifelse(
  x$fltlnl %in% c(7,8,9),
  NA,
  x$fltlnl
)
x$lonely <- ifelse(
  x$lonely == 1,
  0,
  x$lonely
)

x$lonely <- ifelse(
  x$lonely %in% c(2,3,4),
  1,
  x$lonely
)


x$depression <- ifelse(
  x$fltdpr %in% c(7,8,9),
  NA,
  x$fltdpr
)
x$depression <- ifelse(
  x$depression == 1,
  0,
  x$depression
)
x$depression <- ifelse(
  x$depression %in% c(2,3,4),
  1,
  x$depression
)

x$female <- ifelse(
  x$gndr == 9,
  NA,
  x$gndr
)
x$female <- ifelse(
  x$female == 1,
  0,
  1
)

x$age <- ifelse(
  x$agea == 999,
  NA,
  x$agea
)

x$education <- ifelse(
  x$eduyrs %in% c(77,88,99),
  NA,
  x$eduyrs
)

x$married <- ifelse(
  x$maritalb %in% c(77,88,99),
  NA,
  x$maritalb
)
x$married <- ifelse(
  x$married == 1,
  1,
  0
)

table(x$married)
summary(x$married)


x$country_factor <- factor(
  x$cntry
)

x$essround_factor <- factor(
  x$essround
)

x<-x[!is.na(x$psu),]





























































































