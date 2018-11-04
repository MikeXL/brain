%include '~/code/05_wine_data.sas';  ** data file **;

%let ds = wine;
%let target = class;
%let vars = alcohol  
      malic_acid  
      ash  
      alcalinity_of_ash  
      magnesium  
      total_phenols  
      flavanoids  
      nonflavanoid_phenols  
      proanthocyanins  
      color_intensity  
      hue  
      od280_od315_of_diluted_wines  
      proline;
      
**** vanilla neural net with one layer of six neurons ****;      
proc hpneural data=&ds.;
    target &target. /level=nom;
    input &vars. ;
    hidden 6;
    train;
 run;
 
 proc hpbnet data=&ds.
  missingint=impute missingnom=level 
        structure= naive tan pc mb varselect=0 1 2 3 bestmodel;

    target &target.;
    input &vars.;
    output network=net varselect=vsel fit=fit;
run;

**** variable selection *****;
proc sort data=vsel out=vsel;
    by descending _MUTUALINFORMATION_;
run;
title;
proc print data=vsel (obs=200);
run;
**** prob table ****;
proc print data=net /*noobs label */ (obs=100);
    var _parentnode_ _parentcond_ _childnode_ _childcond_ _value_;
    where _type_ = "PROBABILITY";
run;

**** structure ****;
proc print data=net /*noobs label */ (obs=100);
    var _parentnode_  _childnode_ ;
    where _type_ = "STRUCTURE";
run;   