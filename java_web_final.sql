-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema java_web
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema java_web
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `java_web` DEFAULT CHARACTER SET utf8 ;
USE `java_web` ;

-- -----------------------------------------------------
-- Table `java_web`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `java_web`.`user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `role` VARCHAR(2) CHARACTER SET 'utf8' NOT NULL,
  `verify_state` TINYINT(4) NOT NULL DEFAULT '0',
  `user_logo_path` VARCHAR(45) NOT NULL,
  `user_nickname` VARCHAR(45) NULL DEFAULT NULL,
  `user_address` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 138
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `java_web`.`enterprise`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `java_web`.`enterprise` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `enterprise_name` VARCHAR(45) NOT NULL,
  `enterprise_logo_path` VARCHAR(45) NOT NULL,
  `enterprise_address` VARCHAR(45) NOT NULL,
  `enterprise_tel` VARCHAR(45) NOT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `enterprise_name_UNIQUE` (`enterprise_name` ASC) VISIBLE,
  UNIQUE INDEX `enterprise_logo_path_UNIQUE` (`enterprise_logo_path` ASC) VISIBLE,
  INDEX `fk_enterprise_user_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_enterprise_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `java_web`.`user` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 18
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `java_web`.`item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `java_web`.`item` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `stock` INT(4) NULL DEFAULT NULL,
  `item_name` VARCHAR(45) NOT NULL,
  `item_price` INT(5) NOT NULL,
  `item_pic_path` VARCHAR(45) NOT NULL,
  `item_tag` VARCHAR(45) NOT NULL,
  `enterprise_id` INT(11) NOT NULL,
  `item_sale_num` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_item_enterprise1_idx` (`enterprise_id` ASC) VISIBLE,
  CONSTRAINT `fk_item_enterprise1`
    FOREIGN KEY (`enterprise_id`)
    REFERENCES `java_web`.`enterprise` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `java_web`.`cart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `java_web`.`cart` (
  `cart_item_num` INT(3) NOT NULL,
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `item_id` INT(11) NOT NULL,
  `cart_sum_price` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cart_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_cart_item1_idx` (`item_id` ASC) VISIBLE,
  CONSTRAINT `fk_cart_item1`
    FOREIGN KEY (`item_id`)
    REFERENCES `java_web`.`item` (`id`),
  CONSTRAINT `fk_cart_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `java_web`.`user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `java_web`.`order_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `java_web`.`order_detail` (
  `order_time` DATETIME NOT NULL,
  `order_item_num` INT(11) NOT NULL,
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `item_id` INT(11) NOT NULL,
  `order_sum_price` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_order_detail_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_order_detail_item1_idx` (`item_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_detail_item1`
    FOREIGN KEY (`item_id`)
    REFERENCES `java_web`.`item` (`id`),
  CONSTRAINT `fk_order_detail_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `java_web`.`user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
