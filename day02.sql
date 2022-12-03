create table ogrenciler2(

ogrenci_no char(7),
	isim varchar(20),
	soyisim varchar(25),
	not_ort real , --ondalıklı sayılar için real(double) gibi
	kayit_tarihi date );
	
	create table notlar as select isim,not_ort from ogrenciler2;
	insert into notlar values('emre',89.9);
	insert into notlar values('erhan',88.0);
	select * from notlar;
	
	create table ogretmenler(
	ogretmen_no char(7),
	isim varchar(50),
	soyisim varchar(50),
		dogum_tarihi date
	);
	insert into ogretmenler values('1234567','emre','tatar','1987-07-23');
	insert into ogretmenler values('7654321','erhan','alkar','1980-07-23');
	create table ogretmenler(
	
		--CONSTRAINT
	create table ogretmenler2(
		ogretmen_no char(7) unique,
	isim varchar(50) not null,
	soyisim varchar(50),
		dogum_tarihi date
	);
	insert into ogretmenler2 values('1234567','emre','tatar','1987-07-23');
	insert into ogretmenler2 values('7654321','erhan','alkar','1980-07-23');
	-- insert into ogretmenler2 values('1234567','emo','babo');	hata verir çünkü ogretmen_no tekrar edilemez unique dir.
	insert into ogretmenler2 (ogretmen_no,isim) values('4567890','erkan');
	--insert into ogretmenler2 (ogretmen_no,soyisim)values('1234568','hata'); isim null olamaz hata verir
	 
		--PRIMARY KEY OLUŞTURMA
	create table personel(

    tc_no char(7) primary key,
	isim varchar(20),
	soyisim varchar(25),
	maas real , --ondalıklı sayılar için real(double) gibi
	dogum_tarihi date );	
		
	--PRIMARY KEY OLUŞTURMA 2.yol
		create table personel2(
    tc_no char(7) ,
	isim varchar(20),
	soyisim varchar(25),
	maas real , --ondalıklı sayılar için real(double) gibi
	dogum_tarihi date,
		constraint tc primary key(tc_no) -- constraint e belirli isim vermek istersek bu yolu kullanırız.		
		);	
		
		--FOREIGN KEY
	/*
“tedarikciler3” isimli bir tablo olusturun. Tabloda “tedarikci_id”, “tedarikci_ismi”,
“iletisim_isim” field’lari olsun ve “tedarikci_id” yi Primary Key yapin.
“urunler” isminde baska bir tablo olusturun “tedarikci_id” ve “urun_id” field’lari olsun ve
“tedarikci_id” yi Foreign Key yapin.
*/	
		create table tedarikciler(
		
		tedarikci_id char(5) primary key,   
		tedarikci_ismi varchar(20),
		iletisim_isim varchar(25)			
		);
		
		create table urunler(
		tedarikci_id char(5),
		urun_id char(5),
			foreign key (tedarikci_id) references tedarikciler
		);
		
/*“calisanlar” isimli bir Tablo olusturun. Icinde “id”, “isim”, “maas”, “ise_baslama” 
field’lari olsun. 
“id” yi Primary Key yapin, “isim” i Unique, “maas” i Not Null yapın.
“adresler” isminde baska bir tablo olusturun.
Icinde “adres_id”, “sokak”, “cadde” ve “sehir” fieldlari olsun.
“adres_id” field‘i ile Foreign Key oluşturun.*/
		
		create table calisanlar(
		id char(5) primary key,
		isim varchar(20) unique,
		maas real not null,
		ise_baslama date
		);
		create table adresler(
		adres_id char(5),
			sokak varchar(25),
			cadde varchar(25),
			sehir varchar(25),
			foreign key (adres_id) references calisanlar(id)
		);
INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', 'Mehmet Yılmaz', 5000, '2018-04-14');-- unique constraint olduğu için hata verdi
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); -- maas not null olduğu için hata 
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); -- isim unique constraint olduğu için hata verdi
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14');--primary key

INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

		-- Parent tabloda olmayan id ile child a ekleme yapamayiz
INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');-- hata

		-- Foreign Key'e null değeri atanabilir.
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Maraş');
		select * from calisanlar;
		select * from adresler;

		--CHECK sayısal verilere belirli değer filtrelemesi yapmak için kullanılır
	create table calisanlar1(
	id char(5) primary key,
	isim varchar(20) unique,
	maas real check (maas>10000),
	ise_baslama date
		);	
	INSERT INTO calisanlar1 VALUES('10002', 'Mehmet Yılmaz' ,9000, '2018-04-14');-- hata maas 10000 den küçük olamaz
	INSERT INTO calisanlar1 VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
		
		--DQL WHERE KULLANIMI
select * from calisanlar ;
select isim from calisanlar; -- sadece isimleri getirir.
--calisanlar tablosundan maaşı 5000 den büyük olan isimleri ve maas lari getiriniz.
		select isim,maas from calisanlar where maas>5000;
-- calisanlar tablosundan ismi Mehmet Yılmaz olan tüm verileri getiriniz
		select * from calisanlar where isim = 'Mehmet Yılmaz';
-- calisanlar tablosunda maaşı 5000 olan tüm verileri getir.
		select * from calisanlar where maas = 5000;
		
		-- DML DELETE KOMUTU
	delete from calisanlar; -- eğer parent table başka bir child table ile ilişkili ise önce child table silinmelidir.	
	delete from adresler; -- adresler tablosu içinde ki verileri siler	

-- şehri antep olan adresler tablosunda ki verileri silelim.
	delete from adresler where sehir ='Antep';	
		select * from adresler;
		
		CREATE TABLE ogrenciler3
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
INSERT INTO ogrenciler3 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler3 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler3 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler3 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler3 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler3 VALUES(127, 'Mustafa Bak', 'Ali', 99);
		--ogrenciler 3 tablosunda ismi nesibe yılmaz veya ismi mustafa bak olan verileri siliniz.
delete from ogrenciler3 where isim ='Nesibe Yilmaz' or isim ='Mustafa Bak';
		select * from ogrenciler3;
		
		