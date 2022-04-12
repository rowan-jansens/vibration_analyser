function res = serial_command(serial_object, value)
if value > 255
    value = 255;
    disp("Value to large, defalut to 255")
end
    write(serial_object, value, "int16");
    %writeline(serial_object, string(value))
    res = 1;
end