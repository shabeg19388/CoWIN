import mysql.connector
import pandas as pd

mydb = mysql.connector.connect(
  host = "localhost",
  user = "root",
  password = "Harshita@123",
  database = "cowinnew",
  auth_plugin='mysql_native_password')

mydb1 = mydb.cursor()

mydb1.execute("""SELECT d.department_id,
d.department_name,
count(*)
FROM frontline_worker f,
department d
WHERE f.department_id = d.department_id
GROUP BY d.department_id
having count(*) = 
(SELECT MAX(mycount)
 FROM
 (SELECT COUNT(*) mycount
  FROM frontline_worker
  GROUP BY department_id) a);
""")
myresult = mydb1.fetchall()
for x in myresult:
    print(x)

