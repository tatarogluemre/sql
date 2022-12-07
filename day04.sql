ALIASES
-- Aliases kodu ile tablo yazdirilirken, field isimleri sadece o cikti icin degistirilebilir.
CREATE TABLE calisanlar3 (
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50)
);
INSERT INTO calisanlar3 VALUES(123456789,'Ali Can', 'Istanbul');
INSERT INTO calisanlar3 VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO calisanlar3 VALUES(345678901, 'Mine Bulut', 'Izmir');
select * from calisanlar3
--Eger iki sutunun verilerini birlestirmek istersek concat sembol olan || kullaniriz.

select concat(calisan_isim,' ',calisan_dogdugu_sehir ) as isim_sehir from calisanlar3;


select calisan_id AS id,calisan_isim ||' '|| calisan_dogdugu_sehir AS calisan_bilgisi FROM calisanlar3
--2.yol
select calisan_id AS id, concat(calisan_isim,' ' calisan_dogdugu_sehir) AS calisan_bilgisi FROM calisanlar3

select concat(calisan_isim ,' ',calisan_dogdugu_sehir)AS bilgi from calisanlar3 where calisan_id='123456789'; 

CREATE TABLE insanlar
(
ssn char(9),
isim varchar(50),
adres varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir');
INSERT INTO insanlar (ssn, adres) VALUES(456789012, 'Bursa');
INSERT INTO insanlar (ssn, adres) VALUES(567890123, 'Denizli'); 

-- Name sutununda null olan değerleri listeleyelim
SELECT isim FROM insanlar WHERE isim IS NULL

-- Insanlar taplosunda sadece null olmayan değerleri listeleyiniz
SELECT isim FROM insanlar WHERE isim IS NOT NULL

-- Insanlar toplasunda null değer almış değerleri no name olarak değiştiriniz

update insanlar set isim='NO NAME' where isim is null;
select * from insanlar;


drop table  if exists insanlar;

CREATE TABLE insanlar
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO insanlar VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO insanlar VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO insanlar VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');


--ORDER BY CLAUSE
/*
Tablolardaki verileri sıralamak için ORDER BY komutu kullanırız
Büyükten küçüğe yada küçükten büyüğe sıralama yapabiliriz
Default olarak küçükten büyüğe sıralama yapar
Eğer BÜYÜKTEN KÜÇÜĞE sıralmak istersek ORDER BY komutundan sonra DESC komutunu kullanırız
*/
-- insanlar tablosunda ki dataları adrese göre sıralayın
select * from insanlar order by adres;

select * from insanlar order by soyisim;

--insanlar tablosunda ismi mine olanları SSN siralı olarak listeleyin
select * from insanlar where isim='Mine' order by ssn;

--NOT : Order By komutundan sonra field ismi yerine field numarasi da kullanilabilir
--Insanlar tablosundaki soyismi Bulut olanlari isim sirali olarak listeleyin
select * from insanlar where soyisim='Bulut' ORDER BY 2;

--NOT : Order By komutundan sonra field(sutun) ismi yerine field(sutun) numarasi da kullanilabilir
--Insanlar tablosundaki soyismi Bulut olanlari isim sirali olarak listeleyin 
SELECT * FROM insanlar WHERE soyisim='Bulut' ORDER BY 2

-- Insanlar tablosundaki tum kayitlari SSN numarasi buyukten kucuge olarak siralayin
SELECT * FROM insanlar ORDER BY ssn DESC;

-- Insanlar tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyin
SELECT * FROM insanlar ORDER BY isim ASC, soyisim DESC;

-- İsim ve soyisim değerlerini soyisim kelime uzunluklarına göre sıralayınız
SELECT isim,soyisim FROM insanlar ORDER BY LENGTH (soyisim) DESC;

/*
Eğer sutun uzunluğuna göre sıralamak istersek LENGTH komutu kullanırız 
Ve yine uzunluğu büyükten küçüğe sıralamak istersek sonuna DESC komutunu ekleriz
*/

-- Tüm isim ve soyisim değerlerini aynı sutunda çağırarak her bir sütun değerini uzunluğuna göre sıralayınız.
select isim || ' ' || soyisim as isim_soyisim from insanlar order by length(isim||soyisim);

select isim || ' ' || soyisim as isim_soyisim from insanlar order by length(isim)+ length(soyisim);

--GROUP BY CLAUSE
/*
Group By komutu sonuçları bir veya daha fazla sütuna göre gruplamak için SELECT
komutuyla birlikte kullanılır.
*/
CREATE TABLE manav
(
isim varchar(50),
Urun_adi varchar(50),
Urun_miktar int
);
INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);

--isme göre alınan ürünleri bulun 

select isim ,sum(urun_miktar) from manav group by isim; 
--aggregate methodlarda tek kullanımın dışında çoklu veri çağırma kullanımlarda group by kullanırız.

--ürün ismine göre ürünü alan toplam kişi saysı 
select urun_adi , count(isim) from manav group by urun_adi;

--kişilerin aldığı ürün sayısı
select isim ,count(urun_adi) as algigi_urun_sayisi from manav group by isim;