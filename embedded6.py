import mysql.connector
import pandas as pd

mydb = mysql.connector.connect(
  host = "localhost",
  user = "root",
  password = "Harshita@123",
  database = "cowinnew",
  auth_plugin='mysql_native_password')

mydb1 = mydb.cursor()

mydb1.execute("""SELECT HCW_ID,
count(*) as frequency
FROM Vaccination V
group by HCW_ID

Having count(*) = 
(SELECT MAX(mycount)
FROM 
(SELECT COUNT(*)mycount FROM vaccination
GROUP BY hcw_id) as b);

""")
myresult = mydb1.fetchall()
for x in myresult:
    print(x)

#df = pd.DataFrame(mydb1.fetchall(), columns = [d[0] for d in mydb1.description])
#print(df.head())
