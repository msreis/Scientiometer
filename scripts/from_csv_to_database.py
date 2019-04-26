#!/bin/python3

import mysql.connector
import csv
import sys
import re
import datetime as dt
import getopt

db_host = "localhost"
db_user = "root"
db_passwd = "example"

# There will be several files per year, so we update this once the year group o
# files changes
year = '2019'

# Each file is for a different lab, so we just update this variable based on the
# file opened
lab_name = ['lab 1', 0]
lab_div = 'div 1'

abbreviations = {
    #     'DR': ['Doutorado'],
    #     'MS': ['Mestrado'],
    #     'G': ['Graduação'],
    #     'NM': ['Nível Médio'],
    #     'PDN': ['Pós-doutorado Nacional'],
    #     'PDE': ['Pós-doutorado Exterior'],
    #     'N/A': ['Não Possui'],
    #     'T':['Técnico Nível Médio'],
    #     'IC':['Iniciação Científica'],
    #     'PD': ['Pós-doutorado'],
    #     'AP':['Aperfeiçoamento'],
    #     'TT1':['Treinamento Técnico 1'],
    #     'TT2':['Treinamento Técnico 2'],
    #     'TT3':['Treinamento Técnico 3'],
    #     'TT4':['Treinamento Técnico 4'],
    #     'TT5':['Treinamento Técnico 5'],
    #     'PM':['Palestra Magna'],
    #     'CO':['Comunicação Oral'],
    #     'AP':['Poster'],
    #     'CS':['Coordenação de Seção'],
    #     'MR':['Mesa Redonda'],
    #     'CE':['Coordenação do Evento'],
    #     'TCC':['Trabalho de Conclusão de Curso'],
    #     'E':['Extensão Uniersitária'],
    #     'D':['Difusão'],
    #     'I':['Publico Geral'],
    #     'II':['Graduandos'],
    #     'III':['Pós-graduandos'],
}

# We need to seek the file in each section
file = None

outfile = None


def main():
    try:
        optlist, args = getopt.gnu_getopt(
            sys.argv[1:], 'y:f:l:d:h', ['year=', 'file=', 'lab=', 'div=', 'delimiter=', 'help'])

    except getopt.GetoptError as err:
        print(err)

    global year
    global lab_name
    global lab_div
    global file
    global outfile

    delim = '|'

    for opt, arg in optlist:
        if opt in ('-y', '--year'):
            year = arg

        elif opt in ('-f', '--file'):
            file_name = arg
            outfile = open(file_name + '_script.sql', 'w+')

        elif opt in ('-l', '--lab'):
            lab_name[0] = arg

        elif opt in ('-d', '--delimiter'):
            delim = arg

        elif opt == '--div':
            lab_div = arg
        elif opt in ('-h', '--help'):
            print('Usage: script.py [-y | --year] <year> [-f | --file] <file>\
[-l| --lab] <lab name> [--div] <lab division> [-d | --delimiter]\
<csv delimiter> [-h | --help]')
            sys.exit(2)

    conn = mysql.connector.connect(
        host=db_host,
        user=db_user,
        passwd=db_passwd
    )
    cursor = conn.cursor()

    file = open(file_name)
    csv_file = csv.reader(file, delimiter=delim)

    section_1_1(csv_file, cursor)
    section_1_2(csv_file, cursor)
    section_1_3(csv_file, cursor)
    section_1_4(csv_file, cursor)
    section_1_5(csv_file, cursor)
    section_1_6(csv_file, cursor)
    section_2_1(csv_file, cursor)
    section_2_2(csv_file, cursor)
    section_2_3(csv_file, cursor)
    section_2_4(csv_file, cursor)
    section_2_5(csv_file, cursor)
    section_2_6(csv_file, cursor)
    section_2_7(csv_file, cursor)
    section_2_8(csv_file, cursor)
    section_3_1(csv_file, cursor)
    section_3_2(csv_file, cursor)
    section_3_3(csv_file, cursor)
    section_3_4(csv_file, cursor)
    section_3_5(csv_file, cursor)
    section_4_1(csv_file, cursor)
    section_4_2(csv_file, cursor)
    section_4_3(csv_file, cursor)
    section_5_1(csv_file, cursor)
    section_5_2(csv_file, cursor)
    section_5_3(csv_file, cursor)
    section_5_4(csv_file, cursor)
    section_6_0(csv_file, cursor)

    conn.commit()
    conn.close()


def section_1_1(csv_file, cursor):
    file.seek(0)
    print('Section 1.1 ----')
    lines = locate_table(csv_file, '1.1.')
    file.seek(0)
    aux_fields = {
        'role': [2, 0],
        'title': [3, 0],
        'postdoc': [4, 0],
    }
    fk_ids = {
        'lab_div': 0,
        'lab': 0,
        'employee': 0
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] and num < lines[0] + lines[1]:
            if row[1]:
                print(row)
                for field in aux_fields:
                    aux_fields[field][1] = (insert_aux(
                        cursor, field, row[aux_fields[field][0]]))

                # insert laboratory is a special case
                fk_ids['lab_div'] = insert_aux(cursor, 'lab_div', lab_div)
                cursor.execute(
                    'SELECT id FROM scientiometer.laboratory WHERE laboratory_name = %s LIMIT 1;', lab_name[0:1])
                fk_ids['lab'] = cursor.fetchone()
                if fk_ids['lab'] == None:
                    fk_ids['lab'] = insert_complex(
                        cursor, 'laboratory', (lab_name[0], fk_ids['lab_div']))
                else:
                    fk_ids['lab'] = fk_ids['lab'][0]
                lab_name[1] = fk_ids['lab']

                # TODO: handle email and code

                # Handle if is a state employee
                is_state = row[2] == 'I' or row[2] == 'II' or row[2] == 'III' or row[2] == 'IV' or row[2] == 'V' or row[2] == 'VI'

                # Handle ingress date
                if is_state and row[7] != '':
                    date_admission = dt.datetime.strptime(row[7], '%Y-%m-%d')
                else:
                    # date_admission = dt.datetime.strptime(row[15], '%d/%m/%Y')
                    date_admission = None

                # insert employee
                fk_ids['employee'] = insert_complex(
                    cursor, 'employee', (row[1], aux_fields['role'][1], aux_fields['title'][1], is_state, fk_ids['lab']))

                # insert researcher
                insert_complex(
                    cursor, 'researcher', (fk_ids['employee'], aux_fields['postdoc'][1], row[5], row[6], date_admission, '', 0))


def section_1_2(csv_file, cursor):
    file.seek(0)
    print('Section 1.2 ----')
    lines = locate_table(csv_file, '1.2.')
    aux_fields = {
        'role': [2, 0],
        'title': [3, 0],
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] and num < lines[0] + lines[1]:
            if row[1]:
                print(row)
                for field in aux_fields:
                    aux_fields[field][1] = (insert_aux(
                        cursor, field, row[aux_fields[field][0]]))
                # insert employee
                insert_complex(
                    cursor, 'employee', (row[1], aux_fields['role'][1], aux_fields['title'][1], 1, lab_name[1]))


def section_1_3(csv_file, cursor):
    file.seek(0)
    print('Section 1.3 ----')
    lines = locate_table(csv_file, '1.3.')
    aux_fields = {
        'role': [2, 0],
        'title': [3, 0],
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] and num < lines[0] + lines[1]:
            if row[1]:
                print(row)
                for field in aux_fields:
                    aux_fields[field][1] = (insert_aux(
                        cursor, field, row[aux_fields[field][0]]))
                # insert employee
                insert_complex(
                    cursor, 'employee', (row[1], aux_fields['role'][1], aux_fields['title'][1], 0, lab_name[1]))


def section_1_4(csv_file, cursor):
    file.seek(0)
    print('Section 1.4 ----')
    lines = locate_table(csv_file, '1.4.')
    aux_fields = {
        'internship_level': [3, 0],
        'intern': [1, 0],
    }
    fk_ids = {
        'researcher': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] and num < lines[0] + lines[1]:
            if row[1]:
                print(row)
                for field in aux_fields:
                    aux_fields[field][1] = (insert_aux(
                        cursor, field, row[aux_fields[field][0]]))

                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s LIMIT 1;', row[2:3])
                fk_ids['researcher'] = cursor.fetchone()[0]

                insert_complex(cursor, 'advising', (
                    aux_fields['intern'][1], fk_ids['researcher'], aux_fields['internship_level'][1], row[5], row[6]))


def section_1_5(csv_file, cursor):
    file.seek(0)
    print('Section 1.5 ----')
    lines = locate_table(csv_file, '1.5.')
    aux_fields = {
        'internship_level': [3, 0],
        'intern': [1, 0],
    }
    fk_ids = {
        'researcher': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] and num < lines[0] + lines[1]:
            if row[1]:
                print(row)
                for field in aux_fields:
                    aux_fields[field][1] = (insert_aux(
                        cursor, field, row[aux_fields[field][0]]))

                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s LIMIT 1;', row[2:3])
                fk_ids['researcher'] = cursor.fetchone()[0]

                insert_complex(cursor, 'advising', (
                    aux_fields['intern'][1], fk_ids['researcher'], aux_fields['internship_level'][1], row[4], row[5]))


def section_1_6(csv_file, cursor):
    file.seek(0)
    print('Section 1.6 ----')
    lines = locate_table(csv_file, '1.6.')
    aux_fields = {
        'cnpq_level': [3, 0],
    }
    fk_ids = {
        'researcher': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] and num < lines[0] + lines[1]:
            if row[1]:
                print(row)
                for field in aux_fields:
                    aux_fields[field][1] = (insert_aux(
                        cursor, field, row[aux_fields[field][0]]))

                # insert productivity scholarship
                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s LIMIT 1;', row[1:2])
                fk_ids['researcher'] = cursor.fetchone()[0]
                insert_complex(cursor, 'prod_scholarship',
                               (aux_fields['cnpq_level'][1], row[6], row[4], row[5], fk_ids['researcher']))


def section_2_1(csv_file, cursor):
    file.seek(0)
    print('Section 2.1 ----')
    lines = locate_table(csv_file, '2.1.')
    aux_fields = {
        'qualis': [3, 0],
        'collab_type': [4, 0],
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] and num < lines[0] + lines[1]:
            if row[1]:
                print(row)
                for field in aux_fields:
                    aux_fields[field][1] = (insert_aux(
                        cursor, field, row[aux_fields[field][0]]))

                # Handle empty as null
                if row[5] == '':
                    impact_factor = None
                else:
                    impact_factor = row[5]

                insert_complex(cursor, 'published_work', (
                    row[1], row[2], aux_fields['qualis'][1], lab_name[1], aux_fields['collab_type'][1], impact_factor, year))


def section_2_2(csv_file, cursor):
    file.seek(0)
    print('Section 2.2 ----')
    lines = locate_table(csv_file, '2.2.')
    aux_fields = {
        'collab_type': [4, 0],
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] and num < lines[0] + lines[1]:
            if row[1]:
                print(row)
                for field in aux_fields:
                    aux_fields[field][1] = (insert_aux(
                        cursor, field, row[aux_fields[field][0]]))

                insert_complex(cursor, 'published_book',
                               (row[1], row[2], row[3], row[4], lab_name[1], year))


def section_2_3(csv_file, cursor):
    file.seek(0)
    print('Section 2.3 ----')
    lines = locate_table(csv_file, '2.3.')
    fk_ids = {
        'researcher': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] and num < lines[0] + lines[1]:
            if row[1]:
                print(row)

                for col, _ in enumerate(row):
                    if row[col] == '':
                        row[col] = 0

                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s LIMIT 1;', row[1:2])
                fk_ids['researcher'] = cursor.fetchone()[0]
                insert_complex(
                    cursor, 'article_prod', (fk_ids['researcher'], row[2], row[3], row[4], row[5], row[6], year))


def section_2_4(csv_file, cursor):
    file.seek(0)
    print('Section 2.4 ----')
    lines = locate_table(csv_file, '2.4.')
    aux_fields = {
        'funding_agency': [4, 0],
    }
    fk_ids = {
        'researcher': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] and num < lines[0] + lines[1]:
            if row[1]:
                print(row)
                aux_fields['funding_agency'][1] = insert_aux(
                    cursor, 'funding_agency', 'FAPESP')

                for col, _ in enumerate(row):
                    if row[col] == '':
                        row[col] = 0

                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s LIMIT 1;', row[1:2])
                fk_ids['researcher'] = cursor.fetchone()[0]
                insert_complex(cursor, 'article_student_postdoc', (
                    fk_ids['researcher'], aux_fields['funding_agency'][1], row[2], row[3], row[4], row[5], row[6], year))


def section_2_5(csv_file, cursor):
    file.seek(0)
    print('Section 2.5 ----')
    lines = locate_table(csv_file, '2.5.')
    aux_fields = {
        'funding_agency': [4, 0],
    }
    fk_ids = {
        'researcher': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] and num < lines[0] + lines[1]:
            if row[1]:
                print(row)
                aux_fields['funding_agency'][1] = insert_aux(
                    cursor, 'funding_agency', 'CAPES')

                for col, _ in enumerate(row):
                    if row[col] == '':
                        row[col] = 0

                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s LIMIT 1;', row[1:2])
                fk_ids['researcher'] = cursor.fetchone()[0]
                insert_complex(cursor, 'article_student_postdoc', (
                    fk_ids['researcher'], aux_fields['funding_agency'][1], row[2], row[3], row[4], row[5], row[6], year))


def section_2_6(csv_file, cursor):
    file.seek(0)
    print('Section 2.6 ----')
    lines = locate_table(csv_file, '2.6.')
    aux_fields = {
        'funding_agency': [4, 0, 0],
    }
    fk_ids = {
        'researcher': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] and num < lines[0] + lines[1]:
            if row[1]:
                print(row)
                aux_fields['funding_agency'][1] = insert_aux(
                    cursor, 'funding_agency', 'CNPq')
                aux_fields['funding_agency'][2] = insert_aux(
                    cursor, 'funding_agency', 'FB')

                for col, _ in enumerate(row):
                    if row[col] == '':
                        row[col] = 0

                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s LIMIT 1;', row[1:2])
                fk_ids['researcher'] = cursor.fetchone()[0]

                # HACK: insert two rows, one for foundation and one for CNPq
                insert_complex(cursor, 'article_student_postdoc', (
                    fk_ids['researcher'], aux_fields['funding_agency'][1], row[2], row[3], row[5], row[6], row[7], year))

                insert_complex(cursor, 'article_student_postdoc', (
                    fk_ids['researcher'], aux_fields['funding_agency'][2], row[2], row[4], row[5], row[6], row[7], year))


def section_2_7(csv_file, cursor):
    file.seek(0)
    print('Section 2.7 ----')
    lines = locate_table(csv_file, '2.7.')
    aux_fields = {
        'line_research': [4, 0, 0],
    }
    fk_ids = {
        'researcher': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] and num < lines[0] + lines[1]:
            if row[1]:
                print(row)
                aux_fields['line_research'][1] = insert_aux(
                    cursor, 'line_research', row[6])
                aux_fields['line_research'][2] = insert_aux(
                    cursor, 'line_research', row[7])

                for col, _ in enumerate(row[2:6]):
                    if row[col] == '':
                        row[col] = None

                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s LIMIT 1;', row[1:2])
                fk_ids['researcher'] = cursor.fetchone()[0]
                insert_complex(cursor, 'scientometric', (
                    fk_ids['researcher'],  row[2], row[3], row[4], row[5], aux_fields['line_research'][1], aux_fields['line_research'][2], year))


def section_2_8(csv_file, cursor):
    file.seek(0)
    print('Section 2.8 ----')
    lines = locate_table(csv_file, '2.8.')
    aux_fields = {
        'participation_role': [4, 0, 0, 0],
    }
    fk_ids = {
        'researcher': 0,
        'congress': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] and num < lines[0] + lines[1]:
            if row[1]:
                print(row)

                # Every participation type we insert as a separate participation
                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s LIMIT 1;', row[1:2])
                fk_ids['researcher'] = cursor.fetchone()[0]
                fk_ids['congress'] = insert_complex(
                    cursor, 'congress', (row[2], row[3]))
                for i in range(3):
                    if row[4 + i] != '':
                        aux_fields['participation_role'][1 + i] = insert_aux(
                            cursor, 'participation_role', row[4 + i])
                        insert_complex(cursor, 'participation_congress', (
                            fk_ids['congress'], fk_ids['researcher'], aux_fields['participation_role'][1 + i], year))


def section_3_1(csv_file, cursor):
    file.seek(0)
    print('Section 3.1 ----')
    lines = locate_table(csv_file, '3.1.')
    aux_fields = {
        'institution': [3, 0],
        'supervision_type': [4, 0],
    }
    fk_ids = {
        'researcher': 0,
        'student': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] and num < lines[0] + lines[1]:
            if row[1]:
                print(row)
                for field in aux_fields:
                    aux_fields[field][1] = (insert_aux(
                        cursor, field, row[aux_fields[field][0]]))

                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s LIMIT 1;', row[2:3])
                fk_ids['researcher'] = cursor.fetchone()[0]


                cursor.execute(
                    'SELECT id FROM scientiometer.intern WHERE name = %s LIMIT 1;', row[1:2])
                print(cursor.statement)
                fk_ids['student'] = cursor.fetchone()[0]

                insert_complex(cursor, 'supervision', (
                    fk_ids['student'], fk_ids['researcher'], aux_fields['institution'][1], aux_fields['supervision_type'][1], year))



#TODO: fix program name and institution separation
def section_3_2(csv_file, cursor):
    file.seek(0)
    print('Section 3.2 ----')
    lines = locate_table(csv_file, '3.2.')
    aux_fields = {
        'institution': [2, 0],
        'postgraduate_level': [3, 0],
        'postgraduate_program': [2, 0],
    }
    fk_ids = {
        'researcher': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] and num < lines[0] + lines[1]:
            if row[1]:
                print(row)
                # Separates program from institution from same field in csv.
                # Also handles names containing '-' and names without institution
                program = row[aux_fields['postgraduate_program'][0]].split('-')[0:-1]\
                    or row[aux_fields['postgraduate_program'][0]].split('-')[0]
                program = '-'.join(program).strip()

                aux_fields['institution'][1] = (insert_aux(
                    cursor, 'institution', row[aux_fields['institution'][0]].split('-')[-1].strip()))

                aux_fields['postgraduate_program'][1] = (insert_aux(
                    cursor, 'postgraduate_program', program))

                aux_fields['postgraduate_level'][1] = (insert_aux(
                    cursor, 'postgraduate_level', row[aux_fields['postgraduate_level'][0]]))

                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s LIMIT 1;', row[1:2])
                fk_ids['researcher'] = cursor.fetchone()[0]
                insert_complex(cursor, 'postgrad_supervision', (fk_ids['researcher'], aux_fields['postgraduate_level']
                                                                [1], aux_fields['postgraduate_program'][1], aux_fields['institution'][1], year))


def section_3_3(csv_file, cursor):
    file.seek(0)
    print('Section 3.3 ----')
    lines = locate_table(csv_file, '3.3.')
    aux_fields = {
        'institution': [2, 0],
        'postgraduate_program': [2, 0],
    }
    fk_ids = {
        'researcher': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] and num < lines[0] + lines[1]:
            if row[1]:
                print(row)
                # Separates program from institution from same field in csv.
                # Also handles names containing '-' and names without institution
                program = row[aux_fields['postgraduate_program'][0]].split(' - ')[0:-1]\
                    or row[aux_fields['postgraduate_program'][0]].split(' - ')[0]
                program = '-'.join(program).strip()

                institution = row[aux_fields['institution']
                                  [0]].split(' - ')[-1].strip()
                if institution == '':
                    institution = row[3]

                aux_fields['institution'][1] = (insert_aux(
                    cursor, 'institution', institution))

                aux_fields['postgraduate_program'][1] = (insert_aux(
                    cursor, 'postgraduate_program', program))

                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s LIMIT 1;', row[1:2])
                fk_ids['researcher'] = cursor.fetchone()[0]
                insert_complex(cursor, 'postgrad_ministered', (
                    fk_ids['researcher'], aux_fields['postgraduate_program'][1], row[4], row[3], aux_fields['institution'][1], year))


def section_3_4(csv_file, cursor):
    file.seek(0)
    print('Section 3.4 ----')
    lines = locate_table(csv_file, '3.4.')
    aux_fields = {
        'institution': [2, 0],
        'postgraduate_program': [2, 0],
    }
    fk_ids = {
        'researcher': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] and num < lines[0] + lines[1]:
            if row[1]:
                print(row)
                # Separates program from institution from same field in csv.
                # Also handles names containing '-' and names without institution
                program = row[aux_fields['postgraduate_program'][0]].split(' - ')[0:-1]\
                    or row[aux_fields['postgraduate_program'][0]].split(' - ')[0]
                program = '-'.join(program).strip()

                institution = row[aux_fields['institution']
                                  [0]].split(' - ')[-1].strip()
                if institution == '':
                    institution = row[3]

                aux_fields['institution'][1] = (insert_aux(
                    cursor, 'institution', institution))

                aux_fields['postgraduate_program'][1] = (insert_aux(
                    cursor, 'postgraduate_program', program))

                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s LIMIT 1;', row[1:2])
                fk_ids['researcher'] = cursor.fetchone()[0]
                insert_complex(cursor, 'lectures', (
                    fk_ids['researcher'], aux_fields['postgraduate_program'][1], aux_fields['institution'][1], row[4], row[5],  year))


def section_3_5(csv_file, cursor):
    file.seek(0)
    print('Section 3.5 ----')
    lines = locate_table(csv_file, '3.5.')
    aux_fields = {
        'course_level': [3, 0],
        'course_classification': [4, 0],
    }
    fk_ids = {
        'researcher': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] and num < lines[0] + lines[1]:
            if row[1]:
                print(row)
                for field in aux_fields:
                    aux_fields[field][1] = (insert_aux(
                        cursor, field, row[aux_fields[field][0]]))

                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s LIMIT 1;', row[1:2])
                fk_ids['researcher'] = cursor.fetchone()[0]
                insert_complex(cursor, 'coordination_course', (
                    fk_ids['researcher'], row[2], aux_fields['course_level'][1], aux_fields['course_classification'][1], row[5], year))


def section_4_1(csv_file, cursor):
    file.seek(0)
    print('Section 4.1 ----')
    lines = locate_table(csv_file, '4.1.')
    aux_fields = {
        'project_type': [2, 0],
        'participation_type': [3, 0],
        'funding_agency': [4, 0],
    }
    fk_ids = {
        'researcher': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] and num < lines[0] + lines[1]:
            if row[1]:
                print(row)
                for field in aux_fields:
                    aux_fields[field][1] = (insert_aux(
                        cursor, field, row[aux_fields[field][0]]))

                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s LIMIT 1;', row[1:2])
                fk_ids['researcher'] = cursor.fetchone()[0]
                insert_complex(cursor, 'active_grant', (fk_ids['researcher'], aux_fields['project_type'][1],
                                                      aux_fields['participation_type'][1], aux_fields['funding_agency'][1], row[5], row[6], row[7]))


def section_4_2(csv_file, cursor):
    file.seek(0)
    print('Section 4.2 ----')
    lines = locate_table(csv_file, '4.2.')
    aux_fields = {
        'funding_agency': [4, 0],
    }
    fk_ids = {
        'researcher': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] and num < lines[0] + lines[1]:
            if row[1]:
                print(row)
                for field in aux_fields:
                    aux_fields[field][1] = (insert_aux(
                        cursor, field, row[aux_fields[field][0]]))

                for col, _ in enumerate(row):
                    if row[col] == '':
                        row[col] = 0
                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s LIMIT 1;', row[1:2])
                fk_ids['researcher'] = cursor.fetchone()[0]

                new_process = row[2] == 'Processo novo'

                insert_complex(cursor, 'contracted_value', (
                    fk_ids['researcher'], new_process, row[3], aux_fields['funding_agency'][1], row[5], row[6], row[7], year))


def section_4_3(csv_file, cursor):
    file.seek(0)
    print('Section 4.3 ----')
    lines = locate_table(csv_file, '4.3.')
    aux_fields = {
        'funding_agency': [4, 0],
    }
    fk_ids = {
        'researcher': 0,
        'intern': [],
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] and num < lines[0] + lines[1]:
            if row[1]:
                print(row)
                for field in aux_fields:
                    aux_fields[field][1] = (insert_aux(
                        cursor, field, row[aux_fields[field][0]]))

                for col, _ in enumerate(row):
                    if row[col] == '':
                        row[col] = 0

                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s LIMIT 1;', row[2:3])
                fk_ids['researcher'] = cursor.fetchone()[0]

                cursor.execute(
                    'SELECT id FROM scientiometer.intern WHERE name = %s LIMIT 1;', row[1:2])
                print(cursor.statement)
                fk_ids['intern'] = cursor.fetchone()[0]

                insert_complex(cursor, 'scholarship', (
                    aux_fields['funding_agency'][1], fk_ids['researcher'], fk_ids['intern'], row[3], row[5], row[6], row[7], year))


def section_5_1(csv_file, cursor):
    file.seek(0)
    print('Section 5.1 ----')
    lines = locate_table(csv_file, '5.1.')
    fk_ids = {
        'researcher': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] and num < lines[0] + lines[1]:
            if row[1]:
                print(row)

                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s LIMIT 1;', row[1:2])
                fk_ids['researcher'] = cursor.fetchone()[0]

                if row[3] == '':
                    row[3] = None

                insert_complex(cursor, 'institutional_activity',
                               (fk_ids['researcher'], row[2], row[3], year))


def section_5_2(csv_file, cursor):
    file.seek(0)
    print('Section 5.2 ----')
    lines = locate_table(csv_file, '5.2.')
    fk_ids = {
        'researcher': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] and num < lines[0] + lines[1]:
            if row[1]:
                print(row)

                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s LIMIT 1;', row[1:2])
                fk_ids['researcher'] = cursor.fetchone()[0]

                if row[3] == '':
                    row[3] = None

                insert_complex(cursor, 'cultural_activity',
                               (fk_ids['researcher'], row[2], row[3], year))


def section_5_3(csv_file, cursor):
    file.seek(0)
    print('Section 5.3 ----')
    lines = locate_table(csv_file, '5.3.')
    fk_ids = {
        'researcher': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] and num < lines[0] + lines[1]:
            if row[1]:
                print(row)

                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s LIMIT 1;', row[1:2])
                fk_ids['researcher'] = cursor.fetchone()[0]

                if row[3] == '':
                    row[3] = None

                insert_complex(cursor, 'innovation_activity',
                               (fk_ids['researcher'], row[2], row[3], year))


def section_5_4(csv_file, cursor):
    file.seek(0)
    print('Section 5.4 ----')
    lines = locate_table(csv_file, '5.4.')
    fk_ids = {
        'researcher': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] and num < lines[0] + lines[1]:
            if row[1]:
                print(row)

                if row[3] == '':
                    row[3] = None

                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s LIMIT 1;', row[1:2])
                fk_ids['researcher'] = cursor.fetchone()[0]

                insert_complex(cursor, 'service_provision',
                               (fk_ids['researcher'], row[2], row[3], year))


def section_6_0(csv_file, cursor):
    file.seek(0)
    print('Section 6.0 ----')
    lines = locate_table(csv_file, '6 – ')
    fk_ids = {
        'researcher': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] and num < lines[0] + lines[1]:
            if row[1]:
                print(row)

                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s LIMIT 1;', row[1:2])
                fk_ids['researcher'] = cursor.fetchone()[0]

                insert_complex(
                    cursor, 'note', (fk_ids['researcher'], row[2], year))


def insert_aux(cursor, query, data):
    inserts = {
        'title': 'INSERT INTO `scientiometer`.`title` (`id`, `title`) VALUES (NULL, %s);',
        'role': 'INSERT INTO `scientiometer`.`role_foundation_or_pq_level` (`id`, `role_name_or_pq_level`) VALUES (NULL, %s);',
        'postdoc': 'INSERT INTO `scientiometer`.`post_doctoral_type` (`id`, `type`) VALUES (NULL, %s);',
        'internship_level': 'INSERT INTO `scientiometer`.`internship_level` (`id`, `level`) VALUES (NULL, %s);',
        'cnpq_level': 'INSERT INTO `scientiometer`.`cnpq_level` (`id`, `cnpq_level`) VALUES (NULL, %s);',
        'collab_type': 'INSERT INTO `scientiometer`.`collaboration_type` (`id`, `collaboration_type`) VALUES (NULL, %s);',
        'qualis': 'INSERT INTO `scientiometer`.`qualis` (`id`, `qualis_type`) VALUES (NULL, %s);',
        'lab_div': 'INSERT INTO `scientiometer`.`lab_division` (`id`, `division_name`) VALUES (NULL, %s);',
        'line_research': 'INSERT INTO `scientiometer`.`line_of_research` (`id`, `line_of_research`) VALUES (NULL, %s);',
        'participation_role': 'INSERT INTO `scientiometer`.`participation_role` (`id`, `role_description`) VALUES (NULL, %s);',
        'institution': 'INSERT INTO `scientiometer`.`institution` (`id`, `institution_name`) VALUES (NULL, %s);',
        'supervision_type': 'INSERT INTO `scientiometer`.`supervision_type` (`id`, `type_description`) VALUES (NULL, %s);',
        'postgraduate_program': 'INSERT INTO `scientiometer`.`postgraduate_program` (`id`, `program_name`) VALUES (NULL, %s);',
        'postgraduate_level': 'INSERT INTO `scientiometer`.`postgraduate_level` (`id`, `level`) VALUES (NULL, %s);',
        'course_level': 'INSERT INTO `scientiometer`.`course_level` (`id`, `course_level`) VALUES (NULL, %s);',
        'course_classification': 'INSERT INTO `scientiometer`.`course_classification` (`id`, `classification`) VALUES (NULL, %s);',
        'project_type': 'INSERT INTO `scientiometer`.`project_type` (`id`, `project_type`) VALUES (NULL, %s);',
        'funding_agency': 'INSERT INTO `scientiometer`.`funding_agency` (`id`, `agency_name`) VALUES (NULL, %s);',
        'participation_type': 'INSERT INTO `scientiometer`.`participation_type` (`id`, `participation_type`) VALUES (NULL, %s);',
        'intern': 'INSERT INTO `scientiometer`.`intern` (`id`, `name`) VALUES (NULL, %s);',
    }
    selects = {
        'title': 'SELECT id FROM `scientiometer`.title WHERE title = %s;',
        'role': 'SELECT id FROM scientiometer.role_foundation_or_pq_level WHERE role_name_or_pq_level = %s;',
        'postdoc': 'SELECT id FROM scientiometer.post_doctoral_type WHERE type = %s;',
        'internship_level': 'SELECT id FROM `scientiometer`.`internship_level` WHERE level = %s;',
        'cnpq_level': 'SELECT id FROM `scientiometer`.`cnpq_level` WHERE cnpq_level = %s;',
        'collab_type': 'SELECT id FROM `scientiometer`.`collaboration_type` WHERE collaboration_type = %s;',
        'qualis': 'SELECT id FROM `scientiometer`.`qualis` WHERE qualis_type = %s;',
        'lab_div': 'SELECT id FROM `scientiometer`.`lab_division` WHERE division_name = %s;',
        'line_research': 'SELECT id FROM `scientiometer`.`line_of_research` WHERE line_of_research = %s;',
        'participation_role': 'SELECT id FROM `scientiometer`.`participation_role` WHERE role_description =  %s;',
        'institution': 'SELECT id FROM `scientiometer`.`institution` WHERE institution_name = %s;',
        'supervision_type': 'SELECT id FROM `scientiometer`.`supervision_type` WHERE type_description = %s;',
        'postgraduate_program': 'SELECT id FROM `scientiometer`.`postgraduate_program` WHERE program_name = %s;',
        'postgraduate_level': 'SELECT id FROM `scientiometer`.`postgraduate_level` WHERE level = %s;',
        'course_level': 'SELECT id FROM `scientiometer`.`course_level` WHERE course_level = %s;',
        'course_classification': 'SELECT id FROM `scientiometer`.`course_classification` WHERE classification = %s;',
        'project_type': 'SELECT id FROM `scientiometer`.`project_type` WHERE project_type = %s;',
        'funding_agency': 'SELECT id FROM `scientiometer`.`funding_agency` WHERE agency_name = %s;',
        'participation_type': 'SELECT id FROM `scientiometer`.`participation_type` WHERE participation_type = %s;',
        'intern': 'SELECT id FROM `scientiometer`.`intern` WHERE name = %s;',
    }

    if data in abbreviations:
        value = abbreviations[data]
    else:
        value = [data]

    print(value)

    cursor.execute(selects[query], value)

    id = cursor.fetchone()
    if id == None:
        try:
            cursor.execute(inserts[query], value)
        except Exception as e:
            print("==============ERROR=================")
            print("Failed to insert a ROW")
            print(e, file=sys.stderr)
            print("==============ERROR=================")
            cursor._connection.rollback()
            exit(1)

        outfile.write(cursor.statement + '\n')
        id = cursor.lastrowid
    else:
        # HACK: the connector returns a tuple even for a single result, so we
        # get only the first value
        id = id[0]

    return id


def insert_complex(cursor, table, data):
    inserts = {
        'employee': 'INSERT INTO `scientiometer`.`employee` (`id`, `name`, `role_foundation_or_pq_level_id`, `title_id`, `foundation_employee`, `laboratory_id`) VALUES (NULL, %s, %s, %s, %s, %s);',
        'researcher': 'INSERT INTO `scientiometer`.`researcher` (`employee_id`, `post_doctoral_type_id`, `researcher_id`, `orcid`, `ingress_date`, `email`, `lab_director`) VALUES (%s, %s, %s, %s, %s, %s, %s);',
        'prod_scholarship': 'INSERT INTO `scientiometer`.`productivity_scholarship` (`id`, `cnpq_level_id`, `fb_level`, `validity_start`, `validity_end`, `granted_researcher_id`) VALUES (NULL, %s, %s, %s, %s, %s);',
        'published_work': 'INSERT INTO `scientiometer`.`published_work` (`id`, `doi_url`, `reference`, `qualis_id`, `laboratory_id`, `collaboration_type_id`, `impact_factor`, `year`) VALUES (NULL, %s, %s, %s, %s, %s, %s, %s);',
        'laboratory': 'INSERT INTO `scientiometer`.`laboratory` (`id`, `laboratory_name`, `lab_division_id`) VALUES (NULL, %s, %s);',
        'published_book': 'INSERT INTO `scientiometer`.`book_chapter_published` (`id`, `doi_url`, `isbn_online`, `isbn_print`, `reference`, `laboratory_id`, `year`) VALUES (NULL, %s, %s, %s, %s, %s, %s);',
        'article_prod': 'INSERT INTO `scientiometer`.`article_production` (`id`, `researcher_employee_id`, `n_total_publications`, `n_intl_collab`, `n_first_author`, `n_corresponding_author`, `n_last_author`, `year`) VALUES (NULL, %s, %s, %s, %s, %s, %s, %s);',
        'article_student_postdoc': 'INSERT INTO `scientiometer`.`article_student_postdoc` (`id`, `researcher_employee_id`, `funding_agency_id`, `n_intl_collab`, `n_sci_initiation`, `n_msc_student`, `n_doc_student`, `n_postdoc`, `year`) VALUES (NULL, %s, %s, %s, %s, %s, %s, %s, %s);',
        'scientometric': 'INSERT INTO `scientiometer`.`scientometric_index` (`id`, `researcher_employee_id`, `n_citations_wos`, `h_index_wos`, `n_citations_gs`, `h_index_gs`, `main_line_of_research_id`, `secondary_line_of_research_id`, `year`) VALUES (NULL, %s, %s, %s, %s, %s, %s, %s, %s);',
        'congress': 'INSERT INTO `scientiometer`.`congress` (`id`, `name`, `country`) VALUES (NULL, %s, %s);',
        'participation_congress': 'INSERT INTO `scientiometer`.`participation_congress` (`id`, `congress_id`, `researcher_employee_id`, `participation_role_id`, `year`) VALUES (NULL, %s, %s, %s, %s);',
        'supervision': 'INSERT INTO `scientiometer`.`supervision` (`id`, `advising_intern_id`, `advising_researcher_id`, `institution_id`, `supervision_type_id`, `finish_year`) VALUES (NULL, %s, %s, %s, %s, %s);',
        'postgrad_supervision': 'INSERT INTO `scientiometer`.`postgraduate_program_supervision` (`id`, `researcher_employee_id`, `postgraduate_level_id`, `postgraduate_program_id`, `institution_id`, `year`) VALUES (NULL, %s, %s, %s, %s, %s);',
        'postgrad_ministered': 'INSERT INTO `scientiometer`.`postgraduate_discipline_ministered_under_supervision` (`id`, `supervisor_researcher_id`, `postgraduate_program_id`, `discipline_name`, `discipline_code`, `institution_id`, `year`) VALUES (NULL, %s, %s, %s, %s, %s, %s);',
        'lectures': 'INSERT INTO `scientiometer`.`discipline_lectures_ministered` (`id`, `researcher_employee_id`, `postgraduate_program_id`, `institution_id`, `discipline_name`, `n_classes`, `year`) VALUES (NULL, %s, %s, %s, %s, %s, %s);',
        'coordination_course': 'INSERT INTO `scientiometer`.`coordination_of_course` (`id`, `researcher_employee_id`, `course_name`, `course_level_id`, `course_classification_id`, `workload`, `year`) VALUES (NULL, %s, %s, %s, %s, %s, %s);',
        'active_grant': 'INSERT INTO `scientiometer`.`active_grant` (`id`, `granted_researcher_id`, `project_type_id`, `participation_type_id`, `funding_agency_id`, `process_number`, `validity_start`, `validity_end`) VALUES (NULL, %s, %s, %s, %s, %s, %s, %s);',
        'contracted_value': 'INSERT INTO `scientiometer`.`contracted_value` (`id`, `granted_researcher`, `new_process`, `process_number`, `funding_agency_id`, `value_BRL`, `value_USD`, `validity_end`, `year`) VALUES (NULL, %s, %s, %s, %s, %s, %s, %s, %s);',
        'scholarship': 'INSERT INTO `scientiometer`.`scholarship` (`id`, `funding_agency_id`, `advising_researcher_id`, `advising_intern_id`, `process_number`, `total_value_BRL`, `total_value_USD`, `technical_reserve_BRL`, `year`) VALUES (NULL, %s, %s, %s, %s, %s, %s, %s, %s);',
        'institutional_activity': 'INSERT INTO `scientiometer`.`institutional_activity` (`id`, `researcher_employee_id`, `activity`, `duration`, `year`) VALUES (NULL, %s, %s, %s, %s);',
        'cultural_activity': 'INSERT INTO `scientiometer`.`cultural_activity` (`id`, `researcher_employee_id`, `participation_type`, `duration`, `year`) VALUES (NULL, %s, %s, %s, %s);',
        'innovation_activity': 'INSERT INTO `scientiometer`.`innovation_activity` (`id`, `researcher_employee_id`, `participation_type`, `duration`, `year`) VALUES (NULL, %s, %s, %s, %s);',
        'service_provision': 'INSERT INTO `scientiometer`.`service_provision` (`id`, `researcher_employee_id`, `service_provisioned`, `duration`, `year`) VALUES (NULL, %s, %s, %s, %s);',
        'note': 'INSERT INTO `scientiometer`.`note` (`id`, `researcher_employee_id`, `note`, `year`) VALUES (NULL, %s, %s, %s);',
        'advising': 'INSERT INTO `scientiometer`.`advising` (`intern_id`, `researcher_id`, `internship_level_id`, `validity_start`, `validity_end`) VALUES (%s, %s, %s, %s, %s);'
    }
    print(data)
    try:
        cursor.execute(inserts[table], data)
    except Exception as e:
        print("==============ERROR=================")
        print("Failed to insert a ROW")
        print(e, file=sys.stderr)
        print("==============ERROR=================")
        cursor._connection.rollback()
        exit(1)

    outfile.write(cursor.statement + '\n')
    return cursor.lastrowid


def locate_table(csv_file, match):
    result = [0, 0]
    found = False
    found_id = False
    for n, row in enumerate(csv_file):
        if not found and (re.search('^' + match, row[1]) or re.search('^' + match, row[0])):
            print('match > ', n, row)
            found = True
        elif found:
            if row[0] == 'ID':
                print('id > ', n, row)
                found_id = True
                result[0] = n + 1
            elif row[0] == '' and found_id:
                print('empty > ', n, row)
                result[1] = n - result[0]
                break

    if result[1] == 0:
        result[1] = n + 1 - result[0]

    file.seek(0)
    return result


main()
