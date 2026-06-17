# Bu hafta European Social Survey verisiyle (ESS 7, ESS 11)
# yalnızlık belirtenlerin daha fazla depresyon belirtme
# eğiliminde olup olmadığını sorgulayacağız.

# İhtiyacımız olan değişkenleri içeren en güncel iki ESS verisi
# ESS 7 ve ESS 11 olduğu için bunları tercih ettik.

# Bu ilişkiyi sorgularken; yaş, eğitim seviyesi, cinsiyet,
# hanehalkı büyüklüğü, hanehalkı gelir seviyesi ve
# çalışılan firma büyüklüğü gibi kontrol değişkenleri kullanacağız.

# Ayrıca ülkeler, zaman (anket dönemi - 7 veya 11-) ve
# meslek sabit etkileri kullanacağız.

# Sabit etkiler sayesinde, örneğin ülke sabit etkilerini
# regresyona ekleyerek bağımlı değişken açısından ülkeler
# arasında bir ayrışma varsa bunu regresyonumuzda
# kontrol edeceğiz.

# Meslek sabit etkileri sayesinde bağımlı degişken açısından mesleklere göre bir ayrışma varsa bu kontrol edilecek

install.packages("survey")   # Anket (survey) verileri ve ağırlıklı analizler
install.packages("broom")    # Regresyon sonuçlarını düzenli tabloya dönüştürme
install.packages("writexl")  # Sonuçları Excel (.xlsx) dosyasına yazdırma

library(survey)
library(broom)
library(writexl)

sddf_7<- read.csv(
  "ESS7_SDDF.csv"
)

sddf_7 <- sddf_7[,5:10]

ess_7 <- read.csv(
  "ESS7.csv"
)

ess_11 <- read.csv(
  "ESS11.csv"
)

# iki tabloyu birleştiriyoruz cntry ve idno ile
ess_7<-merge(
  x=ess_7,
  y=sddf_7,
  by=c("cntry","idno"),
  all.x=TRUE
)
rm(sddf_7) # sddf7 dosyasını sildik artık gerek kalmadıgı için

#kullanacagımız degiskenleri common_vars nesnesine kaydettik
common_vars<-c(
  "psu",
  "name",
  "essround",
  "edition",
  "proddate",
  "cntry",
  "idno",
  "anweight",
  "isco08",
  "hinctnta",
  "fltlnl",
  "fltdpr",
  "gndr",
  "agea",
  "eduyrs",
  "maritalb",
  "estsz",
  "hhmmb"
)

common_vars[!(common_vars%in%colnames(ess_11))] #ess11 içinde bütün degiskenleri barındırıyor mu
common_vars[!(common_vars%in%colnames(ess_7))]


x<-rbind(# alınan sütunları alt alta ekle birleştir
  subset( #ess7deki sütunları al
    ess_7,
    select = common_vars
  ),
  subset( #ess11deki sütunları al 
    ess_11,
    select = common_vars
  )
)

rm(list = ls()[ls()!="x"]) # x dısındaki herseyi sildik

# isco08 değişkenindeki geçersiz meslek kodlarını (66666, 77777,
# 88888, 99999) NA yaparak occupation adlı yeni bir değişken oluştur
x$occupation<-ifelse(
  x$isco08%in%c(66666,77777,88888,99999),
  NA,
  x$isco08
)

# occupation değişkenini kategorik (factor) formata dönüştür
x$occupation<-factor(
  x$occupation
)


x$hh_income<-ifelse(
  x$hinctnta %in% c(77,88,99),
  NA,
  x$hinctnta
)


# hh_income değişkenindeki gelir kodlarını üç gelir grubunda
# birleştir ve factor olarak tanımlayarak kategori sırasını
# Low → Middle → High şeklinde belirle
x$hh_income<-ifelse(
  x$hh_income %in% c(1,2,3,4),
  "Low Household Income",
  x$hh_income
)

x$hh_income<-ifelse(
  x$hh_income %in% c(5,6,7),
  "Middle Household Income",
  x$hh_income
)

x$hh_income<-ifelse(
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

# referans kategoriyi "Low Household Income" olarak belirledik
x$hh_income<-relevel(
  x$hh_income,
  ref = "Low Household Income"
)

# Geçersiz firma büyüklüğü kodlarını NA yaparak işletmeleri çalışan sayılarına göre adlandırdık
x$firm_size<-ifelse(
  x$estsz %in% c(6,7,8,9),
  NA,
  x$estsz
)

x$firm_size<-ifelse(
  x$firm_size %in% c(1,2),
  "Under 25",
  x$firm_size
)
x$firm_size<-ifelse(
  x$firm_size ==3,
  "25 to 99",
  x$firm_size
)
x$firm_size<-ifelse(
  x$firm_size %in% c(4,5),
  "100 or more",
  x$firm_size
)

table(x$firm_size)
x$firm_size<-factor(
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

# hh_size değişkeninde 0 değerlerini say ve bu gözlemleri veri setinden çıkar
sum(x$hh_size==0,na.rm = TRUE)
x<-x[x$hh_size!=0,]


#Kukla değişkene ceviriyoruz 0-1 olarak

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


# fltdpr değişkenindeki geçersiz değerleri (7, 8, 9) NA yap,
# ardından değişkeni ikili hale getirerek 1’i 0’a, 2–4 aralığını 1’e dönüştür. 
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
  x$female == 2,
  1,
  0
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

x$country_factor <- factor(x$cntry)
x$essround_factor<-factor(x$essround)

# psu değişkeninde NA olan gözlemleri veri setinden çıkar
x<-x[!is.na(x$psu),]


x_survey<-svydesign(
  ids = ~psu,
  weights = ~anweight,
  data = x
)





































