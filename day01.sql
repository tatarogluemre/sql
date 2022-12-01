create table ogrenciler(

ogrenci_no char(7),
	isim varchar(20),
	soyisim varchar(25),
	not_ort real , --ondalıklı sayılar için real(double) gibi
	kayit_tarihi date

);
--varolan tablodan yeni bir tablo oluşturma
create table ogrenci_ortalamalar 
as select isim,soyisim,not_ort -- varolan tablodan aynı head leri aynı şakilde data typları ile as select ile alırız
from ogrenciler --yeni table ismi ile oluştur.

--table içine veri ekleme Data Manupulation Language
insert into ogrenciler values('1234567','Emre','Tataroğlu',99.9,now());
insert into ogrenciler values('1234765','Ali','Tataroğlu',99.6,'2020-12-10');
--table içinde bazı field lara data eklemek için
insert into ogrenciler (ogrenci_no,isim,soyisim) values('3456789','Adem','Aga');
insert into ogrenciler (isim,soyisim) values('Eren','LAga');

--DQL -DATA QUERY LANGUAGE
--SELECT
select * from ogrenciler;