clear
clc
close all
load summary_singledrug;
drugIdx_name=readtable('drugName.csv');
rownumber=size(summary_singledrug,1);
rownumber=27;
totalnumber=rownumber/3;
figure_n=ceil(totalnumber/9);
for figure_idx=1:figure_n
%draw bar plot for every single drug
figure(figure_idx)
for drugNumber=(9*figure_idx-8):min(9*figure_idx,totalnumber)
    i=drugNumber;
    cck_single=summary_singledrug((3*i-2):3*i,:);
    cck_single=table2array(cck_single);
    drugIdx=cck_single(1);
    cck_single=cck_single(:,2:end);
    barvalue=mean(cck_single);
    barvalue=barvalue/barvalue(1);
    stderror=std(cck_single);
    %draw bar figure
    subplot(3,3,i-9*figure_idx+9)
    bar(barvalue,0.5,'w');
    hold on
    errorbar(barvalue,stderror,'k','LineStyle','none');
 
    
%%%%%%%%title legend %%%%%%%%%%%%%%%%%%%%%%%%
xlabel(strcat(drugIdx_name{drugIdx,2}, '(mg/ml)'),'FontName','Times New Roman','FontSize',10);
set(gca,'xtick',[1 2 3 4 5],'xticklabel',{'control','10^{-1}','10^{-2}','10^{-3}','10^{-4}'});
ylabel('Cell Viability','FontName','Times New Roman','FontSize',10);
set(gca,'ytick',[0.5 1 ]);
set(gca,'FontName','Times New Roman','FontSize',10,'ticklength',[0 11]);
set(gca,'FontWeight','bold')
axis([0.5 5.5 0 1.5]) 
H1=line([0.5 0.58],[0.5 0.5]);
H2=line([0.5 0.58],[1 1]);
H1.Color=[0 0 0];
H2.Color=[0 0 0];
%box off   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%asterisk%%%%%%%%%%%%%%%%%%%%%%%
[p,tbl,stats]=anova1(cck_single,[],'off');
asterisk=multcompare(stats,'display','off');

for pos=1:4
    sig_val=asterisk(pos,6);
    if sig_val<0.01
        H3=text(pos+1,barvalue(pos+1)+0.2,'*');
        H3.HorizontalAlignment='center';
        H3.FontSize=14;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
end
end