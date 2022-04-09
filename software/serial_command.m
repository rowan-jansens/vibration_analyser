function res = serial_command(serial_object, value)
    write(serial_object, value, "int16");
    res = 1;
end