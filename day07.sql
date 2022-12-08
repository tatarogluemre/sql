-- DISTINCT
-- DISTINCT clause, çağrılan terimlerden tekrarlı olanların sadece birincisini alır.
CREATE TABLE musteri_urun 
(
urun_id int, 
musteri_isim varchar(50),
urun_isim varchar(50) 
);
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (20, 'Veli', 'Elma'); 
INSERT INTO musteri_urun VALUES (30, 'Ayse', 'Armut'); 
INSERT INTO musteri_urun VALUES (20, 'Ali', 'Elma'); 
INSERT INTO musteri_urun VALUES (10, 'Adem', 'Portakal'); 
INSERT INTO musteri_urun VALUES (40, 'Veli', 'Kaysi'); 
INSERT INTO musteri_urun VALUES (20, 'Elif', 'Elma');

SELECT DISTINCT(urun_isim) FROM musteri_urun;

--Tabloda kaç farklı meyve vardır.
SELECT count(DISTINCT(urun_isim)),urun_isim FROM musteri_urun GROUP BY urun_isim;
-----------------------------------------------------------------------------
--FETCH NEXT () ROW ONLY / OFSET /LIMIT

--Müşteri ürün tablosundan ilk üç kaydı listeleyiniz
SELECT * FROM musteri_urun ORDER BY urun_id
FETCH NEXT 3 ROW ONLY

--LIMIT
SELECT * FROM musteri_urun ORDER BY urun_id
LIMIT 3

--Müşteri ürün tablosundan SON üç kaydı listeleyiniz
SELECT * FROM musteri_urun ORDER BY urun_id DESC
LIMIT 3;

CREATE TABLE maas
(
id int,
musteri_isim varchar(50),
maas int
);
INSERT INTO maas VALUES (10, 'Ali', 5000);
INSERT INTO maas VALUES (10, 'Ali', 7500);
INSERT INTO maas VALUES (20, 'Veli', 10000);
INSERT INTO maas VALUES (30, 'Ayse', 9000);
INSERT INTO maas VALUES (20, 'Ali', 6500);
INSERT INTO maas VALUES (10, 'Adem', 8000);
INSERT INTO maas VALUES (40, 'Veli', 8500);
INSERT INTO maas VALUES (20, 'Elif', 5500);

--En yuksek maaası alan musteriyi bulunuz.
SELECT * FROM maas 
ORDER BY maas DESC LIMIT 1;

--maas tablosunda en yüksek ikinci maası listeleyin
SELECT * FROM maas ORDER BY maas DESC OFFSET 1 LIMIT 1; 
-- OFFSET SATIR ATLAMAK İÇİN KULLANILIR.

-- Maas tablosunda en yüksek dördüncü maası listeleyiniz
SELECT  * FROM maas ORDER BY maas DESC OFFSET 3 LIMIT 1;
DROP TABLE IF EXISTS personel
--------------------------------------------
--DDL --> ALTER TABLE
CREATE TABLE personel  (
id int,
isim varchar(50),  sehir varchar(50),  maas int,  
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY (id)
);
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

-- 1) ADD default deger ile tabloya yenibir field(sutun)ekleme yapılır.
ALTER TABLE personel ADD ulke varchar(30);
ALTER TABLE personel ADD adres varchar(50) DEFAULT 'Turkiye'; -- DEFAULT tüm satırlara verilen değeri ekler.
SELECT * FROM personel

--2) DROP tablodan sutun silme
ALTER TABLE personel DROP COLUMN ulke, DROP COLUMN adres;

--3) RENAME tabloda sutun ismi değiştirme
ALTER TABLE personel RENAME COLUMN ulke TO country;  --ulkeyi country olarak değiştirdi.

-- 4) Tablo adını değiştirme
ALTER TABLE personel RENAME TO isciler
SELECT * FROM isciler
ALTER TABLE isciler RENAME TO personel
SELECT * FROM personel

--5) TYPE/SET(modify) sutunların özelliklerini data typlarını değiştirme
ALTER TABLE personel ALTER COLUMN country TYPE varchar(30), -- Data Type değiştirmek için TYPE 
ALTER COLUMN maas SET NOT NULL; -- CONSTRAINT değiştirmek için SET kullanılır.

--6) farklı data type dönüştürme
ALTER TABLE personel ALTER COLUMN maas TYPE varchar(30) USING(maas::varchar(30));
/*
Eğer numerik data türüne sahip bir sütunun data türüne string bir data türü atamak istersek
TYPE varchar(30) USING(maas::varchar(30)) bu formatı kullanırız
*/
ALTER TABLE personel ALTER COLUMN maas TYPE int USING(maas::int);
 drop table ogrenciler2
 ---------------------------------
/*
			TRANSACTION (BEGIN - SAVEPOINT - ROLLBACK - COMMIT
	Transaction veritabani sistemlerinde bir islem basladiginda baslar ve bitince sona erer. Bu
	islemler veritabani olusturma, veri silme, veri guncelleme, veriyi geri getirme gibi islemler olabilir.
      BEGIN - SAVEPOINT -ROLLBACK - COMMIT  
	  TRANCASCTION SIRALAMASI BEGIN ile başlar  
	  SAVEPOINT  İle tablo kayıt noktaları oluşturulur.
	  ROLLBACK ile tablodaki oluşturulan kayıt noktalarına döneriz
	  COMMIT ile süreci bitiririz.
 */

 CREATE TABLE ogrenciler2
(
id serial,  --- serial data turu otomotik olarak 1 den başlayarak sıralı olarak sayı atar
	          -- insert into ile veri eklerken serial data turunun veri değeri yerine default yazarız.
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real       
);
BEGIN;
INSERT INTO ogrenciler2 VALUES(default, 'Ali Can', 'Hasan',75.5);
INSERT INTO ogrenciler2 VALUES(default, 'Merve Gul', 'Ayse',85.3);
savepoint x;
INSERT INTO ogrenciler2 VALUES(default, 'Kemal Yasa', 'Hasan',85.6);
INSERT INTO ogrenciler2 VALUES(default, 'Nesibe Yilmaz', 'Ayse',95.3);
savepoint y;
INSERT INTO ogrenciler2 VALUES(default, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler2 VALUES(default, 'Can Bak', 'Ali', 67.5);
ROLLBACK to x;
COMMIT;
select * from ogrenciler2
delete from ogrenciler2;