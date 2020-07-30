# mysql -h 127.0.0.1 -u Air_admin -p airline 
from __future__ import print_function, unicode_literals
import mysql.connector
from pyfiglet import Figlet
from PyInquirer import prompt
from pprint import pprint
import pandas as pd
from datetime import timedelta

def WEL():
    f = Figlet(font='slant')
    print ( f.renderText('Airline Database Management System') )

def add__P_record( mycursor ,mydb):
    questions = [
        {
            'type': 'input',
            'name': 'name',
            'message': 'Plz enter full name',
        },
        {
            'type': 'input',
            'name': 'cnic',
            'message': 'Plz enter CNIC (13-digit)',
        },
        {
            'type': 'input',
            'name': 'phone',
            'message': 'Plz enter phone(11-digit)',
        },
        {
            'type': 'input',
            'name': 'adress',
            'message': 'Plz enter adress',
        },
        {
            'type': 'input',
            'name': 'nation',
            'message': 'Plz enter nationality',
        },
    ]
    answers=prompt(questions)
 
    val= (answers['name'], answers['cnic'], answers['adress']  ,answers['phone'] ,answers['nation'])
    w_sql="INSERT INTO PERSON  VALUES (%s, %s , %s ,%s ,%s)"

    try:
        mycursor.execute(w_sql , val)
        mydb.commit()
        print("\nCOMMITED\n")
    except:
        print("error-wrong-credentials")


def add_f_record(mycursor,mydb):
    print("1->Add a flight id(arrival and dep airport)\n0->Add new flight against flight_id")
    a=input()
    if input==1:
        questions = [
            {
                'type': 'input',
                'name': 'flight_id',
                'message': 'Plz enter flight id(UNIQUE)',
            },
            {
                'type': 'input',
                'name': 'departure_airport',
                'message': 'Plz enter departure airport',
            },
            {
                'type': 'input',
                'name': 'arrival_airport',
                'message': 'Plz enter arrival airport',
            }
        ]
        answers=prompt(questions)
        w_sql="INSERT INTO FLIGHT_ID VALUES (%s,%s ,%s);"
        val=(answers['flight_id'], answers['departure_airport'], answers['arrival_airport'])
        try:
            mycursor.execute(w_sql , val)
            mydb.commit()
            print("\nCOMMITED\n")
        except:
            print("error-wrong-credentials")
    else:
        questions = [
            {
                'type': 'input',
                'name': 'flight_id',
                'message': 'Plz enter flight id',
            },
            {
                'type': 'input',
                'name': 'departure_time',
                'message': 'Plz enter departure time',
            },
            {
                'type': 'input',
                'name': 'arrival_time',
                'message': 'Plz enter arrival time',
            },
             {
                'type': 'input',
                'name': 'Date',
                'message': 'Plz enter DateStamp (YYYY-MM-DD 00:00:00)',
            },
            {
                'type': 'input',
                'name': 'airplane',
                'message': 'Plz enter name of airplane',
            },
            {
                'type': 'input',
                'name': 'fare',
                'message': 'Plz enter fare of journey',
            }
        ]
        answers=prompt(questions)
        w_sql="INSERT INTO flights_in_process VALUES (%s, %s, %s , %s ,%s ,%s ,%s)"
        val=(0, answers['flight_id'],answers['departure_time'] ,answers['arrival_time'],answers['Date'],answers['airplane'],answers['fare'])
        try:
            mycursor.execute(w_sql , val)
            mydb.commit()
            print("\nCOMMITED\n")
        except:
            print("error-wrong-credentials")


def udate_p_record(mycursor,mydb):
    questions = [
        {
            'type': 'input',
            'name': 'cc',
            'message': 'Plz enter the cnic of passenger.',
        },
        {
            'type': 'input',
            'name': 'p_k',
            'message': 'Plz enter attribute(exact) of the table which you want to modify',
        }, 
        {
            'type': 'input',
            'name': 'n_V',
            'message': 'Plz enter updated_value',
        },
    ]
    answers = prompt(questions)
    sql="UPDATE person SET {} = \"{}\" WHERE Cnic = {}".format(answers['p_k'] ,answers['n_V'],  answers['cc'])
    # print(sql)
    try:
        mycursor.execute(sql)
        mydb.commit()
        print("\nCOMMITED\n")
    except:
        print("error-wrong-credentials")


def update_f_record(mycursor, mydb):
    questions = [
        {
            'type': 'input',
            'name': 'id',
            'message': 'Plz enter the flight number',
        },
        {
            'type': 'input',
            'name': 'p_V',
            'message': 'Plz enter the attribute(col)',
        },
        {
            'type': 'input',
            'name': 'n_V',
            'message': 'Plz enter updated_value',
        },
    ]
    answers = prompt(questions)
    sql="UPDATE flights_in_process SET {} = \"{}\" WHERE flight_number = {}".format(answers['p_V'] ,answers['n_V'],answers['id'])
    # print(sql)
    try:
        mycursor.execute(sql)
        mydb.commit()
        print("\nCOMMITED\n")
    except:
        print("error-wrong-credentials")


def cancel_flight(mycursor , mydb):
    # flight id 
    print("ENTER THE Flight number..")
    a=input()
    w_sql="DELETE FROM  flights_in_process WHERE flight_number = {}".format(a)
    # print (w_sql)
    try:
        mycursor.execute(w_sql)
        mydb.commit()
        print("\nCOMMITED\n")
    except:
        print("error-wrong-credentials")

def create_dataframe(mycursor  ,table):
    sql="DESCRIBE {}".format(table)
    mycursor.execute(sql)
    my= mycursor.fetchall()
    table_=  []
    for c in my:
        table_.append(c[0])

    sql= "SELECT * FROM {}".format(table)
    mycursor.execute(sql)
    res= mycursor.fetchall()
    data=[]
    for s in res:
        data.append(s)
    df = pd.DataFrame(data, columns = table_) 
    print(df)


def print_tabluar(mycursor):
    mycursor.execute("SHOW TABLES")
    myresult = mycursor.fetchall()
    for x in myresult:
        print("   |-----------------------------------------------------------------------------------------")
        create_dataframe(mycursor , x[0])
    return


def flight_history(mycursor):
    print("Enter the CNIC OF THE CUSTOMER")
    cnin= input()

    w_sql="SELECT  temp.P_CNIC, f.flight_number ,f.a_t ,f.d_t , f.date_f ,f.flight_id_t , x.d_A, x.a_A  from flights_in_process as f, (SELECT * from passenger_in_flight WHERE P_CNIC={})as temp , FLIGHT_ID as x where temp.flight_details = f.flight_number and x.id = f.flight_id_t".format(cnin)
   
    try:
        mycursor.execute(w_sql)
        res= mycursor.fetchall()
        for c in res:
           print("(" , c[0], c[1], str(c[2]) ,str(c[3]), str(c[4])  , c[5] ,c[6] ,c[7] ,")")
        #    print(c)

    except:
        print("error-wrong-credentials")


def generate_ticket(mycursor, mydb):
    w_sql="select * from flight_details_f";
    mycursor.execute(w_sql)
    res= mycursor.fetchall()
    for c in res:
        print(c)
    
    print("Enter the valid flight id from above table  where you wanna book the flight")
    idd= input()
    print("Enter your CNIC")
    cnin= input()
    INSER= (0 , idd , cnin)
    w_sql1="INSERT INTO passenger_in_flight VALUES (%s,%s,%s)"
   
    try:
        mycursor.execute(w_sql1 , INSER)
        mydb.commit()
        print("\nCOMMITED\n")
    except:
        print("error-wrong-credentials")



def all_flights_on_day(mycursor):
    print("Enter the date to see all fligths (yyyy-mm-dd)..")
    date= input()
    # w_sql="SELECT * from flights_in_process where date_f = \"{}\" ".format(date);
    w_sql="SELECT * from flight_details_f where date_f = \"{}\" ".format(date);

   
    try:
        mycursor.execute(w_sql)
        res= mycursor.fetchall()
        for c in res:
           print("(" , c[0], c[1],c[2] , c[3] , str(c[4]) ,str(c[5]), str(c[6]) ,c[7] ,")")
        #    print(c)
    except:
        print("error-wrong-credentials")

def cancel_ticket(mycursor, mydb):
    print("ENTER THE customer id..")
    a=input()
    w_sql="DELETE FROM  passenger_in_flight WHERE coustmer_id = {}".format(a)
    try:
        mycursor.execute(w_sql)
        mydb.commit()
        print("\nCOMMITED\n")
    except:
        print("error-wrong-credentials")


def cheap_flight(mycursor):
    print("ENTER arr airport..")
    a=input()
    print("ENTER dep airport..")
    b=input()
    w_sql="SELECT * from FLIGHT_DETAILS_F where fare in ( SELECT min(xx.fare) from (SELECT * from FLIGHT_DETAILS_F where a_a=\'{}\' and d_A =\'{}\') as xx) ".format(a,b);
    try:
        mycursor.execute(w_sql)
        res= mycursor.fetchall()
        for c in res:
           print(c)
    except:
        print("error-wrong-credentials")



def all_availabe_flight(mycursor):
    print("ENTER arr airport..")
    a=input()
    print("ENTER dep airport..")
    b=input()
    print("Enter starting date (yyyy-mm-dd)..")
    date= input()
    print("Enter ending date (yyyy-mm-dd)..")
    date1= input()
    
    w_sql="SELECT * from (SELECT * FROM FLIGHT_DETAILS_F where a_A =\'{}\' and d_a=\'{}\') as temp where temp.date_f BETWEEN \"{}\" AND \"{}\" ".format(a,b,date,date1)
    try:
        mycursor.execute(w_sql)
        res= mycursor.fetchall()
        for c in res:
           print(c)   
    except:
        print("error-wrong-credentials")


def hel(mycursor  , mydb , token):
    while True:
        if token:
            c='a) Add a new flight record \nb) Update flight record.\nc) Cancel flight record.\nd) All flights landing and taking off on a airport on that day \ne) View in tabular form \nQ) TO QUIT'
            print(c)
            
            questions = [
                {
                    'type': 'list',
                    'name': 'cho',
                    'message': 'Select choice',
                    'choices': ['a', 'b', 'c', 'd', 'e', 'Q']
                }
            ]
            answer = prompt(questions)
            x=answer['cho']
            
            if x=='a':
                add_f_record(mycursor,mydb)
            elif x=='b':
                update_f_record(mycursor,mydb)
            elif x=='c':
                cancel_flight(mycursor ,mydb)
            elif x=='d':
                all_flights_on_day(mycursor);
            elif x=='e': 
                print_tabluar(mycursor)
            elif x=='Q':
                break
        else:
            c1 = 'a) Create passenger record \nb) Update passenger record \nc) Using departure,arrival airport IATA code, view available flights in a particular time period.\nd) Generate ticket for a passenger.\ne) Using departure,arrival airport IATA code, view the cheapest flight.\nf) Flight history of passenger \ng) Cancel a particular ticket record \nQ) TO QUIT'
            print(c1)
            questions = [
                {
                    'type': 'list',
                    'name': 'cho1',
                    'message': 'Select choice' , 
                    'choices': ['a', 'b', 'c', 'd', 'e' ,'f' , 'g' , 'Q']
                }
            ]
            answer1=prompt(questions)
            x=answer1['cho1']

            if x=='a':
                add__P_record(mycursor,mydb)
            elif x=='b':
                udate_p_record(mycursor , mydb)
            elif x=='c':
                all_availabe_flight(mycursor)
            elif x=='d':
                generate_ticket(mycursor, mydb)
            elif x=='e':
                cheap_flight(mycursor)
            elif x=='f': 
              flight_history(mycursor)
            elif x=='g':
                cancel_ticket(mycursor,mydb)
            elif x=='Q':
                break

def login():
    questions = [
        {
            'type': 'input',
            'name': 'username',
            'message': 'Enter username',
        },
        {
            'type': 'password',
            'name': 'pass_',
            'message': 'Enter password',
        }
    ]
    
    while 1:
        answers = prompt(questions)
        try:
            mydb = mysql.connector.connect(
                host="localhost",
                user=answers['username'],
                passwd=answers['pass_'],
                database="Airline",
                auth_plugin='mysql_native_password'
            )
            break
        except:
            print("Worng user name and password")

    token=0
    if answers['username']=='Air_admin': 
        token=1
   
    mycursor = mydb.cursor()
    hel(mycursor , mydb  ,token)

def main():
    WEL()
    login()

if __name__ == '__main__':
        main()