USE LittleLemonDB;

DELIMITER //
create procedure UpdateBooking(IN booking_id INT, IN booking_date datetime, OUT msg varchar(225))
BEGIN 
update Bookings
set bDate = booking_date
where bookingID = booking_id;
SET msg = CONCAT("Booking ", booking_id, " updated");

END //

DELIMITER ;


call UpdateBooking(9, "2022-11-30", @msg);
select @msg;