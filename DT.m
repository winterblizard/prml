clc
clear all
close all;
load fisheriris;  % �������ݼ�
x = meas;
y = species;

%���ؼ���
l=zeros(1,3);
l(1)=0;
H=0;
for i=1:3
    b=log2(1/3);
    l(i)=-1/3*b;
    H=H+l(i);
end

% ���ݿ��ӻ�
class = unique(y);
classic = {'��Ƭ��', '��Ƭ��', '���곤', '�����'};
ind1 = ismember(y, class{1});
ind2 = ismember(y, class{2});
ind3 = ismember(y, class{3});
%�ҳ����ֻ����ڵ�λ��
s=10;
for i=1:4
   for j=1:4
      subplot(4,4,4*(i-1)+j);%��i�е�j��
      if i==j
          set(gca, 'xtick', [], 'ytick', []);
          text(.2, .5, classic{i});
          set(gca, 'box', 'off');
          continue;
       end
      scatter(x(ind1,i), x(ind1,j), s, 'r', 'MarkerFaceColor', 'r');
      hold on
      scatter(x(ind2,i), x(ind2,j), s, 'b', 'MarkerFaceColor', 'b');
      hold on
      scatter(x(ind3,i), x(ind3,j), s, 'g', 'MarkerFaceColor', 'g');
       set(gca, 'box', 'off');
   end
end
% �������ѵ�����Ͳ��Լ�
ratio = 8/2; %ѵ���Ȳ���8/2
num = length(x);  
num_test = round(num/(1+ratio)); 
num_train = num - num_test;  
index = randperm(num);  %��150�������
x_train = x(index(1:num_train),:);
y_train = y(index(1:num_train));
x_test = x(index(num_train+1:end),:);
y_test = y(index(num_train+1:end));

% ������������Ԥ����
tree = fitctree(x_train, y_train);
y_test_p = predict(tree, x_test);

%���ӻ�������
view(tree,'Mode','graph');

%��֦������
%tree_cut=prune(tree,'level',1);

% ����Ԥ��׼ȷ��
acc = sum(strcmp(y_test,y_test_p))/num_test;
disp(['The accuracy is ', num2str(acc)]);
