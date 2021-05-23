clc;
clear all;
close all;
load fisheriris
X = meas(:,3:4);  %仅使用meas里第三和第四的特征(花瓣长和花瓣宽)
Y = species;
tabulate(Y)    %展示Y各个的species的占比

%创建mdl
Mdl = fitcnb(X,Y,'ClassNames',{'setosa','versicolor','virginica'});

versicolorIndex = strcmp(Mdl.ClassNames,'versicolor');
estimates = Mdl.DistributionParameters{versicolorIndex,1};
%使用点表示法显示特定高斯拟合的参数，例如显示versicolor中第一个特征的拟合。
%estimates = 2×1
%4.2600 均值
%0.4699 方差


%绘制高斯轮廓
figure ;%打开一个新的画布
gscatter(X(:,1),X(:,2),Y);%画出散点图
h = gca;
cxlim = h.XLim;%获取x轴坐标
cylim = h.YLim; %获取y轴坐标
hold on
Params = cell2mat(Mdl.DistributionParameters);%获取高斯分布的参数
Mu = Params(2*(1:3)-1,1:2); % 提取均值列
Sigma = zeros(2,2,3);
for i = 1:3
 Sigma(:,:,i) = diag(Params(2*i,:)).^2; 
 xlim = Mu(i,1) + 4*[1 -1]*sqrt(Sigma(1,1,i));
 ylim = Mu(i,2) + 4*[1 -1]*sqrt(Sigma(2,2,i));
ezcontour(@(x1,x2)mvnpdf([x1,x2],Mu(i,:),Sigma(:,:,i)),[xlim ylim])
% 绘制多元正态分布的等高线
end
h.XLim = cxlim;%设置X轴显示范围
h.YLim = cylim;%设置Y轴显示范围
title('Naive Bayes Classifier -- Fisher''s Iris Data')
xlabel('Petal Length (cm)')
ylabel('Petal Width (cm)')
hold off

