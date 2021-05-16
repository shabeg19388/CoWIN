import mysql.connector
import pandas as pd

mydb = mysql.connector.connect(
  host = "localhost",
  user = "root",
  password = "Harshita@123",
  database = "cowinnew",
  auth_plugin='mysql_native_password')

mydb1 = mydb.cursor()

mydb1.execute("""Select Distribution_Date, CS_Distribution_ID, Quantity , SUM(Quantity) OVER(PARTITION By  Distribution_Date) AS Total_Quantity_Sold FROM CS_Distribution;""")

myresult = mydb1.fetchall()
for x in myresult:
    print(x)

