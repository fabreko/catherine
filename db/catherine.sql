SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS `catherine` ;
CREATE SCHEMA IF NOT EXISTS `catherine` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `catherine` ;

-- -----------------------------------------------------
-- Table `catherine`.`dim_tempo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `catherine`.`dim_tempo` ;

CREATE  TABLE IF NOT EXISTS `catherine`.`dim_tempo` (
  `dim_tempo_id` INT NOT NULL AUTO_INCREMENT ,
  `ano` INT(11) NULL ,
  `mes` INT(11) NULL ,
  `dia` INT(11) NULL ,
  `ano_texto` VARCHAR(45) NULL ,
  `mes_texto` VARCHAR(45) NULL ,
  `dia_texto` VARCHAR(45) NULL ,
  PRIMARY KEY (`dim_tempo_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `catherine`.`dim_local`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `catherine`.`dim_local` ;

CREATE  TABLE IF NOT EXISTS `catherine`.`dim_local` (
  `dim_local_id` INT NOT NULL AUTO_INCREMENT ,
  `cidade` VARCHAR(40) NULL ,
  `nome_estado` VARCHAR(40) NULL ,
  `uf` CHAR(2) NULL ,
  PRIMARY KEY (`dim_local_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `catherine`.`dim_curso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `catherine`.`dim_curso` ;

CREATE  TABLE IF NOT EXISTS `catherine`.`dim_curso` (
  `dim_curso_id` INT NOT NULL AUTO_INCREMENT ,
  `nome_curso` VARCHAR(60) NULL ,
  `nome_centro` VARCHAR(40) NULL ,
  `sigla_centro` CHAR(5) NULL ,
  PRIMARY KEY (`dim_curso_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `catherine`.`fato_vagas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `catherine`.`fato_vagas` ;

CREATE  TABLE IF NOT EXISTS `catherine`.`fato_vagas` (
  `fato_vagas_id` INT NOT NULL ,
  `dim_tempo_dim_tempo_id` INT NOT NULL ,
  `dim_curso_dim_curso_id` INT NOT NULL ,
  `numero_vagas` INT NULL ,
  `vagas_ocupadas` INT NULL ,
  `concorrentes` INT NULL ,
  `media_acertos` DECIMAL(5,2) NULL ,
  `media_redacao` DECIMAL(5,2) NULL ,
  `nome_vestibular` VARCHAR(45) NULL ,
  PRIMARY KEY (`fato_vagas_id`, `dim_tempo_dim_tempo_id`, `dim_curso_dim_curso_id`) ,
  INDEX `fk_fato_vagas_dim_tempo1` (`dim_tempo_dim_tempo_id` ASC) ,
  INDEX `fk_fato_vagas_dim_curso1` (`dim_curso_dim_curso_id` ASC) ,
  CONSTRAINT `fk_fato_vagas_dim_tempo1`
    FOREIGN KEY (`dim_tempo_dim_tempo_id` )
    REFERENCES `catherine`.`dim_tempo` (`dim_tempo_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fato_vagas_dim_curso1`
    FOREIGN KEY (`dim_curso_dim_curso_id` )
    REFERENCES `catherine`.`dim_curso` (`dim_curso_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `catherine`.`fato_censo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `catherine`.`fato_censo` ;

CREATE  TABLE IF NOT EXISTS `catherine`.`fato_censo` (
  `dim_local_id` INT NOT NULL ,
  `dim_tempo_id` INT NOT NULL ,
  `media_acertos` DECIMAL(5,2) NULL ,
  `percentual_aprovacao` DECIMAL(2,2) NULL ,
  `percentual_estudantes_prevestibular` DECIMAL(2,2) NULL ,
  `numero_estudantes_prevestibular` INT NULL ,
  `numero_vestibulandos` INT NULL ,
  `numero_estudantes_ensino_medio` INT NULL ,
  `media_renda_bruta` VARCHAR(45) NULL ,
  PRIMARY KEY (`dim_local_id`, `dim_tempo_id`) ,
  INDEX `fk_fato_censo_dim_tempo1` (`dim_tempo_id` ASC) ,
  CONSTRAINT `fk_fato_censo_dim_local1`
    FOREIGN KEY (`dim_local_id` )
    REFERENCES `catherine`.`dim_local` (`dim_local_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fato_censo_dim_tempo1`
    FOREIGN KEY (`dim_tempo_id` )
    REFERENCES `catherine`.`dim_tempo` (`dim_tempo_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
