
fldr = '/home/administrator/Tushar/test_data_files/single shots/Glockpistol_6.4_S';
fldr1 = '/home/administrator/Tushar/Data_Files';

sampling_rate = 50000; %Hz
window_size_time = 0.01; %sec
threshold = 1500;
window_size = round(sampling_rate*window_size_time);

fileID=fopen(fullfile(fldr,'all_pressure_data.bin'),'r');
figure
i = 1;
filename = 'pqfile.txt';
foutID = fopen(fullfile(fldr1,filename),'w'); % Add directory path to fopen
fclose(foutID);

while ~feof(fileID)
    y=fread(fileID,window_size,'float32');
    if length(y) ~= window_size
%         disp('Breaking')
        break;
    end
    plot((i-1)+(1:window_size),y,'k');hold all
    if i == 1
        PrevNoiseLevel = std(y);
        i = i + window_size;
        continue;
    end
    [CurrPeak,im] = max((y));
    if (CurrPeak > threshold*PrevNoiseLevel)
%         check = true;
        EventId = im + i - 1;
%       Event(count)=EventId;
%       count=count+1;
        foutID = fopen(fullfile(fldr1,filename),'a');
        fprintf(foutID,'%d\n',EventId);
        fclose(foutID);
        plot(EventId,CurrPeak,'x')  
    else
%       PrevNoiseLevel = std(y);
    end
 
       i = i + window_size; 
end
fclose(fileID);
