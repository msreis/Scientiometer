import mysql.connector
import csv

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
    'DR': ['Doutorado'],
    'MS': ['Mestrado'],
    'G': ['Graduação'],
    'NM': ['Nível Médio'],
    'PDN': ['Pós-doutorado Nacional'],
    'PDE': ['Pós-doutorado Exterior'],
    'N/A': ['Não Possui']
}


def main():
    conn = mysql.connector.connect(
        host=db_host,
        user=db_user,
        passwd=db_passwd
    )
    cursor = conn.cursor()

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
    file.seek(0)
    section_2_2(csv_file, cursor)
    file.seek(0)
    section_2_3(csv_file, cursor)
    file.seek(0)
    section_2_4(csv_file, cursor)
    file.seek(0)
    section_2_5(csv_file, cursor)
    file.seek(0)
    section_2_6(csv_file, cursor)
    file.seek(0)
    section_2_7(csv_file, cursor)
    file.seek(0)
    section_2_8(csv_file, cursor)
    file.seek(0)
    section_3_1(csv_file, cursor)
    file.seek(0)
    section_3_2(csv_file, cursor)

    conn.commit()
    conn.close()


def section_1_1(csv_file, cursor):
    print('Section 1.1 ----')
    lines = (14, 20)
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
        if num >= lines[0] - 1 and num < lines[0] - 1 + lines[1]:
            if row[1]:
                print(row)
                for field in aux_fields:
                    aux_fields[field][1] = (insert_aux(
                        cursor, field, row[aux_fields[field][0]]))

                # insert laboratory is a special case
                fk_ids['lab_div'] = insert_aux(cursor, 'lab_div', lab_div)
                cursor.execute(
                    'SELECT id FROM scientiometer.laboratory WHERE laboratory_name = %s;', lab_name[0:1])
                fk_ids['lab'] = cursor.fetchone()
                if fk_ids['lab'] == None:
                    fk_ids['lab'] = insert_complex(
                        cursor, 'laboratory', (lab_name[0], fk_ids['lab_div']))
                else:
                    fk_ids['lab'] = fk_ids['lab'][0]
                lab_name[1] = fk_ids['lab']

                # TODO: handle foundation employee, ingress date and email
                # insert employee
                fk_ids['employee'] = insert_complex(
                    cursor, 'employee', (row[1], aux_fields['role'][1], aux_fields['title'][1], 0, fk_ids['lab']))
                # insert researcher
                insert_complex(
                    cursor, 'researcher', (fk_ids['employee'], aux_fields['postdoc'][1], row[5], row[6], '2019/01/01', '', 0))


def section_1_2(csv_file, cursor):
    print('Section 1.2 ----')
    lines = (41, 23)
    aux_fields = {
        'role': [2, 0],
        'title': [3, 0],
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] - 1 and num < lines[0] - 1 + lines[1]:
            if row[1]:
                print(row)
                for field in aux_fields:
                    aux_fields[field][1] = (insert_aux(
                        cursor, field, row[aux_fields[field][0]]))
                # insert employee
                insert_complex(
                    cursor, 'employee', (row[1], aux_fields['role'][1], aux_fields['title'][1], 1, 1))


def section_1_3(csv_file, cursor):
    print('Section 1.3 ----')
    lines = (71, 10)
    aux_fields = {
        'role': [2, 0],
        'title': [3, 0],
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] - 1 and num < lines[0] - 1 + lines[1]:
            if row[1]:
                print(row)
                for field in aux_fields:
                    aux_fields[field][1] = (insert_aux(
                        cursor, field, row[aux_fields[field][0]]))
                # insert employee
                insert_complex(
                    cursor, 'employee', (row[1], aux_fields['role'][1], aux_fields['title'][1], 0, 1))


def section_1_4(csv_file, cursor):
    print('Section 1.4 ----')
    lines = (88, 40)
    aux_fields = {
        'internship_level': [3, 0],
    }
    fk_ids = {
        'researcher': 0,
        'intern': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] - 1 and num < lines[0] - 1 + lines[1]:
            if row[1]:
                print(row)
                for field in aux_fields:
                    aux_fields[field][1] = (insert_aux(
                        cursor, field, row[aux_fields[field][0]]))

                # insert intern
                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s;', row[2:3])
                fk_ids['researcher'] = cursor.fetchone()[0]
                print(fk_ids)
                insert_complex(
                    cursor, 'intern', (row[1], fk_ids['researcher'], aux_fields['internship_level'][1], row[5], row[6]))


def section_1_5(csv_file, cursor):
    print('Section 1.5 ----')
    lines = (136, 20)
    aux_fields = {
        'internship_level': [3, 0],
    }
    fk_ids = {
        'researcher': 0,
        'intern': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] - 1 and num < lines[0] - 1 + lines[1]:
            if row[1]:
                print(row)
                for field in aux_fields:
                    aux_fields[field][1] = (insert_aux(
                        cursor, field, row[aux_fields[field][0]]))

                # insert intern
                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s;', row[2:3])
                fk_ids['researcher'] = cursor.fetchone()[0]
                insert_complex(
                    cursor, 'intern', (row[1], fk_ids['researcher'], aux_fields['internship_level'][1], row[4], row[5]))


def section_1_6(csv_file, cursor):
    print('Section 1.6 ----')
    lines = (165, 10)
    aux_fields = {
        'cnpq_level': [2, 0],
    }
    fk_ids = {
        'researcher': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] - 1 and num < lines[0] - 1 + lines[1]:
            if row[1]:
                print(row)
                for field in aux_fields:
                    aux_fields[field][1] = (insert_aux(
                        cursor, field, row[aux_fields[field][0]]))

                # insert productivity scholarship
                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s;', row[1:2])
                fk_ids['researcher'] = cursor.fetchone()[0]
                insert_complex(cursor, 'prod_scholarship',
                               (aux_fields['cnpq_level'][1], row[4], row[5], fk_ids['researcher']))


def section_2_1(csv_file, cursor):
    print('Section 2.1 ----')
    lines = (190, 60)
    aux_fields = {
        'qualis': [3, 0],
        'collab_type': [4, 0],
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] - 1 and num < lines[0] - 1 + lines[1]:
            if row[1]:
                print(row)
                for field in aux_fields:
                    aux_fields[field][1] = (insert_aux(
                        cursor, field, row[aux_fields[field][0]]))

                insert_complex(cursor, 'published_work', (
                    row[1], row[2], aux_fields['qualis'][1], lab_name[1], aux_fields['collab_type'][1], year))


def section_2_2(csv_file, cursor):
    print('Section 2.2 ----')
    lines = (260, 10)
    aux_fields = {
        'collab_type': [4, 0],
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] - 1 and num < lines[0] - 1 + lines[1]:
            if row[1]:
                print(row)
                for field in aux_fields:
                    aux_fields[field][1] = (insert_aux(
                        cursor, field, row[aux_fields[field][0]]))

                insert_complex(cursor, 'published_book',
                               (row[1], row[2], row[3], row[4], lab_name[1], year))


def section_2_3(csv_file, cursor):
    print('Section 2.3 ----')
    lines = (276, 20)
    fk_ids = {
        'researcher': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] - 1 and num < lines[0] - 1 + lines[1]:
            if row[1]:
                print(row)

                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s;', row[1:2])
                fk_ids['researcher'] = cursor.fetchone()[0]
                insert_complex(
                    cursor, 'article_prod', (fk_ids['researcher'], row[2], row[3], row[4], row[5], row[6], year))


def section_2_4(csv_file, cursor):
    print('Section 2.4 ----')
    lines = (302, 20)
    aux_fields = {
        'scholarship_agency': [4, 0],
    }
    fk_ids = {
        'researcher': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] - 1 and num < lines[0] - 1 + lines[1]:
            if row[1]:
                print(row)
                aux_fields['scholarship_agency'][1] = insert_aux(
                    cursor, 'scholarship_agency', 'FAPESP')

                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s;', row[1:2])
                fk_ids['researcher'] = cursor.fetchone()[0]
                insert_complex(cursor, 'article_student_postdoc', (
                    fk_ids['researcher'], aux_fields['scholarship_agency'][1], row[2], row[3], row[4], row[5], row[6], year))


def section_2_5(csv_file, cursor):
    print('Section 2.5 ----')
    lines = (328, 20)
    aux_fields = {
        'scholarship_agency': [4, 0],
    }
    fk_ids = {
        'researcher': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] - 1 and num < lines[0] - 1 + lines[1]:
            if row[1]:
                print(row)
                aux_fields['scholarship_agency'][1] = insert_aux(
                    cursor, 'scholarship_agency', 'CAPES')

                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s;', row[1:2])
                fk_ids['researcher'] = cursor.fetchone()[0]
                insert_complex(cursor, 'article_student_postdoc', (
                    fk_ids['researcher'], aux_fields['scholarship_agency'][1], row[2], row[3], row[4], row[5], row[6], year))


def section_2_6(csv_file, cursor):
    print('Section 2.6 ----')
    lines = (354, 20)
    aux_fields = {
        'scholarship_agency': [4, 0, 0],
    }
    fk_ids = {
        'researcher': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] - 1 and num < lines[0] - 1 + lines[1]:
            if row[1]:
                print(row)
                aux_fields['scholarship_agency'][1] = insert_aux(
                    cursor, 'scholarship_agency', 'CNPq')
                aux_fields['scholarship_agency'][2] = insert_aux(
                    cursor, 'scholarship_agency', 'FB')

                # TODO: is this correct? The number of publications is
                # duplicated, or is it the sum of cnpq and fb?
                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s;', row[1:2])
                fk_ids['researcher'] = cursor.fetchone()[0]
                insert_complex(cursor, 'article_student_postdoc', (
                    fk_ids['researcher'], aux_fields['scholarship_agency'][1], row[2], row[3], row[5], row[6], row[7], year))
                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s;', row[1:2])
                fk_ids['researcher'] = cursor.fetchone()[0]
                insert_complex(cursor, 'article_student_postdoc', (
                    fk_ids['researcher'], aux_fields['scholarship_agency'][2], row[2], row[4], row[5], row[6], row[7], year))


def section_2_7(csv_file, cursor):
    print('Section 2.7 ----')
    lines = (386, 20)
    aux_fields = {
        'line_research': [4, 0, 0],
    }
    fk_ids = {
        'researcher': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] - 1 and num < lines[0] - 1 + lines[1]:
            if row[1]:
                print(row)
                aux_fields['line_research'][1] = insert_aux(
                    cursor, 'line_research', row[6])
                aux_fields['line_research'][2] = insert_aux(
                    cursor, 'line_research', row[7])

                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s;', row[1:2])
                fk_ids['researcher'] = cursor.fetchone()[0]
                insert_complex(cursor, 'scientometric', (
                    fk_ids['researcher'],  row[2], row[3], row[4], row[5], aux_fields['line_research'][1], aux_fields['line_research'][2], year))


def section_2_8(csv_file, cursor):
    print('Section 2.8 ----')
    lines = (414, 20)
    aux_fields = {
        'participation_role': [4, 0, 0, 0],
    }
    fk_ids = {
        'researcher': 0,
        'congress': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] - 1 and num < lines[0] - 1 + lines[1]:
            if row[1]:
                print(row)

                # Every participation type we insert as a separate participation
                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s;', row[1:2])
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
    print('Section 3.1 ----')
    lines = (445, 15)
    aux_fields = {
        'institution': [3, 0],
        'supervision_type': [4, 0],
    }
    fk_ids = {
        'researcher': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] - 1 and num < lines[0] - 1 + lines[1]:
            if row[1]:
                print(row)
                for field in aux_fields:
                    aux_fields[field][1] = (insert_aux(
                        cursor, field, row[aux_fields[field][0]]))

                cursor.execute(
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s;', row[2:3])
                fk_ids['researcher'] = cursor.fetchone()[0]
                insert_complex(cursor, 'supervision', (
                    row[1], fk_ids['researcher'], aux_fields['institution'][1], aux_fields['supervision_type'][1], year))


def section_3_2(csv_file, cursor):
    print('Section 3.2 ----')
    lines = (468, 20)
    aux_fields = {
        'institution': [2, 0],
        'postgraduate_level': [3, 0],
        'postgraduate_program': [2, 0],
    }
    fk_ids = {
        'researcher': 0,
    }
    for num, row in enumerate(csv_file):
        if num >= lines[0] - 1 and num < lines[0] - 1 + lines[1]:
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
                    'SELECT id FROM scientiometer.researcher_data WHERE name = %s;', row[1:2])
                fk_ids['researcher'] = cursor.fetchone()[0]
                insert_complex(cursor, 'postgrad_supervision', (fk_ids['researcher'], aux_fields['postgraduate_level'][1], aux_fields['postgraduate_program'][1], aux_fields['institution'][1], year ))


def insert_aux(cursor, query, data):
    inserts = {
        'title': 'INSERT INTO `scientiometer`.`title` (`id`, `title`) VALUES (NULL, %s);',
        'role': 'INSERT INTO `scientiometer`.`role_foundation_or_pq_level` (`id`, `role_name_or_pq_level`) VALUES (NULL, %s);',
        'postdoc': 'INSERT INTO `scientiometer`.`post_doctoral_type` (`id`, `type`) VALUES (NULL, %s);',
        'internship_level': 'INSERT INTO `scientiometer`.`internship_level` (`id`, `level`) VALUES (NULL, %s);',
        'scholarhip_agency': 'INSERT INTO `scientiometer`.`scholarship_agency` (`id`, `agency`) VALUES (NULL, %s);',
        'cnpq_level': 'INSERT INTO `scientiometer`.`cnpq_level` (`id`, `cnpq_level`) VALUES (NULL, %s);',
        'collab_type': 'INSERT INTO `scientiometer`.`collaboration_type` (`id`, `collaboration_type`) VALUES (NULL, %s);',
        'qualis': 'INSERT INTO `scientiometer`.`qualis` (`id`, `qualis_type`) VALUES (NULL, %s);',
        'lab_div': 'INSERT INTO `scientiometer`.`lab_division` (`id`, `division_name`) VALUES (NULL, %s);',
        'scholarship_agency': 'INSERT INTO `scientiometer`.`scholarship_agency` (`id`, `agency`) VALUES (NULL, %s);',
        'line_research': 'INSERT INTO `scientiometer`.`line_of_research` (`id`, `line_of_research`) VALUES (NULL, %s);',
        'participation_role': 'INSERT INTO `scientiometer`.`participation_role` (`id`, `role_description`) VALUES (NULL, %s);',
        'institution': 'INSERT INTO `scientiometer`.`institution` (`id`, `institution_name`) VALUES (NULL, %s);',
        'supervision_type': 'INSERT INTO `scientiometer`.`supervision_type` (`id`, `type_description`) VALUES (NULL, %s);',
        'postgraduate_program': 'INSERT INTO `scientiometer`.`postgraduate_program` (`id`, `program_name`) VALUES (NULL, %s);',
        'postgraduate_level': 'INSERT INTO `scientiometer`.`postgraduate_level` (`id`, `level`) VALUES (NULL, %s);',
    }
    selects = {
        'title': 'SELECT id FROM `scientiometer`.title WHERE title = %s;',
        'role': 'SELECT id FROM scientiometer.role_foundation_or_pq_level WHERE role_name_or_pq_level = %s;',
        'postdoc': 'SELECT id FROM scientiometer.post_doctoral_type WHERE type = %s;',
        'internship_level': 'SELECT id FROM `scientiometer`.`internship_level` WHERE level = %s;',
        'scholarhip_agency': 'SELECT id FROM `scientiometer`.`scholarship_agency` WHERE agency = %s;',
        'cnpq_level': 'SELECT id FROM `scientiometer`.`cnpq_level` WHERE cnpq_level = %s;',
        'collab_type': 'SELECT id FROM `scientiometer`.`collaboration_type` WHERE collaboration_type = %s;',
        'qualis': 'SELECT id FROM `scientiometer`.`qualis` WHERE qualis_type = %s;',
        'lab_div': 'SELECT id FROM `scientiometer`.`lab_division` WHERE division_name = %s;',
        'scholarship_agency': 'SELECT id FROM `scientiometer`.`scholarship_agency` WHERE agency = %s;',
        'line_research': 'SELECT id FROM `scientiometer`.`line_of_research` WHERE line_of_research = %s;',
        'participation_role': 'SELECT id FROM `scientiometer`.`participation_role` WHERE role_description =  %s;',
        'institution': 'SELECT id FROM `scientiometer`.`institution` WHERE institution_name = %s;',
        'supervision_type': 'SELECT id FROM `scientiometer`.`supervision_type` WHERE type_description = %s;',
        'postgraduate_program': 'SELECT id FROM `scientiometer`.`postgraduate_program` WHERE program_name = %s;',
        'postgraduate_level': 'SELECT id FROM `scientiometer`.`postgraduate_level` WHERE level = %s;',
    }

    if data in abbreviations:
        value = abbreviations[data]
    else:
        value = [data]

    print(value)

    cursor.execute(selects[query], value)

    id = cursor.fetchone()
    if id == None:
        cursor.execute(inserts[query], value)
        id = cursor.lastrowid
    else:
        # HACK: the connector returns a tuple even for a single result, so we
        # get only the first value
        id = id[0]

    return id


def insert_complex(cursor, table, data):
    inserts = {
        'employee': 'INSERT INTO `scientiometer`.`employee` (`id`, `name`, `role_foundation_or_pq_level_id`, `title_id`, `foundation_employee`, `laboratory_id`) VALUES (NULL, %s, %s, %s, %s, %s) ON DUPLICATE KEY UPDATE name = name;',
        'researcher': 'INSERT INTO `scientiometer`.`researcher` (`employee_id`, `post_doctoral_type_id`, `researcher_id`, `orcid`, `ingress_date`, `email`, `lab_director`) VALUES (%s, %s, %s, %s, %s, %s, %s) ON DUPLICATE KEY UPDATE researcher_id = researcher_id;',
        'intern': 'INSERT INTO `scientiometer`.`intern` (`id`, `name`, `researcher_employee_id`, `internship_level_id`, `validity_start`, `validity_end`) VALUES (NULL, %s, %s, %s, %s, %s);',
        'scholarship': 'INSERT INTO `scientiometer`.`scholarship` (`id`, `intern_id`, `scholarship_agency_id`, `process_number`, `total_value_BRL`, `total_value_USD`, `technical_reserve_BRL`, `validity_start`, `validity_end`) VALUES (NULL, %s, %s, %s, %s, %s, %s, %s, %s);',
        'prod_scholarship': 'INSERT INTO `scientiometer`.`productivity_scholarship` (`id`, `cnpq_level_id`, `validity_start`, `validity_end`, `granted_researcher_id`) VALUES (NULL, %s, %s, %s, %s);',
        'published_work': 'INSERT INTO `scientiometer`.`published_work` (`id`, `doi_url`, `reference`, `qualis_id`, `laboratory_id`, `collaboration_type_id`, `year`) VALUES (NULL, %s, %s, %s, %s, %s, %s);',
        'laboratory': 'INSERT INTO `scientiometer`.`laboratory` (`id`, `laboratory_name`, `lab_division_id`) VALUES (NULL, %s, %s) ON DUPLICATE KEY UPDATE laboratory_name = laboratory_name;',
        'published_book': 'INSERT INTO `scientiometer`.`book_chapter_published` (`id`, `doi_url`, `isbn_online`, `isbn_print`, `reference`, `laboratory_id`, `year`) VALUES (NULL, %s, %s, %s, %s, %s, %s);',
        'article_prod': 'INSERT INTO `scientiometer`.`article_production` (`id`, `researcher_employee_id`, `n_total_publications`, `n_intl_collab`, `n_first_author`, `n_corresponding_author`, `n_last_author`, `year`) VALUES (NULL, %s, %s, %s, %s, %s, %s, %s);',
        'article_student_postdoc': 'INSERT INTO `scientiometer`.`article_student_postdoc` (`id`, `researcher_employee_id`, `scholarship_agency_id`, `n_intl_collab`, `n_sci_initiation`, `n_msc_student`, `n_doc_student`, `n_postdoc`, `year`) VALUES (NULL, %s, %s, %s, %s, %s, %s, %s, %s);',
        'scientometric': 'INSERT INTO `scientiometer`.`scientometric_index` (`id`, `researcher_employee_id`, `n_citations_wos`, `h_index_wos`, `n_citations_gs`, `h_index_gs`, `main_line_of_research_id`, `secondary_line_of_research_id`, `year`) VALUES (NULL, %s, %s, %s, %s, %s, %s, %s, %s);',
        'congress': 'INSERT INTO `scientiometer`.`congress` (`id`, `name`, `country`) VALUES (NULL, %s, %s);',
        'participation_congress': 'INSERT INTO `scientiometer`.`participation_congress` (`id`, `congress_id`, `researcher_employee_id`, `participation_role_id`, `year`) VALUES (NULL, %s, %s, %s, %s);',
        'supervision': 'INSERT INTO `scientiometer`.`supervision` (`id`, `student_name`, `supervisor_researcher_id`, `institution_id`, `supervision_type_id`, `finish_year`) VALUES (NULL, %s, %s, %s, %s, %s);',
        'postgrad_supervision': 'INSERT INTO `scientiometer`.`postgraduate_program_supervision` (`id`, `researcher_employee_id`, `postgraduate_level_id`, `postgraduate_program_id`, `institution_id`, `year`) VALUES (NULL, %s, %s, %s, %s, %s);',
    }
    print(data)
    cursor.execute(inserts[table], data)
    return cursor.lastrowid


main()
