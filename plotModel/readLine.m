function [ tline, image_id ] = readLine( fid, jump )
    for i=1:jump
        tline = fgetl(fid);
        if ~ischar(tline)
            image_id = -1;
            break;
        end
        if i==2
            image_id = tline(1:2);
        end
    end
end

