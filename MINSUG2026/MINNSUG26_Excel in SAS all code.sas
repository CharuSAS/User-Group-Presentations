/*1. Metadata Discovery */
/* Point to Excel workbook */
%let path=/create-export/create/homes/Charu.Shankar@sas.com/casuser;
libname cars xlsx "&path\cars.xlsx";

proc contents data=cars.carsdeal;
run;
proc contents data=sashelp.zipcode;
run;


title 'Identifying Common columns';

proc sql;
	select name, memname, libname
		from dictionary.columns
			where (libname='CARS' and memname='CARSDEAL')
				or (libname='SASHELP' and memname ne 'CARS')
			group by name
				having count(distinct libname)=2
					order by 1,3;
quit;


/*2 Data Integration*/

proc sql;
	create table cars_enriched as
		select c.*,
			z.city,
			z.statecode,
			z.statename
		from cars.carsdeal as c
			left join sashelp.zipcode as z
				on c.zip=z.zip;
quit;


/*3 Data Analytics*/

/*3A. Geographic Analysis*/
title '# of vehicles by state after ZIP-code lookup';
proc sql;
	select StateName,
		count(*) as Vehicles
	from cars_enriched
		where not missing(StateName)
			group by StateName
				order by Vehicles desc;
quit;

/*3B. Vehicle Type Analysis*/
title "Vehicle Type Distribution and Average MSRP";
proc sql;
	select Type,
		count(*) as Vehicles,
		mean(MSRP) format=dollar12. as Avg_MSRP
	from cars_enriched
		group by Type
			order by Avg_MSRP desc;
quit;

/*3C Margin Analysis*/
title 'Profit Margin by Vehicle Type';
proc sql;
	select Type,
		mean(MSRP-Invoice) format=dollar12. as Avg_Margin,
		max(MSRP-Invoice) format=dollar12. as Max_Margin
	from cars_enriched
		group by Type
			order by Avg_Margin desc;
quit;
/*3D Luxury Segmentation*/
title 'Luxury Vehicle Segmentation';
proc sql;
   select case
             when MSRP > 50000 then 'Luxury'
             else 'Standard'
          end as Luxury_Segment,
          count(*) as Vehicles,
          mean(MSRP) format=dollar12. as Avg_MSRP,
          mean(MSRP-Invoice) format=dollar12. as Avg_Margin
   from cars_enriched
   group by Luxury_Segment
   order by Avg_MSRP desc;
quit;


/*4. Reporting & Delivery*/
title 'Excel-Based Vehicle Analytics Report';
ods excel file="c:\temp\cars_report.xlsx";

ods excel options(sheet_name="State Summary");
title '# of vehicles by state after ZIP-code lookup';
proc sql;
select StateName,
       count(*) as Vehicles
from cars_enriched
where not missing(StateName)
group by StateName
order by Vehicles desc;
quit;

ods excel options(sheet_name="Type Summary");
title "Vehicle Type Distribution and Average MSRP";
proc sql;
select Type,
       count(*) as Vehicles,
       mean(MSRP) format=dollar12. as Avg_MSRP
from cars_enriched
group by Type
order by Avg_MSRP desc;
quit;

ods excel options(sheet_name="Margin Analysis");
title 'Profit Margin by Vehicle Type';
proc sql;
select Type,
       mean(MSRP-Invoice) format=dollar12. as Avg_Margin,
       max(MSRP-Invoice) format=dollar12. as Max_Margin
from cars_enriched
group by Type
order by Avg_Margin desc;
quit;

ods excel options(sheet_name="Luxury Segmentation");
title 'Luxury Vehicle Segmentation';
proc sql;
select Make,
       Model,
       Type,
       MSRP format=dollar12.,
       case
          when MSRP > 50000 then 'Luxury'
          else 'Standard'
       end as Luxury_Segment
from cars_enriched
order by MSRP desc;
quit;

ods excel close;
