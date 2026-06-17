# Veri analizinnde, Ekonometride üç temel veri türü kullanılır:
# 1. Yatay kesit (cross-section) veriler: Belirli bir anda farklı birimlerden (birey, firma, ülke vb.) toplanan veriler.
# 2. Zaman serisi (time series) veriler: Tek bir birime ait zaman içinde ardışık olarak gözlenen veriler.
# 3. Panel (boylamsal / longitudinal) veriler: Aynı birimlerin hem zaman hem de kesit boyutunda birlikte izlendiği veriler.


installed.packages("wooldridge")
library(wooldridge)

# Lineer Regresyon lm fonksiyonu
# lin lin model
# Örnek 1 CEO maaşı (salary), şirketin kârlılığı (roe) ile artıyor mu?
ceosal1 <- ceosal1
view(ceosal1)
res_ceosal1<-lm(
  salary ~ roe, 
  data = ceosal1
  )

summary(res_ceosal1)


plot(
  ceosal1$roe,
  ceosal1$salary,
  xlab = "Return on equity",
  ylab = "CEO Salary",
  ylim = c(0,4000)
)
abline(
  res_ceosal1,
  col="green"
)

# Örnek 2
#Eğitim seviyesi (educ, yıl cinsinden toplam eğitim miktarı) ve saatlik ücret (wage, dolar cinsinden) arasındaki ilişki.

wage1 <- wage1
res_wage1 <- lm(
  wage ~ educ,
  data = wage1
)

summary(res_wage1)

# log lin model Bağımlı değişkenin logaritması alınır, bağımsız değişken(ler) ise normal haliyle bırakılır.

#  Örnek 3 Eğitim yılının artması ile saatlik ücretteki yüzde artışı
res_wage2 <- lm(
  log(wage) ~ educ,
  data = wage1
)

summary(res_wage2)


# log log model Log-log modelde hem bağımlı hem bağımsız değişken loglanır; bu yüzden X’te %1’lik artış Y’de %β₁’lik değişim yaratır ve bu model esneklik (elasticity) yorumunu verir.

#  Örnek 3 Şirketin cirosunun yüzde birlik değişiminin CEO yıllık gelirinde yüzdelik etkisi.
res_ceosal2 <- lm(
  log(salary) ~ log(sales),
  data = ceosal1
)

summary(res_ceosal2)



# Çoklu Regresyon
#log log model
# Örnek 4 Yıllık CEO gelirini, firmanın satış hacmi ve firmanın piyasa değeriyle açıklanması.

ceosal2 <- ceosal2

res_ceosal3 <- lm(
  log(salary) ~ log(sales)+ log(mktval),
  data = ceosal2
  )

summary(res_ceosal3)


#Bu regresiyona üç değişken daha ekleniyor. İlki firmanın karlılık oranı, (profmarg) İkincisi CEO'nun kaç yıldır şirkette görevde olduğu, (CEOten) Sonuncusu CEO'nun kaç yıldır firmanın çalışanı olduğu (comten)

res_ceosal4 <- lm(
  log(salary) ~ log(sales)+ log(mktval) 
  + profmarg + ceoten + comten,
  data = ceosal2
)

summary(res_ceosal4)



# Örnek 5 wage1 için saatlik ücreti (wage), eğitim seviyesi (educ), iş hayatındaki tecrübe (exper) ve son işverende çalışma süresi (tenure) değişkenleri ile açıklayan model

wage1 <- wage1
res_wage3 <- lm(
  log(wage) ~ educ + exper + tenure,
  data = wage1
)

summary(res_wage3)

# Örnek 6 wage2 için, eğitim seviyesi (educ), kardeş sayısı (sibs), annenin eğitim seviyesi (meduc) ve babanın eğitim seviyesi (feduc) değişkenleri ile açıklanan model


wage2 <- wage2
res_wage4 <- lm(
  educ ~ sibs + meduc + feduc,
  data = wage2
)

summary(res_wage4)





























































