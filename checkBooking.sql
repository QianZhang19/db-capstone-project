-- create a proc to check if a table is alr booked

DELIMITER //
create procedure CheckBooking(booking_date DATE, table_no INT, OUT msg varchar(225) )

BEGIN
if exists
(SELECT bDate, bNo FROM Bookings WHERE booking_date = bDate AND table_no = bNO)
then
SET msg = concat("Table ", table_no, " is already booked");
ELSE
SELECT table_no;
END IF;

END //

DELIMITER ;


call CheckBooking("2022-11-12",1, @msg);
SELECT @msg;

-- select * from bookings;

