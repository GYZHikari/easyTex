clear; clc; close all;
xls_path = './table.xlsx';
[num_matrix, txt_matrix, raw_matrix] = xlsread(xls_path,1);
[val, ind] = sort(num_matrix,2);
[x,y] = find(ind==1);
x = x+1;
y = y+1;
matind = sub2ind(size(raw_matrix), x, y);
for ii = 1:length(matind)
    raw_matrix(matind(ii)) = strcat({'\textcolor{red}{\textbf{'}, cell2string(raw_matrix(matind(ii))), {'}}'});
end
[x,y] = find(ind==2);
x = x+1;
y = y+1;
matind = sub2ind(size(raw_matrix), x, y);
for ii = 1:length(matind)
    raw_matrix(matind(ii)) = strcat({'\textcolor{blue}{'}, cell2string(raw_matrix(matind(ii))), {'}'});
end

[m,n]  = size(raw_matrix);
tracker_matrix = cell(m,2*n-1);
and_matrix = num2cell(repmat('&', m, 1));
for ii = 1:n
    tracker_matrix(:,(2*(ii-1)+1):2*ii) = [raw_matrix(:,ii), and_matrix];
end
tracker_matrix(:,end) = [];
c_num = n;
c_matrix = repmat('c', 1, c_num);
c_matrix = ['c|',  c_matrix];
c_matrix(end) = [];


tex_txt = fopen('tex.txt', 'a');
fprintf(tex_txt, '%s\n',['\begin{tabular}', '{', c_matrix, '}']);
fprintf(tex_txt, '%s\n', '\hline');
for ii = 1:m
    temp = cell2string(tracker_matrix(ii,:));
    fprintf(tex_txt, '%s',temp);
    fprintf(tex_txt, '%s\n', '\\');
    if ii==1
        fprintf(tex_txt, '%s\n', '\hline');
    end
end
fprintf(tex_txt, '%s\n', '\hline');
fprintf(tex_txt, '%s\n', '\end{tabular}');
fclose(tex_txt);

