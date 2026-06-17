install.packages("gtsummary")   # Özet istatistik tabloları oluşturur
install.packages("flextable")   # Tabloları Word'e uygun ve biçimlendirilmiş hale getirir
install.packages("officer")     # Word, PowerPoint gibi Office dosyaları oluşturur


library(gtsummary)
library(flextable)
library(officer)
library(tidyverse)
library(survey)

# Seçilen değişkenler için ağırlıklı özet tablo oluşturur.
tbl_svysummary(
  data = x_survey, 
  include = c(
    depression, 
    lonely, 
    age,
    education,
    female,
    married,
    hh_size,
    hh_income,
    firm_size
  )
)

# değişkenlerin ağırlıklı özet istatistiklerini ESS 7 ve ESS 11 turlarına göre ayrı ayrı gösterir.
tbl_svysummary(
  data = x_survey,
  include = c(
    depression, 
    lonely, 
    age,
    education,
    female,
    married,
    hh_size,
    hh_income,
    firm_size
  ),
  by=essround_factor
)

#raporlanan istatistikleri degistirme
tbl_svysummary(
  data = x_survey,
  include = c(
    depression,
    lonely,
    age,
    education,
    female,
    married,
    hh_size,
    hh_income,
    firm_size
  ),
  by=essround_factor,
  statistic = list(
    all_continuous()~"{mean} ({sd},{min}-{max})", #sürekli değişkenler için ortalama, standart sapma ve min-maks,
    all_categorical()~"{n} ({p}%)" #kategorik değişkenler için sayı ve yüzde hesaplar.
  )
)


#unknown satırlarını kaldırma
tbl_svysummary(
  data = x_survey,
  include = c(
    depression,
    lonely,
    age,
    education,
    female,
    married,
    hh_size,
    hh_income,
    firm_size
  ),
  by = essround_factor,
  statistic = list(
    all_continuous()~"{mean} ({sd}, {min}-{max})",
    all_categorical()~"{n} ({p}%)"
    ),
  missing = "no"
)


#kukla degiskenleri continuous degisken olarak tanımlama

tbl_svysummary(
  data = x_survey,
  include = c(
    depression,
    lonely,
    age,
    education,
    female,
    married,
    hh_size,
    hh_income,
    firm_size
  ),
  by = essround_factor,
  statistic = list(
    all_continuous() ~"{mean} ({sd}, {min}-{max})",
    all_categorical() ~"{n} ({p}%)"
  ),
  missing = "no",
  type = list(
    depression ~ "continuous",
    lonely ~ "continuous",
    female ~ "continuous",
    married ~ "continuous"
  )
)


#Sürekli değişkenlerde ortalama ve standart sapmayı 3 ondalık basamakla
tbl_svysummary(
  data = x_survey,
  include = c(
    depression,
    lonely,
    age,
    education,
    female,
    married,
    hh_size,
    hh_income,
    firm_size
  ),
  by = essround_factor,
  statistic = list(
    all_continuous() ~ "{mean} ({sd}, {min}-{max})",
    all_categorical() ~ "{n} ({p}%)"
  ),
  missing = "no",
  type = list(
    depression ~ "continuous",
    lonely ~"continuous",
    female ~"continuous",
    married ~"continuous"
  ),
  digits = list(
    all_continuous() ~ c(3,3,0,0),
    all_categorical() ~ c(0,0)
  )
)


#degisken isimlerine etiket atama
tbl_svysummary(
  data = x_survey,
  include = c(
    depression,
    lonely,
    age,
    education,
    female,
    married,
    hh_size,
    hh_income,
    firm_size
  ),
  by = essround_factor,
  statistic = list(
    all_continuous()~ "{mean} ({sd}, {min}-{max})",
    all_categorical() ~"{n} ({p}%)"
    ),
  missing = "no",
  type = list(
    depression ~ "continuous",
    lonely ~ "continuous",
    female ~ "continuous",
    married ~ "continuous"
  ),
  digits = list(
    all_continuous() ~ c(3,3,0,0),
    all_categorical() ~ c(0,0)  
  ),
  label = list(
    depression ~ "Depression dummy, mean (SD,range)",
    lonely ~ "Lonely dummy, mean (SD, range)",
    age ~ "Age, mean (SD, range)",
    education ~ "Education, mean (SD, range)",
    female ~ "Female, mean (SD, range)",
    married ~ "Married, mean (SD, range)",
    hh_size ~ "Household Size, mean (SD, range)",
    hh_income ~ "Household Income, n(%)",
    firm_size ~ "Firm size, n(%)"
  )
) %>%add_overall()%>%
modify_footnote(all_stat_cols()~NA)%>%
  modify_header(label="**Variable**")







tbl_svysummary(
  data = x_survey,
  include = c(
    depression,
    lonely,
    age,
    education,
    female,
    married,
    hh_size,
    hh_income,
    firm_size
  ),
  by = essround_factor,
  statistic = list(
    all_continuous()~ "{mean} ({sd}, {min}-{max})",
    all_categorical() ~"{n} ({p}%)"
  ),
  missing = "no",
  type = list(
    depression ~ "continuous",
    lonely ~ "continuous",
    female ~ "continuous",
    married ~ "continuous"
  ),
  digits = list(
    all_continuous() ~ c(3,3,0,0),
    all_categorical() ~ c(0,0)  
  ),
  label = list(
    depression ~ "Depression dummy, mean (SD,range)",
    lonely ~ "Lonely dummy, mean (SD, range)",
    age ~ "Age, mean (SD, range)",
    education ~ "Education, mean (SD, range)",
    female ~ "Female, mean (SD, range)",
    married ~ "Married, mean (SD, range)",
    hh_size ~ "Household Size, mean (SD, range)",
    hh_income ~ "Household Income, n(%)",
    firm_size ~ "Firm size, n(%)"
  )
) %>%add_overall()%>% # add_overall(): #Tabloya tüm örneklem için genel özet sütunu ekler.
  modify_footnote(all_stat_cols()~NA)%>%  # modify_footnote(): Tablodaki tüm istatistik sütunlarının dipnotlarını kaldırır.
  modify_header(label="**Variable**") #modify_header(): Değişken isimleri sütununun başlığını "Variable" olarak değiştirir.


#Worde aktarma
summary_stat_table <- tbl_svysummary(
  data = x_survey,
  include = c(
    depression,
    lonely,
    age,
    education,
    female,
    married,
    hh_size,
    hh_income,
    firm_size
  ),
  by = essround_factor,
  statistic = list(
    all_continuous()~ "{mean} ({sd}, {min}-{max})",
    all_categorical() ~"{n} ({p}%)"
  ),
  missing = "no",
  type = list(
    depression ~ "continuous",
    lonely ~ "continuous",
    female ~ "continuous",
    married ~ "continuous"
  ),
  digits = list(
    all_continuous() ~ c(3,3,0,0),
    all_categorical() ~ c(0,0)  
  ),
  label = list(
    depression ~ "Depression dummy, mean (SD, range)",
    lonely ~ "Lonely dummy, mean (SD, range)",
    age ~ "Age, mean (SD, range)",
    education ~ "Education, mean (SD, range)",
    female ~ "Female, mean (SD, range)",
    married ~ "Married, mean (SD, range)",
    hh_size ~ "Household Size, mean (SD, range)",
    hh_income ~ "Household Income, n(%)",
    firm_size ~ "Firm size, n(%)"
  )
) %>%add_overall()%>% # add_overall(): 
  modify_footnote(all_stat_cols()~NA)%>%  
  modify_header(label="**Variable**") 

summary_stat_table2<-as_flex_table( # summary_stat_table nesnesini Word/flextable formatına uygun hale getirir.
  summary_stat_table
)

summary_stat_table3 <- read_docx()# Boş bir Word dosyası (docx) oluşturur, tablo veya içerik eklemek için başlangıç nesnesi hazırlar.

summary_stat_table3 <- body_add_flextable(# Flextable olarak hazırlanan tabloyu Word belgesinin gövdesine ekler.
  summary_stat_table3,
  summary_stat_table2
)

print(
  summary_stat_table3,# Word dosyasını oluşturur ve tabloyu "summary_stat_table.docx" olarak kaydeder.
  target="summary_stat_table.docx"
)

save.image()












