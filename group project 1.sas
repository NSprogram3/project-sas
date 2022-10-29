

/* Descriptive Statistics math score , reading and writing score */


proc means data=work.import
      maxdec=2 fw=10 printalltypes
      n mean std q1 q3 QRANGE;
      var math_score;
      class test_preparation_course;
      title 'Selected Descriptive Statistics math score';
   run;
   title;
   
proc means data=work.import
      maxdec=2 fw=10 printalltypes
      n mean std q1 q3 QRANGE;
      var reading_score;
      class test_preparation_course;
      title 'Selected Descriptive Statistics reading score ';
   run;
   title;
   
proc means data=work.import
      maxdec=2 fw=10 printalltypes
      n mean std q1 q3 QRANGE;
      var writing_score;
      class test_preparation_course;
      title 'Selected Descriptive Statistics writing score ';
   run;
   title;
   
/* Interval Variable Distribution Analysis */   

ods select histogram;
proc univariate data=work.import noprint;
    var math_score;
    histogram math_score / normal kernel;
    inset n mean std / position=ne;
    title "Interval Variable Distribution Analysis";
run;
title;

ods select histogram;
proc univariate data=work.import noprint;
    var reading_score;
    histogram reading_score / normal kernel;
    inset n mean std / position=ne;
    title "Interval Variable Distribution Analysis";
run;
title;

ods select histogram;
proc univariate data=work.import noprint;
    var writing_score;
    histogram writing_score / normal kernel;
    inset n mean std / position=ne;
    title "Interval Variable Distribution Analysis";
run;
title;


/* First 10 Observations of the Imputed Data Set */

proc print data=WORK.IMPORT(obs=10);
       
       
   title 'First 10 Observations of the Imputed Data Set';
run;



/*  Frequency Analysis for genere */
ods graphics;
proc freq data=WORK.IMPORT;
    tables test_preparation_course / plots=freqplot ;
    format test_preparation_course ;
    title "Categorical Variable Frequency Analysis";
run;

/* correlation between all variables */
proc corr data = WORK.IMPORT ;
run;
/* Descriptive Statistics Using PROC UNIVARIATE */

proc univariate data=WORK.IMPORT noprint;
   var math_score  reading_score writing_score;
   histogram math_score  reading_score writing_score / normal(mu=est sigma=est noprint);
   inset min max skewness kurtosis / position=ne;
   probplot math_score  reading_score writing_score / normal(mu=est sigma=est);
   title 'Descriptive Statistics Using PROC UNIVARIATE';
run;
title;

/* box plot for math ,reading, writing */
proc sgplot data=WORK.IMPORT;
   
   vbox math_score   ;
   
   title "Box Plots of math score ";
run;

proc sgplot data=WORK.IMPORT;
   
   vbox reading_score  ;
   
   title "Box Plots of reading scor";
run;

proc sgplot data=WORK.IMPORT;
   
   vbox writing_score   ;
   
   title "Box Plots of writing score  ";
run;

/*95% Confidence Interval for math , reading, writing score*/

proc means data=WORK.IMPORT maxdec=2
              n mean stderr clm;
      var math_score;
      title '95% Confidence Interval for math score';
   run;
   title;
   
/* t test for two sample  */

ods noproctitle;
ods graphics / imagemap=on;

/* Test for normality */

proc univariate data=WORK.IMPORT normal mu0=0;
	ods select TestsForNormality;
	class test_preparation_course;
	var math_score;
run;


/* t test relation math score to test preparation course */
proc ttest data=WORK.IMPORT sides=2 h0=0 plots(showh0);
	class test_preparation_course;
	var math_score;
run;


/* t test relation reading score to test preparation course */
proc ttest data=WORK.IMPORT sides=2 h0=0 plots(showh0);
	class test_preparation_course;
	var reading_score;
run;


/* t test relation writing score to test preparation course */
proc ttest data=WORK.IMPORT sides=2 h0=0 plots(showh0);
	class test_preparation_course;
	var writing_score;
run;

