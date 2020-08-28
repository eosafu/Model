%usefile C:\Users\ezras\Documents\EG\COVID19\SpatialAfrica\data2\model.prg
delimiter = ;
logopen using C:\Users\ezras\Documents\EG\COVID19\SpatialAfrica\data2\new\m1\logb.log;
dataset d;
d.infile using C:\Users\ezras\Documents\EG\COVID19\SpatialAfrica\data2\data3.txt;
map m;
m.infile using C:\Users\ezras\Documents\EG\COVID19\SpatialAfrica\afr47_reord3.bnd;
m.reorder;
mcmcreg b;
b.outfile=C:\Users\ezras\Documents\EG\COVID19\SpatialAfrica\data2\new\m1\b1;
b.hregress covid=const+day(pspline)+country(random)+country(spatial,map=m), family=hurdle equationtype=pi iterations=12000 burnin=2000 step=10 setseed=2 using d;
b.hregress covid=const+country(random)+country(spatial,map=m)+wk1*country(spatial,map=m)+wk2*country(spatial,map=m)+wk3*country(spatial,map=m)+wk4*country(spatial,map=m)+wk5*country(spatial,map=m)+wk6*country(spatial,map=m), family=hurdle equationtype=lambda iterations=12000 burnin=2000 step=10 predict=full setseed=2 using d;

b.plotautocor,mean
b.getsample;
drop b d;
delimiter=return;

%b.hregress covid=const+wk1*country(spatial,map=m)+wk2*country(spatial,map=m)+wk3*country(spatial,map=m)+wk4*country(spatial,map=m)+wk5*country(spatial,map=m)+wk6*country(spatial,map=m), family=hurdle equationtype=lambda iterations=12000 burnin=2000 step=10 predict=full setseed=2 using d;
