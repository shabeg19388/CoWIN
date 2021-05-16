import mysql.connector
import pandas as pd

mydb = mysql.connector.connect(
  host = "localhost",
  user = "root",
  password = "Harshita@123",
  database = "cowinnew",
  auth_plugin='mysql_native_password')

mydb1 = mydb.cursor()

mydb1.execute("""select avg(Age), State_Name
from Users U, State S, District D, Population P 
where U.User_ID=P.Population_ID
and U.District_ID=D.District_ID
and D.State_ID=S.State_ID
group by S.State_ID;
""")
myresult = mydb1.fetchall()
for x in myresult:
    print(x)

