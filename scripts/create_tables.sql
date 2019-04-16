-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema scientiometer
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema scientiometer
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `scientiometer` ;
USE `scientiometer` ;

-- -----------------------------------------------------
-- Table `scientiometer`.`role_foundation_or_pq_level`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`role_foundation_or_pq_level` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `role_name_or_pq_level` VARCHAR(75) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `role_name_or_pq_level_UNIQUE` (`role_name_or_pq_level` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`title`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`title` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `title_UNIQUE` (`title` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`lab_division`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`lab_division` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `division_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `division_name_UNIQUE` (`division_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`laboratory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`laboratory` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `laboratory_name` VARCHAR(45) NOT NULL,
  `lab_division_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_laboratory_lab_division1_idx` (`lab_division_id` ASC) VISIBLE,
  UNIQUE INDEX `laboratory_name_UNIQUE` (`laboratory_name` ASC) VISIBLE,
  CONSTRAINT `fk_laboratory_lab_division1`
    FOREIGN KEY (`lab_division_id`)
    REFERENCES `scientiometer`.`lab_division` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`employee` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `role_foundation_or_pq_level_id` INT NOT NULL,
  `title_id` INT NOT NULL,
  `foundation_employee` TINYINT NOT NULL,
  `laboratory_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_employee_role_foundation_or_pq_level1_idx` (`role_foundation_or_pq_level_id` ASC) VISIBLE,
  INDEX `fk_employee_title1_idx` (`title_id` ASC) VISIBLE,
  INDEX `fk_employee_laboratory1_idx` (`laboratory_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_role_foundation_or_pq_level1`
    FOREIGN KEY (`role_foundation_or_pq_level_id`)
    REFERENCES `scientiometer`.`role_foundation_or_pq_level` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_title1`
    FOREIGN KEY (`title_id`)
    REFERENCES `scientiometer`.`title` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_laboratory1`
    FOREIGN KEY (`laboratory_id`)
    REFERENCES `scientiometer`.`laboratory` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`post_doctoral_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`post_doctoral_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `type_UNIQUE` (`type` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`researcher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`researcher` (
  `employee_id` INT NOT NULL,
  `post_doctoral_type_id` INT NOT NULL,
  `researcher_id` VARCHAR(9) NOT NULL,
  `orcid` VARCHAR(16) NOT NULL,
  `ingress_date` DATE NOT NULL,
  `email` VARCHAR(60) NOT NULL,
  `lab_director` TINYINT NOT NULL,
  UNIQUE INDEX `researcher_id_UNIQUE` (`researcher_id` ASC) VISIBLE,
  UNIQUE INDEX `orcid_UNIQUE` (`orcid` ASC) VISIBLE,
  PRIMARY KEY (`employee_id`),
  INDEX `fk_researcher_post_doctoral1_idx` (`post_doctoral_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_researcher_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `scientiometer`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_researcher_post_doctoral1`
    FOREIGN KEY (`post_doctoral_type_id`)
    REFERENCES `scientiometer`.`post_doctoral_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
PACK_KEYS = DEFAULT;


-- -----------------------------------------------------
-- Table `scientiometer`.`internship_level`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`internship_level` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `level` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `level_UNIQUE` (`level` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`intern`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`intern` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `researcher_employee_id` INT NOT NULL,
  `internship_level_id` INT NOT NULL,
  `validity_start` YEAR(4) NOT NULL,
  `validity_end` YEAR(4) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_intern_researcher1_idx` (`researcher_employee_id` ASC) VISIBLE,
  INDEX `fk_intern_internship_level1_idx` (`internship_level_id` ASC) VISIBLE,
  CONSTRAINT `fk_intern_researcher1`
    FOREIGN KEY (`researcher_employee_id`)
    REFERENCES `scientiometer`.`researcher` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_intern_internship_level1`
    FOREIGN KEY (`internship_level_id`)
    REFERENCES `scientiometer`.`internship_level` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`scholarship_agency`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`scholarship_agency` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `agency` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `agency_UNIQUE` (`agency` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`cnpq_level`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`cnpq_level` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cnpq_level` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cnpq_level_UNIQUE` (`cnpq_level` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`productivity_scholarship`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`productivity_scholarship` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cnpq_level_id` INT NULL,
  `validity_start` YEAR(4) NOT NULL,
  `validity_end` YEAR(4) NULL,
  `granted_researcher_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_productivity_scholarships_cnpq_level1_idx` (`cnpq_level_id` ASC) VISIBLE,
  INDEX `fk_productivity_scholarships_researcher1_idx` (`granted_researcher_id` ASC) VISIBLE,
  CONSTRAINT `fk_productivity_scholarships_cnpq_level1`
    FOREIGN KEY (`cnpq_level_id`)
    REFERENCES `scientiometer`.`cnpq_level` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productivity_scholarships_researcher1`
    FOREIGN KEY (`granted_researcher_id`)
    REFERENCES `scientiometer`.`researcher` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`article_production`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`article_production` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `researcher_employee_id` INT NOT NULL,
  `n_total_publications` INT NOT NULL,
  `n_intl_collab` INT NOT NULL,
  `n_first_author` INT NOT NULL,
  `n_corresponding_author` INT NOT NULL,
  `n_last_author` INT NOT NULL,
  `year` YEAR(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_article_production_researcher1_idx` (`researcher_employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_article_production_researcher1`
    FOREIGN KEY (`researcher_employee_id`)
    REFERENCES `scientiometer`.`researcher` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`article_student_postdoc`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`article_student_postdoc` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `researcher_employee_id` INT NOT NULL,
  `scholarship_agency_id` INT NOT NULL,
  `n_intl_collab` INT NOT NULL,
  `n_sci_initiation` INT NOT NULL,
  `n_msc_student` INT NOT NULL,
  `n_doc_student` INT NOT NULL,
  `n_postdoc` INT NOT NULL,
  `year` YEAR(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_article_sci_initiation_postdoc_researcher1_idx` (`researcher_employee_id` ASC) VISIBLE,
  INDEX `fk_article_sci_initiation_postdoc_scholarship_agency1_idx` (`scholarship_agency_id` ASC) VISIBLE,
  CONSTRAINT `fk_article_sci_initiation_postdoc_researcher1`
    FOREIGN KEY (`researcher_employee_id`)
    REFERENCES `scientiometer`.`researcher` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_article_sci_initiation_postdoc_scholarship_agency1`
    FOREIGN KEY (`scholarship_agency_id`)
    REFERENCES `scientiometer`.`scholarship_agency` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`line_of_research`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`line_of_research` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `line_of_research` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `line_of_research_UNIQUE` (`line_of_research` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`scientometric_index`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`scientometric_index` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `researcher_employee_id` INT NOT NULL,
  `n_citations_wos` INT NOT NULL,
  `h_index_wos` INT NOT NULL,
  `n_citations_gs` INT NOT NULL,
  `h_index_gs` INT NOT NULL,
  `main_line_of_research_id` INT NOT NULL,
  `secondary_line_of_research_id` INT NULL,
  `year` YEAR(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_scientometric_index_researcher1_idx` (`researcher_employee_id` ASC) VISIBLE,
  INDEX `fk_scientometric_index_line_of_research1_idx` (`main_line_of_research_id` ASC) VISIBLE,
  INDEX `fk_scientometric_index_line_of_research2_idx` (`secondary_line_of_research_id` ASC) VISIBLE,
  CONSTRAINT `fk_scientometric_index_researcher1`
    FOREIGN KEY (`researcher_employee_id`)
    REFERENCES `scientiometer`.`researcher` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_scientometric_index_line_of_research1`
    FOREIGN KEY (`main_line_of_research_id`)
    REFERENCES `scientiometer`.`line_of_research` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_scientometric_index_line_of_research2`
    FOREIGN KEY (`secondary_line_of_research_id`)
    REFERENCES `scientiometer`.`line_of_research` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`congress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`congress` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`participation_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`participation_role` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `role_description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `role_description_UNIQUE` (`role_description` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`participation_congress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`participation_congress` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `congress_id` INT NOT NULL,
  `researcher_employee_id` INT NOT NULL,
  `participation_role_id` INT NOT NULL,
  `year` YEAR(4) NOT NULL,
  INDEX `fk_participation_congress_researcher1_idx` (`researcher_employee_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  INDEX `fk_participation_congress_participation_role1_idx` (`participation_role_id` ASC) VISIBLE,
  CONSTRAINT `fk_participation_congress_cogress1`
    FOREIGN KEY (`congress_id`)
    REFERENCES `scientiometer`.`congress` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_participation_congress_researcher1`
    FOREIGN KEY (`researcher_employee_id`)
    REFERENCES `scientiometer`.`researcher` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_participation_congress_participation_role1`
    FOREIGN KEY (`participation_role_id`)
    REFERENCES `scientiometer`.`participation_role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`institution`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`institution` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `institution_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `institution_name_UNIQUE` (`institution_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`supervision_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`supervision_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type_description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `type_description_UNIQUE` (`type_description` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`supervision`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`supervision` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `student_name` VARCHAR(45) NOT NULL,
  `supervisor_researcher_id` INT NOT NULL,
  `institution_id` INT NOT NULL,
  `supervision_type_id` INT NOT NULL,
  `finish_year` YEAR(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_supervision_researcher1_idx` (`supervisor_researcher_id` ASC) VISIBLE,
  INDEX `fk_supervision_institution1_idx` (`institution_id` ASC) VISIBLE,
  INDEX `fk_supervision_supervision_type1_idx` (`supervision_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_supervision_researcher1`
    FOREIGN KEY (`supervisor_researcher_id`)
    REFERENCES `scientiometer`.`researcher` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_supervision_institution1`
    FOREIGN KEY (`institution_id`)
    REFERENCES `scientiometer`.`institution` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_supervision_supervision_type1`
    FOREIGN KEY (`supervision_type_id`)
    REFERENCES `scientiometer`.`supervision_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`postgraduate_program`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`postgraduate_program` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `program_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `program_name_UNIQUE` (`program_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`postgraduate_level`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`postgraduate_level` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `level` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `level_UNIQUE` (`level` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`postgraduate_program_supervision`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`postgraduate_program_supervision` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `researcher_employee_id` INT NOT NULL,
  `postgraduate_level_id` INT NOT NULL,
  `postgraduate_program_id` INT NOT NULL,
  `institution_id` INT NOT NULL,
  `year` YEAR(4) NOT NULL,
  INDEX `fk_postgraduate_accreditation_postgraduate_level1_idx` (`postgraduate_level_id` ASC) VISIBLE,
  INDEX `fk_postgraduate_accreditation_post_graduate_program1_idx` (`postgraduate_program_id` ASC) VISIBLE,
  INDEX `fk_postgraduate_program_supervision_institution1_idx` (`institution_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_postgraduate_accreditation_researcher1`
    FOREIGN KEY (`researcher_employee_id`)
    REFERENCES `scientiometer`.`researcher` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_postgraduate_accreditation_postgraduate_level1`
    FOREIGN KEY (`postgraduate_level_id`)
    REFERENCES `scientiometer`.`postgraduate_level` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_postgraduate_accreditation_post_graduate_program1`
    FOREIGN KEY (`postgraduate_program_id`)
    REFERENCES `scientiometer`.`postgraduate_program` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_postgraduate_program_supervision_institution1`
    FOREIGN KEY (`institution_id`)
    REFERENCES `scientiometer`.`institution` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`postgraduate_discipline_ministered_under_supervision`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`postgraduate_discipline_ministered_under_supervision` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `supervisor_researcher_id` INT NOT NULL,
  `postgraduate_program_id` INT NOT NULL,
  `discipline_name` VARCHAR(100) NOT NULL,
  `discipline_code` VARCHAR(15) NOT NULL,
  `institution_id` INT NOT NULL,
  `year` YEAR(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ministered_postgrad_discipline_researcher1_idx` (`supervisor_researcher_id` ASC) VISIBLE,
  INDEX `fk_ministered_postgrad_discipline_post_graduate_program1_idx` (`postgraduate_program_id` ASC) VISIBLE,
  INDEX `fk_postgraduate_discipline_ministered_under_supervision_ins_idx` (`institution_id` ASC) VISIBLE,
  CONSTRAINT `fk_ministered_postgrad_discipline_researcher1`
    FOREIGN KEY (`supervisor_researcher_id`)
    REFERENCES `scientiometer`.`researcher` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ministered_postgrad_discipline_post_graduate_program1`
    FOREIGN KEY (`postgraduate_program_id`)
    REFERENCES `scientiometer`.`postgraduate_program` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_postgraduate_discipline_ministered_under_supervision_insti1`
    FOREIGN KEY (`institution_id`)
    REFERENCES `scientiometer`.`institution` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`discipline_lectures_ministered`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`discipline_lectures_ministered` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `researcher_employee_id` INT NOT NULL,
  `postgraduate_program_id` INT NULL,
  `institution_id` INT NULL,
  `discipline_name` VARCHAR(100) NULL,
  `n_classes` INT NOT NULL,
  `year` YEAR(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_desciplines_lectures_ministered_researcher1_idx` (`researcher_employee_id` ASC) VISIBLE,
  INDEX `fk_desciplines_lectures_ministered_post_graduate_program1_idx` (`postgraduate_program_id` ASC) VISIBLE,
  INDEX `fk_desciplines_lectures_ministered_institution1_idx` (`institution_id` ASC) VISIBLE,
  CONSTRAINT `fk_desciplines_lectures_ministered_researcher1`
    FOREIGN KEY (`researcher_employee_id`)
    REFERENCES `scientiometer`.`researcher` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_desciplines_lectures_ministered_post_graduate_program1`
    FOREIGN KEY (`postgraduate_program_id`)
    REFERENCES `scientiometer`.`postgraduate_program` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_desciplines_lectures_ministered_institution1`
    FOREIGN KEY (`institution_id`)
    REFERENCES `scientiometer`.`institution` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`course_level`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`course_level` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `course_level` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `course_level_UNIQUE` (`course_level` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`course_classification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`course_classification` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `classification` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `classificaton_UNIQUE` (`classification` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`coordination_of_course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`coordination_of_course` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `researcher_employee_id` INT NOT NULL,
  `course_name` VARCHAR(100) NOT NULL,
  `course_level_id` INT NOT NULL,
  `course_classification_id` INT NOT NULL,
  `workload` INT NOT NULL,
  `year` YEAR(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_coordination_of_course_researcher1_idx` (`researcher_employee_id` ASC) VISIBLE,
  INDEX `fk_coordination_of_course_course_level1_idx` (`course_level_id` ASC) VISIBLE,
  INDEX `fk_coordination_of_course_course_classification1_idx` (`course_classification_id` ASC) VISIBLE,
  CONSTRAINT `fk_coordination_of_course_researcher1`
    FOREIGN KEY (`researcher_employee_id`)
    REFERENCES `scientiometer`.`researcher` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_coordination_of_course_course_level1`
    FOREIGN KEY (`course_level_id`)
    REFERENCES `scientiometer`.`course_level` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_coordination_of_course_course_classification1`
    FOREIGN KEY (`course_classification_id`)
    REFERENCES `scientiometer`.`course_classification` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`project_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`project_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `project_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `project_type_UNIQUE` (`project_type` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`participation_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`participation_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `participation_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `participation_type_UNIQUE` (`participation_type` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`aid_agency`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`aid_agency` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `agency_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `agency_name_UNIQUE` (`agency_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`active_aid`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`active_aid` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `granted_researcher_id` INT NOT NULL,
  `project_type_id` INT NOT NULL,
  `participation_type_id` INT NOT NULL,
  `aid_agency_id` INT NOT NULL,
  `process_number` VARCHAR(45) NOT NULL,
  `validity_start` YEAR(4) NOT NULL,
  `validity_end` YEAR(4) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_active_aid_researcher1_idx` (`granted_researcher_id` ASC) VISIBLE,
  INDEX `fk_active_aid_project_type1_idx` (`project_type_id` ASC) VISIBLE,
  INDEX `fk_active_aid_participation_type1_idx` (`participation_type_id` ASC) VISIBLE,
  INDEX `fk_active_aid_aid_agency1_idx` (`aid_agency_id` ASC) VISIBLE,
  CONSTRAINT `fk_active_aid_researcher1`
    FOREIGN KEY (`granted_researcher_id`)
    REFERENCES `scientiometer`.`researcher` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_active_aid_project_type1`
    FOREIGN KEY (`project_type_id`)
    REFERENCES `scientiometer`.`project_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_active_aid_participation_type1`
    FOREIGN KEY (`participation_type_id`)
    REFERENCES `scientiometer`.`participation_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_active_aid_aid_agency1`
    FOREIGN KEY (`aid_agency_id`)
    REFERENCES `scientiometer`.`aid_agency` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`contracted_value`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`contracted_value` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `granted_researcher` INT NOT NULL,
  `new_process` TINYINT NOT NULL,
  `process_number` VARCHAR(45) NOT NULL,
  `aid_agency_id` INT NOT NULL,
  `value_BRL` DECIMAL NOT NULL,
  `value_USD` DECIMAL NOT NULL,
  `validity_end` YEAR(4) NULL,
  `year` YEAR(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_contracted_value_researcher1_idx` (`granted_researcher` ASC) VISIBLE,
  INDEX `fk_contracted_value_aid_agency1_idx` (`aid_agency_id` ASC) VISIBLE,
  CONSTRAINT `fk_contracted_value_researcher1`
    FOREIGN KEY (`granted_researcher`)
    REFERENCES `scientiometer`.`researcher` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contracted_value_aid_agency1`
    FOREIGN KEY (`aid_agency_id`)
    REFERENCES `scientiometer`.`aid_agency` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`scholarship`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`scholarship` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `intern_id` INT NOT NULL,
  `scholarship_agency_id` INT NOT NULL,
  `process_number` VARCHAR(45) NOT NULL,
  `total_value_BRL` DECIMAL NOT NULL,
  `total_value_USD` DECIMAL NOT NULL,
  `technical_reserve_BRL` DECIMAL NOT NULL,
  `validity_start` YEAR(4) NOT NULL,
  `validity_end` YEAR(4) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_table1_intern1_idx` (`intern_id` ASC) VISIBLE,
  INDEX `fk_table1_scholarship_agency1_idx` (`scholarship_agency_id` ASC) VISIBLE,
  CONSTRAINT `fk_table1_intern1`
    FOREIGN KEY (`intern_id`)
    REFERENCES `scientiometer`.`intern` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table1_scholarship_agency1`
    FOREIGN KEY (`scholarship_agency_id`)
    REFERENCES `scientiometer`.`scholarship_agency` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`institutional_activities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`institutional_activities` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `researcher_employee_id` INT NOT NULL,
  `activity` VARCHAR(45) NOT NULL,
  `duration` INT NOT NULL,
  `year` YEAR(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_institutional_activities_researcher1_idx` (`researcher_employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_institutional_activities_researcher1`
    FOREIGN KEY (`researcher_employee_id`)
    REFERENCES `scientiometer`.`researcher` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`cultural_activities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`cultural_activities` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `researcher_employee_id` INT NOT NULL,
  `participation_type` VARCHAR(45) NOT NULL,
  `duration` INT NOT NULL,
  `year` YEAR(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cultural_activities_researcher1_idx` (`researcher_employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_cultural_activities_researcher1`
    FOREIGN KEY (`researcher_employee_id`)
    REFERENCES `scientiometer`.`researcher` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`innovation_activities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`innovation_activities` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `researcher_employee_id` INT NOT NULL,
  `participation_type` VARCHAR(45) NOT NULL,
  `duration` INT NOT NULL,
  `year` YEAR(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_innovation_activities_researcher1_idx` (`researcher_employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_innovation_activities_researcher1`
    FOREIGN KEY (`researcher_employee_id`)
    REFERENCES `scientiometer`.`researcher` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`service_provision`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`service_provision` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `researcher_employee_id` INT NOT NULL,
  `service_provisioned` VARCHAR(45) NOT NULL,
  `duration` INT NOT NULL,
  `year` YEAR(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_service_provision_researcher1_idx` (`researcher_employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_service_provision_researcher1`
    FOREIGN KEY (`researcher_employee_id`)
    REFERENCES `scientiometer`.`researcher` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`note`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`note` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `researcher_employee_id` INT NOT NULL,
  `note` VARCHAR(300) NOT NULL,
  `year` YEAR(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_note_researcher1_idx` (`researcher_employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_note_researcher1`
    FOREIGN KEY (`researcher_employee_id`)
    REFERENCES `scientiometer`.`researcher` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`qualis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`qualis` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `qualis_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `qualis_type_UNIQUE` (`qualis_type` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`collaboration_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`collaboration_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `collaboration_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `collaboration_type_UNIQUE` (`collaboration_type` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`published_work`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`published_work` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `doi_url` VARCHAR(150) NULL,
  `reference` VARCHAR(150) NULL,
  `qualis_id` INT NOT NULL,
  `laboratory_id` INT NOT NULL,
  `collaboration_type_id` INT NOT NULL,
  `year` YEAR(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_published_work_qualis1_idx` (`qualis_id` ASC) VISIBLE,
  INDEX `fk_published_work_laboratory1_idx` (`laboratory_id` ASC) VISIBLE,
  INDEX `fk_published_work_collaboration_type1_idx` (`collaboration_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_published_work_qualis1`
    FOREIGN KEY (`qualis_id`)
    REFERENCES `scientiometer`.`qualis` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_published_work_laboratory1`
    FOREIGN KEY (`laboratory_id`)
    REFERENCES `scientiometer`.`laboratory` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_published_work_collaboration_type1`
    FOREIGN KEY (`collaboration_type_id`)
    REFERENCES `scientiometer`.`collaboration_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scientiometer`.`book_chapter_published`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`book_chapter_published` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `doi_url` VARCHAR(150) NULL,
  `isbn_online` VARCHAR(45) NULL,
  `isbn_print` VARCHAR(45) NULL,
  `reference` VARCHAR(150) NULL,
  `laboratory_id` INT NOT NULL,
  `year` YEAR(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_book_shapter_published_laboratory1_idx` (`laboratory_id` ASC) VISIBLE,
  CONSTRAINT `fk_book_shapter_published_laboratory1`
    FOREIGN KEY (`laboratory_id`)
    REFERENCES `scientiometer`.`laboratory` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `scientiometer` ;

-- -----------------------------------------------------
-- Placeholder table for view `scientiometer`.`researcher_data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scientiometer`.`researcher_data` (`employee_id` INT, `post_doctoral_type_id` INT, `researcher_id` INT, `orcid` INT, `ingress_date` INT, `email` INT, `lab_director` INT, `id` INT, `name` INT, `role_foundation_or_pq_level_id` INT, `title_id` INT, `foundation_employee` INT, `laboratory_id` INT);

-- -----------------------------------------------------
-- View `scientiometer`.`researcher_data`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scientiometer`.`researcher_data`;
USE `scientiometer`;
CREATE  OR REPLACE VIEW `researcher_data` AS SELECT * FROM researcher JOIN employee ON (employee_id = id);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
