%LET myfolder = \\HOME\mackcd1\Documents\Projects\Git\project-tracking;

libname myp "&MYFOLDER.";

data myp.test_data;
  do study_id = 1 to 10000;
    mydate = '01JAN1970'd + study_id;
    myvar = log2(study_id);
    mycovar = rand('normal', study_id, myvar);
    output myp.test_data;
  end;
  format mydate yymmdd10.;
run;

ods pdf file="&MYFOLDER.\Unnecessary Output.pdf";
title "Unnecessary Output";

title2 "Means";
proc means data=myp.test_data;
  var myvar mycovar;
run;

title2 "Correlation";
proc reg data=myp.test_data;
  model myvar = mycovar;
run;

title2 "Sample Data";
proc print data=myp.test_data(obs=10);
run;

ods pdf close;