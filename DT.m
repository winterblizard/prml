clc
clear all
close all;
load fisheriris;  % 加载数据集
x = meas;
y = species;

%逆熵计算
l=zeros(1,3);
l(1)=0;
H=0;
for i=1:3
    b=log2(1/3);
    l(i)=-1/3*b;
    H=H+l(i);
end

% 数据可视化
class = unique(y);
classic = {'萼片长', '萼片宽', '花瓣长', '花瓣宽'};
ind1 = ismember(y, class{1});
ind2 = ismember(y, class{2});
ind3 = ismember(y, class{3});
%找出三种花所在的位置
s=10;
for i=1:4
   for j=1:4
      subplot(4,4,4*(i-1)+j);%第i行第j列
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
% 随机划分训练集和测试集
ratio = 8/2; %训练比测试8/2
num = length(x);  
num_test = round(num/(1+ratio)); 
num_train = num - num_test;  
index = randperm(num);  %将150随机打乱
x_train = x(index(1:num_train),:);
y_train = y(index(1:num_train));
x_test = x(index(num_train+1:end),:);
y_test = y(index(num_train+1:end));

% 构建决策树并预测结果
tree = fitctree(x_train, y_train);
y_test_p = predict(tree, x_test);

%可视化决策树
view(tree,'Mode','graph');

%剪枝决策树
%tree_cut=prune(tree,'level',1);

% 计算预测准确率
acc = sum(strcmp(y_test,y_test_p))/num_test;
disp(['The accuracy is ', num2str(acc)]);
