from mysql.connector.pooling import MySQLConnectionPool
import mysql.connector as connector
from mysql.connector import Error

try:
    connection=connector.connect(
                                user="admin1", # use your own
                                password="zhangqian0109", # use your own
                                )

except Error as er:
    print("Error number: ", er.errno)
    print("Error message: ", er.msg)

cursor = connection.cursor(buffered = True)

cursor.execute("USE LittleLemonDB")

# cursor.execute("SHOW tables;")

# tables = cursor.fetchall()

# if tables:
#     print("There are tables in the LittleLemonDB")
#     for table in tables:
#         print(table)

# else:
#     print("No table found")


view_t = """CREATE VIEW OrdersView AS
SELECT orderID, quantity, cost 
FROM Orders
WHERE quantity>2;
"""


join_t = """SELECT 
Customer.customerID, Customer.name, Orders.orderID, Orders.cost, Menus.cuisines, MenuItems.courses, MenuItems.starters
FROM Customer
INNER JOIN Orders
ON Customer.customerID = Orders.orderID
INNER JOIN Menus
ON Menus.orderId = Orders.orderID
INNER JOIN MenuItems
ON MenuItems.menuitemID = Menus.menuitemID
"""


suq = """SELECT
cuisines AS MenuName
FROM Menus
WHERE menuID =
ANY (SELECT menuID FROM Orders WHERE quantity >=2)
"""

# Create optimised queries to manage and analyse data
max_order = """
CREATE PROCEDURE GetMaxQuantity()
BEGIN
SELECT MAX(quantity)
FROM Orders
END

"""