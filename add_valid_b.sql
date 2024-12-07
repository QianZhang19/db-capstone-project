USE LittleLemonDB;


DELIMITER //
create procedure AddValidBooking(booking_date DATETIME, table_no INT, OUT msg varchar(225) )
BEGIN
DECLARE new_bookingID INT;
start transaction;
if exists
(SELECT bDate, bNo FROM Bookings WHERE booking_date = bDate AND table_no = bNO)
then
SET msg = concat("Table ", table_no, " is already booked - booking cancelled");
rollback;
ELSE
SELECT COALESCE(MAX(bookingID), 0) + 1 INTO new_bookingID FROM Bookings;
insert into Bookings(bookingID,bDate,bNo,customerID) values (new_bookingID,booking_date, table_no, 1);
commit;
END IF;
END //

DELIMITER ;


call AddValidBooking("2022-12-17",7, @msg);

-- SELECT * FROM Bookings;
