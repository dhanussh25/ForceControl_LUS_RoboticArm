 S = readtable('GV_graph.xls','Range','F9:G28');
 col1 = S{:,1};
 col2 = S{:,2};
 figure;
 plot(col1,col2);
 title('linearity');
 xlabel('weight in grams');
 ylabel('voltage');
 