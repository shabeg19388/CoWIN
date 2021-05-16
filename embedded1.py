import mysql.connector
import pandas as pd

mydb = mysql.connector.connect(
  host = "localhost",
  user = "root",
  password = "Harshita@123",
  database = "cowinnew",
  auth_plugin='mysql_native_password')

mydb1 = mydb.cursor()

mydb1.execute("""select S1.State_ID, State_Name, count(*) as frequency
from Application_Form A1, Population P1, Users U1, State S1, District D1
where A1.Population_ID=P1.Population_ID
and P1.Population_ID=U1.User_ID
and U1.District_ID=D1.District_ID
and D1.State_ID=S1.State_ID
group by S1.State_ID
having frequency in(SELECT Max(freq) from (
select count(*) as freq, State_Name
from Application_Form A, Population P, District D, Users U, State S
where A.Population_ID=P.Population_ID
and P.Population_ID=U.User_ID
and U.District_ID=D.District_ID
and D.State_ID=S.State_ID
group by S.State_ID) as p);
""")
myresult = mydb1.fetchall()
for x in myresult:
    print(x)

