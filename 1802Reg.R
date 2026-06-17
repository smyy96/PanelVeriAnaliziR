
installed.packages("wooldridge")
library(wooldridge)

hprice1 <- hprice1
# oda sayısı ve alan degistikce ev fiyatindaki degisim 
res_hprice1 <- lm(
  price ~ sqrft + bdrms,
  data = hprice1
)

summary(res_hprice1)

#Kare terimli modeller

wage1 <- wage1

res_wage1 <- lm(
  wage ~ exper+ I(exper^2),
  data = wage1
)
summary(res_wage1)

#Kukla degisken yalnızca 1-0 degeri alan degiskenlerdir
#saatlik ücrete; cinsiyetin, egitimin, is hayatı tecrubesinin ve son işverendeki calısma süresinin etkisi 
res_wage2 <- lm(
  wage ~ female + educ + exper + tenure,
  data = wage1
)
summary(res_wage2)

# colcpa öğrencinin not ortalaması,hsgpa lise not ortalaması, act branş sınavı, pc bilgisayar varsa 1

gpa1 <- gpa1
res_qpa1<-lm(
  colGPA ~ hsGPA+ACT+PC,
  data = gpa1
)
summary(res_qpa1)

# log lin kukla degisken

res_wage3 <- lm(
  log(wage) ~ female+educ+exper+I(exper^2)+tenure+I(tenure^2),
  data = wage1
)
summary(res_wage3)


res_wage4 <- lm(
  wage ~ female+educ+exper+I(exper^2)+tenure+I(tenure^2)+married,
  data = wage1
)
summary(res_wage4)

# evli ya da bekar erkeklerin saatlik ücrete etkisi
View(wage1)
wage1$marrmale <- ifelse(
  wage1$female==0 & wage1$married==1, #evli olan erkeklere 1 olmayanlara 0
  1,
  0
)


wage1$marrfemale <- ifelse(
  wage1$female==1 & wage1$married==1, #evli olan kadınlara 1 olmayanlara 0
  1,
  0
)


wage1$singfemale <- ifelse(
  wage1$female==1 & wage1$married==0, #bekar olan kadınlara 1 olmayanlara 0
  1,
  0
)

res_wage5 <- lm(
  log(wage)~ marrmale + marrfemale + singfemale + educ + exper+I(exper^2)+tenure+I(tenure^2),
  data = wage1
)
summary(res_wage5)




















