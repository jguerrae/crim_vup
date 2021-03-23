//BASE CON TODOS LOS DELITOS

clear all

cd "D:\1. 2020 - 2\2. Crimen\criminalidad_vup\Data\análisis_descriptivo\VIDA"

use "db.dta"

//REGRESIONES

*PLACEBO CON FE

reg cantidad S D SD_1 SD_2 SD_3 SD SD1 SD2 SD3 i.n_year i.n_month 
outreg2 using regresion_ES.doc, replace ctitle(FE YM) keep(S D SD_1 SD_2 SD_3 SD SD1 SD2 SD3)
estimates store reg1
coefplot reg1, vertical keep(SD_1 SD_2 SD_3 SD SD1 SD2 SD3) ciopts(recast(. rcap)) yline(0) graphregion(color(white)) mlabel format(%9.1f) mlabposition(11) mlabsize(small) mlabcolor(black) levels(95 99) note("Nota: los lags corresponden a 2 meses", span) title("Event Study")
graph export "ES.png", as(png) name("Graph") replace



*CENTRALES

reg cantidad S D SD i.n_year i.n_month
outreg2 using regresiones.doc, replace ctitle(FE YM) keep(S D SD) addtext(FE year, YES, FE month, YES) 

reg cantidad S D SD i.n_month
outreg2 using regresiones.doc, append ctitle(FE M) keep(S D SD) addtext(FE year, NO, FE month, YES) 

reg cantidad S D SD i.n_year
outreg2 using regresiones.doc, append ctitle(FE Y) keep(S D SD) addtext(FE year, Yes, FE month, NO) 

reg cantidad S D SD 
outreg2 using regresiones.doc, append ctitle(NO FE) keep(S D SD) addtext(FE year, NO, FE month, NO) 


*CENTRAL RESTRINGIENDO VENTANAS

reg cantidad S D SD i.n_year i.n_month if D_1==1 & D1==0
outreg2 using regresiones_tiempo.doc, replace ctitle(R 2M) keep(S D SD) addtext(FE year, YES, FE month, YES) 

reg cantidad S D SD i.n_year i.n_month if D_2==1 & D2==0
outreg2 using regresiones_tiempo.doc, append ctitle(R 4M) keep(S D SD) addtext(FE year, YES, FE month, YES)

reg cantidad S D SD i.n_year i.n_month if D_3==1 & D3==0
outreg2 using regresiones_tiempo.doc, append ctitle(R 6M) keep(S D SD) addtext(FE year, YES, FE month, YES)

reg cantidad S D SD i.n_year i.n_month if index>=488 & index<=973
outreg2 using regresiones_tiempo.doc, append ctitle(R 8M) keep(S D SD) addtext(FE year, YES, FE month, YES) 
 
reg cantidad S D SD i.n_year i.n_month if index>=365 & index<=1095
outreg2 using regresiones_tiempo.doc, append ctitle(R 12M) keep(S D SD) addtext(FE year, YES, FE month, YES)

reg cantidad S D SD i.n_year i.n_month if index>=184 & index<=1279
outreg2 using regresiones_tiempo.doc, append ctitle(R 18M) keep(S D SD) addtext(FE year, YES, FE month, YES) 

reg cantidad S D SD i.n_year i.n_month
outreg2 using regresiones_tiempo.doc, append ctitle(R 24M) keep(S D SD) addtext(FE year, YES, FE month, YES) 





