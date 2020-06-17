%%% Opening the files
fileID_test = fopen('test.txt','r');
fileID_result = fopen('test_result.txt','r');
%%% Preparing the array for test vector and result vector
test = [];
result = [];
%%% bit acquisition from test vector
i=0;
while true
      thisline = fgetl(fileID_test);
  if (~ischar(thisline)) 
      break;
  elseif (i>0) 
      test = [test thisline];
  end
  i = i+1;
end
%%% bit acquisition from form result vector
while true
      thisline = fgetl(fileID_result);
  if (~ischar(thisline)) 
      break;
  else
      result = [result thisline];
  end
end
%%% Comparing the test and result vector
result = strrep(result, ' ', '');
if (sum(result==test)==length(test))
    disp("Transmition and reception was successful");
end
%%% Closing the files
fclose(fileID_test);
fclose(fileID_result);
