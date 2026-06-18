tbl_regression(
  results2
)

tbl_regression(
  results2,
  exponentiate = TRUE
)


tbl_regression(
  results2,
  exponentiate = TRUE,
  intercept = TRUE
)


tbl_regression(
  results2,
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
    firm_size
  ),
  pvalue_fun = function(x){
    format(round(x,digits = 3))
  }
)


tbl_regression(
  results2,
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
    firm_size
  ),
  pvalue_fun = function(x){
    format(round(x,digits = 3))
  },
  estimate_fun = function(x){
    format(round(x,digits = 3))
  }
)


tbl_results2_1<-tbl_regression(
  results2,
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
    firm_size
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
    firm_size ~ "Firm Size (Reference: Under 25)"
  )
)%>% remove_row_type(
  variables = c(
    hh_income,
    firm_size
  ),
  type = "reference"
)%>% modify_header(
  label = "**Variable**"
)


tbl_results2_2<- as_flex_table(
  tbl_results2_1
)


tbl_results2_3 <- read_docx()
tbl_results2_3<-body_add_flextable(
  tbl_results2_3,
  tbl_results2_2
)
print(
  tbl_results2_3,
  target = "regression_results2.docx"
)

save.image()








