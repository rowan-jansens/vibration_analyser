function [phase, amp] = collect_sample(arduino)

    

    num_data_points = 500;
    configureCallback(arduino, "off");
    %set up data struct to read
    arduino.UserData = struct("Data",zeros(num_data_points,3),"Count",1, "Points", num_data_points);
    
    serial_command(arduino, num_data_points/10);
    configureTerminator(arduino,"CR");
    flush(arduino);

    configureCallback(arduino,"terminator", @read_data);

    uiwait




    

    disp("Data Aquired")
    data_array=[(arduino.UserData.Data(:,1)-arduino.UserData.Data(1,1))./1000000    arduino.UserData.Data(:,2)  (arduino.UserData.Data(:,3)-arduino.UserData.Data(1,1))./1000000];
    [phase, amp] = compute_phase(data_array);

    function read_data(src, ~)


    % Read the ASCII data from the serialport object.
    data = readline(src);
    data = split(data);
    data = str2double(data);
    %disp(src.UserData.Count);

     %Convert the string data to numeric type and save it in the UserData
     %property of the serialport object.
     src.UserData.Data(src.UserData.Count,:) = [data(1) data(2) data(3)];
 
     % Update the Count value of the serialport object.
     src.UserData.Count = src.UserData.Count + 1;

         if src.UserData.Count > src.UserData.Points
            configureCallback(src, "off");
            disp("Done reading");
            uiresume

         end
    end

end
