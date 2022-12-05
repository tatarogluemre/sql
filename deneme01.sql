create table personel(
tc char(11) primary key,
isim varchar(25),
soyisim varchar(25),
adres varchar(50)
);
insert into personel values('12345678909','ekrem','fas','asdfdasfd');
insert into personel values('12345679809','ece','kas','asdfdasfd');
insert into personel values('43245678909','emre','tas','asdfdasfd');

create table maas_bilgi(
maas_id char(11) unique,
	maas int ,
	prim int ,

CONSTRAINT maas_bilgi FOREIGN KEY(maas_id) REFERENCES personel(tc)
	ON DELETE CASCADE
);

insert into maas_bilgi values('12345678909',12000,1000);
insert into maas_bilgi values('12345679809',5000,480);
insert into maas_bilgi values('43245678909',7000,900);

delete from maas where maas_id = '12345679809';
select * from personel;
select * from maas_bilgi;

drop table if exists maas;

select tc,isim from personel where isim in('emre','ekrem');
select tc,isim from personel where isim not in('emre','ekrem');

select tc , isim from personel where tc in (select maas_id from maas_bilgi where maas between 4000 and 8000);

select isim from personel where tc in(select maas_id from maas_bilgi where maas <7000);

select count(maas) from maas_bilgi;
select round(avg(prim),2) from maas_bilgi;

select isim ,(select max(maas) from maas_bilgi where maas_id = tc) from personel;

update personel set adres = 'dddsgfsdg';


