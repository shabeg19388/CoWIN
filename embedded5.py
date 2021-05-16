import mysql.connector
import pandas as pd

mydb = mysql.connector.connect(
  host = "localhost",
  user = "root",
  password = "Harshita@123",
  database = "cowinnew",
  auth_plugin='mysql_native_password')

mydb1 = mydb.cursor()

mydb1.execute("""Select VS.Supplier_ID, First_Name, Last_Name , Money_Earned
from Users, Vaccine_Supplier VS
where VS.Supplier_ID=Users.User_ID 
having Supplier_ID in(
select Supplier_ID from (
select count(distinct Vaccine_ID) as v, Supplier_ID, Money_Earned
from Supply_Vaccine
group by Supplier_ID 
having max(Money_Earned)
order by v DESC
) as vs);
""")
myresult = mydb1.fetchall()
for x in myresult:
    print(x)

