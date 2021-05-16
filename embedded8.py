import mysql.connector
import pandas as pd

mydb = mysql.connector.connect(
  host = "localhost",
  user = "root",
  password = "Harshita@123",
  database = "cowinnew",
  auth_plugin='mysql_native_password')

mydb1 = mydb.cursor()

mydb1.execute("""Select hospital_ID, hopsital_name, helpline , sum(number) from hospital group by cube(hospital_ID, hospital_name, helpline);""")
myresult = mydb1.fetchall()
for x in myresult:
    print(x)

