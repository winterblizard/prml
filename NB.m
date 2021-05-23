clc;
clear all;
close all;
load fisheriris
X = meas(:,3:4);  %��ʹ��meas������͵��ĵ�����(���곤�ͻ����)
Y = species;
tabulate(Y)    %չʾY������species��ռ��

%����mdl
Mdl = fitcnb(X,Y,'ClassNames',{'setosa','versicolor','virginica'});

versicolorIndex = strcmp(Mdl.ClassNames,'versicolor');
estimates = Mdl.DistributionParameters{versicolorIndex,1};
%ʹ�õ��ʾ����ʾ�ض���˹��ϵĲ�����������ʾversicolor�е�һ����������ϡ�
%estimates = 2��1
%4.2600 ��ֵ
%0.4699 ����


%���Ƹ�˹����
figure ;%��һ���µĻ���
gscatter(X(:,1),X(:,2),Y);%����ɢ��ͼ
h = gca;
cxlim = h.XLim;%��ȡx������
cylim = h.YLim; %��ȡy������
hold on
Params = cell2mat(Mdl.DistributionParameters);%��ȡ��˹�ֲ��Ĳ���
Mu = Params(2*(1:3)-1,1:2); % ��ȡ��ֵ��
Sigma = zeros(2,2,3);
for i = 1:3
 Sigma(:,:,i) = diag(Params(2*i,:)).^2; 
 xlim = Mu(i,1) + 4*[1 -1]*sqrt(Sigma(1,1,i));
 ylim = Mu(i,2) + 4*[1 -1]*sqrt(Sigma(2,2,i));
ezcontour(@(x1,x2)mvnpdf([x1,x2],Mu(i,:),Sigma(:,:,i)),[xlim ylim])
% ���ƶ�Ԫ��̬�ֲ��ĵȸ���
end
h.XLim = cxlim;%����X����ʾ��Χ
h.YLim = cylim;%����Y����ʾ��Χ
title('Naive Bayes Classifier -- Fisher''s Iris Data')
xlabel('Petal Length (cm)')
ylabel('Petal Width (cm)')
hold off

