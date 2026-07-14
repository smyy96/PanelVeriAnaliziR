install.packages("haven")
install.packages("labelled")

library(haven)
library(labelled)
library(gtsummary)
library(flextable)
library(officer)
library(writexl)
library(broom)

x <- read_sav(
  "TGSS2024.sav"
)

View(x)


x$lonely<- x$welalone
  
x$lonely <- ifelse(
    x$lonely==1,
    0,
    x$lonely
)

x$lonely <- ifelse(
  x$lonely %in% c(2,3,4),
  1,
  x$lonely
)

x$depression<- x$weldepp
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

x$hh_income <- ifelse(
  x$incomehh %in% 1:8,
  "Low household income",
  x$incomehh
)

x$hh_income <- ifelse(
  x$hh_income %in% 9:15,
  "Middle household income",
  x$hh_income
)

x$hh_income <- ifelse(
  x$hh_income %in% 16:24,
  "High household income",
  x$hh_income
)


x$hh_income<-factor(
  x$hh_income,
  levels = c(
    "Low household income",
    "Middle household income",
    "High household income"
  )
)

x$hh_income<-relevel(
  x$hh_income,
  ref = "Low household income"
)

x$education <- ifelse(
  x$degree == 1,
  "None",
  x$degree
)


x$education <- ifelse(
  x$education %in% c(2,3),
  "Primary & middle school",
  x$education
)


x$education <- ifelse(
  x$education == 4,
  "High school",
  x$education
)

x$education <- ifelse(
  x$education %in% c(5,6,7,8),
  "University and above",
  x$education
)


x$education <- factor(
  x$education,
  levels = c(
    "None",
    "Primary & middle school",
    "High school",
    "University and above"
  )
)

x$education <- relevel(
  x$education,
  ref = "None"
)


x$urban_rural <- ifelse(
  x$degurba==1,
  "Rural",
  x$degurba
)


x$urban_rural <- ifelse(
  x$urban_rural==2,
  "Medium density urban",
  x$urban_rural
)

x$urban_rural <- ifelse(
  x$urban_rural==3,
  "High density urban",
  x$urban_rural
)

x$urban_rural<- factor(
  x$urban_rural,
  levels = c(
    "Rural",
    "Medium density urban",
    "High density urban"
  )
)

x$urban_rural <- relevel(
  x$urban_rural,
  ref = "Rural"
)


x$married<-ifelse(
  x$marital %in% c(1,4,5,6),
  0,
  x$marital
)

x$married<-ifelse(
  x$married %in% c(2,3),
  1,
  x$married
)


x$female <- ifelse(
  x$gender == 1,
  0,
  x$gender
)

x$female <- ifelse(
  x$female == 2,
  1,
  x$female
)


x$hh_size<-x$hhsize
x$hh_size <- x$hh_size+1


x$region<-x$nuts1
x$region <- factor(
  x$region
)


#regresyon sonucları

results_lonely <- glm(
  lonely~
    depression+
    age+
    education+
    female+
    married+
    hh_size+
    hh_income+
    urban_rural+
    region,
    data=x,
  family="binomial"(link="logit")
    )


summary(
  results_lonely
)

results_lonely_tidy <- tidy(
  results_lonely,
  exponentiate = TRUE
)

write_xlsx(
  results_lonely_tidy,
  "results_lonely.xlsx"
)


summary_stat_table_lonely<-tbl_summary(
  data=x,
  include = c(
    lonely,
    depression,
    age,
    education,
    female,
    married,
    hh_size,
    hh_income,
    urban_rural
  ),
  statistic = list(
    all_continuous()~"{mean}({sd}, {min}-{max})",
    all_categorical()~"{n}({p}%)"
  ),
  missing = "no",
  type = list(
    lonely ~ "continuous",
    depression ~"continuous",
    female ~"continuous",
    married ~ "continuous"
  ),
  digits = list(
    all_continuous()~c(3,3,0,0),
    all_categorical()~c(0,0)
  ),
  label = list(
    lonely ~"Lonely dummy, mean(SD,Range)",
    depression ~"Depression dummy, mean(SD,Range)",
    age ~ "Age, mean(SD,Range)",
    education ~ "Education, n(%)",
    female ~ "Female, mean (SD, range)",
    married ~ "Married, mean (SD, range)",
    hh_size ~ "Household Size, mean (SD, range)",
    hh_income ~ "Household Income, n(%)",
    urban_rural ~ "Urban-rural location, n(%)"
  )
)%>%
  modify_footnote(all_stat_cols()~NA)%>%  
  modify_header(label="**Variable**") 




summary_stat_table_lonely2<-as_flex_table( # summary_stat_table nesnesini Word/flextable formatına uygun hale getirir.
  summary_stat_table_lonely
)

summary_stat_table_lonely3 <- read_docx()# Boş bir Word dosyası (docx) oluşturur, tablo veya içerik eklemek için başlangıç nesnesi hazırlar.

summary_stat_table_lonely3 <- body_add_flextable(# Flextable olarak hazırlanan tabloyu Word belgesinin gövdesine ekler.
  summary_stat_table_lonely3,
  summary_stat_table_lonely2
)

print(
  summary_stat_table_lonely3,# Word dosyasını oluşturur ve tabloyu "summary_stat_table.docx" olarak kaydeder.
  target="summary_stat_table_lonely.docx"
)




#Regresyon sonuclarını raporlama


tbl_results_lonely1<-tbl_regression(
  results_lonely,
  exponentiate = TRUE,
  intercept = TRUE,
  include = c(
    depression,
    age,
    education,
    female,
    married,
    hh_size,
    hh_income,
    urban_rural
  ),
  pvalue_fun = function(x){
    format(round(x,digits = 3))
  },
  estimate_fun = function(x){
    format(round(x,digits = 3))
  },
  label = list(
    depression ~ "Depression dummy",
    age~"Age",
    education~"Education",
    female~"Female",
    married~"Married",
    hh_size~"Household Size",
    hh_income~"Household Income (Reference: Low Household Income)",
    urban_rural ~ "Urban-rural location (Reference: Rural)"
  )
)%>% remove_row_type(
  variables = c(
    education,
    hh_income,
    urban_rural
  ),
  type = "reference"
)%>% modify_header(
  label = "**Variable**"
)


tbl_results_lonely2<- as_flex_table(
  tbl_results_lonely1
)


tbl_results_lonely3 <- read_docx()
tbl_results_lonely3<-body_add_flextable(
  tbl_results_lonely3,
  tbl_results_lonely2
)
print(
  tbl_results_lonely3,
  target = "regression_results_lonely.docx"
)



save.image()








