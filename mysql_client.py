from mysql.connector.pooling import MySQLConnectionPool
import mysql.connector as connector
from mysql.connector import Error

try:
    connection=connector.connect(
                                user="admin1", 
                                password="zhangqian0109",
                                db = "LittleLemonDB"
                                )

except Error as er:
    print("Error number: ", er.errno)
    print("Error message: ", er.msg)

cursor = connection.cursor(buffered = True)

# cursor.execute("USE LittleLemonDB")

# # A test query
# show_tables_query = "SHOW tables"
# cursor.execute(show_tables_query)
# results = cursor.fetchall()
# print(results)


# query customer(name, contact) who order is greater than 60
qu = """
SELECT Customer.name, Customer.contact, Orders.cost
FROM Customer
INNER JOIN Orders
ON Customer.customerID = Orders.customerID
WHERE Orders.cost > 60;
"""

cursor.execute(qu)
res = cursor.fetchall()

print (res)