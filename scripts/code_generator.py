import random
import string
import mysql.connector
import getopt
import sys


db_host = "localhost"
db_user = "root"
db_passwd = "example"

codes = []

def connect_db(db_host, db_user, db_passwd):
    try:
        conn = mysql.connector.connect(
            host=db_host,
            user=db_user,
            passwd=db_passwd
        )
        cursor = conn.cursor()
        cursor.execute("use scientiometer;")
        return cursor, conn
    except Exception as e:
        print("Error setting up DB connection")
        print(e)
        exit(1)

def save_code(db_id, code, cursor):
    cursor.execute(
        "UPDATE researcher SET code = %s WHERE employee_id = %s;", (code, db_id))
    print(cursor.statement)

def retrieve_codes(cursor):
    cursor.execute("SELECT code FROM researcher_data WHERE code IS NOT NULL;")
    codes = cursor.fetchall()
    return codes

def gen_code(codes):
    code = ''.join(random.choices(
        (string.ascii_uppercase), k=4))
    while code in codes:
        code = ''.join(random.choices(
            (string.ascii_uppercase), k=4))
    codes.append(code)
    return code

def generate_ovewrite_all(cursor):
    print("Re-generating all codes")
    cursor.execute("SELECT id FROM researcher_data;")
    ids = cursor.fetchall()
    codes = []
    for id_ in ids:
        save_code(id_[0], gen_code(codes), cursor)

def generate_not_have(cursor):
    print("Generating codes for those who doesn't have one")
    cursor.execute("SELECT id FROM researcher_data WHERE code IS NULL;")
    ids_empty = cursor.fetchall()
    print(ids_empty)
    codes = retrieve_codes(cursor)
    for id_empty in ids_empty:
        save_code(id_empty[0], gen_code(codes), cursor)

def generete_single( db_id, cursor):
    print(f"Generating code for id: {db_id}")
    codes = retrieve_codes(cursor)
    save_code(db_id, gen_code(codes), cursor)

def help():
    print("""\
        Usage: script.py
            -s | --single Generate/update a single entry. Default is random code. Use --id and --code
            -a | --all Generate/update all entries
            -e | --empty Generate/update only empty entries
            --id <id to modify> Use with --single option
            --code <code for the entry> Optional use with --single option
            -h | --help Show this message"""
            )
    sys.exit(2)

def main():
    try:
        optlist, args = getopt.gnu_getopt(
            sys.argv[1:], 'saeh', ['single', 'all', 'empty', 'id=', 'code=', 'help'])
    except getopt.GetoptError as err:
        print(err)

    mode = None
    in_id = None
    code = None

    for opt, arg in optlist:
        if opt in ('-s', '--single'):
            mode = 'single'

        elif opt in ('-a', '--all'):
            if (input("Are you sure to change ALL codes in database? YES or NO: ") != 'YES'):
                print("Operation canceled")
                exit(0)
            mode = 'all'

        elif opt in ('-e', '--empty'):
            mode = 'empty'

        elif opt  == '--id':
            mode += 'id'
            in_id = arg

        elif opt == '--code':
            mode += 'code'
            code = arg

        elif opt in ('-h', '--help'):
            help()

    if len(optlist) == 0:
        help()

    cursor, conn = connect_db(db_host, db_user, db_passwd)

    if mode == 'all':
        generate_ovewrite_all(cursor)
    elif mode == 'empty':
        generate_not_have(cursor)
    elif mode == 'singleidcode':
        save_code(in_id, code, cursor)
    elif mode == 'singleid':
        generete_single(in_id, cursor)

    conn.commit()

main()