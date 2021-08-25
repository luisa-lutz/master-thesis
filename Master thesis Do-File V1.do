
***********************MASTER THESIS**********************************
******************CANDIDATE NUMBER: 14838*************************** 
***********DEPARTEMENT OF GEOGRAPHY AND ENVIRONMENT*******************
*******LONDON SCHOOL OF ECONOMICS AND POLITICAL SCIENCE***************

*************************SUPERVISOR:********************************** 
***********************VIKTOR ROEZER, PHD***************************** 

clear all

insheet using "/Users/luisalutz/Documents/LSE /Masterarbeit/Master thesis_August 5, 2021_08.23.csv", comma names

*insheet using "C:\Users\Luisa\OneDrive\Dokumente\Dokumente\Bachelorarbeit\112361-V1\20071036_Data.csv", comma 

br

*Formating data set

drop recipientlastname recipientfirstname recipientemail externalreference userlanguage distributionchannel startdate enddate 
drop ipaddress durationinseconds status progress recordeddate locationlatitude locationlongitude q56
drop in 1/2
destring, replace 

*Delete uncompleted responses 

drop if finished==0

*Label variables

label var q14 "Age"
label var q15 "Gender"
label var q16 "Education"
label var q17 "Employment"
label var q18 "Income"
label var q19 "Housing Type"
label var q20 "Housing Size"
label var q21 "House Ownership"
label var q22 "Household Size"
label var q59 "Risk preference"
label var q58 "Information preference"
label var q62 "Climate change beliefs"
label var q3 "Disaster frequency"
label var q5 "Severity of disasters"
label var q7 "Evolution of disasters"
label var q8 "Insurance experience"

*Renaming variables

rename q59 risk_preference
rename q58 information_preference
rename qid1 residency_departamento
rename q31 provincia_arequipa
rename q35 provincia_callao
rename q34 provincia_lima
rename q32 distritos_arequipa 
rename q36 distritos_camana
rename q37 distritos_caraveli
rename q38 distritos_castilla
rename q39 distritos_caylloma
rename q40 distritos_condesuyos
rename q41 distritos_islay
rename q42 distritos_launion
rename q43 distritos_callao
rename q44 distritos_lima
rename q45 distritos_barranca
rename q46 distritos_cajatambo 
rename q47 distritos_canta
rename q48 distritos_canete
rename q49 distritos_huaral
rename q50 distritos_huarochiri
rename q51 distritos_huaura 
rename q52 distritos_oyon
rename q53 distritos_yauyos
rename q8 insurance_experience
rename q9 negative_experience
rename q65 wti_baseline
rename q78 wtp_baseline
rename q67 motives_baseline
rename q10 wti_information
rename q79 wtp_information 
rename q12 motives_information 
rename q28 wti_climatechange 
rename q77 wtp_climatechange 
rename q30 motives_climatechange
rename q2 local_disasters
rename q3 frequency_disasters
rename q5 severity_disasters
rename q7 evolution_disasters
rename q62 climatechange 
rename q14 age
rename q15 sex
rename q16 education 
rename q17 employment 
rename q18 income 
rename q19 housing_type
rename q20 size_house
rename q21 house_ownership 
rename q22 household_size


*Recode values for willingness to insure 

replace wti_baseline = 0 if wti_baseline==2
replace wti_information = 0 if wti_information==2
replace wti_climatechange = 0 if wti_climatechange==2

*Recode climate change attitude 

replace climatechange = 3 if climatechange==1
replace climatechange = 1 if climatechange==2
replace climatechange = 2 if climatechange==3

*Recode negative experience in order to obtain a specific dummy for each reason why participants had not previously purchased insurance 

split negative_experience, parse(,) destring gen(reasons_negative_experience)

gen lack_knowledge_ne = .
replace lack_knowledge_ne = 1 if reasons_negative_experience1==1 | reasons_negative_experience2==1 | reasons_negative_experience3==1
replace lack_knowledge_ne = 0 if lack_knowledge_ne == . 

gen lack_trust_ne = .
replace lack_trust_ne = 1 if reasons_negative_experience1==2 | reasons_negative_experience2==2 | reasons_negative_experience3==2
replace lack_trust_ne = 0 if lack_trust_ne == . 

gen financial_resources_ne = . 
replace financial_resources_ne = 1 if reasons_negative_experience1==3 | reasons_negative_experience2==3 | reasons_negative_experience3==3
replace financial_resources_ne = 0 if financial_resources_ne == . 

gen no_disasters_ne = . 
replace no_disasters_ne = 1 if reasons_negative_experience1==4 | reasons_negative_experience2==4 | reasons_negative_experience3==4
replace no_disasters_ne = 0 if no_disasters_ne == .

gen government_insurance_ne = . 
replace government_insurance_ne = 1 if reasons_negative_experience1==5 | reasons_negative_experience2==5 | reasons_negative_experience3==5
replace government_insurance_ne = 0 if government_insurance_ne == .

gen other_reasons_ne = . 
replace other_reasons_ne = 1 if reasons_negative_experience1==6 | reasons_negative_experience2==6 | reasons_negative_experience3==6
replace other_reasons_ne = 0 if other_reasons_ne == .

drop reasons_negative_experience1 reasons_negative_experience2 reasons_negative_experience3

*Label new variables 

label var lack_knowledge_ne "No prior purchase due to lack of knowledge"
label var lack_trust_ne "No prior purchase due to lack of trust"
label var financial_resources_ne "No prior purchase due to lack of trust"
label var no_disasters_ne "No prior purchase due to belief in low disaster probability"
label var government_insurance_ne "No prior purchase due to government relief"
label var other_reasons_ne "No prior purchase due to other reasons"


*Recode baseline motives in order to obtain a specific dummy for each reason why participants in the baseline treatment were not willing to purchase insurance 

split motives_baseline, parse(,) destring gen(reasons_baseline)

gen lack_knowledge_bl = .
replace lack_knowledge_bl = 1 if reasons_baseline1==1 | reasons_baseline2==1 | reasons_baseline3==1
replace lack_knowledge_bl = 0 if lack_knowledge_bl == . 

gen lack_trust_bl = .
replace lack_trust_bl = 1 if reasons_baseline1==2 | reasons_baseline2==2 | reasons_baseline3==2
replace lack_trust_bl = 0 if lack_trust_bl == . 

gen no_payment_bl = . 
replace no_payment_bl = 1 if reasons_baseline1==3 | reasons_baseline2==3 | reasons_baseline3==3
replace no_payment_bl = 0 if no_payment_bl == .

gen financial_resources_bl = . 
replace financial_resources_bl = 1 if reasons_baseline1==4 | reasons_baseline2==4 | reasons_baseline3==4
replace financial_resources_bl = 0 if financial_resources_bl == . 

gen no_disasters_bl = . 
replace no_disasters_bl = 1 if reasons_baseline1==5 | reasons_baseline2==5 | reasons_baseline3==5
replace no_disasters_bl = 0 if no_disasters_bl == .

gen other_reasons_bl = . 
replace other_reasons_bl = 1 if reasons_baseline1==6 | reasons_baseline2==6 | reasons_baseline3==6
replace other_reasons_bl = 0 if other_reasons_bl == .

drop reasons_baseline1 reasons_baseline2 reasons_baseline3

*Label new variables 

label var lack_knowledge_bl "No purchase after BL due to lack of knowledge"
label var lack_trust_bl "No purchase after BL due to lack of trust"
label var no_payment_bl "No purchase after BL due to fear of no payment"
label var financial_resources_bl "No purchase after BL due to lack of financial resources"
label var no_disasters_bl "No purchase after BL due to belief in low disaster probability"
label var other_reasons_bl "No purchase after BL due to other reasons"

*Recode information motives in order to obtain a specific dummy for each reason why participants in the information treatment were not willing to purchase insurance 

split motives_information, parse(,) destring gen(reasons_information)

gen lack_knowledge_info = .
replace lack_knowledge_info = 1 if reasons_information1==1 | reasons_information2==1 
replace lack_knowledge_info = 0 if lack_knowledge_info == . 

gen lack_trust_info = .
replace lack_trust_info = 1 if reasons_information1==2 | reasons_information2==2 
replace lack_trust_info = 0 if lack_trust_info == . 

gen no_payment_info = . 
replace no_payment_info = 1 if reasons_information1==3 | reasons_information2==3 
replace no_payment_info = 0 if no_payment_info == .

gen financial_resources_info = . 
replace financial_resources_info = 1 if reasons_information1==4 | reasons_information2==4 
replace financial_resources_info = 0 if financial_resources_info == . 

gen no_disasters_info = . 
replace no_disasters_info = 1 if reasons_information1==5 | reasons_information2==5 
replace no_disasters_info = 0 if no_disasters_info == .

gen other_reasons_info = . 
replace other_reasons_info = 1 if reasons_information1==6 | reasons_information2==6 
replace other_reasons_info = 0 if other_reasons_info == .

drop reasons_information1 reasons_information2 

*Label new variables 

label var lack_knowledge_info "No purchase after IT due to lack of knowledge"
label var lack_trust_info "No purchase after IT due to lack of trust"
label var no_payment_info "No purchase after IT due to fear of no payment"
label var financial_resources_info "No purchase after IT due to lack of financial resources"
label var no_disasters_info "No purchase after IT due to belief in low disaster probability"
label var other_reasons_info "No purchase after IT due to other reasons"


*Recode climate change motives in order to obtain a separate dummy for each reason why participants in the climate change treatment were not willing to purchase insurance

gen lack_knowledge_cc = .
replace lack_knowledge_cc = 1 if motives_climatechange==1 
replace lack_knowledge_cc = 0 if lack_knowledge_cc == . 

gen lack_trust_cc = .
replace lack_trust_cc = 1 if motives_climatechange==2 
replace lack_trust_cc = 0 if lack_trust_cc == . 

gen no_payment_cc = . 
replace no_payment_cc = 1 if motives_climatechange==3 
replace no_payment_cc = 0 if no_payment_cc == .

gen financial_resources_cc = . 
replace financial_resources_cc = 1 if motives_climatechange==4 
replace financial_resources_cc = 0 if financial_resources_cc == . 

gen no_disasters_cc = . 
replace no_disasters_cc = 1 if motives_climatechange==5 
replace no_disasters_cc = 0 if no_disasters_cc == .

gen other_reasons_cc = . 
replace other_reasons_cc = 1 if motives_climatechange==6 
replace other_reasons_cc = 0 if other_reasons_cc == .

*Label new variables 

label var lack_knowledge_cc "No purchase after CCT due to lack of knowledge"
label var lack_trust_cc "No purchase after CCT due to lack of trust"
label var no_payment_cc "No purchase after CCT due to fear of no payment"
label var financial_resources_cc "No purchase after CCT due to lack of financial resources"
label var no_disasters_cc "No purchase after CCT due to belief in low disaster probability"
label var other_reasons_cc "No purchase after CCT due to other reasons"


*Recode local disasters in order to obtain a separate dummy for each natural disaster which participants were experiencing in their region  

split local_disasters, parse(,) destring gen(split_local_disasters)

gen river_flood = .
replace river_flood = 1 if split_local_disasters1==1 | split_local_disasters2==1 | split_local_disasters3==1
replace river_flood = 0 if river_flood == . 

gen urban_flood = .
replace urban_flood = 1 if split_local_disasters1==2 | split_local_disasters2==2 | split_local_disasters3==2
replace urban_flood = 0 if urban_flood == . 

gen costal_flood = . 
replace costal_flood = 1 if split_local_disasters1==3 | split_local_disasters2==3 | split_local_disasters3==3
replace costal_flood = 0 if costal_flood == . 

gen earthquake = . 
replace earthquake = 1 if split_local_disasters1==4 | split_local_disasters2==4 | split_local_disasters3==4
replace earthquake = 0 if earthquake == .

gen landslide = . 
replace landslide = 1 if split_local_disasters1==5 | split_local_disasters2==5 | split_local_disasters3==5
replace landslide = 0 if landslide == .

gen tsunami = . 
replace tsunami = 1 if split_local_disasters1==6 | split_local_disasters2==6 | split_local_disasters3==6
replace tsunami = 0 if tsunami == .

gen volcanic_erruption = . 
replace volcanic_erruption = 1 if split_local_disasters1==7 | split_local_disasters2==7 | split_local_disasters3==7
replace volcanic_erruption = 0 if volcanic_erruption == .

gen water_scarcity = . 
replace water_scarcity = 1 if split_local_disasters1==8 | split_local_disasters2==8 | split_local_disasters3==8
replace water_scarcity = 0 if water_scarcity == .

gen extreme_heat = . 
replace extreme_heat = 1 if split_local_disasters1==9 | split_local_disasters2==9 | split_local_disasters3==9
replace extreme_heat = 0 if extreme_heat == .

gen wildfire = . 
replace wildfire = 1 if split_local_disasters1==10 | split_local_disasters2==6 | split_local_disasters3==6
replace wildfire = 0 if wildfire == .

drop  split_local_disasters1  split_local_disasters2  split_local_disasters3 split_local_disasters4 split_local_disasters5 split_local_disasters6 split_local_disasters7

*Label new variables 

label var river_flood "River flood"
label var urban_flood "Urban flood"
label var costal_flood "Costal flood"
label var earthquake "Earthquake"
label var landslide "Landslide"
label var tsunami "Tsunami"
label var volcanic_erruption "Volcanic erruption"
label var water_scarcity "Water scarcity"
label var extreme_heat "Extreme heat"
label var wildfire "Wildfire"

*Generate grouped disaster variable for disasters which participants do to experience very frequently 

gen other_disasters = . 
replace other_disasters = 1 if volcanic_erruption==1 | wildfire==1 | extreme_heat==1

*Group controls for the regressions 

global demographics age ib4.sex ib1.education i.employment income i.residency_departamento 
global housing i.housing_type i.size_house i.house_ownership household_size 
global attitudes risk_preference information_preference ib1.climatechange
global motives i.lack_knowledge_info i.lack_trust_info i.no_payment_info i.financial_resources_info i.no_disasters_info i.other_reasons_info i.lack_knowledge_cc i.lack_trust_cc i.no_payment_cc i.financial_resources_cc i.no_disasters_cc i.other_reasons_cc 
global disaster_experience river_flood urban_flood costal_flood earthquake landslide tsunami volcanic_erruption water_scarcity extreme_heat wildfire frequency_disasters severity_disasters ib4.evolution_disasters
global insurance i.insurance_experience lack_knowledge_ne lack_trust_ne financial_resources_ne no_disasters_ne government_insurance_ne other_reasons_ne

*Generate treatment variables 

generate treatment_information = . 
replace treatment_information = 1 if wti_information==0 | wti_information==1
replace treatment_information = 0 if wti_information== . 

generate treatment_climatechange = . 
replace treatment_climatechange = 1 if wti_climatechange==0 | wti_climatechange==1
replace treatment_climatechange = 0 if wti_climatechange== .

*Generate overall willingness to insure and overall willingess to pay 

generate wti = . 
replace wti = 1 if wti_information==1 | wti_climatechange==1 | wti_baseline==1
replace wti = 0 if wti == .

generate wtp = wtp_baseline
replace wtp = wtp_information if wtp== . 
replace wtp = wtp_climatechange if wtp== .
replace wtp = 0 if wtp== .  


*************************************
****PART 1: DESCRIPTIVE STATISTICS***
*************************************

******SOCIODEMOGRAPHIC VARIABLES******

*Percentage of females 

tab sex 

*Age distribution 

tab age

*Education

tab education 

*Employment 

tab employment 

*Income 

tab income 

*******HOUSING CHARACTERISTICS*********

*Size of house

tab size_house

*Housing type 

tab housing_type 

*House ownership 

tab house_ownership 

*Number of people residing in the household 

tab household_size

********WILLINGESS TO INSURE/PAY**********

*Check distribution of willingness to insure 

tab wti_baseline
tab wti_information
tab wti_climatechange

*Check distribution of willingness to pay 

summarize wtp_baseline, detail 
histogram wtp_baseline, normal

summarize wtp_information, detail 
histogram wtp_information, normal

summarize wtp_climatechange, detail 
histogram wtp_climatechange, normal




*************************************
****PART 2: WILLINGNESS TO INSURE****
*************************************

*I run a linear regression to estimate the effect of the information treatment and the climate change treatment on the willingness to insure. Three different models are specified, each including a different set of controls. 

reg wti treatment_information treatment_climatechange i.age i.sex ib3.education i.employment i.income i.residency_departamento $housing, robust
outreg2 using tab_wti_ols.tex, replace ctitle(Model A) dec(2) label 

reg wti treatment_information treatment_climatechange i.age i.sex ib3.education i.employment i.income i.residency_departamento $housing $attitudes $motives, robust 
outreg2 using tab_wti_ols.tex, append ctitle(Model B) dec(2) label 

reg wti treatment_information treatment_climatechange i.age i.sex ib3.education i.employment i.income i.residency_departamento $housing $attitudes $motives river_flood urban_flood costal_flood earthquake landslide tsunami volcanic_erruption water_scarcity extreme_heat wildfire frequency_disasters severity_disasters ib4.evolution_disasters i.insurance_experience lack_knowledge_ne lack_trust_ne financial_resources_ne no_disasters_ne government_insurance_ne other_reasons_ne, robust 
outreg2 using tab_wti_ols.tex, append ctitle(Model C) dec(2) label 



*************************************
****PART 3: WILLINGNESS TO PAY*******
*************************************

*I run a tobit regression to estimate the effect of the information treatment and the climate change treatment on the willingness to pay for disaster risk insurance. Three different models are specified, each including a different set of controls. 
 
tobit wtp treatment_information treatment_climatechange i.age i.sex ib3.education i.employment i.income i.residency_departamento $housing, ll(0) ul(150) 
margins, dydx(treatment_information treatment_climatechange education employment housing_type house_ownership) 
outreg2 using tab_wtp.tex, replace ctitle(Model A) dec(2) label 
 
tobit wtp treatment_information treatment_climatechange i.age i.sex ib3.education i.employment i.income i.residency_departamento $housing $attitudes $motives, ll(0) ul(150)
margins, dydx(treatment_information treatment_climatechange education employment housing_type risk_preference house_ownership) 
outreg2 using tab_wtp.tex, append ctitle(Model B) dec(2) label 

tobit wtp treatment_information treatment_climatechange i.age i.sex ib3.education i.employment i.income i.residency_departamento $housing $attitudes $motives river_flood urban_flood costal_flood earthquake landslide tsunami volcanic_erruption water_scarcity extreme_heat wildfire frequency_disasters severity_disasters ib4.evolution_disasters i.insurance_experience lack_trust_ne financial_resources_ne no_disasters_ne government_insurance_ne other_reasons_ne, ll(0) ul(150)
margins, dydx(treatment_information treatment_climatechange education employment housing_type house_ownership frequency_disasters risk_preference evolution_disaster) 
outreg2 using tab_wtp.tex, append ctitle(Model C) dec(2) label 


  
 
*************************
*********Appendix********
*************************

******Robustness checks*******

**********OTHER MODELS FOR THE EFFECT ON WILLINGNESS TO INSURE/PAY********* 

*Probit regression for willingness to insure (due to the fact that the willingness to insure is coded as a binary measure). Note that the sets of controls included differ from the controls included in the linear model, as many of the binary explanatory variables perfectly predict the outcome.   

probit wti treatment_information treatment_climatechange i.age ib4.sex ib1.education i.employment income i.residency_departamento $housing 
margins, dydx(treatment_information treatment_climatechange) 
outreg2 using tab_wti.tex, replace ctitle(Model A) dec(2) label 

probit wti treatment_information treatment_climatechange i.age ib4.sex ib1.education i.employment income i.residency_departamento $housing $attitudes i.no_payment_info i.financial_resources_info i.no_disasters_info i.other_reasons_info i.no_payment_cc i.financial_resources_cc i.no_disasters_cc i.other_reasons_cc 
margins, dydx(treatment_information treatment_climatechange) 
outreg2 using tab_wti.tex, append ctitle(Model B) dec(2) label 

probit wti treatment_information treatment_climatechange age ib4.sex education i.employment income i.residency_departamento $housing $attitudes river_flood urban_flood costal_flood earthquake landslide tsunami volcanic_erruption water_scarcity extreme_heat wildfire frequency_disasters severity_disasters ib4.evolution_disasters i.insurance_experience lack_trust_ne financial_resources_ne no_disasters_ne government_insurance_ne other_reasons_ne 
margins, dydx(treatment_information treatment_climatechange) 
outreg2 using tab_wti.tex, append ctitle(Model C) dec(2) label

*Linear regression for willingness to pay 

reg wtp treatment_information treatment_climatechange i.age ib4.sex ib1.education i.employment i.income i.residency_departamento $housing, robust
outreg2 using tab_wti_ols.tex, replace ctitle(Model A) dec(2) label 

reg wtp treatment_information treatment_climatechange i.age ib4.sex ib1.education i.employment i.income i.residency_departamento $housing $attitudes $motives, robust 
outreg2 using tab_wti_ols.tex, append ctitle(Model B) dec(2) label 

reg wtp treatment_information treatment_climatechange i.age ib4.sex ib1.education i.employment i.income i.residency_departamento $housing $attitudes $motives river_flood urban_flood costal_flood earthquake landslide tsunami volcanic_erruption water_scarcity extreme_heat wildfire frequency_disasters severity_disasters ib4.evolution_disasters i.insurance_experience lack_knowledge_ne lack_trust_ne financial_resources_ne no_disasters_ne government_insurance_ne other_reasons_ne, robust
outreg2 using tab_wti_ols.tex, append ctitle(Model C) dec(2) label 


***********ROBUSTNESS TEST ON PROTEST RESPONSES***********

*Identify protest responses (protest responses are defined as expressions of lack of trust in insurance schemes by participants which are not willing to purachse an insurance at all) 

gen protest_response = .
replace protest_response = 1 if lack_trust_cc==1 | lack_trust_bl==1 | lack_trust_info==1
replace protest_response = 0 if protest_response == . 

*To check whether protest responses are of any concern in the analysis, I run the models included in the paper with the variable 'protest responses' as an explanatory variable. If the variable is not a significant predictor of the willingness to pay or the willingess to insure, then protest responses are not of any concern in the analysis. 

*Linear regression model to estimate the effect of the two treatments on the the willingess to insure 

reg wti treatment_information treatment_climatechange protest_response i.age ib4.sex ib1.education i.employment i.income i.residency_departamento $housing, robust
outreg2 using tab_wti_ols.tex, replace ctitle(Model A) dec(2) label 

reg wti treatment_information treatment_climatechange protest_response i.age ib4.sex ib1.education i.employment i.income i.residency_departamento $housing $attitudes $motives, robust 
outreg2 using tab_wti_ols.tex, append ctitle(Model B) dec(2) label 

reg wti treatment_information treatment_climatechange protest_response i.age ib4.sex ib1.education i.employment i.income i.residency_departamento $housing $attitudes $motives river_flood urban_flood costal_flood earthquake landslide tsunami volcanic_erruption water_scarcity extreme_heat wildfire frequency_disasters severity_disasters ib4.evolution_disasters i.insurance_experience lack_knowledge_ne lack_trust_ne financial_resources_ne no_disasters_ne government_insurance_ne other_reasons_ne, robust 
outreg2 using tab_wti_ols.tex, append ctitle(Model C) dec(2) label

*Probit model to estimate the effect of the two treatments on the willingess to insure 

probit wti treatment_information treatment_climatechange protest_response i.age ib4.sex ib1.education i.employment income i.residency_departamento $housing 
margins, dydx(treatment_information treatment_climatechange) 
outreg2 using tab_wti.tex, replace ctitle(Model A) dec(2) label 

probit wti treatment_information treatment_climatechange protest_response i.age ib4.sex ib1.education i.employment income i.residency_departamento $housing $attitudes i.no_payment_info i.financial_resources_info i.no_disasters_info i.other_reasons_info i.no_payment_cc i.financial_resources_cc i.no_disasters_cc i.other_reasons_cc 
margins, dydx(treatment_information treatment_climatechange) 
outreg2 using tab_wti.tex, append ctitle(Model B) dec(2) label 

probit wti treatment_information treatment_climatechange protest_response age ib4.sex education i.employment income i.residency_departamento $housing $attitudes river_flood urban_flood costal_flood earthquake landslide tsunami volcanic_erruption water_scarcity extreme_heat wildfire frequency_disasters severity_disasters ib4.evolution_disasters i.insurance_experience lack_trust_ne financial_resources_ne no_disasters_ne government_insurance_ne other_reasons_ne 
margins, dydx(treatment_information treatment_climatechange) 
outreg2 using tab_wti.tex, append ctitle(Model C) dec(2) label

*Tobit model to estimate the effect of the two different treatments on the willingess to pay for disaster risk insurance 

tobit wtp treatment_information treatment_climatechange protest_response i.age ib4.sex ib1.education i.employment i.income i.residency_departamento $housing, ll(0) ul(150) 
margins, dydx(treatment_information treatment_climatechange) 
outreg2 using tab_wtp.tex, replace ctitle(Model A) dec(2) label 
 
tobit wtp treatment_information treatment_climatechange protest_response i.age ib4.sex ib1.education i.employment i.income i.residency_departamento $housing $attitudes, ll(0) ul(150)
margins, dydx(treatment_information treatment_climatechange) 
outreg2 using tab_wtp.tex, append ctitle(Model B) dec(2) label 

tobit wtp treatment_information treatment_climatechange protest_response i.age ib4.sex ib1.education i.employment i.income i.residency_departamento $housing $attitudes frequency_disasters severity_disasters ib4.evolution_disasters i.insurance_experience, ll(0) ul(150)
margins, dydx(treatment_information treatment_climatechange) 
outreg2 using tab_wtp.tex, append ctitle(Model C) dec(2) label

















*Recode motive variables for probit regression 

gen lack_of_knowledge = . 
replace lack_of_knowledge = 1 if lack_knowledge_cc==1 | lack_knowledge_info==1 | lack_knowledge_bl==1
replace lack_of_knowledge = 0 if lack_of_knowledge==.

gen lack_trust = . 
replace lack_trust = 1 if lack_trust_cc==1 | lack_trust_info==1 | lack_trust_bl==1
replace lack_trust = 0 if lack_trust==.

gen no_payment = . 
replace no_payment = 1 if no_payment_cc==1 | no_payment_info==1 | no_payment_bl==1
replace no_payment = 0 if no_payment==. 

gen financial_resources = . 
replace financial_resources = 1 if financial_resources_cc==1 | financial_resources_info==1 | financial_resources_bl==1
replace financial_resources = 0 if financial_resources==.

gen no_disasters = . 
replace no_disasters = 1 if no_disasters_cc==1 | no_disasters_info==1 | no_disasters_bl==1
replace no_disasters = 0 if no_disasters==.

gen other_reasons = . 
replace other_reasons = 1 if other_reasons_cc==1 | other_reasons_info==1 | other_reasons_bl==1
replace other_reasons = 0 if other_reasons==.



probit wti treatment_information treatment_climatechange i.age ib4.sex ib1.education i.employment income i.residency_departamento $housing 
margins, dydx(treatment_information treatment_climatechange) 
outreg2 using tab_wti.tex, replace ctitle(Model A) dec(2) label 

probit wti treatment_information treatment_climatechange age ib4.sex ib1.education i.employment income i.residency_departamento $housing $attitudes no_payment financial_resources no_disasters other_reasons 
margins, dydx(treatment_information treatment_climatechange) 
outreg2 using tab_wti.tex, append ctitle(Model B) dec(2) label 

probit wti treatment_information treatment_climatechange age ib4.sex education i.employment income i.residency_departamento $housing no_payment no_disasters other_reasons river_flood urban_flood costal_flood earthquake landslide frequency_disasters severity_disasters ib4.evolution_disasters i.insurance_experience financial_resources_ne  
margins, dydx(treatment_information treatment_climatechange) 
outreg2 using tab_wti.tex, append ctitle(Model C) dec(2) label 
