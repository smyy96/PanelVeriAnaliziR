library(survey)
library(broom)
library(writexl)
library(gtsummary)
library(flextable)
library(officer)


# Depresyonu hangi değişkenlerin etkilediğini inceleyen bir lojistik regresyon analizi yapmak. Bağımlı değişken: depression
# Bağımsız değişkenler: yalnızlık, yaş, eğitim, cinsiyet,
# medeni durum, hanehalkı büyüklüğü, hanehalkı geliri,
# firma büyüklüğü, ESS turu, ülke ve meslek.
results <- svyglm(
  formula = depression ~
    lonely+
    age+
    education+
    female+
    married+
    hh_size+
    hh_income+
    firm_size+
    essround_factor+
    country_factor+
    occupation,
  design = x_survey,
  family = "quasibinomial"
)

# tidy(): svyglm model çıktısını düzenli bir veri çerçevesine dönüştürür.
# exponentiate = TRUE: lojistik regresyon katsayılarının üstelini alarak
# sonuçları Odds Ratio (OR) biçiminde gösterir.
result_tidy<-tidy(
  results,
  exponentiate = TRUE
)



write_xlsx(
  result_tidy,
  "results1.xlsx"
)


tbl_regression(
  results
)


# Regresyon modeli sonuçlarını tablo haline getirir.
# exponentiate = TRUE ile katsayılar Odds Ratio (OR) olarak gösterilir.
tbl_regression(
  results,
  exponentiate = TRUE
)



tbl_regression(
  results,
  exponentiate = TRUE,
  intercept = TRUE
)

#istediğimiz degişkenleri secerek regresyon tablosunu olusturma 
tbl_regression(
  results,
  exponentiate = TRUE,
  intercept = TRUE,
  include = c(
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



#tablodaki p degerlerinin küsürat kısmını 3 basamaklı yapma
tbl_regression(
  results,
  exponentiate = TRUE,
  intercept = TRUE,
  include = c(
    lonely,
    age,
    education,
    female,
    married,
    hh_size,
    hh_income,
    firm_size
  ),
  pvalue_fun = function(x){
    format(round(x,digits = 3))
  }
)

#tablodaki odds ratio degerlerinin küsürat kısmını 3 basamaklı yapma
tbl_regression(
  results,
  exponentiate = TRUE,
  intercept = TRUE,
  include = c(
    lonely,
    age,
    education,
    female,
    married,
    hh_size,
    hh_income,
    firm_size
  ),
  pvalue_fun = function(x){
    format(round(x,digits = 3))
  },
  estimate_fun = function(x){
    format(round(x,digits = 3))
  }
)


#degisken isimlerini düzeltme
tbl_regression(
  results,
  exponentiate = TRUE,
  intercept = TRUE,
  include = c(
    lonely,
    age,
    education,
    female,
    married,
    hh_size,
    hh_income,
    firm_size
  ),
  pvalue_fun = function(x){
    format(round(x,digits = 3))
  },
  estimate_fun = function(x){
    format(round(x,digits = 3))
  },
  label = list(
    lonely ~ "Lonely dummy",
    age~"Age",
    education~"Education",
    female~"Female",
    married~"Married",
    hh_size~"Household Size",
    hh_income~"Household Income (Reference: Low Household Income)",
    firm_size ~ "Firm Size (Reference: Under 25)"
  )
)


tbl_result1 <- tbl_regression(
  results,
  exponentiate = TRUE,
  intercept = TRUE,
  include = c(
    lonely,
    age,
    education,
    female,
    married,
    hh_size,
    hh_income,
    firm_size
  ),
  pvalue_fun = function(x){
    format(round(x,digits = 3))
  },
  estimate_fun = function(x){
    format(round(x,digits = 3))
  },
  label = list(
    lonely ~ "Lonely dummy",
    age~"Age",
    education~"Education",
    female~"Female",
    married~"Married",
    hh_size~"Household Size",
    hh_income~"Household Income (Reference: Low Household Income)",
    firm_size ~ "Firm Size (Reference: Under 25)"
  )
)



tbl_result1<-remove_row_type(
  tbl_result1, 
  variables = c(
    hh_income,
    firm_size
  ),
  type = "reference"
)

tbl_result1 <- modify_header(
  tbl_result1,
  label="**Variable**"
)


#word dosyası olarak dısarı aktarma
tbl_results2 <- as_flex_table(
  tbl_result1
)

tbl_result3 <- read_docx()
tbl_result3<-body_add_flextable(
  tbl_result3,
  tbl_results2
)

print(tbl_result3, target="regression_results_1.docx")


save.image()
















































