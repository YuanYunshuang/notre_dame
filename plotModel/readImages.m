function [ images ] = readImages( path )
fid = fopen(path);
% Jump header to qvec and tvec line
for i=1:9
    tline = fgetl(fid);
    if i==6
        image_id = tline(1:2);
    end
end
images = zeros(91,8);
i=1;
while ischar(tline)
    k=1;
    images(i,k)=str2double(image_id);
    k = k+1;
    start =1;
    for j=1:length(tline)
        if tline(j)==' '
            images(i,k)=str2double(tline(start:j-1));
            start = j+1;
            k = k+1;
        end
    end
    [tline, image_id] = readLine(fid,5);
    i = i+1;
end


end

