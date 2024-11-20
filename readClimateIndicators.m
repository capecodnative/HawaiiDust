tempPDO=readmatrix("ClimateIndicators/ersst.v5.pdo.dat.txt","NumHeaderLines",1);
tc=tempPDO(:,1)>=1980 & tempPDO(:,1)<=2023;
PDO1980to2023=tempPDO(tc,2:end);
PDOall=tempPDO(:,2:end);
PDOall=reshape(PDOall',[],1);
PDOall(PDOall>99)=[];
corrMonthlyPDO=reshape(PDO1980to2023',[],1);

tempNino=readmatrix("ClimateIndicators/nino4.long.anom.data.txt","NumHeaderLines",1);
tc=tempNino(:,1)>=1980 & tempNino(:,1)<=2023;
Nino41980to2023=tempPDO(tc,2:end);
NinoAll=tempNino(:,2:end);
NinoAll=reshape(NinoAll',[],1);
NinoAll(isnan(NinoAll))=[];
corrMonthlyNino=reshape(Nino41980to2023',[],1);

clear tc tempPDO tempNino
