-- -------------------------------------------
SET AUTOCOMMIT=0;
START TRANSACTION;
SET SQL_QUOTE_SHOW_CREATE = 1;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
-- -------------------------------------------
-- -------------------------------------------
-- START BACKUP
-- -------------------------------------------
-- -------------------------------------------
-- TABLE `AuthAssignment`
-- -------------------------------------------
DROP TABLE IF EXISTS `AuthAssignment`;
CREATE TABLE IF NOT EXISTS `AuthAssignment` (
  `itemname` varchar(64) CHARACTER SET latin1 NOT NULL,
  `userid` varchar(64) CHARACTER SET latin1 NOT NULL,
  `bizrule` text CHARACTER SET latin1,
  `data` text CHARACTER SET latin1,
  PRIMARY KEY (`itemname`,`userid`),
  CONSTRAINT `FK_AuthAssignment` FOREIGN KEY (`itemname`) REFERENCES `AuthItem` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `AuthItem`
-- -------------------------------------------
DROP TABLE IF EXISTS `AuthItem`;
CREATE TABLE IF NOT EXISTS `AuthItem` (
  `name` varchar(64) CHARACTER SET latin1 NOT NULL,
  `type` int(11) NOT NULL,
  `description` text CHARACTER SET latin1,
  `bizrule` text CHARACTER SET latin1,
  `data` text CHARACTER SET latin1,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `AuthItemChild`
-- -------------------------------------------
DROP TABLE IF EXISTS `AuthItemChild`;
CREATE TABLE IF NOT EXISTS `AuthItemChild` (
  `parent` varchar(64) CHARACTER SET latin1 NOT NULL,
  `child` varchar(64) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `account`
-- -------------------------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE IF NOT EXISTS `account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `current_balance` decimal(15,4) DEFAULT '0.0000',
  `status` varchar(1) DEFAULT '1',
  `date_created` datetime DEFAULT NULL,
  `note` text,
  PRIMARY KEY (`id`),
  KEY `FK_account_client_id` (`client_id`),
  CONSTRAINT `FK_account` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- -------------------------------------------
-- TABLE `account_receivable`
-- -------------------------------------------
DROP TABLE IF EXISTS `account_receivable`;
CREATE TABLE IF NOT EXISTS `account_receivable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `trans_id` int(11) NOT NULL,
  `trans_amount` decimal(15,4) DEFAULT NULL,
  `trans_code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trans_datetime` datetime DEFAULT NULL,
  `trans_status` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT 'N',
  `note` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `FK_transactions_account_id` (`account_id`),
  KEY `FK_transactions_employee_id` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `account_receivable_supplier`
-- -------------------------------------------
DROP TABLE IF EXISTS `account_receivable_supplier`;
CREATE TABLE IF NOT EXISTS `account_receivable_supplier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `trans_id` int(11) NOT NULL,
  `trans_amount` decimal(15,4) DEFAULT NULL,
  `trans_code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trans_datetime` datetime DEFAULT NULL,
  `trans_status` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT 'N',
  `note` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `account_supplier`
-- -------------------------------------------
DROP TABLE IF EXISTS `account_supplier`;
CREATE TABLE IF NOT EXISTS `account_supplier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supplier_id` int(11) NOT NULL,
  `name` varchar(60) DEFAULT NULL,
  `current_balance` decimal(15,4) DEFAULT '0.0000',
  `status` varchar(1) DEFAULT '1',
  `date_created` datetime DEFAULT NULL,
  `note` text,
  PRIMARY KEY (`id`),
  KEY `FK_account_supplier_supplier_id` (`supplier_id`),
  CONSTRAINT `FK_account_supplier_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- -------------------------------------------
-- TABLE `app_config`
-- -------------------------------------------
DROP TABLE IF EXISTS `app_config`;
CREATE TABLE IF NOT EXISTS `app_config` (
  `key` varchar(255) CHARACTER SET utf8 NOT NULL,
  `value` varchar(255) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `category`
-- -------------------------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 NOT NULL,
  `created_date` datetime DEFAULT NULL,
  `modified_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `client`
-- -------------------------------------------
DROP TABLE IF EXISTS `client`;
CREATE TABLE IF NOT EXISTS `client` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) CHARACTER SET utf8 NOT NULL,
  `last_name` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `mobile_no` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `address1` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
  `address2` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `country_code` varchar(2) CHARACTER SET utf8 DEFAULT NULL,
  `email` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `notes` text CHARACTER SET utf8,
  `status` varchar(1) CHARACTER SET utf8 DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `currency_type`
-- -------------------------------------------
DROP TABLE IF EXISTS `currency_type`;
CREATE TABLE IF NOT EXISTS `currency_type` (
  `code` int(11) NOT NULL DEFAULT '0',
  `currency_id` char(3) NOT NULL DEFAULT '',
  `currency_name` varchar(70) NOT NULL DEFAULT '',
  PRIMARY KEY (`currency_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- -------------------------------------------
-- TABLE `debt_collector`
-- -------------------------------------------
DROP TABLE IF EXISTS `debt_collector`;
CREATE TABLE IF NOT EXISTS `debt_collector` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fullname` varchar(100) NOT NULL,
  `mobile_no` varchar(15) DEFAULT NULL,
  `adddress1` varchar(60) DEFAULT NULL,
  `address2` varchar(60) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `country_code` varchar(2) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- -------------------------------------------
-- TABLE `debter_client_ref`
-- -------------------------------------------
DROP TABLE IF EXISTS `debter_client_ref`;
CREATE TABLE IF NOT EXISTS `debter_client_ref` (
  `debter_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  PRIMARY KEY (`debter_id`,`client_id`),
  KEY `FK_debter_client_ref_client_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- -------------------------------------------
-- TABLE `employee`
-- -------------------------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE IF NOT EXISTS `employee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) CHARACTER SET utf8 NOT NULL,
  `last_name` varchar(50) CHARACTER SET utf8 NOT NULL,
  `mobile_no` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `adddress1` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
  `address2` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `country_code` varchar(2) CHARACTER SET utf8 DEFAULT NULL,
  `email` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `notes` text CHARACTER SET utf8,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `employee_image`
-- -------------------------------------------
DROP TABLE IF EXISTS `employee_image`;
CREATE TABLE IF NOT EXISTS `employee_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL,
  `photo` blob NOT NULL,
  `thumbnail` blob,
  `filename` varchar(30) CHARACTER SET latin1 NOT NULL,
  `filetype` varchar(15) CHARACTER SET latin1 DEFAULT NULL,
  `path` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `width` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `height` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_employee_image_emp_id` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `exchange_rate`
-- -------------------------------------------
DROP TABLE IF EXISTS `exchange_rate`;
CREATE TABLE IF NOT EXISTS `exchange_rate` (
  `base_currency` varchar(3) NOT NULL,
  `to_currency` varchar(3) NOT NULL,
  `base_cur_val` double(15,2) NOT NULL,
  `to_cur_val` double(15,2) NOT NULL,
  PRIMARY KEY (`base_currency`,`to_currency`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- -------------------------------------------
-- TABLE `inventory`
-- -------------------------------------------
DROP TABLE IF EXISTS `inventory`;
CREATE TABLE IF NOT EXISTS `inventory` (
  `trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `trans_items` int(11) NOT NULL,
  `trans_user` int(11) NOT NULL,
  `trans_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `trans_comment` text CHARACTER SET utf8 NOT NULL,
  `trans_inventory` double(15,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`trans_id`),
  KEY `FK_inventory_item_id` (`trans_items`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `invoice`
-- -------------------------------------------
DROP TABLE IF EXISTS `invoice`;
CREATE TABLE IF NOT EXISTS `invoice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `invoice_number` varchar(50) CHARACTER SET utf8 NOT NULL,
  `date_issued` date DEFAULT NULL,
  `amount` decimal(15,3) DEFAULT NULL,
  `work_description` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  `payment_term` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `taxt1_rate` decimal(6,2) DEFAULT NULL,
  `tax1_desc` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `tax2_rate` decimal(6,2) DEFAULT NULL,
  `tax2_desc` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `note` text CHARACTER SET utf8,
  `day_payment_due` int(11) DEFAULT NULL,
  `flag` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_invoice_client_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `invoice_item`
-- -------------------------------------------
DROP TABLE IF EXISTS `invoice_item`;
CREATE TABLE IF NOT EXISTS `invoice_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_id` int(11) NOT NULL,
  `amount` decimal(10,3) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `work_description` text,
  `discount` decimal(10,3) DEFAULT NULL,
  `discount_desc` varchar(400) DEFAULT NULL,
  `modified_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_invoice_item_invoice_id` (`invoice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- -------------------------------------------
-- TABLE `invoice_payment`
-- -------------------------------------------
DROP TABLE IF EXISTS `invoice_payment`;
CREATE TABLE IF NOT EXISTS `invoice_payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_id` int(11) NOT NULL,
  `invoice_number` varchar(50) DEFAULT NULL,
  `date_paid` date DEFAULT NULL,
  `amount_paid` decimal(10,3) NOT NULL,
  `give_away` decimal(10,3) DEFAULT NULL,
  `note` text,
  `modified_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `FK_invoice_payment_invoice_id` (`invoice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- -------------------------------------------
-- TABLE `item`
-- -------------------------------------------
DROP TABLE IF EXISTS `item`;
CREATE TABLE IF NOT EXISTS `item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 NOT NULL,
  `item_number` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `cost_price` double(15,4) DEFAULT NULL,
  `unit_price` double(15,4) DEFAULT NULL,
  `quantity` double(15,2) NOT NULL,
  `reorder_level` double(15,2) DEFAULT NULL,
  `location` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `allow_alt_description` tinyint(1) DEFAULT NULL,
  `is_serialized` tinyint(1) DEFAULT NULL,
  `description` text CHARACTER SET utf8,
  `status` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `created_date` datetime DEFAULT NULL,
  `modified_date` datetime DEFAULT NULL,
  `is_expire` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_item_category_id` (`category_id`),
  KEY `FK_item_supplier_id` (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `item_expire`
-- -------------------------------------------
DROP TABLE IF EXISTS `item_expire`;
CREATE TABLE IF NOT EXISTS `item_expire` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `mfd_date` date DEFAULT NULL,
  `expire_date` date NOT NULL,
  `quantity` decimal(15,2) DEFAULT '0.00',
  PRIMARY KEY (`id`,`item_id`,`expire_date`),
  UNIQUE KEY `item_expire` (`item_id`,`expire_date`),
  KEY `FK_item_expire_item_id` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `item_expire_dt`
-- -------------------------------------------
DROP TABLE IF EXISTS `item_expire_dt`;
CREATE TABLE IF NOT EXISTS `item_expire_dt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_expire_id` int(11) NOT NULL,
  `trans_id` int(11) NOT NULL,
  `trans_qty` decimal(15,2) NOT NULL,
  `trans_comment` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_date` datetime DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_item_expire_dt` (`item_expire_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `item_image`
-- -------------------------------------------
DROP TABLE IF EXISTS `item_image`;
CREATE TABLE IF NOT EXISTS `item_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `photo` blob NOT NULL,
  `thumbnail` blob,
  `filename` varchar(30) CHARACTER SET latin1 NOT NULL,
  `filetype` varchar(15) CHARACTER SET latin1 DEFAULT NULL,
  `path` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `width` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `height` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_item_image_item_id` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `item_price`
-- -------------------------------------------
DROP TABLE IF EXISTS `item_price`;
CREATE TABLE IF NOT EXISTS `item_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `old_price` double(15,4) DEFAULT NULL,
  `new_price` double(15,4) DEFAULT NULL,
  `modified_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_item_price_item_id` (`item_id`),
  KEY `FK_item_price_emp_id` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `item_price_promo`
-- -------------------------------------------
DROP TABLE IF EXISTS `item_price_promo`;
CREATE TABLE IF NOT EXISTS `item_price_promo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) DEFAULT NULL,
  `unit_price` double(15,4) NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `item_id_udx` (`item_id`),
  CONSTRAINT `FK_item_price_promo_id` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `item_price_promo_dt`
-- -------------------------------------------
DROP TABLE IF EXISTS `item_price_promo_dt`;
CREATE TABLE IF NOT EXISTS `item_price_promo_dt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_price_promo_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `unit_price` double(15,4) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `modified_date` datetime DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `item_price_tier`
-- -------------------------------------------
DROP TABLE IF EXISTS `item_price_tier`;
CREATE TABLE IF NOT EXISTS `item_price_tier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `price_tier_id` int(11) NOT NULL,
  `price` double(15,4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`item_id`,`price_tier_id`),
  KEY `FK_item_price_tier_item_id` (`item_id`),
  KEY `FK_item_price_tier_id` (`price_tier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `item_sub_unit`
-- -------------------------------------------
DROP TABLE IF EXISTS `item_sub_unit`;
CREATE TABLE IF NOT EXISTS `item_sub_unit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- -------------------------------------------
-- TABLE `item_unit`
-- -------------------------------------------
DROP TABLE IF EXISTS `item_unit`;
CREATE TABLE IF NOT EXISTS `item_unit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- -------------------------------------------
-- TABLE `item_unit_quantity`
-- -------------------------------------------
DROP TABLE IF EXISTS `item_unit_quantity`;
CREATE TABLE IF NOT EXISTS `item_unit_quantity` (
  `item_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `quantity` double(15,2) NOT NULL,
  `cost_price` double(15,2) DEFAULT NULL,
  `unit_price` double(15,2) DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  KEY `FK_item_unit_quantity_unit_id` (`unit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- -------------------------------------------
-- TABLE `price_tier`
-- -------------------------------------------
DROP TABLE IF EXISTS `price_tier`;
CREATE TABLE IF NOT EXISTS `price_tier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tier_name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modified_date` datetime DEFAULT NULL,
  `deleted` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `rbac_group`
-- -------------------------------------------
DROP TABLE IF EXISTS `rbac_group`;
CREATE TABLE IF NOT EXISTS `rbac_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(60) NOT NULL,
  `note` varchar(250) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- -------------------------------------------
-- TABLE `rbac_user`
-- -------------------------------------------
DROP TABLE IF EXISTS `rbac_user`;
CREATE TABLE IF NOT EXISTS `rbac_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(60) CHARACTER SET utf8 NOT NULL,
  `group_id` int(11) DEFAULT NULL,
  `employee_id` int(11) NOT NULL,
  `user_password` varchar(128) CHARACTER SET utf8 NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `status` tinyint(1) DEFAULT '1',
  `date_entered` datetime DEFAULT NULL,
  `modified_date` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_indx` (`user_name`),
  KEY `FK_rbac_user_group_id` (`group_id`),
  KEY `FK_rbac_user_employee_id` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `receiving`
-- -------------------------------------------
DROP TABLE IF EXISTS `receiving`;
CREATE TABLE IF NOT EXISTS `receiving` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `receive_time` datetime NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `sub_total` double(15,4) DEFAULT NULL,
  `payment_type` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `status` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `remark` text CHARACTER SET utf8,
  `discount_amount` decimal(15,4) DEFAULT NULL,
  `discount_type` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_sale_emp_id` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `receiving_item`
-- -------------------------------------------
DROP TABLE IF EXISTS `receiving_item`;
CREATE TABLE IF NOT EXISTS `receiving_item` (
  `receive_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `description` text CHARACTER SET utf8,
  `line` int(11) DEFAULT NULL,
  `quantity` double(15,2) DEFAULT NULL,
  `cost_price` double(15,4) DEFAULT NULL,
  `unit_price` double(15,4) DEFAULT NULL,
  `price` double(15,4) DEFAULT NULL,
  `discount_amount` double(15,2) DEFAULT NULL,
  `discount_type` varchar(2) CHARACTER SET utf8 DEFAULT '%',
  PRIMARY KEY (`receive_id`,`item_id`),
  KEY `FK_sale_item_item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `sale`
-- -------------------------------------------
DROP TABLE IF EXISTS `sale`;
CREATE TABLE IF NOT EXISTS `sale` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sale_time` datetime NOT NULL,
  `client_id` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `sub_total` decimal(15,4) DEFAULT NULL,
  `payment_type` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `remark` text CHARACTER SET utf8,
  `discount_amount` decimal(15,2) DEFAULT '0.00',
  `discount_type` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_sale_emp_id` (`employee_id`),
  KEY `FK_sale_client_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `sale_client_cookie`
-- -------------------------------------------
DROP TABLE IF EXISTS `sale_client_cookie`;
CREATE TABLE IF NOT EXISTS `sale_client_cookie` (
  `client_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `description` text,
  `quantity` double(15,2) NOT NULL,
  `cost_price` double(15,4) DEFAULT NULL,
  `unit_price` double(15,4) DEFAULT NULL,
  `price` double(15,4) DEFAULT NULL,
  `discount_amount` decimal(15,2) DEFAULT NULL,
  `discount_type` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`client_id`,`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- -------------------------------------------
-- TABLE `sale_item`
-- -------------------------------------------
DROP TABLE IF EXISTS `sale_item`;
CREATE TABLE IF NOT EXISTS `sale_item` (
  `sale_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `description` text CHARACTER SET utf8,
  `line` int(11) DEFAULT NULL,
  `quantity` double(15,2) DEFAULT NULL,
  `cost_price` double(15,4) DEFAULT NULL,
  `unit_price` double(15,4) DEFAULT NULL,
  `price` double(15,4) DEFAULT NULL,
  `discount_amount` double(15,2) DEFAULT NULL,
  `discount_type` varchar(2) CHARACTER SET utf8 DEFAULT '%',
  PRIMARY KEY (`sale_id`,`item_id`),
  KEY `FK_sale_item_item_id` (`item_id`),
  CONSTRAINT `FK_sale_item_sale_id` FOREIGN KEY (`sale_id`) REFERENCES `sale` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `sale_payment`
-- -------------------------------------------
DROP TABLE IF EXISTS `sale_payment`;
CREATE TABLE IF NOT EXISTS `sale_payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sale_id` int(11) NOT NULL,
  `payment_type` varchar(40) CHARACTER SET utf8 DEFAULT NULL,
  `payment_amount` double NOT NULL,
  `give_away` double DEFAULT NULL,
  `date_paid` datetime DEFAULT NULL,
  `note` text CHARACTER SET utf8,
  `modified_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_sale_payment_sale_id` (`sale_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `sale_suspended`
-- -------------------------------------------
DROP TABLE IF EXISTS `sale_suspended`;
CREATE TABLE IF NOT EXISTS `sale_suspended` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sale_time` datetime NOT NULL,
  `client_id` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `sub_total` double(15,4) DEFAULT NULL,
  `payment_type` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `remark` text CHARACTER SET utf8,
  PRIMARY KEY (`id`),
  KEY `FK_sale_suspended_client_id` (`client_id`),
  KEY `FK_sale_suspended_emp_Id` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `sale_suspended_item`
-- -------------------------------------------
DROP TABLE IF EXISTS `sale_suspended_item`;
CREATE TABLE IF NOT EXISTS `sale_suspended_item` (
  `sale_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `description` text CHARACTER SET utf8,
  `line` int(11) DEFAULT NULL,
  `quantity` double(15,2) DEFAULT NULL,
  `cost_price` double(15,4) DEFAULT NULL,
  `unit_price` double(15,4) DEFAULT NULL,
  `price` double(15,4) DEFAULT NULL,
  `discount_amount` double(15,2) DEFAULT NULL,
  `discount_type` varchar(2) CHARACTER SET utf8 DEFAULT '%',
  KEY `FK_sale_suspended_item_sale_id` (`sale_id`),
  KEY `FK_sale_suspended_item_item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `sale_suspended_payment`
-- -------------------------------------------
DROP TABLE IF EXISTS `sale_suspended_payment`;
CREATE TABLE IF NOT EXISTS `sale_suspended_payment` (
  `sale_id` int(11) NOT NULL,
  `payment_type` varchar(40) CHARACTER SET utf8 NOT NULL,
  `payment_amount` double NOT NULL,
  PRIMARY KEY (`sale_id`,`payment_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `settings`
-- -------------------------------------------
DROP TABLE IF EXISTS `settings`;
CREATE TABLE IF NOT EXISTS `settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(64) CHARACTER SET utf8 NOT NULL DEFAULT 'system',
  `key` varchar(255) CHARACTER SET utf8 NOT NULL,
  `value` text CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_key` (`category`,`key`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `supplier`
-- -------------------------------------------
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE IF NOT EXISTS `supplier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(60) CHARACTER SET utf8 NOT NULL,
  `first_name` varchar(30) CHARACTER SET utf8 NOT NULL,
  `last_name` varchar(30) CHARACTER SET utf8 NOT NULL,
  `mobile_no` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `address1` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `address2` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `country_code` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `email` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `notes` text CHARACTER SET utf8,
  `status` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `tbl_audit_logs`
-- -------------------------------------------
DROP TABLE IF EXISTS `tbl_audit_logs`;
CREATE TABLE IF NOT EXISTS `tbl_audit_logs` (
  `username` varchar(50) CHARACTER SET latin1 NOT NULL,
  `ipaddress` varchar(50) CHARACTER SET latin1 NOT NULL,
  `logtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `controller` varchar(255) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `action` varchar(255) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `details` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE `transactions`
-- -------------------------------------------
DROP TABLE IF EXISTS `transactions`;
CREATE TABLE IF NOT EXISTS `transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `trans_amount` decimal(15,4) DEFAULT NULL,
  `trans_code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trans_datetime` datetime DEFAULT NULL,
  `trans_status` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT 'N',
  `note` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `FK_transactions_account_id` (`account_id`),
  KEY `FK_transactions_employee_id` (`employee_id`),
  CONSTRAINT `FK_transactions_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_transactions_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------
-- TABLE DATA AuthAssignment
-- -------------------------------------------
INSERT INTO AuthAssignment VALUES("client.create","2",Null,Null);
INSERT INTO AuthAssignment VALUES("client.create","3",Null,Null);
INSERT INTO AuthAssignment VALUES("client.delete","2",Null,Null);
INSERT INTO AuthAssignment VALUES("client.delete","3",Null,Null);
INSERT INTO AuthAssignment VALUES("client.index","2",Null,Null);
INSERT INTO AuthAssignment VALUES("client.index","3",Null,Null);
INSERT INTO AuthAssignment VALUES("client.update","2",Null,Null);
INSERT INTO AuthAssignment VALUES("client.update","3",Null,Null);
INSERT INTO AuthAssignment VALUES("employee.create","2",Null,Null);
INSERT INTO AuthAssignment VALUES("employee.create","3",Null,Null);
INSERT INTO AuthAssignment VALUES("employee.delete","2",Null,Null);
INSERT INTO AuthAssignment VALUES("employee.delete","3",Null,Null);
INSERT INTO AuthAssignment VALUES("employee.index","2",Null,Null);
INSERT INTO AuthAssignment VALUES("employee.index","3",Null,Null);
INSERT INTO AuthAssignment VALUES("employee.update","2",Null,Null);
INSERT INTO AuthAssignment VALUES("employee.update","3",Null,Null);
INSERT INTO AuthAssignment VALUES("invoice.delete","3",Null,Null);
INSERT INTO AuthAssignment VALUES("invoice.index","3",Null,Null);
INSERT INTO AuthAssignment VALUES("invoice.print","3",Null,Null);
INSERT INTO AuthAssignment VALUES("item.create","2",Null,Null);
INSERT INTO AuthAssignment VALUES("item.create","3",Null,Null);
INSERT INTO AuthAssignment VALUES("item.delete","2",Null,Null);
INSERT INTO AuthAssignment VALUES("item.delete","3",Null,Null);
INSERT INTO AuthAssignment VALUES("item.index","2",Null,Null);
INSERT INTO AuthAssignment VALUES("item.index","3",Null,Null);
INSERT INTO AuthAssignment VALUES("item.update","2",Null,Null);
INSERT INTO AuthAssignment VALUES("item.update","3",Null,Null);
INSERT INTO AuthAssignment VALUES("payment.index","3",Null,Null);
INSERT INTO AuthAssignment VALUES("receiving.edit","2",Null,Null);
INSERT INTO AuthAssignment VALUES("report.index","2",Null,Null);
INSERT INTO AuthAssignment VALUES("report.index","3",Null,Null);
INSERT INTO AuthAssignment VALUES("sale.discount","2",Null,Null);
INSERT INTO AuthAssignment VALUES("sale.discount","3",Null,Null);
INSERT INTO AuthAssignment VALUES("sale.edit","2",Null,Null);
INSERT INTO AuthAssignment VALUES("sale.edit","3",Null,Null);
INSERT INTO AuthAssignment VALUES("sale.editprice","2",Null,Null);
INSERT INTO AuthAssignment VALUES("sale.editprice","3",Null,Null);
INSERT INTO AuthAssignment VALUES("store.update","2",Null,Null);
INSERT INTO AuthAssignment VALUES("store.update","3",Null,Null);
INSERT INTO AuthAssignment VALUES("supplier.create","2",Null,Null);
INSERT INTO AuthAssignment VALUES("supplier.create","3",Null,Null);
INSERT INTO AuthAssignment VALUES("supplier.delete","2",Null,Null);
INSERT INTO AuthAssignment VALUES("supplier.delete","3",Null,Null);
INSERT INTO AuthAssignment VALUES("supplier.index","2",Null,Null);
INSERT INTO AuthAssignment VALUES("supplier.index","3",Null,Null);
INSERT INTO AuthAssignment VALUES("supplier.update","2",Null,Null);
INSERT INTO AuthAssignment VALUES("supplier.update","3",Null,Null);
INSERT INTO AuthAssignment VALUES("transaction.adjustin","3",Null,Null);
INSERT INTO AuthAssignment VALUES("transaction.adjustout","3",Null,Null);
INSERT INTO AuthAssignment VALUES("transaction.count","3",Null,Null);
INSERT INTO AuthAssignment VALUES("transaction.receive","3",Null,Null);
INSERT INTO AuthAssignment VALUES("transaction.return","3",Null,Null);
INSERT INTO AuthAssignment VALUES("transaction.transfer","3",Null,Null);






-- -------------------------------------------
-- TABLE DATA AuthItem
-- -------------------------------------------
INSERT INTO AuthItem VALUES("client.create","0","Create Client",Null,"N;");
INSERT INTO AuthItem VALUES("client.delete","0","Delete Client",Null,"N;");
INSERT INTO AuthItem VALUES("client.index","0","List Client",Null,"N;");
INSERT INTO AuthItem VALUES("client.update","0","Update Client",Null,"N;");
INSERT INTO AuthItem VALUES("employee.create","0","Create Employee",Null,Null);
INSERT INTO AuthItem VALUES("employee.delete","0","Delete Employee",Null,Null);
INSERT INTO AuthItem VALUES("employee.index","0","List Employee",Null,Null);
INSERT INTO AuthItem VALUES("employee.update","0","Update Employee",Null,Null);
INSERT INTO AuthItem VALUES("invoice.delete","0","Cancel Invoice",Null,"N;");
INSERT INTO AuthItem VALUES("invoice.index","0","List Invoice",Null,"N;");
INSERT INTO AuthItem VALUES("invoice.print","0","Re-print Invoice",Null,"N;");
INSERT INTO AuthItem VALUES("invoice.update","0","Update Invoice",Null,"N;");
INSERT INTO AuthItem VALUES("item.create","0","Create Item",Null,Null);
INSERT INTO AuthItem VALUES("item.delete","0","Delete Item",Null,Null);
INSERT INTO AuthItem VALUES("item.index","0","List Item",Null,Null);
INSERT INTO AuthItem VALUES("item.update","0","Update Item",Null,Null);
INSERT INTO AuthItem VALUES("itemAdmin","1","Administer Item",Null,"N;");
INSERT INTO AuthItem VALUES("payment.index","0","Invoice Payment (Debt)",Null,Null);
INSERT INTO AuthItem VALUES("receiving.edit","0","Process Purchase orders",Null,"N;");
INSERT INTO AuthItem VALUES("report.index","0","View and generate reports",Null,"N;");
INSERT INTO AuthItem VALUES("sale.discount","0","Sale Give Discount",Null,"N;");
INSERT INTO AuthItem VALUES("sale.edit","0","Edit Sale",Null,"N;");
INSERT INTO AuthItem VALUES("sale.editprice","0","Edit Sale Price",Null,"N;");
INSERT INTO AuthItem VALUES("setting.exchangerate","0","Exchange Rate",Null,Null);
INSERT INTO AuthItem VALUES("setting.receipt","0","Receipt Setting",Null,Null);
INSERT INTO AuthItem VALUES("setting.sale","0","Sale Setting",Null,Null);
INSERT INTO AuthItem VALUES("setting.site","0","Shop Setting",Null,Null);
INSERT INTO AuthItem VALUES("setting.system","0","System Setting",Null,Null);
INSERT INTO AuthItem VALUES("store.update","0","Change the store\'s configuration",Null,"N;");
INSERT INTO AuthItem VALUES("supplier.create","0","Create Supplier",Null,Null);
INSERT INTO AuthItem VALUES("supplier.delete","0","Delete Supplier",Null,Null);
INSERT INTO AuthItem VALUES("supplier.index","0","List Supplier",Null,Null);
INSERT INTO AuthItem VALUES("supplier.update","0","Update Supplier",Null,Null);
INSERT INTO AuthItem VALUES("transaction.adjustin","0","Adjustment In",Null,Null);
INSERT INTO AuthItem VALUES("transaction.adjustout","0","Adjustment Out",Null,Null);
INSERT INTO AuthItem VALUES("transaction.count","0","Physical Count",Null,Null);
INSERT INTO AuthItem VALUES("transaction.receive","0","Receive from Supplier",Null,Null);
INSERT INTO AuthItem VALUES("transaction.return","0","Return to Supplier",Null,Null);
INSERT INTO AuthItem VALUES("transaction.transfer","0","Transfer to (Another Branch)",Null,Null);






-- -------------------------------------------
-- TABLE DATA AuthItemChild
-- -------------------------------------------






-- -------------------------------------------
-- TABLE DATA account
-- -------------------------------------------
INSERT INTO account VALUES("1","1","Nano","0.0000","1","2014-11-03 13:52:16",Null);






-- -------------------------------------------
-- TABLE DATA account_receivable
-- -------------------------------------------






-- -------------------------------------------
-- TABLE DATA account_receivable_supplier
-- -------------------------------------------
INSERT INTO account_receivable_supplier VALUES("1","2","38","21","16.0000","CHRECV","2014-10-23 12:50:23","N",Null);
INSERT INTO account_receivable_supplier VALUES("2","2","38","22","8.0000","CHRECV","2014-10-23 13:10:49","N",Null);
INSERT INTO account_receivable_supplier VALUES("3","1","38","23","25.0000","CHRECV","2014-10-23 23:51:03","N",Null);
INSERT INTO account_receivable_supplier VALUES("4","1","38","24","2.5000","CHRECV","2014-10-24 09:49:53","N",Null);
INSERT INTO account_receivable_supplier VALUES("5","2","38","25","10.5000","CHRECV","2014-10-28 03:02:34","N",Null);
INSERT INTO account_receivable_supplier VALUES("6","3","38","26","11.8000","CHRECV","2014-10-28 03:59:09","N",Null);
INSERT INTO account_receivable_supplier VALUES("7","4","38","27","39.6000","CHRECV","2014-10-28 04:00:41","N",Null);
INSERT INTO account_receivable_supplier VALUES("8","2","38","28","20.0000","CHRECV","2014-10-28 04:03:01","N",Null);
INSERT INTO account_receivable_supplier VALUES("9","3","38","29","2.3000","CHRECV","2014-10-28 04:04:50","N",Null);






-- -------------------------------------------
-- TABLE DATA account_supplier
-- -------------------------------------------
INSERT INTO account_supplier VALUES("1","2","ABC","27.5000","1","2014-10-23 05:38:32",Null);
INSERT INTO account_supplier VALUES("2","3","iOne","54.5000","1","2014-10-23 05:46:11",Null);
INSERT INTO account_supplier VALUES("3","4","Cellcard","14.1000","1","2014-10-23 05:48:07",Null);
INSERT INTO account_supplier VALUES("4","5","Royal Group","39.6000","1","2014-10-24 10:30:17",Null);






-- -------------------------------------------
-- TABLE DATA app_config
-- -------------------------------------------






-- -------------------------------------------
-- TABLE DATA category
-- -------------------------------------------
INSERT INTO category VALUES("1","Medicine","2014-11-01 00:00:00",Null);






-- -------------------------------------------
-- TABLE DATA client
-- -------------------------------------------
INSERT INTO client VALUES("1","Nano","ipod","012812812",Null,Null,Null,Null,Null,Null,"1");






-- -------------------------------------------
-- TABLE DATA currency_type
-- -------------------------------------------
INSERT INTO currency_type VALUES("76","KHR","Kampuchea Riel");
INSERT INTO currency_type VALUES("142","THB","Thai Baht");
INSERT INTO currency_type VALUES("151","USD","United States Dollar");






-- -------------------------------------------
-- TABLE DATA debt_collector
-- -------------------------------------------






-- -------------------------------------------
-- TABLE DATA debter_client_ref
-- -------------------------------------------






-- -------------------------------------------
-- TABLE DATA employee
-- -------------------------------------------
INSERT INTO employee VALUES("37","Owner","System","012999068",Null,Null,Null,Null,Null,Null);
INSERT INTO employee VALUES("38","super","pos","012878878","super addresss1","super address",Null,Null,Null,Null);






-- -------------------------------------------
-- TABLE DATA employee_image
-- -------------------------------------------






-- -------------------------------------------
-- TABLE DATA exchange_rate
-- -------------------------------------------






-- -------------------------------------------
-- TABLE DATA inventory
-- -------------------------------------------






-- -------------------------------------------
-- TABLE DATA invoice
-- -------------------------------------------






-- -------------------------------------------
-- TABLE DATA invoice_item
-- -------------------------------------------






-- -------------------------------------------
-- TABLE DATA invoice_payment
-- -------------------------------------------






-- -------------------------------------------
-- TABLE DATA item
-- -------------------------------------------
INSERT INTO item VALUES("1","Dofelo","8935085510415","1",Null,"3.0000","12.0000","2.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("2","Domepra","8935085510316","1",Null,"0.9000","3.3000","250.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("3","Doparexib 200mg","8935085513614","1",Null,"2.2000","4.2000","76.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("4","Dolumixib 100mg","8935085513416","1",Null,"1.2000","2.2000","63.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("5","Oripicin 1mg","8935204502536","1",Null,"2.0000","4.5000","20.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("6","Vixzol 500mg","8935085513010","1",Null,"5.0000","12.5000","14.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("7","Fucefu 500mg","8935204510913","1",Null,"4.5000","5.5000","26.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("8","Futipus 100mg","8935204513334","1",Null,"1.2000","1.8000","84.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("9","Pandonam 40mg","8935085503615","1",Null,"1.8000","3.5000","29.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("10","Fudcefu 250mg","8935204510814","1",Null,"2.5000","3.7000","88.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("11","Ormyco 120mg","8935204517318","1",Null,"2.4000","3.0000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("12","Phudskin 10mg","8935204521438","1",Null,"1.8000","2.6000","14.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("13","Clari-Meyer 250mg",Null,"1",Null,"3.2000","5.5000","34.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("14","Baby 250mg","8935204501127","1",Null,"1.4000","2.2000","84.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("15","Prenisolone 5mg",Null,"1",Null,"1.0000","1.5000","11.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("16","Cool flu","8935204501331","1",Null,"3.0000","3.8500","10.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("17","Magnesi-B6","8935085513539","1",Null,"1.8000","2.8000","86.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("18","SkD fort 500mg","8935204511415","1",Null,"2.7000","3.5000","56.50",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("19","Dothaimin","8935085508733","1",Null,"2.7000","3.5000","6.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("20","Nelidevi","8935204517417","1",Null,"3.5000","5.5000","11.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("21","Denilac","8935085522234","1",Null,"3.0000","4.5500","14.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("22","Vixzol 400mg","8935085512914","1",Null,"4.0000","10.0000","20.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("23","SKD cafein","8935204501232","1",Null,"1.8000","2.8000","60.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("24","Fudocal","8935204514638","1",Null,"3.0000","7.5000","13.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("25","Oricefa 500mg","8935204510135","1",Null,"5.5000","7.5000","28.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("26","Dewoton","8935085506739","1",Null,"5.0000","14.9000","70.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("27","SKD325 fort","8935204519435","1",Null,"1.8000","2.7000","38.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("28","Vit c","8935204501416","1",Null,"1.4000","2.7000","20.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("29","Baby fort 250mg","8935204501126","1",Null,"1.8000","2.7000","44.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("30","Baby fort 150mg","8935204519220","1",Null,"1.4000","2.2000","67.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("31","Phudchymo","9835204519024","1",Null,"0.7000","1.0000","20.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("32","Oriphosha","8935204500112","1",Null,"2.4000","3.0000","51.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("33","Glyford","8935085502038","1",Null,"5.0000","6.6000","47.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("34","Ofxaquin 200mg","8935085500614","1",Null,"5.0000","6.6000","46.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("35","Tophem","8935085506319","1",Null,"2.7000","4.0000","32.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("36","Dopiro D","8935085510231","1",Null,"2.7000","4.5000","4.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("37","Pataloxkit","8935085510118","1",Null,"5.5000","7.5000","19.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("38","Orgrinin","8935204502932","1",Null,"4.0000","7.7000","19.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("39","Orcardus","8935204520936","1",Null,"7.0000","15.0000","-7.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("40","Bronzoni","8935085515137","1",Null,"2.2000","4.0000","28.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("41","3 B plus","BC320135010010772","1",Null,"2.5000","3.5000","0.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-01 19:10:13","0");
INSERT INTO item VALUES("42","Forte-Max","8935204504530","1",Null,"4.0000","7.7000","50.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("43","Phudtinol","8935204518834","1",Null,"2.5000","3.5000","20.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("44","Roxythromycin","8934574010573","1",Null,"3.2000","4.5000","2.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("45","Be Ho","8934574120432","1",Null,"1.5000","2.8000","48.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("46","Vitimin B1B6B12","8934574090711","1",Null,"1.8000","2.8000","10.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("47","Mg-B6",Null,"1",Null,"1.8000","2.9000","36.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("48","Acnekyn","8935085501734","1",Null,"2.5000","3.5000","40.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("49","Mekocefaclor","8934574120098","1",Null,"1.8000","2.5000","21.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("50","SKD325 Bottle","8935204519145","1",Null,"1.2000","1.5000","100.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("51","Futipus 200mg","8935204513433","1",Null,"1.8000","3.1000","120.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("52","SKD 325","8935204519138","1",Null,"1.5000","2.2000","31.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("53","Mekocefa 500","8934574080088","1",Null,"4.5000","6.0000","36.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("54","Mekocefa 250","8934574120173","1",Null,"1.8000","2.5000","17.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("55","Fudvia","8935085529448","1",Null,"4.5000","5.0000","31.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("56","Fumagate","8935204522039","1",Null,"3.5000","5.0000","38.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("57","Donagel","8935085524320","1",Null,"3.0000","10.0000","155.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("58","Augbatam","8934574120180","1",Null,"3.2000","3.8000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("59","Dotemo","8935085519234","1",Null,"3.3000","4.5000","52.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("60","Mekomucosol","8934574120067","1",Null,"1.7000","2.5000","75.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("61","Origluta","8935204501928","1",Null,"2.5000","4.0000","20.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("62","Erybact 365","8934574120050","1",Null,"2.0000","2.5000","37.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("63","Befadol",Null,"1",Null,"2.2000","3.5000","32.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("64","Sanroza","8935085501116","1",Null,"3.5000","6.6000","35.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("65","Aller fort",Null,"1",Null,"3.3000","5.5000","60.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");






-- -------------------------------------------
-- TABLE DATA item_expire
-- -------------------------------------------
INSERT INTO item_expire VALUES("5","3",Null,"1970-01-01","2.00");
INSERT INTO item_expire VALUES("6","8",Null,"1970-01-01","19.00");
INSERT INTO item_expire VALUES("7","1",Null,"0000-00-00","10.00");
INSERT INTO item_expire VALUES("8","3",Null,"2020-01-20","1.00");
INSERT INTO item_expire VALUES("9","5",Null,"2019-01-20","1.00");






-- -------------------------------------------
-- TABLE DATA item_expire_dt
-- -------------------------------------------
INSERT INTO item_expire_dt VALUES("5","5","27","2.00","Receive from Supplier 27","2014-10-28 04:00:41","38");
INSERT INTO item_expire_dt VALUES("6","6","27","19.00","Receive from Supplier 27","2014-10-28 04:00:41","38");
INSERT INTO item_expire_dt VALUES("7","7","28","10.00","Receive from Supplier 28","2014-10-28 04:03:01","38");
INSERT INTO item_expire_dt VALUES("8","8","29","1.00","Receive from Supplier 29","2014-10-28 04:04:50","38");
INSERT INTO item_expire_dt VALUES("9","9","29","1.00","Receive from Supplier 29","2014-10-28 04:04:50","38");






-- -------------------------------------------
-- TABLE DATA item_image
-- -------------------------------------------
INSERT INTO item_image VALUES("1","9","����\0JFIF\0\0H\0H\0\0��(�Exif\0\0MM\0*\0\0\0\0\0\0\0\0\0\0�\0\0\0\0	\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0�(\0\0\0\0\0\0\01\0\0\0\0.\0\0�2\0\0\0\0\0\0�\0\0\0\0\0\0\0�i\0\0\0\0\0\0	\0�\0\0\0\0\0\0�\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Apple\0iPhone 5\0\0\0\0\0H\0\0\0\0\0\0H\0\0\0Microsoft Windows Photo Viewer 6.2.9200.16384\02014:04:18 00:11:21\0\0��\0\0\0\0\0\0>��\0\0\0\0\0\0F�\"\0\0\0\0\0\0\0�\'\0\0\0\0\0�\0\0�\0\0\0\0\00221�\0\0\0\0\0\0N�\0\0\0\0\0\0b�\0\0\0\0\0�\0\n\0\0\0\0\0v�\0\0\0\0\0\0~�\0\n\0\0\0\0\0��\0\0\0\0\0\0\0�	\0\0\0\0\0\0\0�\n\0\0\0\0\0\0��\0\0\0\0\0\0��\0\0\0\0\00100�\0\0\0\0\0\0\0�\0\0\0\0\0\0	��\0\0\0\0\0\0��\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0�\0\0\0\0\0!\0\0�\0\0\0\0\0\0\0\0�\0\0\0\0\0\n2\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\02013:05:13 09:07:26\02013:05:13 09:07:26\0\0\0�\0\0o\0\0�\0\0~\0\0O�\0\0-5\0\0�\0\0\0d_�qq\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0�(\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0�\0\0\0\0\0\0\0H\0\0\0\0\0\0H\0\0\0����\0C\0		\n
INSERT INTO item_image VALUES("2","22","����\0JFIF\0\0H\0H\0\0��(�Exif\0\0MM\0*\0\0\0\0\0\0\0\0\0\0�\0\0\0\0	\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0�(\0\0\0\0\0\0\01\0\0\0\0.\0\0�2\0\0\0\0\0\0�\0\0\0\0\0\0\0�i\0\0\0\0\0\0	\0�\0\0\0\0\0\0�\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Apple\0iPhone 5\0\0\0\0\0H\0\0\0\0\0\0H\0\0\0Microsoft Windows Photo Viewer 6.2.9200.16384\02014:04:18 00:11:21\0\0��\0\0\0\0\0\0>��\0\0\0\0\0\0F�\"\0\0\0\0\0\0\0�\'\0\0\0\0\0�\0\0�\0\0\0\0\00221�\0\0\0\0\0\0N�\0\0\0\0\0\0b�\0\0\0\0\0�\0\n\0\0\0\0\0v�\0\0\0\0\0\0~�\0\n\0\0\0\0\0��\0\0\0\0\0\0\0�	\0\0\0\0\0\0\0�\n\0\0\0\0\0\0��\0\0\0\0\0\0��\0\0\0\0\00100�\0\0\0\0\0\0\0�\0\0\0\0\0\0	��\0\0\0\0\0\0��\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0�\0\0\0\0\0!\0\0�\0\0\0\0\0\0\0\0�\0\0\0\0\0\n2\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\02013:05:13 09:07:26\02013:05:13 09:07:26\0\0\0�\0\0o\0\0�\0\0~\0\0O�\0\0-5\0\0�\0\0\0d_�qq\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0�(\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0�\0\0\0\0\0\0\0H\0\0\0\0\0\0H\0\0\0����\0C\0		\n
INSERT INTO item_image VALUES("3","28","����\0JFIF\0\0H\0H\0\0��\0C\0\n\n\n		\n%# , #&\')*)-0-(0%()(��\0C\n\n\n\n(((((((((((((((((((((((((((((((((((((((((((((((((((��\0��\"\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0@\0\0!1AQ\"aq��2��#B���R�3�$brCS�%4����\0\0\0\0\0\0\0\0\0\0\0\0\0��\07\0\0\0\0!1A\"Qaq�2������#�B�3$4CR��\0\0\0?\0T֪�i���䑉��r�t�@ߝ���b��Б� ��8��=�c�mm�(ǼR�c�{̊��@����`� ��1������`$�iv�v�R9�ۓ߭Tu=X2J[���Z=u�rD�Ѿu{[�:�A� �qS��2d��ȴ���Jci�֭6^2$!Cr���^�o�e�kI󒡷��OLMR�mF�$�L�i�Ցp�S�Y13�
�l�R}DGz��g�N�r�ok�}�[Z�r	�i��-���IR��Eâv����e^�ޤ��!�g������P\'&pq�iE�١^bJv�{�:u��,R�����L��Jm��r�UF����O2����D�Vv�I��hJw�	�ҩ������y�in0I��p=���ZmDI�&q�sWl1ȓ��X�\0���ZR�)H$�dsW�j�0�kH�����x�r�Ş}��#@:{�$���q�U\05��s��ܽ�L�d��	��X&@��Q�$�Yml��Y�0ӞsN�C�H.7#i�B?�Q�ݐ:�iǗbZ�ӑ�F��7V|	J�F=�V] 6֙`�ϥ�\\v=�3U/���ʈ�B\\뷌!6�-!�ҏU
INSERT INTO item_image VALUES("4","34","����\0JFIF\0\0\0\0\0\0��\0C\0\n\n\n		\n%# , #&\')*)-0-(0%()(��\0C\n\n\n\n(((((((((((((((((((((((((((((((((((((((((((((((((((��\0\0�\0�\"\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\07\0\0\0\0\0\0!1\"AQaq2B#b����3��4R�����\0\0\0\0\0\0\0\0\0\0\0\0\0��\0+\0\0\0\0\0\0\0\0!1AQa\"#2��q�ѡ��\0\0\0?\0�ʴ��Z�R���\"OT��2x�p�F�.Tv��%�j+\\�(������8ڕ,�(�#���)d���Xq�[�O����Q�[�w�~+R�;qO#ڃ�j2






-- -------------------------------------------
-- TABLE DATA item_price
-- -------------------------------------------
INSERT INTO item_price VALUES("5","1","38","1.5000","2.5000",Null);
INSERT INTO item_price VALUES("6","2","38","1.7000","2.7000",Null);
INSERT INTO item_price VALUES("7","3","38","0.7000","0.9000","2014-10-28 03:59:09");
INSERT INTO item_price VALUES("8","4","38","0.7000","0.1400","2014-10-28 03:59:09");
INSERT INTO item_price VALUES("9","8","38","3.0000","5.0000","2014-10-28 04:00:41");






-- -------------------------------------------
-- TABLE DATA item_price_promo
-- -------------------------------------------






-- -------------------------------------------
-- TABLE DATA item_price_promo_dt
-- -------------------------------------------






-- -------------------------------------------
-- TABLE DATA item_price_tier
-- -------------------------------------------
INSERT INTO item_price_tier VALUES("1","5","1","2.5000");
INSERT INTO item_price_tier VALUES("2","5","2","2.6000");
INSERT INTO item_price_tier VALUES("3","3","1","0.8000");
INSERT INTO item_price_tier VALUES("4","3","2","0.9000");
INSERT INTO item_price_tier VALUES("5","6","1","3.0000");
INSERT INTO item_price_tier VALUES("6","6","2","4.0000");
INSERT INTO item_price_tier VALUES("7","1","1","2.0000");
INSERT INTO item_price_tier VALUES("8","1","2","2.5000");
INSERT INTO item_price_tier VALUES("9","2","1","1.9000");
INSERT INTO item_price_tier VALUES("10","2","2","2.0000");
INSERT INTO item_price_tier VALUES("11","4","1","0.8000");
INSERT INTO item_price_tier VALUES("12","4","2","0.9000");
INSERT INTO item_price_tier VALUES("13","7","1","3.0000");
INSERT INTO item_price_tier VALUES("14","7","2","4.0000");
INSERT INTO item_price_tier VALUES("15","8","1","4.0000");






-- -------------------------------------------
-- TABLE DATA item_sub_unit
-- -------------------------------------------






-- -------------------------------------------
-- TABLE DATA item_unit
-- -------------------------------------------
INSERT INTO item_unit VALUES("1","បន្ទះ");
INSERT INTO item_unit VALUES("2","ប្រអប់");
INSERT INTO item_unit VALUES("3","ដប");
INSERT INTO item_unit VALUES("4","កំបុង");






-- -------------------------------------------
-- TABLE DATA item_unit_quantity
-- -------------------------------------------






-- -------------------------------------------
-- TABLE DATA price_tier
-- -------------------------------------------
INSERT INTO price_tier VALUES("1","Corporate","2014-10-21 00:05:59","0");
INSERT INTO price_tier VALUES("2","Organization","2014-10-21 00:41:46","0");






-- -------------------------------------------
-- TABLE DATA rbac_group
-- -------------------------------------------






-- -------------------------------------------
-- TABLE DATA rbac_user
-- -------------------------------------------
INSERT INTO rbac_user VALUES("2","admin",Null,"37","$2a$08$6Bpd5qGSPhB5dehzcrje4eYbfeTmxKI6WI8AgnamWSJyC4nAYNES6","0","1",Null,"2014-02-15 11:31:55",Null);
INSERT INTO rbac_user VALUES("3","super",Null,"38","$2a$08$/BW7UO.1LsTvZc5kfMtcyeFYbod45/8vM7ECJ6cYfnp8FFQ81NBlG","0","1","2013-10-10 09:44:04","2014-05-06 16:35:34",Null);






-- -------------------------------------------
-- TABLE DATA receiving
-- -------------------------------------------
INSERT INTO receiving VALUES("2","2014-10-23 04:33:39","3","38","2.0000",Null,"Receive from Supplier",Null,Null,Null);
INSERT INTO receiving VALUES("13","2014-10-23 05:22:59","4","38","20.0000",Null,"Receive from Supplier",Null,Null,Null);
INSERT INTO receiving VALUES("20","2014-10-23 05:43:10","3","38","80.0000",Null,"Receive from Supplier",Null,Null,Null);
INSERT INTO receiving VALUES("21","2014-10-23 05:50:23","3","38","16.0000",Null,"Receive from Supplier",Null,Null,Null);
INSERT INTO receiving VALUES("22","2014-10-23 06:10:49","3","38","8.0000",Null,"Return to Supplier",Null,Null,Null);
INSERT INTO receiving VALUES("23","2014-10-23 16:51:03","2","38","25.0000",Null,"Receive from Supplier",Null,Null,Null);
INSERT INTO receiving VALUES("24","2014-10-24 02:49:53","2","38","2.5000",Null,"Receive from Supplier",Null,Null,Null);
INSERT INTO receiving VALUES("25","2014-10-27 20:02:34","3","38","10.5000",Null,"Receive from Supplier",Null,Null,Null);
INSERT INTO receiving VALUES("26","2014-10-27 20:59:09","4","38","11.8000",Null,"Receive from Supplier",Null,Null,Null);
INSERT INTO receiving VALUES("27","2014-10-27 21:00:41","5","38","39.6000",Null,"Receive from Supplier",Null,Null,Null);
INSERT INTO receiving VALUES("28","2014-10-27 21:03:01","3","38","20.0000",Null,"Receive from Supplier",Null,Null,Null);
INSERT INTO receiving VALUES("29","2014-10-27 21:04:50","4","38","2.3000",Null,"Receive from Supplier",Null,Null,Null);






-- -------------------------------------------
-- TABLE DATA receiving_item
-- -------------------------------------------
INSERT INTO receiving_item VALUES("13","3",Null,"3","10.00","0.5000","0.7000","0.7000","0.00","%");
INSERT INTO receiving_item VALUES("13","5",Null,"5","10.00","1.5000","2.0000","2.0000","0.00","%");
INSERT INTO receiving_item VALUES("20","1",Null,"1","20.00","2.0000","1.5000","2.5000","0.00","%");
INSERT INTO receiving_item VALUES("20","2",Null,"2","20.00","2.0000","1.7000","2.7000","0.00","%");
INSERT INTO receiving_item VALUES("21","1",Null,"1","3.00","2.0000","2.5000","2.5000","0.00","%");
INSERT INTO receiving_item VALUES("21","2",Null,"2","5.00","2.0000","2.7000","2.7000","0.00","%");
INSERT INTO receiving_item VALUES("22","1",Null,"1","2.00","2.0000","2.5000","2.5000","0.00","%");
INSERT INTO receiving_item VALUES("22","2",Null,"2","2.00","2.0000","2.7000","2.7000","0.00","%");
INSERT INTO receiving_item VALUES("23","1",Null,"1","10.00","2.0000","2.5000","2.5000","0.00","%");
INSERT INTO receiving_item VALUES("23","4",Null,"4","10.00","0.5000","0.7000","0.7000","0.00","%");
INSERT INTO receiving_item VALUES("24","3",Null,"3","2.00","0.5000","0.7000","0.7000","0.00","%");
INSERT INTO receiving_item VALUES("24","5",Null,"5","1.00","1.5000","2.0000","2.0000","0.00","%");
INSERT INTO receiving_item VALUES("25","2",Null,"2","3.00","2.0000","2.7000","2.7000","0.00","%");
INSERT INTO receiving_item VALUES("25","3",Null,"3","4.00","0.5000","0.7000","0.7000","0.00","%");
INSERT INTO receiving_item VALUES("25","4",Null,"4","2.00","0.5000","0.7000","0.7000","0.00","%");
INSERT INTO receiving_item VALUES("25","5",Null,"5","1.00","1.5000","2.0000","2.0000","0.00","%");
INSERT INTO receiving_item VALUES("26","1",Null,"1","1.00","2.0000","2.5000","2.5000","0.00","%");
INSERT INTO receiving_item VALUES("26","3",Null,"3","1.00","0.8000","0.7000","0.9000","0.00","%");
INSERT INTO receiving_item VALUES("26","4",Null,"4","10.00","0.9000","0.7000","0.1400","0.00","%");
INSERT INTO receiving_item VALUES("27","3",Null,"3","2.00","0.8000","0.9000","0.9000","0.00","%");
INSERT INTO receiving_item VALUES("27","8",Null,"8","19.00","2.0000","3.0000","5.0000","0.00","%");
INSERT INTO receiving_item VALUES("28","1",Null,"1","10.00","2.0000","2.5000","2.5000","0.00","%");
INSERT INTO receiving_item VALUES("29","3",Null,"3","1.00","0.8000","0.9000","0.9000","0.00","%");
INSERT INTO receiving_item VALUES("29","5",Null,"5","1.00","1.5000","2.0000","2.0000","0.00","%");






-- -------------------------------------------
-- TABLE DATA sale
-- -------------------------------------------






-- -------------------------------------------
-- TABLE DATA sale_client_cookie
-- -------------------------------------------






-- -------------------------------------------
-- TABLE DATA sale_item
-- -------------------------------------------






-- -------------------------------------------
-- TABLE DATA sale_payment
-- -------------------------------------------






-- -------------------------------------------
-- TABLE DATA sale_suspended
-- -------------------------------------------






-- -------------------------------------------
-- TABLE DATA sale_suspended_item
-- -------------------------------------------






-- -------------------------------------------
-- TABLE DATA sale_suspended_payment
-- -------------------------------------------






-- -------------------------------------------
-- TABLE DATA settings
-- -------------------------------------------
INSERT INTO settings VALUES("32","exchange_rate","USD2KHR","s:4:\"4000\";");
INSERT INTO settings VALUES("33","site","companyName","s:12:\"Bakou System\";");
INSERT INTO settings VALUES("34","site","companyAddress","s:26:\"St. Fortune, Ratana Plazza\";");
INSERT INTO settings VALUES("35","site","companyPhone","s:11:\"85512777007\";");
INSERT INTO settings VALUES("36","site","currencySymbol","s:3:\"USD\";");
INSERT INTO settings VALUES("37","site","email","s:14:\"yoyo@gmail.com\";");
INSERT INTO settings VALUES("38","site","returnPolicy","s:93:\"ទំនិញដែលទិញហើយមិនអាចដូរវិញបានទេ\";");
INSERT INTO settings VALUES("39","system","language","s:2:\"en\";");
INSERT INTO settings VALUES("40","system","decimalPlace","s:1:\"2\";");
INSERT INTO settings VALUES("41","sale","saleCookie","s:1:\"0\";");
INSERT INTO settings VALUES("42","sale","receiptPrint","s:1:\"1\";");
INSERT INTO settings VALUES("43","sale","receiptPrintDraftSale","s:0:\"\";");
INSERT INTO settings VALUES("44","sale","touchScreen","s:0:\"\";");
INSERT INTO settings VALUES("45","sale","discount","s:6:\"hidden\";");
INSERT INTO settings VALUES("46","receipt","printcompanyLogo","s:0:\"\";");
INSERT INTO settings VALUES("47","receipt","printcompanyName","s:1:\"1\";");
INSERT INTO settings VALUES("48","receipt","printcompanyAddress","s:1:\"1\";");
INSERT INTO settings VALUES("49","receipt","printcompanyPhone","s:1:\"1\";");
INSERT INTO settings VALUES("50","receipt","printtransactionTime","s:1:\"1\";");
INSERT INTO settings VALUES("51","receipt","printSignature","s:0:\"\";");
INSERT INTO settings VALUES("52","site","companyAddress1","s:20:\"Phnom Penh, Cambodia\";");
INSERT INTO settings VALUES("53","receipt","printcompanyAddress1","s:1:\"1\";");
INSERT INTO settings VALUES("54","item","itemNumberPerPage","s:2:\"20\";");
INSERT INTO settings VALUES("55","item","itemExpireDate","s:1:\"1\";");






-- -------------------------------------------
-- TABLE DATA supplier
-- -------------------------------------------
INSERT INTO supplier VALUES("2","ABC","Leang","Sok",Null,Null,Null,Null,Null,Null,Null,"1");
INSERT INTO supplier VALUES("3","iOne","Sopheak","Sok","012121212",Null,Null,Null,Null,Null,Null,"1");
INSERT INTO supplier VALUES("4","Cellcard","Cellcard","012",Null,Null,Null,Null,Null,Null,Null,"1");
INSERT INTO supplier VALUES("5","Royal Group","Lux","sok",Null,Null,Null,Null,Null,Null,Null,"1");






-- -------------------------------------------
-- TABLE DATA tbl_audit_logs
-- -------------------------------------------
INSERT INTO tbl_audit_logs VALUES("Guest","203.144.91.4","2014-06-10 22:43:08","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-10 22:43:41","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-10 22:52:17","saleItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-10 22:52:27","priceTier","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-10 22:52:32","saleItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-10 22:52:53","item","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-10 22:52:56","item","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-10 22:52:58","item","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-10 22:53:00","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-10 22:53:03","saleItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-10 22:53:03","saleItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","203.144.91.4","2014-06-10 22:53:34","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","72.223.39.64","2014-06-10 23:04:39","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","72.223.39.64","2014-06-10 23:05:09","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","72.223.39.64","2014-06-10 23:05:14","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-10 23:05:30","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-10 23:05:38","item","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-10 23:06:06","receivingItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-10 23:06:15","item","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-10 23:06:22","item","UpdateImage",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-10 23:06:28","client","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-10 23:06:31","site","error",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-10 23:06:36","report","SaleInvoice",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-10 23:06:41","site","error",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-10 23:06:45","client","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-10 23:06:50","settings","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-10 23:09:23","settings","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-10 23:09:52","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-10 23:11:21","item","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-10 23:11:28","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-10 23:14:32","site","about",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-10 23:14:54","employee","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-10 23:15:04","supplier","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-10 23:15:09","report","SaleInvoice",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","72.223.39.64","2014-06-10 23:15:39","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","203.144.91.4","2014-06-11 00:01:54","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 00:02:02","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 00:02:05","item","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 00:02:08","site","about",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 00:02:12","employee","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 00:02:13","supplier","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 00:02:15","settings","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 00:02:16","priceTier","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 00:02:19","saleItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 00:02:21","sale","Invoice",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 00:02:23","receivingItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 00:02:25","receivingItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 00:02:26","client","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 00:02:29","receivingItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","203.144.91.4","2014-06-11 00:02:32","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","148.167.2.30","2014-06-11 03:40:54","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 03:41:31","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 03:42:05","client","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 03:42:06","site","error",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 03:42:07","report","SaleInvoice",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 03:42:09","settings","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 03:42:14","settings","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 03:42:16","client","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 03:42:17","site","error",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 03:42:17","report","SaleInvoice",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 03:42:28","settings","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 03:42:33","site","about",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 03:42:37","report","SaleItemSummary",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 03:42:38","site","error",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 03:42:47","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","148.167.2.30","2014-06-11 03:43:11","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","148.167.2.30","2014-06-11 03:43:24","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 03:45:40","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 03:45:45","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 03:45:46","item","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 03:45:50","site","error",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 03:45:54","site","error",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 03:46:05","client","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 03:46:11","client","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 03:46:16","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 03:46:52","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","148.167.2.30","2014-06-11 03:46:55","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","148.167.2.30","2014-06-11 03:52:06","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 03:52:13","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 03:52:17","sale","Invoice",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 03:52:27","receivingItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 03:52:30","client","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 03:52:31","item","admin",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","148.167.2.30","2014-06-11 03:52:37","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","203.144.68.145","2014-06-11 11:06:35","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.68.145","2014-06-11 11:06:44","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","203.144.68.145","2014-06-11 11:07:46","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","203.144.91.4","2014-06-11 14:00:06","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","42.115.40.103","2014-06-11 14:00:19","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","42.115.39.160","2014-06-11 16:38:46","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","124.248.166.17","2014-06-11 18:58:42","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","124.248.166.17","2014-06-11 18:58:53","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","124.248.166.17","2014-06-11 18:59:01","report","Inventory",Null);
INSERT INTO tbl_audit_logs VALUES("super","124.248.166.17","2014-06-11 19:00:42","sale","Invoice",Null);
INSERT INTO tbl_audit_logs VALUES("super","124.248.166.17","2014-06-11 19:00:48","site","error",Null);
INSERT INTO tbl_audit_logs VALUES("super","124.248.166.17","2014-06-11 19:00:49","site","error",Null);
INSERT INTO tbl_audit_logs VALUES("super","124.248.166.17","2014-06-11 19:01:03","site","error",Null);
INSERT INTO tbl_audit_logs VALUES("super","124.248.166.17","2014-06-11 19:01:07","report","Inventory",Null);
INSERT INTO tbl_audit_logs VALUES("super","124.248.166.17","2014-06-11 19:07:32","saleItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","124.248.166.17","2014-06-11 19:08:01","saleItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","124.248.166.17","2014-06-11 19:23:51","saleItem","Complete",Null);
INSERT INTO tbl_audit_logs VALUES("super","124.248.166.17","2014-06-11 19:26:50","saleItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","124.248.166.17","2014-06-11 19:28:08","saleItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","203.144.91.4","2014-06-11 23:21:33","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 23:21:51","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 23:21:56","saleItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 23:38:32","receivingItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 23:39:05","receivingItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","148.167.2.30","2014-06-12 02:29:15","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 02:29:34","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 02:29:44","client","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 02:29:44","item","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 02:29:46","sale","Invoice",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 02:29:47","site","about",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 02:29:50","saleItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 02:29:51","saleItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 02:29:52","sale","Invoice",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 02:29:52","client","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 02:29:54","item","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 02:29:54","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 02:30:07","settings","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 02:30:08","client","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 02:30:09","site","error",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 02:30:10","report","SaleInvoice",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 02:38:51","settings","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 02:38:52","client","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 02:38:52","report","SaleInvoice",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 02:38:54","client","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 02:38:58","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","148.167.2.30","2014-06-12 02:40:35","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","148.167.2.30","2014-06-12 03:38:22","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 03:38:47","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 03:39:04","item","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 03:39:04","client","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 03:39:16","receivingItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 03:39:19","receivingItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 03:39:23","sale","Invoice",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 03:39:33","settings","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","208.80.194.127","2014-06-13 10:46:44","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","203.144.91.4","2014-06-13 18:49:53","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-13 18:49:59","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-13 18:50:05","report","itemExpiry",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","203.144.91.4","2014-06-13 18:50:25","site","index",Null);






-- -------------------------------------------
-- TABLE DATA transactions
-- -------------------------------------------






-- -------------------------------------------
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
COMMIT;
-- -------------------------------------------
-- -------------------------------------------
-- END BACKUP
-- -------------------------------------------