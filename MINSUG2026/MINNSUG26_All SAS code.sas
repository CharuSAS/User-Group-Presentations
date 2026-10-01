/*3.1 order of first occurrence*/
data _null_;
    x=year;
    year=2026;
    put x=;
run;

/* 3.4 SAS string operation*/
data _null_;
    x='hello';
    y=' world';
    z=catt(x,y);
    put z;
run;

/*3.4 data step comparison with Python*/
data _null_;
    retain product 1;
    do i = 2 to 10 by 2;
        product = product * i;
    end;
    put 'The product is: ' product;
run;
