import mysql.connector
import csv

db_host = "localhost"
db_user = "root"
db_passwd = "example"

abbreviations = {
    'DR':['Doutorado'],
    'MS':['Mestrado'],
    'G':['Graduação'],
    'NM':['Nível Médio'],
    'PDN':['Pós-doutorado Nacional'],
    'PDE':['Pós-doutorado Exterior'],
    'N/A':['Não Possui']
}

def main():
    conn = mysql.connector.connect(
        host=db_host,
        user=db_user,
        passwd=db_passwd
    )
    cursor = conn.cursor()

    ins_title = 'INSERT INTO `scientiometer`.`title` (`id`, `title`) VALUES (NULL, %s);'

    file = open("rel.csv")
    csv_file = csv.reader(file, delimiter=',')

    section_1_1(csv_file, cursor)
    file.seek(0)
    section_1_2(csv_file, cursor)
    file.seek(0)
    section_1_3(csv_file, cursor)
    file.seek(0)
    section_1_4(csv_file, cursor)
    file.seek(0)
    section_1_5(csv_file, cursor)

    conn.commit()
    conn.close()

#TODO: treat laboratory, ingress year and email
def section_1_1(csv_file, cursor):
    print('Section 1.1 ----')
    lines = (14,20)
    aux_fields = {
        'role':[2,()],
        'title':[3,()],
        'postdoc':[4,()],
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] - 1 and num < lines[0] - 1 + lines[1]:
            if row[1]:
                print(row)
                for field in aux_fields:
                    aux_fields[field][1] = (insert_aux(cursor, row, field, aux_fields[field][0]))
                #insert employee
                id = insert_complex(cursor, 'employee', (row[1], aux_fields['role'][1], aux_fields['title'][1], 0, 1))
                #insert researcher
                insert_complex(cursor, 'researcher', (id, aux_fields['postdoc'][1], row[5], row[6], 2019, '', 0))

def section_1_2(csv_file, cursor):
    print('Section 1.2 ----')
    lines = (41,23)
    aux_fields = {
        'role':[2,()],
        'title':[3,()],
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] - 1 and num < lines[0] - 1 + lines[1]:
            if row[1]:
                print(row)
                for field in aux_fields:
                    aux_fields[field][1] = (insert_aux(cursor, row, field, aux_fields[field][0]))
                #insert employee
                insert_complex(cursor, 'employee', (row[1], aux_fields['role'][1], aux_fields['title'][1], 1, 1))

def section_1_3(csv_file, cursor):
    print('Section 1.3 ----')
    lines = (71,10)
    aux_fields = {
        'role':[2,()],
        'title':[3,()],
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] - 1 and num < lines[0] - 1 + lines[1]:
            if row[1]:
                print(row)
                for field in aux_fields:
                    aux_fields[field][1] = (insert_aux(cursor, row, field, aux_fields[field][0]))
                #insert employee
                insert_complex(cursor, 'employee', (row[1], aux_fields['role'][1], aux_fields['title'][1], 0, 1))

def section_1_4(csv_file, cursor):
    print('Section 1.4 ----')
    lines = (88,40)
    aux_fields = {
        'internship_level':[3,()],
    }
    ids = {
        'researcher':0,
        'intern':0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] - 1 and num < lines[0] - 1 + lines[1]:
            if row[1]:
                print(row)
                for field in aux_fields:
                    aux_fields[field][1] = (insert_aux(cursor, row, field, aux_fields[field][0]))

                #insert intern
                cursor.execute('SELECT id FROM scientiometer.researcher_data WHERE name = %s;', row[2:3])
                ids['researcher'] = cursor.fetchone()[0]
                print(ids)
                insert_complex(cursor, 'intern', (row[1], ids['researcher'], aux_fields['internship_level'][1], row[5], row[6]))


def section_1_5(csv_file, cursor):
    print('Section 1.5 ----')
    lines = (136,20)
    aux_fields = {
        'internship_level':[3,()],
    }
    ids = {
        'researcher':0,
        'intern':0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] - 1 and num < lines[0] - 1 + lines[1]:
            if row[1]:
                print(row)
                for field in aux_fields:
                    aux_fields[field][1] = (insert_aux(cursor, row, field, aux_fields[field][0]))

                #insert intern
                cursor.execute('SELECT id FROM scientiometer.researcher_data WHERE name = %s;', row[2:3])
                ids['researcher'] = cursor.fetchone()[0]
                print(ids)
                insert_complex(cursor, 'intern', (row[1], ids['researcher'], aux_fields['internship_level'][1], row[4], row[5]))

def section_1_6(csv_file, cursor):
    print('Section 1.6 ----')
    lines = (136,20)
    aux_fields = {
        'cnpq_level':[2,()],
    }
    ids = {
        'researcher':0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] - 1 and num < lines[0] - 1 + lines[1]:
            if row[1]:
                print(row)
                for field in aux_fields:
                    aux_fields[field][1] = (insert_aux(cursor, row, field, aux_fields[field][0]))

                #insert intern
                cursor.execute('SELECT id FROM scientiometer.researcher_data WHERE name = %s;', row[2:3])
                ids['researcher'] = cursor.fetchone()[0]
                print(ids)
                insert_complex(cursor, 'intern', (row[1], ids['researcher'], aux_fields['internship_level'][1], row[4], row[5]))

def insert_aux(cursor, csv_row, query, csv_row_n):
    inserts = {
        'title':'INSERT INTO `scientiometer`.`title` (`id`, `title`) VALUES (NULL, %s);',
        'role':'INSERT INTO `scientiometer`.`role_foundation_or_pq_level` (`id`, `role_name_or_pq_level`) VALUES (NULL, %s);',
        'postdoc':'INSERT INTO `scientiometer`.`post_doctoral_type` (`id`, `type`) VALUES (NULL, %s);',
        'internship_level':'INSERT INTO `scientiometer`.`internship_level` (`id`, `level`) VALUES (NULL, %s);',
        'scholarhip_agency':'INSERT INTO `scientiometer`.`scholarship_agency` (`id`, `agency`) VALUES (NULL, %s);',
        'cnpq_level':'INSERT INTO `scientiometer`.`cnpq_level` (`id`, `cnpq_level`) VALUES (NULL, %s);'
    }
    selects = {
        'title':'SELECT id FROM `scientiometer`.title WHERE title = %s;',
        'role':'SELECT id FROM scientiometer.role_foundation_or_pq_level WHERE role_name_or_pq_level = %s;',
        'postdoc':'SELECT id FROM scientiometer.post_doctoral_type WHERE type = %s;',
        'internship_level':'SELECT id FROM `scientiometer`.`internship_level` WHERE level = %s;',
        'scholarhip_agency':'SELECT id FROM `scientiometer`.`scholarship_agency` WHERE agency = %s;',
        'cnpq_level':'SELECT id FROM `scientiometer`.`cnpq_level` WHERE cnpq_level = %s;'
    }

    if csv_row[csv_row_n] in abbreviations:
        value = abbreviations[csv_row[csv_row_n]]
    else:
        value = [csv_row[csv_row_n]]

    print(value)

    cursor.execute(selects[query], value)

    id = cursor.fetchone()
    if id == None:
        cursor.execute(inserts[query], value)
        id = cursor.lastrowid
    else:
        id = id[0]

    return id

def insert_complex(cursor, table, data):
    inserts = {
        'employee':'INSERT INTO `scientiometer`.`employee` (`id`, `name`, `role_foundation_or_pq_level_id`, `title_id`, `foundation_employee`, `laboratory_id`) VALUES (NULL, %s, %s, %s, %s, %s) ON DUPLICATE KEY UPDATE name = name;',
        'researcher':'INSERT INTO `scientiometer`.`researcher` (`employee_id`, `post_doctoral_type_id`, `researcher_id`, `orcid`, `ingress_year`, `email`, `lab_director`) VALUES (%s, %s, %s, %s, %s, %s, %s) ON DUPLICATE KEY UPDATE researcher_id = researcher_id;',
        'intern':'INSERT INTO `scientiometer`.`intern` (`id`, `name`, `researcher_employee_id`, `internship_level_id`, `validity_start`, `validity_end`) VALUES (NULL, %s, %s, %s, %s, %s);',
        'scholarship':'INSERT INTO `scientiometer`.`scholarship` (`id`, `intern_id`, `scholarship_agency_id`, `process_number`, `total_value_BRL`, `total_value_USD`, `technical_reserve_BRL`, `validity_start`, `validity_end`) VALUES (NULL, %s, %s, %s, %s, %s, %s, %s, %s);',
    }
    print(data)
    cursor.execute(inserts[table], data)
    return cursor.lastrowid


main()