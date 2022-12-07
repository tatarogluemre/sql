CREATE TABLE sirketler  (
sirket_id int,  
sirket_isim varchar(20)
);
INSERT INTO sirketler VALUES(100, 'Toyota');  
INSERT INTO sirketler VALUES(101, 'Honda');  
INSERT INTO sirketler VALUES(102, 'Ford');  
INSERT INTO sirketler VALUES(103, 'Hyundai');

CREATE TABLE siparisler  (
siparis_id int,  
	sirket_id int,  
	siparis_tarihi date
);
INSERT INTO siparisler VALUES(11, 101, '2020-04-17');  
INSERT INTO siparisler VALUES(22, 102, '2020-04-18');  
INSERT INTO siparisler VALUES(33, 103, '2020-04-19');  
INSERT INTO siparisler VALUES(44, 104, '2020-04-20');  
INSERT INTO siparisler VALUES(55, 105, '2020-04-21');

/*
	NOT :
	1) Select’ten sonra tabloda gormek istediginiz sutunlari yazarken Tablo_adi.field_adi seklinde yazin
	2) From’dan sonra tablo ismi yazarken 1.Tablo ismi + INNER JOIN + 2.Tablo ismi yazmaliyiz
	3) Join’i hangi kurala gore yapacaginizi belirtmelisiniz. Bunun icin ON+ kuralimiz yazilmali
	
2 Tablodaki datalari Birlestirmek icin kullanilir.
Su ana kadar gordugumuz Union,Intersect ve Minus sorgu sonuclari icin kullanilir
Tablolar icin ise JOIN kullanilir
5 Cesit Join vardir
1) INNER JOIN iki Tablodaki ortak datalari gosterir
2) LEFT JOIN Ilk datada olan tum recordlari gosterir
3) RIGHT JOIN Ikinci tabloda olan tum recordlari gosterir
4) FULL JOIN Iki tablodaki tum recordlari gosterir
5) SELF JOIN Bir tablonun kendi icinde Join edilmesi ile olusur

soruda istenilen fieldları alırken
ınner joinde sadece kesişimleri
left joinde 1. tablo + kesişimleri
right joinde 2. tablo + kesişimleri
*/
 select * from sirketler
 select * from siparisler

-- SORU) Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
--       siparis_tarihleri ile yeni bir tablo olusturun

SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi FROM sirketler
INNER JOIN siparisler ON sirketler.sirket_id = siparisler.sirket_id;

-- LEFT JOIN
-- Iki Tabloda sirket_id'si ayni olanlarin sirket_ismi, siparis_id ve
-- siparis_tarihleri ile yeni bir tablo olusturun

SELECT sirketler.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi
FROM sirketler LEFT JOIN siparisler
ON sirketler.sirket_id=siparisler.sirket_id;

--RIGHT JOIN

SELECT sirketler.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi
FROM sirketler RIGHT JOIN siparisler
ON sirketler.sirket_id=siparisler.sirket_id;

--FULL JOIN

SELECT sirketler.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi
FROM sirketler FULL JOIN siparisler
ON sirketler.sirket_id=siparisler.sirket_id;

DROP TABLE personel cascade

CREATE TABLE personel  (
id int,
isim varchar(20),  
title varchar(60),  yonetici_id int
);
INSERT INTO personel VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO personel VALUES(2, 'Veli Cem', 'QA', 3);
INSERT INTO personel VALUES(3, 'Ayse Gul', 'QA Lead', 4);  INSERT INTO personel VALUES(4, 'Fatma Can', 'CEO', 5);
select * from personel;

--SELF JOIN 
-- Hayali bir tablo oluşturup inner join yaparak self join yapıyoruz ör: personel p1 tablosundan p1.isim verisi oluşturma
--Her personelin yanına yönetici ismi yazdıran bir tablo oluşturun;

SELECT p1.isim AS personel_isim , p2.isim AS yonetici_isim FROM personel p1 INNER JOIN personel p2 
ON p1.yonetici_id = p2.id;

DROP TABLE musteriler;

-- LIKE CONDITION

CREATE TABLE musteriler  (
id int UNIQUE,
isim varchar(50) NOT NULL,
gelir int
);
INSERT INTO musteriler (id, isim, gelir) VALUES (1001, 'Ali', 62000); 
INSERT INTO musteriler (id, isim, gelir) VALUES (1002, 'Ayse', 57500);  
INSERT INTO musteriler (id, isim, gelir) VALUES (1003, 'Feride', 71000);
INSERT INTO musteriler (id, isim, gelir) VALUES (1004, 'Fatma', 42000);  
INSERT INTO musteriler (id, isim, gelir) VALUES (1005, 'Kasim', 44000);
INSERT INTO musteriler (id, isim, gelir) VALUES (1006, 'ahmet', 82000); 

/*
LIKE kullanımında büyük küçük harf gözetmeksizin sonuç almak istersek ILIKE kullanırız
LIKE yerine ~~ sembollerini kullanabiliriz. Eğer büyük küçük harf gözetmeksizin kullanmak istersek ~~* sembollerini kullanırız
*/

-- İsmi A harfi ile başlayan müşterilerin tüm bilgilerini yazdıran sorguyu yazınız.
SELECT * FROM musteriler WHERE isim LIKE 'A%' ; -- bu sadece büyük A ları getirir.
SELECT * FROM musteriler WHERE isim ILIKE 'A%'; --ILIKE büyük küçük harf gözetmez.

--ismi e harfi ile biten müsterilerin isimlerini ve gelrirlerini yazdıran QUERY yazın.
SELECT isim , gelir FROM musteriler WHERE isim LIKE '%e';
 
 -- isminin içinde er olan müsterilerin isim ve gelirlerin sorgula
 SELECT isim ,gelir FROM musteriler WHERE isim LIKE '%er%';
 
 --Ismi 5 harfli olup son 4 harfi atma olan musterilerin tum bilgilerini yazdiran QUERY yazin
 SELECT * FROM musteriler WHERE isim LIKE '_atma';
 
--Ikinci harfi a olan musterilerin tum bilgilerini yazdiran QUERY yazin
 SELECT * FROM musteriler WHERE isim LIKE '_a%';
 
--Ucuncu harfi s olan musterilerin tum bilgilerini yazdiran QUERY yaz
SELECT * FROM musteriler WHERE isim LIKE '__s%';

--REGEXP_LIKE
--REGEXP_LIKE =>Daha karmaşık sorgular için herhangi bir kod, metin icerisinde istenilen yazi
--	veya kod parcasinin aranip bulunmasini saglayan kendine ait soz dizimi olan bir yapidir.
--	(REGEXP_LIKE) PostgreSQL de ‘’ ~ ‘’ karekteri ile kullanilir(Altgr + ü)
CREATE TABLE kelimeler  (
id int UNIQUE,
kelime varchar(50) NOT NULL,  Harf_sayisi int
);
INSERT INTO kelimeler VALUES (1001, 'hot', 3);  
INSERT INTO kelimeler VALUES (1002, 'hat', 3);  
INSERT INTO kelimeler VALUES (1003, 'hit', 3);  
INSERT INTO kelimeler VALUES (1004, 'hbt', 3);  
INSERT INTO kelimeler VALUES (1008, 'hct', 3);  
INSERT INTO kelimeler VALUES (1005, 'adem', 4); 
INSERT INTO kelimeler VALUES (1006, 'selim', 5);  
INSERT INTO kelimeler VALUES (1007, 'yusuf', 5);
INSERT INTO kelimeler VALUES (1009, 'hAt', 6);  
--SORU : Ilk harfi h,son harfi t olup 2.harfi a veya i olan 3 harfli kelimelerin tum bilgilerini yazdiran
--       QUERY yazin
SELECT * FROM kelimeler WHERE kelime ~ 'h[ai]t';
SELECT * FROM kelimeler WHERE kelime ~*'h[ai]t'; -- büyük küçük harf gözetmez ~*

--SORU : Ilk harfi h,son harfi t olup 2.harfi a ile k arasinda olan 3 harfli kelimelerin  
--tum bilgilerini  yazdiran QUERY yazin
SELECT * FROM kelimeler WHERE kelime ~* 'h[ak]t';

--SORU : a veya s ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin başlayan ^
SELECT * FROM kelimeler WHERE kelime ~* '^[as]';

--SORU : m veya f ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin  biten  $
SELECT * FROM kelimeler WHERE kelime ~* '[mf]$';

--NOT LIKE NOT ILIKE
--SORU : Baş harfi h olmayan kelimeleri getir
SELECT * FROM kelimeler WHERE kelime NOT LIKE 'h%';

-- UPPER - LOWER - INITCAP
--Tablolari yazdirirken buyuk harf, kucuk harf veya ilk harfleri buyuk digerleri
--kucuk harf yazdirmak icin kullaniriz

-- SORU : Kelimeler tablosundaki kelime sütunundaki verileri önce hepsini büyük harf, sonra küçük harf ve ilk harfleri
-- büyük olucak şekilde yazdıralım
SELECT UPPER(kelime) FROM kelimeler;
SELECT LOWER(kelime) FROM kelimeler;
SELECT INITCAP(kelime) FROM kelimeler;

SELECT UPPER(isim),LOWER(title) FROM personel;
