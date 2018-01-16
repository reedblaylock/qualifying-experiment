function highlow = getHighLow(filename)

fid = fopen(filename);
C = textscan(fid, '%s', 1, 'delimiter', '\n', 'headerlines', 2); % 2 = line number - 1
highlow = C{1}{1};
fclose(fid);

end