%include '~/code/05_wine_data.sas';  ** data file **;

data wine;
    set wine (where=(class <3));
    class = class -1;
run;

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
    id alcohol hue color_intensity malic_acid &target.;
    score out=wine_pred_nn;
 run;
 
proc sgplot data=wine_pred_nn;
    scatter x=p_&target.1 y=p_&target.2 /colorresponse=p_&target.3;
run;
 
 ** explore model behaviour with pd plot **;
 ** partial dependence plots yhat ~ X1**;
 ** or partial residual plots residual ~ Xi **;
 proc sgplot data=wine_pred_nn;
    series y=p_&target.1 x=alcohol;
    series y=p_&target.1 x=hue;
    series y=p_&target.1 x=color_intensity;
    series y=p_&target.1 x=malic_acid;
    title "pd plot";
 run;
 proc sgplot data=wine_pred_nn;
    scatter x=alcohol y=hue /colorresponse=p_&target.1 colormodel=(blue green orange red);
 run;

** explore model performance with ROC, lift, or calibration plot **;
** calibration plot .... empirical probability vs. predicted probability **;

proc sgplot data=wine_pred_nn noautolegend aspect=1;
   loess x=p_class1 y=class / interpolation=cubic clm;   /* smoothing value by AICC (0.657) */
   lineparm x=0 y=0 slope=1 / lineattrs=(color=grey pattern=dash);
run;


 proc hpbnet data=&ds.
  missingint=impute missingnom=level 
        structure= naive tan pc mb varselect=0 1 2 3 bestmodel;

    target &target.;
    input &vars.;
    output network=net varselect=vsel fit=fit pred=wine_pred_bnet;
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

** calibration plot **;

proc sgplot data=wine_pred_bnet noautolegend aspect=1;
   loess x=p_class1 y=class / interpolation=cubic clm;   /* smoothing value by AICC (0.657) */
   lineparm x=0 y=0 slope=1 / lineattrs=(color=grey pattern=dash);
run;



