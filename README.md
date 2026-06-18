
# Veri Analizi Okulu - Panel Veri Dersi Notları

Bu repo, Yükseköğretim Kurulu'nun (YÖK) öncülüğünde ve desteğiyle hayata geçirilen **Veri Analizi Okulu** kapsamında verilen **Panel Veri** dersine ait haftalık ders notlarını, uygulama kodlarını ve örnek çalışmaları içermektedir.

Repo içerisinde her hafta işlenen konulara ait R programlama kodları, kullanılan veri setleri ve ders kapsamında gerçekleştirilen analiz uygulamaları yer almaktadır. Amaç, ders süresince öğrenilen kavramları düzenli bir şekilde arşivlemek ve gelecekte referans olarak kullanılabilecek bir kaynak oluşturmaktır.

## 1. Hafta

### Dosya: 0402tidyverse.R

Bu dosyada R ekosisteminin en yaygın veri analizi paketlerinden biri olan **tidyverse** tanıtılmıştır. Tidyverse; veri temizleme, dönüştürme, özetleme ve analiz işlemlerini daha kolay ve okunabilir hale getiren paketler bütünüdür.

Bu uygulamada:

* Veri setlerinin yüklenmesi ve kullanılması
* Veri filtreleme (`filter`)
* Veri sıralama (`arrange`)
* Sütun seçme (`select`)
* Yeni değişken oluşturma (`mutate`)
* Özet istatistikler üretme (`summarise`)
* Gruplama işlemleri (`group_by`)
* Pipe operatörü (`%>%`) kullanımı
* Uçuş verileri üzerinde temel veri analizi uygulamaları
* Basit doğrusal regresyon modeli oluşturma (`lm`)

konuları ele alınmıştır.

## 2. Hafta

### Dosya: 1102LineerReg.R

* Veri türleri: yatay kesit, zaman serisi, panel veri
* wooldridge veri seti ile regresyon uygulamaları
* lm ile basit ve çoklu regresyon
* log-lineer ve log-log modeller
* CEO maaşı, firma performansı, eğitim ve ücret ilişkileri
* plot ve abline ile temel görselleştirme

## 3. Hafta

### Dosya: 1802Reg.R

* Çoklu regresyon uygulamaları
* Kare terimli (doğrusal olmayan) regresyon modelleri
* Kukla (dummy) değişken kullanımı
* Log-lineer modeller


## 4. Hafta

### Dosya: 2502ESS_analysis.R

Bu haftada European Social Survey (ESS 7 ve ESS 11) verileri kullanılarak bireylerin **yalnızlık (loneliness)** ve **depresyon (depression)** durumları arasındaki ilişki analiz edilmiştir.

* ESS 7 ve ESS 11 veri setlerinin birleştirilmesi
* Ortak değişkenlerin seçilmesi ve veri temizleme
* Gelir, firma büyüklüğü, hane yapısı ve meslek değişkenlerinin kategorik hale getirilmesi
* Geçersiz değerlerin NA olarak düzenlenmesi
* Yalnızlık ve depresyon değişkenlerinin ikili (0-1) forma dönüştürülmesi
* Cinsiyet, yaş, eğitim ve medeni durum değişkenlerinin oluşturulması
* Survey tasarım nesnesi (svydesign) ile ağırlıklı analiz yapısının kurulması


## 5. Hafta

### Dosya: 0403_gtsummary.R

Bu haftada ESS verisi kullanılarak ağırlıklı özet istatistik tabloları oluşturulmuştur.

* survey paketi ile örneklem tasarımı oluşturma (`svydesign`)
* gtsummary ile tanımlayıcı istatistik tabloları üretme (`tbl_svysummary`)
* ESS 7 ve ESS 11 karşılaştırmalı analiz
* değişkenlerin ortalama, standart sapma ve yüzde dağılımlarının hesaplanması
* kukla ve kategorik değişkenlerin düzenlenmesi
* tablo formatlama (label, digits, missing control)
* sonuçların Word dosyasına aktarılması (`flextable`, `officer`)



## 6. Hafta

### Dosya: 1103TblReg.R

* ESS veri setinde veri temizleme ve ön işleme çalışmaları
* Geçersiz gözlemlerin NA olarak düzenlenmesi
* Gelir, firma büyüklüğü ve meslek değişkenlerinin kategorik hale getirilmesi
* Yalnızlık (lonely) ve depresyon (depression) değişkenlerinin ikili (0-1) forma dönüştürülmesi
* Cinsiyet, yaş, eğitim ve medeni durum değişkenlerinin oluşturulması
* Ülke ve anket dönemi için faktör değişkenlerinin tanımlanması
* Regresyon analizine uygun veri setinin hazırlanması


### Dosya: 1103TblReg_1.R

* Survey ağırlıklı lojistik regresyon analizi (`svyglm`)
* Depresyonun belirleyicilerinin incelenmesi
* Odds Ratio (OR) hesaplanması ve yorumlanması
* Regresyon sonuçlarının düzenlenmesi (`broom`)
* Regresyon tablolarının oluşturulması (`gtsummary`)
* Sonuçların Excel ve Word formatında dışa aktarılması
* Regresyon çıktılarının raporlamaya uygun hale getirilmesi






## 7. Hafta

### Dosya: 1803Reg.R

* Survey ağırlıklı tanımlayıcı istatistik tablolarının oluşturulması
* ESS 7 ve ESS 11 verilerinin karşılaştırılması
* Ortalama, standart sapma ve yüzde dağılımlarının hesaplanması
* Tablo biçimlendirme ve etiketleme işlemleri
* Sonuçların Word formatında raporlanması

### Dosya: 1803Reg_1.R

* Survey ağırlıklı lojistik regresyon analizi
* Yalnızlık ve depresyon ilişkisinin incelenmesi
* Odds Ratio (OR) hesaplanması
* Regresyon sonuçlarının tablo haline getirilmesi
* Sonuçların Excel ve Word formatında dışa aktarılması











