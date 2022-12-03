CREATE TABLE ogrenciler10
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
iNSERT INTO ogrenciler10 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler10 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler10 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler10 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler10 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler10 VALUES(127, 'Mustafa Bak', 'Ali', 99);
select * from ogrenciler10;
-- ismi Nesibe Yilmaz veya Mustafa Bak olan kayıtları silelim.
delete from ogrenciler10 where isim = 'Nesibe Yilmaz' or isim = 'Mustafa Bak';
delete from ogrenciler10 where veli_isim = 'Hasan';
--DML -- truncate kullanmi
--Truncate hepsini siler ama spesifik silmez.(sartli silme yapmaz)
truncate ogrenciler10;-- ikiside olur
truncate table ogrenciler10;
select * from ogrenciler10;
-- ON delete CASCADE
drop table if exists talebeler;-- varsa talebeler tablosunu siler
drop table if exists notlar

CREATE TABLE talebeler
(
id CHAR(3) primary key,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
CREATE TABLE notlar(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id)
on delete cascade
);
INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan', 75);
INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse', 85);
INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan', 85);
INSERT INTO talebeler VALUES(126, 'Nesibe Yılmaz', 'Ayse', 95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can', 99);
INSERT INTO notlar VALUES ('123','kimya', 75);
INSERT INTO notlar VALUES ('124', 'fizik', 65);
INSERT INTO notlar VALUES ('125', 'tarih', 90);
INSERT INTO notlar VALUES ('126', 'Matematik', 90);
select * from talebeler;
select * from notlar;
-- notlar tablosundan talebe_id'si 123 olan datayi silelim.
delete from notlar where talebe_id='123';-- childdan siler ama parentten silmez
--talebeler tablosunda id si 126 olani silelim
delete from talebeler where id=126;-- parentdan silersek childaki veride silinir
-- on delete cascade kullanirsak..
--1. tablolardan veri silmek icin.. normalde oncelikle  childdaki datayi silmemiz gerekir.
--2. child da on delete cascade kullanirsak... parent'dan datayi silebiliriz.
--3. bu durumda data hem parenttan hemde childdan silinir.
--IN CONDİTİON
drop table if exists musteriler  --- varsa musteriler tablosunu siler.
CREATE TABLE musteriler (
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (20, 'John', 'Apple');
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm');
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple');
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange');
INSERT INTO musteriler VALUES (40, 'John', 'Apricot');
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');
select * from musteriler;
--musteriler tablosundan urun ismi Orange APple Apricot olan datalari listeleyiniz.
select * from musteriler where  urun_isim ='Orange' or urun_isim ='Apple' or urun_isim ='Apricot'
select * from musteriler where  urun_isim in ('Orange', 'Apple', 'Apricot');
-- ikiside ayni ise yapar

--NOT IN---> disindakileri
-- orange apple ve apricot disindakileri getir.
select * from musteriler where  urun_isim not in ('Orange', 'Apple', 'Apricot');

--BETWEEN CONDITION
--between 20 and 40 dersek 20 ve 40 dhil
select * from musteriler where urun_id>=20 and  urun_id <=40 ;
select * from musteriler where urun_id between 20 and 40;
-- ikiside ayni isi yapar.
--NOT BETWEEN
select * from musteriler where urun_id<20  or  urun_id >40 ;
select * from musteriler where urun_id not  between 20 and 40;
-- ikiside ayni isi yapar.

--SUBQUERIES-- baska bir sordugunun icinde calisan sorgu
CREATE TABLE calisanlar2
(
id int,
isim VARCHAR(50),
sehir VARCHAR(50),
maas int,
isyeri VARCHAR(20)
);
INSERT INTO calisanlar2 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar2 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar2 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar2 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar2 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');
INSERT INTO calisanlar2 VALUES(123456710, 'Fatma Yasa', 'Bursa', null, 'Vakko');
CREATE TABLE markalar
(
marka_id int,
marka_isim VARCHAR(20),
calisan_sayisi int
);
INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);
INSERT INTO markalar VALUES(104, 'Nike', 19000);
select * from calisanlar2;
select * from markalar;

-- Çalisan sayisi 15.000’den cok olan markalarin isimlerini
--ve bu markada calisanlarin isimlerini ve maaşlarini listeleyin.
select isim ,maas, isyeri from calisanlar2
where isyeri in (select marka_isim from markalar where calisan_sayisi>15000);

--marka_idsi 101 den büyük olan marka çalışanlarının 
--isim mmaş ve şehirlerini listeleyiniz.

select isim,maas,sehir from calisanlar2
where isyeri in(select marka_isim from markalar where marka_id>101);

-- AGGREGATE METHOD 
SELECT max(maas) FROM calisanlar2; --tablodaki max massı verir
SELECT max(maas) AS maksimum_maas FROM calisanlar2; -- eğer bir sütuna geçici isim vermek istersek AS komutunu yazdıktan sonra vermek istediğimiz ismi yazarız.

--calisanlar tablosundan min maası al
SELECT min(maas) FROM calisanlar2;

--calisanlar tablosundaki maaşların toplamını listeleyiniz
SELECT sum(maas) FROM calisanlar2;

--calisanlar tablosundaki maasların ortalaması listeleyiniz
SELECT avg(maas)FROM calisanlar2;
SELECT round(avg(maas),2)FROM calisanlar2;--virgülden sonra yuvarlama yapıp 2 sayı alır

-calisanlar tablosundaki maasların sayısını listeleyiniz
SELECT count(maas) FROM calisanlar2; -- null değerleri saymaz 7 satır
SELECT count(*) FROM calisanlar2; -- 8 eğer count(*) koyarsak tüm satırları listeler

--AGGREGATE METHODLARDA SUBQUERY
-- Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz
SELECT marka_id , marka_isim ,(SELECT count(sehir) FROM calisanlar2 WHERE isyeri = marka_isim) FROM markalar;

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maaşini listeleyiniz
SELECT marka_isim , calisan_sayisi ,(select sum(maas) from calisanlar2 where isyeri= marka_isim) as toplam_maas from markalar;

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin max ve min maaşini listeleyiniz
select marka_isim, calisan_sayisi ,
(select min(maas) from calisanlar2 where isyeri = marka_isim)as enaz_maas,
(select max(maas) from calisanlar2 where isyeri = marka_isim) from markalar;

--VIEW KULLANIMI
-- view sorgularda kalıp oluşturmak için kullanılır. 
--istenildiği zaman olusturulan view ismi ile select komutu ile sorgu çağırılır. ör: select * from maxminmaas şeklinde
--tekrar sorgu oluşturmaktan kurtarır method gibi düşünebiliriz.

CREATE VIEW maxminmaas AS
select marka_isim, calisan_sayisi ,
(select min(maas) from calisanlar2 where isyeri = marka_isim)as enaz_maas,
(select max(maas) from calisanlar2 where isyeri = marka_isim) from markalar;

select * from maxminmaas;
select marka_isim from maxminmaas;

CREATE VIEW toplam_maas AS
SELECT marka_isim , calisan_sayisi ,
(select sum(maas) from calisanlar2 where isyeri= marka_isim) as toplam_maas from markalar;

select * from toplam_maas;

--EXISTS CONDITION
/*
EXISTS Condition subquery’ler ile kullanilir. IN ifadesinin kullanımına benzer
olarak, EXISTS ve NOT EXISTS ifadeleri de alt sorgudan getirilen değerlerin içerisinde
bir değerin olması veya olmaması durumunda işlem yapılmasını sağlar
*/
CREATE TABLE mart
(   
urun_id int,    
musteri_isim varchar(50), urun_isim varchar(50)
);
INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE nisan 
(   
urun_id int ,
musteri_isim varchar(50), urun_isim varchar(50)
);
INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

select * from mart;
select * from nisan;


	--MART VE NİSAN aylarında aynı urun_id ile satılan ürünlerin
	--urun_id’lerini listeleyen ve aynı zamanda bu ürünleri MART ayında alan
	--musteri_isim 'lerini listeleyen bir sorgu yazınız.

select urun_id,musteri_isim from mart 
where exists (select urun_id from nisan where mart.urun_id = nisan.urun_id);

--Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.

select urun_isim, musteri_isim from nisan 
where exists( select urun_isim from mart where mart.urun_isim = nisan.urun_isim);

--UPDATE SET
CREATE TABLE tedarikciler -- parent
(
vergi_no int PRIMARY KEY,
firma_ismi VARCHAR(50),
irtibat_ismi VARCHAR(50)
);
INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
INSERT INTO tedarikciler VALUES (102, 'Huawei', 'Çin Li');
INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammen');
INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');

CREATE TABLE urunler -- child
(
ted_vergino int, 
urun_id int, 
urun_isim VARCHAR(50), 
musteri_isim VARCHAR(50),
CONSTRAINT fk_urunler FOREIGN KEY(ted_vergino) REFERENCES tedarikciler(vergi_no)
on delete cascade
);    
INSERT INTO urunler VALUES(101, 1001,'Laptop', 'Ayşe Can');
INSERT INTO urunler VALUES(102, 1002,'Phone', 'Fatma Aka');
INSERT INTO urunler VALUES(102, 1003,'TV', 'Ramazan Öz');
INSERT INTO urunler VALUES(102, 1004,'Laptop', 'Veli Han');
INSERT INTO urunler VALUES(103, 1005,'Phone', 'Canan Ak');
INSERT INTO urunler VALUES(104, 1006,'TV', 'Ali Bak');
INSERT INTO urunler VALUES(104, 1007,'Phone', 'Aslan Yılmaz');
-- vergi_no’su 102 olan tedarikcinin firma ismini 'Vestel' olarak güncelleyeniz.
UPDATE tedarikciler SET firma_ismi='Vestel' WHERE vergi_no=102;
select firma_ismi from tedarikciler;
-- vergi_no’su 101 olan tedarikçinin firma ismini 'casper' ve irtibat_ismi’ni 'Ali Veli' olarak güncelleyiniz.
UPDATE tedarikciler SET firma_ismi='Casper' , irtibat_ismi='Ali Veli' WHERE vergi_no = 101;
select * from tedarikciler;
--  urunler tablosundaki 'Phone' değerlerini 'Telefon' olarak güncelleyiniz.
UPDATE urunler
SET urun_isim = 'Telefon' WHERE urun_isim='Phone';
--urunler tablosundaki urun_id si 1004 den büyük olan ürünlerin Urun_id sini 1 artırın
update urunler set urun_id = urun_id+1 where urun_id>1004;
select*from urunler;

-- urunler tablosundaki tüm ürünlerin urun_id değerini ted_vergino sutun değerleri ile toplayarak güncelleyiniz.
UPDATE urunler SET urun_id= urun_id + ted_vergino;

-- urunler tablosundan Ali Bak’in aldigi urunun ismini, tedarikci tablosunda irtibat_ismi
-- 'Adam Eve' olan firmanın ismi (firma_ismi) ile degistiriniz.

UPDATE urunler 
SET urun_isim = (select firma_ismi from tedarikciler where irtibat_ismi='Adam Eve')
where musteri_isim='Ali Bak';

UPDATE urunler 
SET musteri_isim=(select irtibat_ismi from tedarikciler where firma_ismi='Apple') 
WHERE urun_isim='Laptop';

