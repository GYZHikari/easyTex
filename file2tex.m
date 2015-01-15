clear; close all; clc;
txt_path = 'figure.txt';
fig_path = './rects/';
fig_max_num = 4;
datafile = dir(fig_path);
tmp = [];
for ii = 1:length(datafile)
    if strcmp(datafile(ii).name, '.')||strcmp(datafile(ii).name, '..')
        tmp = [tmp, ii];
    end
end
datafile(tmp) = [];
tex_txt = fopen(txt_path, 'a');
fprintf(tex_txt, '%s\n', '\begin{figure}[!htp]');
fprintf(tex_txt, '%s\n', '\centering');
fprintf(tex_txt, '%s', '\begin{tabular}{');
for ii = 1:fig_max_num
    fprintf(tex_txt, '%s', 'c@{\extracolsep{0.01em}}');
    if ii==fig_max_num
        fprintf(tex_txt, '%s\n',  'c}');
    end
end
for ii = 1:length(datafile)
    sub_file_path = [fig_path, datafile(ii).name, '/'];
    fig_names = dir([sub_file_path,'*.png']);
    for jj = 1:length(fig_names)
        tmp = [sub_file_path, fig_names(jj).name];
        fprintf(tex_txt, '%s\n', ['&\includegraphics[width=' num2str(1/length(fig_names)) '\textwidth,keepaspectratio]' '{' tmp '}']);
    end
    fprintf(tex_txt, '%s\n',  '\\');
end
fprintf(tex_txt, '%s\n',  '\end{tabular}');
fprintf(tex_txt, '%s\n',  '\end{figure}');

fclose(tex_txt);