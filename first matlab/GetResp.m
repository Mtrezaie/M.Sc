function y = GetResp(SerialPort,address)
% Send to second matlab
fprintf(SerialPort,address) ;
% get from second matlab
y = fscanf(SerialPort) ;
y = str2double(y) ;


end
% fclose(SerialPort)
%fclose(port)