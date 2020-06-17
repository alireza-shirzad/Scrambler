%%% Specifying the number of bits of test vector. Not byte! bit!
length = 1024;
%%% Providing the length 12 bit vector in the first line of test file
length_binary = strrep(num2str(de2bi(length,12,'left-msb')), ' ', '');
%%% Opening the file
fileID = fopen('test.txt','w');
%%% Write operatio in the test file
fprintf(fileID,length_binary);
for i = 1:length
    
    if(rand<0.5)
        fprintf(fileID,"\n0");
    else
        fprintf(fileID,"\n1");
    end
    
end
%%% Closing the file
fclose (fileID);