from mysql.connector import MySQLConnection ,Error
from python_mysql_dbconfig import read_db_config

def query_with_fetchall():
    try:
        dbconfig=read_db_config()
        conn=MySQLConnection(**dbconfig)
        cursor=conn.cursor()
        cursor.execute("SELECT * FROM books")
        rows=cursor.fetchall()

        print 'total no of rows %d' % cursor.rowcount
        for row in rows:
            print row[2]

    except Error as e:
        print e

    finally:
        cursor.close()
        conn.close()

def iter_row(cursor,size):
    while True:
        rows=cursor.fetchmany(size)
        if not rows:
            break
        for row in rows:
            yield row

def query_with_fetchmany():
    try:
        dbconfig=read_db_config()
        conn=MySQLConnection(**dbconfig)
        cursor=conn.cursor()
        cursor.execute("Select * from books")

        for row in iter_row(cursor,10):
            print row

    except Error as e:
        print e

    finally:
        cursor.close()
        conn.close()

    

if __name__=='__main__':
    query_with_fetchmany()
