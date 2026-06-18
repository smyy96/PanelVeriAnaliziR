tbl_svysummary(
  data= x_survey,
  include=c(
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


tbl_svysummary(
  data=x_survey,
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
  by = essround_factor
)

#raporlanan istatistiklerini degistirme
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
  )
)


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
  missing = "no"
)




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
  type= list(
    depression ~"continuous",
    lonely ~"continuous",
    female ~"continuous",
    married ~"continuous"
  )
)



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
  type= list(
    depression ~"continuous",
    lonely ~"continuous",
    female ~"continuous",
    married ~"continuous"
  ),
  digits = list(
    all_continuous() ~c(3,3,0,0),
    all_categorical() ~c(0,0)
  )
)


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
  type= list(
    depression ~"continuous",
    lonely ~"continuous",
    female ~"continuous",
    married ~"continuous"
  ),
  digits = list(
    all_continuous() ~c(3,3,0,0),
    all_categorical() ~c(0,0)
  ),
  label = list(
    depression ~ "Depression dummy, mean (SD, range)",
    lonely ~ "Lonely dummy, mean (SD, range)",
    age~"Age, mean (SD, range)",
    education~"Education, mean (SD, range)",
    female~"Female, mean (SD, range)",
    married~"Married, mean (SD, range)",
    hh_size~"Household Size, mean (SD, range)",
    hh_income~"Household Income, N (%)",
    firm_size ~ "Firm Size, N (%)"
  )
)



summary_stat2_table1 <- tbl_svysummary(
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
  type= list(
    depression ~"continuous",
    lonely ~"continuous",
    female ~"continuous",
    married ~"continuous"
  ),
  digits = list(
    all_continuous() ~c(3,3,0,0),
    all_categorical() ~c(0,0)
  ),
  label = list(
    depression ~ "Depression dummy, mean (SD, range)",
    lonely ~ "Lonely dummy, mean (SD, range)",
    age~"Age, mean (SD, range)",
    education~"Education, mean (SD, range)",
    female~"Female, mean (SD, range)",
    married~"Married, mean (SD, range)",
    hh_size~"Household Size, mean (SD, range)",
    hh_income~"Household Income, N (%)",
    firm_size ~ "Firm Size, N (%)"
  )
)  %>% add_overall()%>%
  modify_footnote(all_stat_cols()~NA)%>% 
  modify_header(label="**Variable**")


summary_stat2_table2 <- as_flex_table(
  summary_stat2_table1
)
summary_stat2_table3 <- read_docx()
summary_stat2_table3<-body_add_flextable(
  summary_stat2_table3,
  summary_stat2_table2
)

print(
  summary_stat2_table3,
  target = "summary_stat2_table.docx"
)


save.image()
