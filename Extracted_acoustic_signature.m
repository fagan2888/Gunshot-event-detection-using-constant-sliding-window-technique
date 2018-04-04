
fldr = '/home/administrator/Tushar/test_data_files/single shots/Glockpistol_6.4_S'; % Path of binary file where gunshot was recorded
fldr1 = '/home/administrator/Tushar/Data_Files'; % Path of pqfile.txt where Events is saved

sampling_rate = 50000; %Hz
wndw_prec = 0.001; %sec
wndw_post = 0.003; %sec

Left_count = round(sampling_rate*wndw_prec);
Right_count = round(sampling_rate*wndw_post);

figure

fid = fopen(fullfile(fldr1,'pqfile.txt'),'r');
tline = fgetl(fid);

while ischar(tline)
    EventId = str2num(tline); %#ok<ST2NM> 
new_window_size = EventId-Left_count:EventId+ Right_count;
disp(new_window_size(1));
fdatID = fopen(fullfile(fldr,'all_pressure_data.bin'),'r');
fseek(fdatID,(new_window_size(1)-1)*4,'bof');
y = fread(fdatID,Left_count+Right_count+1,'float32');
% y_corr = [y_corr;y] %#ok<AGROW>
fclose(fdatID);
tline = fgetl(fid);
t = linspace(0,0.004,201);
plot(t,y);
grid on;
xlabel('Time(sec)')
ylabel('Amplitude')

end
