* Importing my dataset into SAS;
proc import 
    datafile="/home/u64533412/DATA 3010 Final Project/fifa_world_cup_player_data.xlsx"
    out=lcm replace dbms=xlsx;
    getnames=Y;
run;

* Making my dataset permanent;
data NCM.lcm;
	set lcm;
run;


* Univariate Analysis - Quantitative;
* Descriptive Statistics Tables;
proc means data=lcm mean std max q1 median q3 min maxdec=2;
	title 'Table of Descriptive Statistics for Goals, Expected Goals, and Successful Dribbles For N = 1248';
	var goals expected_goals successful_dribbles;
run;


* Histograms;
proc sgplot data=lcm;
	title 'Figure 1: Histogram of Goals For N = 1248';
	histogram goals/scale=count binwidth=1 binstart=0;
	xaxis label='Goals';
	yaxis label='Frequency';
run;

proc sgplot data=lcm;
	title 'Figure 2: Histogram of Expected Goals For N = 1248';
	histogram expected_goals/scale=count binwidth=0.005 binstart=0;
	xaxis label='Expected Goals';
	yaxis label='Frequency';
run;

proc sgplot data=lcm;
	title 'Figure 3: Histogram of Successful Dribbles For N = 1248';
	histogram successful_dribbles/scale=count binwidth=2 binstart=0;
	xaxis label='Successful Dribbles';
	yaxis label='Frequency';
run;


* Boxplots;
proc sgplot data=lcm;
	title 'Figure 4: Boxplot of Goals For N = 1248 Players';
	vbox goals;
	yaxis label='Goals' valueshint min=-2 max=25;
run;

proc sgplot data=lcm;
	title 'Figure 5: Boxplot of Expected Goals For N = 1248 Players';
	vbox expected_goals;
	yaxis label='Expected Goals' valueshint min=-0.01 max=0.23;
run;

proc sgplot data=lcm;
	title 'Figure 6: Boxplot of Successful Dribbles For N = 1248 Players';
	vbox successful_dribbles;
	yaxis label='Successful Dribbles' valueshint min=-2 max=60;
run;



* Univariate Analysis - Categorical;
* Frequency Table;
proc freq data=lcm;
	title 'Table of Descriptive Statistics for Position and Team For N = 1248';
	tables position team;
run;


* Pie Chart;
title 'Figure 7: Pie Chart of Player Position For N = 1248';
proc template;
	define statgraph pie;
		begingraph;
			layout region;
				piechart category = position/
				datalabellocation=inside
				datalabelcontent=all
				categorydirection=clockwise
				start=180 name='pie';
				discretelegend 'pie'/
				title='Player Position';
			endlayout;
		endgraph;
	end;
run;

proc sgrender data=lcm template=pie;
run;
title;


* Bar Charts;
proc sgplot data=lcm;
	title 'Figure 8: Bar Chart of Player Position For N = 1248';
	vbar position/datalabel datalabelattrs=(size=10pt weight=bold);
	xaxis label='Player Position' ;
run;

proc sgplot data=lcm;
	title 'Figure 9: Horizontal Bar Chart of Player Team For N = 1248';
	hbar team;
	yaxis label='National Team' ;
run;


* Variable Creation - New Categorical Variable;
* Creating new variable Scoring, determines if a player is a high or low goal scorer;
data lcm;
	set lcm;
	if goals > 4 then Scoring = "High";
	else if goals <= 4 then Scoring = "Low";
run;

* Frequency Table;
proc freq data=lcm;
	title 'Table of Descriptive Statistics for Scoring For N = 1248';
	tables scoring;
run;

* Pie Chart;
title 'Figure 10: Pie Chart of Player Scoring Performance For N = 1248';
proc template;
	define statgraph pie;
		begingraph;
			layout region;
				piechart category = scoring/
				datalabellocation=inside
				datalabelcontent=all
				categorydirection=clockwise
				start=180 name='pie';
				discretelegend 'pie'/
				title='Scoring Performance';
			endlayout;
		endgraph;
	end;
run;

proc sgrender data=lcm template=pie;
run;
title;

* Bar Chart;
proc sgplot data=lcm;
	title 'Figure 11: Bar Chart of Player Scoring Performance For N = 1248';
	vbar scoring/datalabel datalabelattrs=(size=10pt weight=bold);
	xaxis label='Scoring Performance' ;
run;


* Bivariate Analysis;
* Row Percent Contingency Table for Scoring and Position;
proc sort data=lcm;
	by position;
run;

proc freq data=lcm;
	tables position*scoring/nocol;
run;

* 100% Stacked Bar Chart;
title 'Figure 12: 100% Stacked Bar Chart of Scoring Performance by Position For N = 1248';
proc sgplot data=lcm pctlevel=group;
	vbar position / group=scoring stat=pct seglabel;
run;
title;

* Scatterplot;
proc sgplot data=lcm;
	title 'Figure 13: Scatterplot of Goals by Expected Goals For N = 1248';
	reg x=expected_goals y=goals/clm cli;
	xaxis label='Expected Goals (xG)';
	yaxis label='Goals Scored';
run;

proc corr data=lcm;
	var expected_goals goals;
run;

* Stratified Table of Descriptive Statistics;
proc means data=lcm mean std max q1 median q3 min maxdec=2;
	var successful_dribbles;
	class position;
run;

* Side-by-Side Boxplot;
proc sgplot data=lcm;
	title1 'Figure 14: Side By Side Boxplots of Successful Dribbles';
	title2 'By Position For N = 1248';
	vbox successful_dribbles/category=position;
	yaxis label='Successful Dribbles' valueshint min=-2 max=60;
run;
title;

























