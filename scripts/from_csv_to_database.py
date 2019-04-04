import mysql.connector
import csv

db_host = "localhost"
db_user = "root"
db_passwd = "example"
year = '2019'

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
    file.seek(0)
    section_1_6(csv_file, cursor)
    file.seek(0)
    section_2_1(csv_file, cursor)

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
                insert_complex(cursor, 'researcher', (id, aux_fields['postdoc'][1], row[5], row[6], '2019/01/01', '', 0))

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
    fk_ids = {
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
                fk_ids['researcher'] = cursor.fetchone()[0]
                print(fk_ids)
                insert_complex(cursor, 'intern', (row[1], fk_ids['researcher'], aux_fields['internship_level'][1], row[5], row[6]))


def section_1_5(csv_file, cursor):
    print('Section 1.5 ----')
    lines = (136,20)
    aux_fields = {
        'internship_level':[3,()],
    }
    fk_ids = {
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
                fk_ids['researcher'] = cursor.fetchone()[0]
                insert_complex(cursor, 'intern', (row[1], fk_ids['researcher'], aux_fields['internship_level'][1], row[4], row[5]))

def section_1_6(csv_file, cursor):
    print('Section 1.6 ----')
    lines = (165,10)
    aux_fields = {
        'cnpq_level':[2,()],
    }
    fk_ids = {
        'researcher':0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] - 1 and num < lines[0] - 1 + lines[1]:
            if row[1]:
                print(row)
                for field in aux_fields:
                    aux_fields[field][1] = (insert_aux(cursor, row, field, aux_fields[field][0]))

                #insert productivity scholarship
                cursor.execute('SELECT id FROM scientiometer.researcher_data WHERE name = %s;', row[1:2])
                fk_ids['researcher'] = cursor.fetchone()[0]
                insert_complex(cursor, 'prod_scholarship', (aux_fields['cnpq_level'][1], row[4], row[5], fk_ids['researcher']))

def section_2_1(csv_file, cursor):
    print('Section 2.1 ----')
    lines = (190,60)
    aux_fields = {
        'qualis':[3,()],
        'collab_type':[4,()],
    }
    fk_ids = {
        'lab':0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] - 1 and num < lines[0] - 1 + lines[1]:
            if row[1]:
                print(row)
                for field in aux_fields:
                    aux_fields[field][1] = (insert_aux(cursor, row, field, aux_fields[field][0]))

                #insert productivity scholarship
                #TODO: handle lab and year
                cursor.execute('SELECT id FROM scientiometer.laboratory WHERE laboratory_name = %s;', ['lab 1'])
                fk_ids['lab'] = cursor.fetchone()[0]
                insert_complex(cursor, 'published_work', (row[1], row[2], aux_fields['qualis'][1], fk_ids['lab'], aux_fields['collab_type'][1], year))

def insert_aux(cursor, csv_row, query, csv_row_n):
    inserts = {
        'title':'INSERT INTO `scientiometer`.`title` (`id`, `title`) VALUES (NULL, %s);',
        'role':'INSERT INTO `scientiometer`.`role_foundation_or_pq_level` (`id`, `role_name_or_pq_level`) VALUES (NULL, %s);',
        'postdoc':'INSERT INTO `scientiometer`.`post_doctoral_type` (`id`, `type`) VALUES (NULL, %s);',
        'internship_level':'INSERT INTO `scientiometer`.`internship_level` (`id`, `level`) VALUES (NULL, %s);',
        'scholarhip_agency':'INSERT INTO `scientiometer`.`scholarship_agency` (`id`, `agency`) VALUES (NULL, %s);',
        'cnpq_level':'INSERT INTO `scientiometer`.`cnpq_level` (`id`, `cnpq_level`) VALUES (NULL, %s);',
        'collab_type':'INSERT INTO `scientiometer`.`collaboration_type` (`id`, `collaboration_type`) VALUES (NULL, %s);',
        'qualis':'INSERT INTO `scientiometer`.`qualis` (`id`, `qualis_type`) VALUES (NULL, %s);',

    }
    selects = {
        'title':'SELECT id FROM `scientiometer`.title WHERE title = %s;',
        'role':'SELECT id FROM scientiometer.role_foundation_or_pq_level WHERE role_name_or_pq_level = %s;',
        'postdoc':'SELECT id FROM scientiometer.post_doctoral_type WHERE type = %s;',
        'internship_level':'SELECT id FROM `scientiometer`.`internship_level` WHERE level = %s;',
        'scholarhip_agency':'SELECT id FROM `scientiometer`.`scholarship_agency` WHERE agency = %s;',
        'cnpq_level':'SELECT id FROM `scientiometer`.`cnpq_level` WHERE cnpq_level = %s;',
        'collab_type':'SELECT id FROM `scientiometer`.`collaboration_type` WHERE collaboration_type = %s;',
        'qualis':'SELECT id FROM `scientiometer`.`qualis` WHERE qualis_type = %s;',
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
        #HACK: the connector returns a tuple even for a single result, so we
        #get only the first value
        id = id[0]

    return id

def insert_complex(cursor, table, data):
    inserts = {
        'employee':'INSERT INTO `scientiometer`.`employee` (`id`, `name`, `role_foundation_or_pq_level_id`, `title_id`, `foundation_employee`, `laboratory_id`) VALUES (NULL, %s, %s, %s, %s, %s) ON DUPLICATE KEY UPDATE name = name;',
        'researcher':'INSERT INTO `scientiometer`.`researcher` (`employee_id`, `post_doctoral_type_id`, `researcher_id`, `orcid`, `ingress_date`, `email`, `lab_director`) VALUES (%s, %s, %s, %s, %s, %s, %s) ON DUPLICATE KEY UPDATE researcher_id = researcher_id;',
        'intern':'INSERT INTO `scientiometer`.`intern` (`id`, `name`, `researcher_employee_id`, `internship_level_id`, `validity_start`, `validity_end`) VALUES (NULL, %s, %s, %s, %s, %s);',
        'scholarship':'INSERT INTO `scientiometer`.`scholarship` (`id`, `intern_id`, `scholarship_agency_id`, `process_number`, `total_value_BRL`, `total_value_USD`, `technical_reserve_BRL`, `validity_start`, `validity_end`) VALUES (NULL, %s, %s, %s, %s, %s, %s, %s, %s);',
        'prod_scholarship':'INSERT INTO `scientiometer`.`productivity_scholarship` (`id`, `cnpq_level_id`, `validity_start`, `validity_end`, `granted_researcher_id`) VALUES (NULL, %s, %s, %s, %s);',
        'published_work':'INSERT INTO `scientiometer`.`published_work` (`id`, `doi_url`, `reference`, `qualis_id`, `laboratory_id`, `collaboration_type_id`, `year`) VALUES (NULL, %s, %s, %s, %s, %s, %s);'
    }
    print(data)
    cursor.execute(inserts[table], data)
    return cursor.lastrowid


main()