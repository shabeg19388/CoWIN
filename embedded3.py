import mysql.connector
import pandas as pd

mydb = mysql.connector.connect(
  host = "localhost",
  user = "root",
  password = "Harshita@123",
  database = "cowinnew",
  auth_plugin='mysql_native_password')

mydb1 = mydb.cursor()

mydb1.execute("""Select User_ID, rank() over (order by Age Desc) as user_rank from Users order by user_rank;""")

myresult = mydb1.fetchall()
for x in myresult:
    print(x)

