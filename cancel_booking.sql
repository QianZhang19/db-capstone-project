use LittleLemonDB;

DELIMITER //
create procedure CancelBooking(IN booking_id INT, OUT msg varchar(225))
begin
delete from Bookings where bookingID = booking_id;
set msg = CONCAT("Booking ", booking_id, " cancelled");
END //

DELIMITER ;


call CancelBooking(9, @msg);
select @msg;
