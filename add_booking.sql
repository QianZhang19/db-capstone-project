USE LittleLemonDB;

DELIMITER //
create procedure AddBooking(booking_id INT, customer_id INT, booking_date datetime, table_no INT, OUT msg varchar(225))
BEGIN 
insert into Bookings(bookingID, customerID, bDate, bNo) 
values (booking_id, customer_id, booking_date, table_no);
SET msg = "New booking added";

END //

DELIMITER ;

