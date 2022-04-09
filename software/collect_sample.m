function res = collect_sample(num_smaples, port, baud)
   
    clear arduino;

    %connect to serial
    arduino = serialport(port,baud);
    %set up line terminator
    configureTerminator(arduino,"CR/LF");
    %clear serial buffer
    flush(arduino);
    %set up data struct to read
    arduino.UserData = struct("Data",[],"Count",1);
    %run func. every time the "terminator" is detected
    configureCallback(arduino,"terminator",@read_data);

    
    res = 0;
    
    
    function read_data(src, ~)
    % Read the ASCII data from the serialport object.
    data = readline(src);

    % Convert the string data to numeric type and save it in the UserData
    % property of the serialport object.
    src.UserData.Data(end+1) = str2double(data);

    % Update the Count value of the serialport object.
    src.UserData.Count = src.UserData.Count + 1;

    % If 1001 data points have been collected from the Arduino, switch off the
    % callbacks and plot the data.
        if src.UserData.Count > 1001
            configureCallback(src, "off");
            plot(src.UserData.Data(2:end));
        end
    end
end
