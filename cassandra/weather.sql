-- Cassandra Weather script
create keyspace weather with replication = {'class' : 'SimpleStrategy', 'replication_factor' : 3};
use weather;
create table city (cityid int, avg_tmp float, description text, primary key (cityid));
insert into city (cityid, avg_tmp, description) values (1,25.5,'Mild weather');
insert into city (cityid, avg_tmp, description) values (2,3,'Cold weather');
create table forecast(cityid int,forecast_date timestamp,humidity float,chanceofrain float,wind float,feelslike int, centigrade int, primary key (cityid,forecast_date));
insert into forecast(cityid,forecast_date,humidity,chanceofrain,wind,feelslike,centigrade) values (1,'2013-12-10',0.76,0.1,10,8,8);
insert into forecast(cityid,forecast_date,humidity,chanceofrain,wind,feelslike,centigrade) values (1,'2013-12-11',0.90,0.3,12,4,4);
insert into forecast(cityid,forecast_date,humidity,chanceofrain,wind,feelslike,centigrade) values (1,'2013-12-12',0.68,0.2,6,3,3);
insert into forecast(cityid,forecast_date,humidity,chanceofrain,wind,feelslike,centigrade) values (1,'2013-12-10',0.76,0.1,10,8,8);
create table forecast_for_region(cityid int,regionid int, forecast_date timestamp,humidity float,chanceofrain float,wind float,feelslike int, centigrade int, primary key ((cityid,regionid),forecast_date)); 
insert into forecast_for_region(cityid,regionid,forecast_date,humidity,chanceofrain,wind,feelslike,centigrade) values (1,24, '2013-12-10',0.76,0.1,10,8,8);
insert into forecast_for_region(cityid,regionid,forecast_date,humidity,chanceofrain,wind,feelslike,centigrade) values (1,24,'2013-12-11',0.90,0.3,12,4,4);
insert into forecast_for_region(cityid,regionid,forecast_date,humidity,chanceofrain,wind,feelslike,centigrade) values (1,24,'2013-12-12',0.68,0.2,6,3,3);
create index weathertype on weather.city(description);
