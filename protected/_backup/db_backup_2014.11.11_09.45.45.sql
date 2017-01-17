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
  `name` varchar(100) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `code` int(11) NOT NULL AUTO_INCREMENT,
  `currency_id` char(3) CHARACTER SET utf8 NOT NULL,
  `currency_name` varchar(70) CHARACTER SET utf8 NOT NULL,
  `currency_symbol` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  KEY `FK_item_supplier_id` (`supplier_id`),
  CONSTRAINT `FK_item` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
INSERT INTO account VALUES("1","1","Lux Sok","32.2000","1","2014-11-11 02:56:19",Null);






-- -------------------------------------------
-- TABLE DATA account_receivable
-- -------------------------------------------
INSERT INTO account_receivable VALUES("1","1","38","1","-10.0000","PAY","2014-11-11 02:56:29","N",Null);
INSERT INTO account_receivable VALUES("2","1","38","1","42.2000","CHSALE","2014-11-11 02:56:29","N",Null);






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
INSERT INTO account_receivable_supplier VALUES("10","6","38","30","4.6000","CHRECV","2014-11-09 00:20:20","N",Null);
INSERT INTO account_receivable_supplier VALUES("11","1","38","31","7.7000","CHRECV","2014-11-09 00:28:39","N",Null);
INSERT INTO account_receivable_supplier VALUES("12","1","38","32","5.1000","CHRECV","2014-11-09 00:30:32","N",Null);
INSERT INTO account_receivable_supplier VALUES("13","1","38","33","-5.4000","RERECV","2014-11-09 00:53:13","N",Null);
INSERT INTO account_receivable_supplier VALUES("14","7","38","34","402.0000","CHRECV","2014-11-11 02:44:59","N",Null);






-- -------------------------------------------
-- TABLE DATA account_supplier
-- -------------------------------------------
INSERT INTO account_supplier VALUES("7","1","ABC","402.0000","1","2014-11-11 02:42:45",Null);






-- -------------------------------------------
-- TABLE DATA app_config
-- -------------------------------------------






-- -------------------------------------------
-- TABLE DATA category
-- -------------------------------------------






-- -------------------------------------------
-- TABLE DATA client
-- -------------------------------------------
INSERT INTO client VALUES("1","Lux","Sok","012797008",Null,Null,Null,Null,Null,Null,"1");






-- -------------------------------------------
-- TABLE DATA currency_type
-- -------------------------------------------
INSERT INTO currency_type VALUES("1","USD","United States Dollar","$",Null);
INSERT INTO currency_type VALUES("2","KHR","Kampuchea Riel","áŸ›",Null);
INSERT INTO currency_type VALUES("3","THB","Thai Baht","à¸¿",Null);






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
INSERT INTO inventory VALUES("1","41","38","2014-11-11 09:44:59","Receive from Supplier 34","10.00");
INSERT INTO inventory VALUES("2","48","38","2014-11-11 09:44:59","Receive from Supplier 34","20.00");
INSERT INTO inventory VALUES("3","65","38","2014-11-11 09:44:59","Receive from Supplier 34","30.00");
INSERT INTO inventory VALUES("4","58","38","2014-11-11 09:44:59","Receive from Supplier 34","40.00");
INSERT INTO inventory VALUES("5","5","38","2014-11-11 09:44:59","Receive from Supplier 34","50.00");
INSERT INTO inventory VALUES("6","41","38","2014-11-11 09:56:29","POS 1","-1.00");
INSERT INTO inventory VALUES("7","48","38","2014-11-11 09:56:29","POS 1","-2.00");
INSERT INTO inventory VALUES("8","65","38","2014-11-11 09:56:29","POS 1","-3.00");
INSERT INTO inventory VALUES("9","58","38","2014-11-11 09:56:29","POS 1","-4.00");






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
INSERT INTO item VALUES("1","Dofelo","8935085510415",Null,Null,"3.0000","12.0000","0.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-06 11:39:54","0");
INSERT INTO item VALUES("2","Domepra","8935085510316",Null,Null,"0.9000","3.3000","0.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-07 03:26:42","0");
INSERT INTO item VALUES("3","Doparexib 200mg","8935085513614",Null,Null,"2.2000","4.2000","0.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-06 15:24:45","0");
INSERT INTO item VALUES("4","Dolumixib 100mg","8935085513416",Null,Null,"1.2000","2.2000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("5","Oripicin 1mg","8935204502536",Null,Null,"2.0000","4.5000","50.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-11 02:44:59","0");
INSERT INTO item VALUES("6","Vixzol 500mg","8935085513010",Null,Null,"5.0000","12.5000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("7","Fucefu 500mg","8935204510913",Null,Null,"4.5000","5.5000","0.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-09 00:28:39","0");
INSERT INTO item VALUES("8","Futipus 100mg","8935204513334",Null,Null,"1.2000","1.8000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("9","Pandonam 40mg","8935085503615",Null,Null,"1.8000","3.5000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("10","Fudcefu 250mg","8935204510814",Null,Null,"2.5000","3.7000","0.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-06 11:50:17","0");
INSERT INTO item VALUES("11","Ormyco 120mg","8935204517318",Null,Null,"2.4000","3.0000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("12","Phudskin 10mg","8935204521438",Null,Null,"1.8000","2.6000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("13","Clari-Meyer 250mg",Null,Null,Null,"3.2000","5.5000","0.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-09 00:20:20","0");
INSERT INTO item VALUES("14","Baby 250mg","005",Null,Null,"1.4000","2.2000","0.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-09 00:55:42","1");
INSERT INTO item VALUES("15","Prenisolone 5mg",Null,Null,Null,"1.0000","1.5000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("16","Cool flu","8935204501331",Null,Null,"3.0000","3.8500","0.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-05 17:11:53","0");
INSERT INTO item VALUES("17","Magnesi-B6","8935085513539",Null,Null,"1.8000","2.8000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("18","SkD fort 500mg","8935204511415",Null,Null,"2.7000","3.5000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("19","Dothaimin","8935085508733",Null,Null,"2.7000","3.5000","0.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-06 15:39:07","0");
INSERT INTO item VALUES("20","Nelidevi","8935204517417",Null,Null,"3.5000","5.5000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("21","Denilac","8935085522234",Null,Null,"3.0000","4.5500","0.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-06 15:39:07","0");
INSERT INTO item VALUES("22","Vixzol 400mg","8935085512914",Null,Null,"4.0000","10.0000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("23","SKD cafein","8935204501232",Null,Null,"1.8000","2.8000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("24","Fudocal","8935204514638",Null,Null,"3.0000","7.5000","0.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-06 15:39:07","0");
INSERT INTO item VALUES("25","Oricefa 500mg","8935204510135",Null,Null,"5.5000","7.5000","0.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-03 21:26:56","0");
INSERT INTO item VALUES("26","Dewoton","8935085506739",Null,Null,"5.0000","14.9000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("27","SKD325 fort","8935204519435",Null,Null,"1.8000","2.7000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("28","Vit c","8935204501416",Null,Null,"1.4000","2.7000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("29","Baby fort 250mg","8935204501126",Null,Null,"1.8000","2.7000","0.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-09 00:30:32","0");
INSERT INTO item VALUES("30","Baby fort 150mg","8935204519220",Null,Null,"1.4000","2.2000","0.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-06 14:39:20","0");
INSERT INTO item VALUES("31","Phudchymo","9835204519024",Null,Null,"0.7000","1.0000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("32","Oriphosha","8935204500112",Null,Null,"2.4000","3.0000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("33","Glyford","8935085502038",Null,Null,"5.0000","6.6000","0.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-05 14:58:54","0");
INSERT INTO item VALUES("34","Ofxaquin 200mg","8935085500614",Null,Null,"5.0000","6.6000","0.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-06 15:40:30","0");
INSERT INTO item VALUES("35","Tophem","8935085506319",Null,Null,"2.7000","4.0000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("36","Dopiro D","8935085510231",Null,Null,"2.7000","4.5000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("37","Pataloxkit","8935085510118",Null,Null,"5.5000","7.5000","0.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-03 21:26:56","0");
INSERT INTO item VALUES("38","Orgrinin","8935204502932",Null,Null,"4.0000","7.7000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("39","Orcardus","8935204520936",Null,Null,"7.0000","15.0000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("40","Bronzoni","8935085515137",Null,Null,"2.2000","4.0000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("41","3 B plus","001",Null,Null,"2.5000","3.5000","9.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-11 02:56:29","1");
INSERT INTO item VALUES("42","Forte-Max","8935204504530",Null,Null,"4.0000","7.7000","0.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-07 03:26:42","0");
INSERT INTO item VALUES("43","Phudtinol","8935204518834",Null,Null,"2.5000","3.5000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("44","Roxythromycin","8934574010573",Null,Null,"3.2000","4.5000","0.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-06 15:40:30","0");
INSERT INTO item VALUES("45","Be Ho","8934574120432",Null,Null,"1.5000","2.8000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("46","Vitimin B1B6B12","8934574090711",Null,Null,"1.8000","2.8000","0.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-06 15:40:30","0");
INSERT INTO item VALUES("47","Mg-B6",Null,Null,Null,"1.8000","2.9000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("48","Acnekyn","002",Null,Null,"2.5000","3.5000","18.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-11 02:56:29","0");
INSERT INTO item VALUES("49","Mekocefaclor","8934574120098",Null,Null,"1.8000","2.5000","0.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-06 15:40:30","0");
INSERT INTO item VALUES("50","SKD325 Bottle","8935204519145",Null,Null,"1.2000","1.5000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("51","Futipus 200mg","8935204513433",Null,Null,"1.8000","3.1000","0.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-06 15:24:45","0");
INSERT INTO item VALUES("52","SKD 325","8935204519138",Null,Null,"1.5000","2.2000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("53","Mekocefa 500","8934574080088",Null,Null,"4.5000","6.0000","0.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-05 15:03:07","0");
INSERT INTO item VALUES("54","Mekocefa 250","8934574120173",Null,Null,"1.8000","2.5000","0.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-06 15:39:07","0");
INSERT INTO item VALUES("55","Fudvia","8935085529448",Null,Null,"4.5000","5.0000","0.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-06 15:28:20","0");
INSERT INTO item VALUES("56","Fumagate","8935204522039",Null,Null,"3.5000","5.0000","0.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-05 16:32:14","0");
INSERT INTO item VALUES("57","Donagel","8935085524320",Null,Null,"3.0000","10.0000","0.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-05 15:01:34","0");
INSERT INTO item VALUES("58","Augbatam","004",Null,Null,"3.2000","3.8000","36.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-11 02:56:29","0");
INSERT INTO item VALUES("59","Dotemo","8935085519234",Null,Null,"3.3000","4.5000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("60","Mekomucosol","8934574120067",Null,Null,"1.7000","2.5000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("61","Origluta","8935204501928",Null,Null,"2.5000","4.0000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("62","Erybact 365","8934574120050",Null,Null,"2.0000","2.5000","0.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-06 14:39:21","0");
INSERT INTO item VALUES("63","Befadol",Null,Null,Null,"2.2000","3.5000","0.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-09 00:53:13","0");
INSERT INTO item VALUES("64","Sanroza","8935085501116",Null,Null,"3.5000","6.6000","0.00",Null,Null,Null,Null,Null,"1",Null,Null,"0");
INSERT INTO item VALUES("65","Aller fort","003",Null,Null,"3.3000","5.5000","27.00",Null,Null,Null,Null,Null,"1",Null,"2014-11-11 02:56:29","0");
INSERT INTO item VALUES("66","áž”áž„áŸ’áž€áž„áž”áŸ„áŸ‡áž–áž½áž™ážŸáŸ’áž“áŸáž áž¶",Null,Null,Null,"100000.0000","100001.0000","0.00",Null,Null,Null,Null,Null,"1","2014-11-06 15:27:03","2014-11-09 00:56:46","0");






-- -------------------------------------------
-- TABLE DATA item_expire
-- -------------------------------------------
INSERT INTO item_expire VALUES("5","3",Null,"1970-01-01","2.00");
INSERT INTO item_expire VALUES("6","8",Null,"1970-01-01","19.00");
INSERT INTO item_expire VALUES("7","1",Null,"0000-00-00","10.00");
INSERT INTO item_expire VALUES("8","3",Null,"2020-01-20","1.00");
INSERT INTO item_expire VALUES("9","5",Null,"2019-01-20","1.00");
INSERT INTO item_expire VALUES("10","14",Null,"2020-01-01","1.00");
INSERT INTO item_expire VALUES("11","41",Null,"2020-01-01","10.00");






-- -------------------------------------------
-- TABLE DATA item_expire_dt
-- -------------------------------------------
INSERT INTO item_expire_dt VALUES("5","5","27","2.00","Receive from Supplier 27","2014-10-28 04:00:41","38");
INSERT INTO item_expire_dt VALUES("6","6","27","19.00","Receive from Supplier 27","2014-10-28 04:00:41","38");
INSERT INTO item_expire_dt VALUES("7","7","28","10.00","Receive from Supplier 28","2014-10-28 04:03:01","38");
INSERT INTO item_expire_dt VALUES("8","8","29","1.00","Receive from Supplier 29","2014-10-28 04:04:50","38");
INSERT INTO item_expire_dt VALUES("9","9","29","1.00","Receive from Supplier 29","2014-10-28 04:04:50","38");
INSERT INTO item_expire_dt VALUES("10","10","30","1.00","Receive from Supplier 30","2014-11-09 00:20:20","38");
INSERT INTO item_expire_dt VALUES("11","11","34","10.00","Receive from Supplier 34","2014-11-11 02:44:59","38");






-- -------------------------------------------
-- TABLE DATA item_image
-- -------------------------------------------
INSERT INTO item_image VALUES("1","9","ÿØÿà\0JFIF\0\0H\0H\0\0ÿá(Exif\0\0MM\0*\0\0\0\0\0\0\0\0\0\0ž\0\0\0\0	\0\0¤\0\0\0\0\0\0\0\0\0\0\0\0\0®\0\0\0\0\0\0¶(\0\0\0\0\0\0\01\0\0\0\0.\0\0¾2\0\0\0\0\0\0ì\0\0\0\0\0\0\0‡i\0\0\0\0\0\0	\0ê\0\0\0\0\0\0’\0\0 ê\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Apple\0iPhone 5\0\0\0\0\0H\0\0\0\0\0\0H\0\0\0Microsoft Windows Photo Viewer 6.2.9200.16384\02014:04:18 00:11:21\0\0‚š\0\0\0\0\0\0>‚\0\0\0\0\0\0Fˆ\"\0\0\0\0\0\0\0ˆ\'\0\0\0\0\0 \0\0\0\0\0\0\00221\0\0\0\0\0\0N\0\0\0\0\0\0b‘\0\0\0\0\0’\0\n\0\0\0\0\0v’\0\0\0\0\0\0~’\0\n\0\0\0\0\0†’\0\0\0\0\0\0\0’	\0\0\0\0\0\0\0’\n\0\0\0\0\0\0Ž’\0\0\0\0\0\0– \0\0\0\0\00100 \0\0\0\0\0\0\0 \0\0\0\0\0\0	 \0\0\0\0\0\0À¢\0\0\0\0\0\0\0¤\0\0\0\0\0\0\0\0¤\0\0\0\0\0\0\0\0¤\0\0\0\0\0!\0\0¤\0\0\0\0\0\0\0\0ê\0\0\0\0\0\n2\0\0\0\0ê\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\02013:05:13 09:07:26\02013:05:13 09:07:26\0\0\0×\0\0o\0\0í\0\0~\0\0Oµ\0\0-5\0\0\0\0\0d_Çqq\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0î\0\0\0\0\0\0ö(\0\0\0\0\0\0\0\0\0\0\0\0\0þ\0\0\0\0\0\0‰\0\0\0\0\0\0\0H\0\0\0\0\0\0H\0\0\0ÿØÿÛ\0C\0		\n $.\' \",#(7),01444\'9=82<.342ÿÛ\0C			2!!22222222222222222222222222222222222222222222222222ÿÀ\0\0 \0x!\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0	\nÿÄ\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁRÑð$3br‚	\n%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹ºÂÃÄÅÆÇÈÉÊÒÓÔÕÖ×ØÙÚáâãäåæçèéêñòóôõö÷øùúÿÄ\0\0\0\0\0\0\0\0	\nÿÄ\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3RðbrÑ\n$4á%ñ&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹ºÂÃÄÅÆÇÈÉÊÒÓÔÕÖ×ØÙÚâãäåæçèéêòóôõö÷øùúÿÚ\0\0\0?\0ïf$oE\'ô¯nr$bGV&¹ÔÞŽÌM#ckî mÜJë—\02k×m3X5­ÌÏÂZëWÇÌÎ©Ÿ©$× Ä›@Jé’³9™dgŠa]Ç·¥rbŸ¸o†øÄeÿ\0­4Já•Àea‚§¡Jó’Ôï¹©Ú[ÙXLa/J˜•¿v[ÝWô®{Ãåm<ÝIþôYÛùs^*·†§,áftºwì›h»ŠHOr>a]÷‡5?Qš?³]Å!\'î†…vGs†¤ØôÕÛ\0“…š+}È½‘æªYÜØNayLvîç§¥x£ØÝNs¼Œ=B×—S²”mthxcBiuÍ—p8S0ÚÜö®ªãÁÆHä×%)Í_ðÇò­.¤cRêZz?†|Eá¨æEi}®”1ÜHïÚµã×íâG¨[\\ØÉÓ÷©¹1þäîÆ•Íxç†h|È&Žhñ’Ñ¶êD”¦¹1*éa·c‰ªÒu5Ãc²ç#âû¿.É ™_‘ì+ïýBŽÃK€™®ÊQ÷R1“³0È\0sRØYüÅb¥yWeìd¬÷=_ÁšÎ¹wc4W:•Ì–ÅJ„‘÷`{¿­ÕbqMZLê%ð]§˜¯ïÖk|Â–_Ûãç™ØËòŠáöO¶\"ƒD·²ÉoGÚT·r*IPw®}Åh—.†OQÐ<X {«®]ÙXé¯=Ú£G¡vîÜO@(¹)jy½ó‡všM<älXúþ?ýjÃ—ZÕí\\·Ú×=i(©8—ôßËŠ—è2pd^£ë] ž;‹tš&Ž ©õÅ‰¥Éª7£>ec…ÖœßxŽ;qÊÅ…?ÌÕn}÷«û±(êkZjÖ@õ¹”ù8´, ,Š rÄWCÓB#ÜõkXF‹àï0q4 \"þ=h­e>[#™.mOPtM‡§CUL\0Ó±ÐŸf<Ui´øÜ÷¤ÕØ\\£.š‹Œ0Éè+“×lÚmbeÿ\0Qn‚@w=ÿ\0ÿ\0¡VsVF´u‘{¥C~J$ 9<âµËkìCw1ºä0èÂ³ƒw:æ•Œ	R5™Z,mcÈ®»B×-¬cžÆw	j^2Ý‡qþ­j|Ð9£>Yðå™Ô®®¯ÏÌ¬Äîy5WPðÖ¤\'–TQ0v-ÇÊy®EQFm<¼Ñ1ÍÌ<\'?ÄµÓøsO7z”)·å]1´¤Œ¤ívÞ\'½†\'rmì£‚ÿ\0ú\n)VÖV(û¦—µë¿©»±¹\"è² ³dÞ³äàc¸5v/\\é:u´ž(Òe±šl„òXJ€È‚/zè9š¹‹ÿ\0	þ·w|ÿ\0bÒ KPHkØ÷Ç£gâÛ¤»ŒjP‘EÃ*g¿@GëY©š:VE?øÙìµË(ì¬d›MVÙ-ùSå=”ô8úõ¨u\'7~\"º*$1¢¨óOÝl¨ÀZš¿ðëÞ3-\"Õ¾Ü±›k³+ŸyÝŽÜbã6+Ï´’(ób!”Ö1Üë’Ðñï³LŽ0YäJ³<Ñ‹[£,@´±„ðs]Ÿ8ä¬ÎçáãFt\\€DÌ2Š»8á@\"¼Šÿ\0Ågm?—¤Ã9UxQìVºøGô›Hw¥„ê2J®Þ\nt§Ê®e[tŽjïÃ6ÅÞDˆ,XŸsE9¹JW5„Ôcc\'Æºdz­¤21Ü[Ê²Ç\"õRpK¬_x›Åmwy7Ú\"…<¨È]ªr½zrØã‚¼‘ÖÆ#µAõÅ:yc@pÚÀàæGe“Ð~„ñëšmÇ†®eŠb–9oùç»$/¾Wÿ\0¬û«˜ÚúYîÅ,vÛñÒ®néQ¤Í;ØäÚ}qŠ—X²:¼pŒl?xûVQ7’8	ô}úËÀ–ÒCo±2}ÐÄþUÂêòF\'‘!9ˆJÛ¢ö®š.ç-ukÍðóÂ¼euæ”šëtÌxÁ8˜®’/]A ùr¹ëJæ¯C™ÜTëòèuÚ=šÆ¡šN@èj{Ëƒ$†%ÆÀFO©¬aEÇp”¹¤DØÆ(­´ÎGX?èî=«Î<=µ×n£!~k0„ó]]•‡E]Üê¯|?a©¼sÎò)ƒ®Tñô5[R–ÖñœKsk7)ÆÎ3íX­NŽ[³”ÔaÔ4©bd–K›ŒgUä¯\\œU1¬uvžíSÎV*Á¨wÜQi;1ÒkÙI¶ß”^\0­=;Ä7”ÂÎ+GžIM«ïS\\ôW5õ&I4©ì§ºnš2Š-åûþ¯*ŸÂ—òÎÖkjK$§uÎýª@cÚ¶„”49ªCšÌö¯êÑéZ5Ž™“„·…P³?R5ÑÛêðIê‡½¥Ì]lÅp|€}j0SÐuªz£=˜ó‚8¢¢Æ—8-Jc4-­yÅÖ«g¦øLï\"LÌWoÊÁ_Âµš¹­\'c¦¸¹šH[ÈTí¦k‰Žç\\‹\\Ž[‹“2¼^ ¥Béô¬b´:Ò¾§S¤]HÞ&I“{,JIÂúö®{ZºþÓñì¥L*¶á*íËg¸­anMN:­óègÚ†¹`Ø\"½Â¾V£]ß…`\nÇíšÊ+Þhénñ3[Rs&v?™«	#(ëów>•ÝË°¦ì§9æˆu)ž@¡\'¥8‰´z—‡<Étd2äüÇÚµþÌ1]i{§—\'ï°òp(¥aÜòëûãm‡nq‘Š­¤hÚ‹!’´ÙRüÀA’•†{Æ=¾•WÖÆÍir„þÖôG®5Q•*Ád\n=EbÞVTsi¡^A;™“îÖ\\º1«djø\næÓM·¿‹VÕ­–êá¹Vb¥O¦zb°õ¼¶¯wöiÃH\0nÝW+ZÈ\'ë³(i6ý£&æ/´®O©®ÂE‘ô¡i\"“.÷-éíYm#I-2SæsÕÏô¨dºç±o°lImmqy\"Ç\n;³\0­wþðWKOåãpˆu?ZÞ”ÕœÕªYXïã·XÑcB¢€ŽÂ¥ÛÅt(iQE+x®£(mQ ê,Eli—\"Êú)Á\nFWqì`Ý¦vÆ7Ö@±ÜGËyOr	S#/;IäN“KXme·µ„[4Ž\\°Ãn\'©®›]Êv<³]øqsw¬Oq§Ïo“±.Y¹Sßÿ\0¯\\—ˆ4“¡øŽÙ#bðI	\'÷ñÁýk.V‘éNºœcÐÞ°Ô,²B•Ý[¹Cé†$Šh½‘ÉÀ,Ià\nÆl‹Ü™lîe|H6ƒƒïW¬ô›ríæ¹b9\0wõ­)Ðî&ÏBð¼–VQ…†ÑÈ¿r>µÖ¬Â@H÷µÛÊ’Ðå«`J‡ƒïS,èÕ‹9Ú¶ƒ²L($ð;Y~Õ¬ÈÌsµ™­J\"–Û¶|§æô®I+Ìô£ðˆ¶—ðù¤xB…Y#m ’{æ¶¦Ôá[wHšD[yL,Ó)äOP}k®=Î9Y”–Òåæºkõ­÷-cnJãœþ5Èx¶ÒØé“Ásx‚böóÃóO¨ëS%îšÓÕØá­e´a9Š\"–ünžO—y™ô­mÔ¥ÁšQò&qîkk$u»îÍÛ‡,žha»½WG}ë ûÊÀƒ]ˆ•M=¤y	V½©í]F—¨	$[¤òçÁô£Ú¶Z!ÍhÍÅ„ÊûÔRCÿ\0âf›™!r¤ò+9£…«²UÕ™zÑP‰å<OD™›\\ crßwW±›9‘¹VR¤W,¾3±|%ë	…ª[$-n‰~Þ9ôõ­95˜¿´míâhçóù¤|Äg¦+¥|\'$£¨Ë‹k–˜C¦Ê[³´“MÞfz€ÙàŸ¡®#^žóMMGûKf¸0€¡IR¸#êþ…M¯tÒ†’Hó»fÞì\'Ú>KhØ1_aÚ»1æ¸†/9Q@j¢žŸ­aJ\'§]$Ò]Y\"\0`¨Ç4Ž(îÜ5º19åù€µŽäí]BÙ­õ’_YafŒä‘ÔCZEßB\'+jmhú¹›Î6N¹ãßÔ{õkS·IÌ‚sØ3Çµ9jsµiÛ\\{ÑX1Xñï]É6»$¥‰”¨cëž•ê¶äIic\\²~ñ×R)3Íô»˜­<A{ÛÝÏ™YB	Â€ ôÁÇóÚÃâM\"ÛD@‹wq®ño¸1ÚŸþ½lª[@­„wN;Ó<X×^*½¾7F}5 ÌQÆŸ,xõ÷ükŒñ_‹-üMp–ñ@vFÅÑ›Ôuý(•Ot¼>ûTßKsÚùþÎŠFr_ð­»I¿³,£¶˜ÜbpêÊßtý=>„TÂ|¦¸…z­[Íysn’ÙL\0@ÔT`ÞCi¢#‚ß{‘Zè1Zšö—	~‰,L7¶E÷½¤ÝÏ£Ý)S˜¤áéøÕ%fCZXÜºŠ7	}kÄNrGüójØÓï„ê°H£“ù0þ†´ò9í¥Œ[N{MH…‚R]	ùqê?\n+­LäîÏ0·c±O)B´XdOñ®«KÔRKt õ\0×îÎé.§›øæÎâÇ_’ö(ÙgÚÅ»oïU4‹›yn’(™Ê²ì›î“ŽáZ4va«®G	nuZŒvÖ—ÚL×Án$œÄ‡fÐ¼áº*Åkm6\0nqóÆ®±»„ŒúÕ2ZŠ2”3*éòElIç,kv<jªà¸dgÞ¡÷1”®ïÜÉ{=K@º&Þr-äaòîùAþ™­í;Ævâ5º€7$|Ë×ñ®ºnè˜£´ÑãÓ<Sk4‘CöKÈÈ%£ùwÐûÒ}’ú»”£Cu÷ú×BÕ\nÚØÓÓh^HK~é›­ØÖ¤7qÃpaT!I:ú{U£7H¹ây¯´	–-†,˜Ë6Õ-Û>Ç½-ªhðý6êGÊRM ²¢¶t×Ž‘;Þ¾Ù¯2Öf÷æ‰§)‚îÊH.U]­»§5æ~\"ðùÑïDHÛ —-=@÷­tw7´î—M‰0K;m`\\¨e=IÇ·­/ˆ„-o†hÙƒŠ1ŽsÙqÚ´µô!MÜçeÒ.ÒßÍ™d*pp½\05Õøzä(Ôÿ\0\n…üª+FÈØ¿ªÅÅ«!ç# ¦Øé¦ëNŽ+ˆ†Á‚	ê(¥+&Rv5të¡§xŽÇÉp¶ñ¡IPwSÅw:…±óh°C}EuÑøMZ³^dÐÈˆ³³\núœzÐqÑ¸Ã/Ý?îÖæ5#ÔÒŠò 	>mÊçøÁíE$gì¹µ<>êÎk[§È!ÃŸZtwÌLÛz©òæ¼éÇ©9t5 ¾i.Þ‹}œ°ùíW¤Ó¬n-82\' y”A\\ß—Ý¹`½¶ ´‹\'\0ô¸¦Ûxjt“ísl2(àãúV‘ÜçødX¸H6æ;(»¾PsT¿²çÑ€–=òFpÏíô¥XóDê‘­c<w$á«BF\"ùÆâ¹\"µ©“k¥ÜÜ_GpÍÄŽ¯p+¼¶¸¸6ïIÜ·ÍÏzô)«\"§+Ùe{‹‹Ù.G’@\0ÀzûÕ†¹3X$‘ð¶‘ìjî]E±hB÷VP¼y,‡9Wè¤ÈSQÐÈºÓ¡»l¨¡î+–Õ<>Öå|¢\\HJ·šäjçžŠšrýž9õÁ>ž•}õcÂ©\' ¨Z^ÓÜ/hî.^Y~}ÃŸJÖ1ŒdVˆæ›¼Žy/ímõY,e„FÎÄ¤ŸÂç®h¿•äJŽ€³’œóžáZ§}¸>hœì¶÷:V¢ŽÅ2”_n+nÎA©Œ¨ýÂ»jËÙûÅÃDmÙG›Ì#%.~¸â³ÿ\0µ#žù4µ$\'ñJ­ÑÇA]IhD_¿rôÍ,kr6[vGqô©tÅ—VÆTºgÔPm?#¥ðÜYGQHÀ÷¢¡³ÉÄTýã2b£h‡¥bŠ9ÍfÖ°‘DŠò|ÎEC§ø|ÜáåÊÇØw56úðXEm—ýéâ Ö¨G?â=ûFÐan#!‘|v5…c®›Plobu™Ër vúT·gszR¶‡Ekn549>dL£\'Óÿ\0¯[QÅoii\0Nüó]×S±laëZ±É§éì<×?¾îO©®+T¾Ô4—K²	 B	xú®=jkJÆ2ÓS_Iñ¤zœÈZ	9‰aÏÒº¸žéçVÃåbvü$úÕ)©«jz•Ù´äˆ’Y@$žæŠ–ÏkšM˜[!Ž Ø¯-Œ2È²:ËÐÔËÑ@täÔes@\nÑ†ŠÄÕ<?g¨ƒçÂ¼>†‹\\«Øãn-õÞîµ™çŒN>ð‡Ö­^x²KÈv‰äáÎîGÒ³çpV:éÔº±RÍÄ#“–c–5¢“£¬‚a}Jz™/£[A¨¥Å–nÜñÿ\0}«°Óu9mŸ~ÈÂ`p{â´S®¬z&“|—Ö\"TôÁ†ŠéZ«žeEË&Œí R`TšŠh+Í\04 =i…\04­Fc‹›¨ékt(úzÁ¸ðu´Ùwb$ç?—šL´ùL;¿j„˜X\\ í÷Z³EÓÛÉåÌ¯ú5sÎ7„îKöàÖµöøBÆ³F—±ßø&ërI	=W }(®Ø;Dóñ?Ä?ÿÙ\0ÿá9ghttp://ns.adobe.com/xap/1.0/\0<x:xmpmeta xmlns:x=\"adobe:ns:meta/\" x:xmptk=\"XMP Core 4.4.0\">\n	<rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\">\n		<rdf:Description rdf:about=\"\" xmlns:mwg-rs=\"http://www.metadataworkinggroup.com/schemas/regions/\" xmlns:stDim=\"http://ns.adobe.com/xap/1.0/sType/Dimensions#\" xmlns:apple-fi=\"http://ns.apple.com/faceinfo/1.0/\" xmlns:stArea=\"http://ns.adobe.com/xmp/sType/Area#\">\n			<mwg-rs:Regions rdf:parseType=\"Resource\">\n				<mwg-rs:AppliedToDimensions rdf:parseType=\"Resource\">\n					<stDim:w>3264</stDim:w>\n					<stDim:h>2448</stDim:h>\n					<stDim:unit>pixel</stDim:unit>\n				</mwg-rs:AppliedToDimensions>\n				<mwg-rs:RegionList>\n					<rdf:Bag>\n						<rdf:li rdf:parseType=\"Resource\">\n							<mwg-rs:Extensions rdf:parseType=\"Resource\">\n								<apple-fi:Timestamp>-264753123</apple-fi:Timestamp>\n								<apple-fi:ConfidenceLevel>281</apple-fi:ConfidenceLevel>\n								<apple-fi:FaceID>12</apple-fi:FaceID>\n								<apple-fi:AngleInfoRoll>270</apple-fi:AngleInfoRoll>\n							</mwg-rs:Extensions>\n							<mwg-rs:Area rdf:parseType=\"Resource\">\n								<stArea:y>0.802</stArea:y>\n								<stArea:w>0.141</stArea:w>\n								<stArea:unit>normalized</stArea:unit>\n								<stArea:x>0.342</stArea:x>\n								<stArea:h>0.188</stArea:h>\n							</mwg-rs:Area>\n							<mwg-rs:Type>Face</mwg-rs:Type>\n						</rdf:li>\n						<rdf:li rdf:parseType=\"Resource\">\n							<mwg-rs:Extensions rdf:parseType=\"Resource\">\n								<apple-fi:Timestamp>-264753123</apple-fi:Timestamp>\n								<apple-fi:FaceID>11</apple-fi:FaceID>\n								<apple-fi:ConfidenceLevel>277</apple-fi:ConfidenceLevel>\n								<apple-fi:AngleInfoYaw>45</apple-fi:AngleInfoYaw>\n								<apple-fi:AngleInfoRoll>270</apple-fi:AngleInfoRoll>\n							</mwg-rs:Extensions>\n							<mwg-rs:Area rdf:parseType=\"Resource\">\n								<stArea:y>0.618</stArea:y>\n								<stArea:w>0.159</stArea:w>\n								<stArea:unit>normalized</stArea:unit>\n								<stArea:x>0.273</stArea:x>\n								<stArea:h>0.212</stArea:h>\n							</mwg-rs:Area>\n							<mwg-rs:Type>Face</mwg-rs:Type>\n						</rdf:li>\n					</rdf:Bag>\n				</mwg-rs:RegionList>\n			</mwg-rs:Regions>\n		</rdf:Description>\n		<rdf:Description xmlns:xmp=\"http://ns.adobe.com/xap/1.0/\"><xmp:CreatorTool>Microsoft Windows Photo Viewer 6.2.9200.16384</xmp:CreatorTool></rdf:Description></rdf:RDF>\n</x:xmpmeta>\n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                   <?xpacket end=\'w\'?>ÿÛ\0C\0		\n\n\n\n		\n\n\n	ÿÛ\0C																																																			ÿÀ\0À	\"\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0	\nÿÄ\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁRÑð$3br‚	\n%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹ºÂÃÄÅÆÇÈÉÊÒÓÔÕÖ×ØÙÚáâãäåæçèéêñòóôõö÷øùúÿÄ\0\0\0\0\0\0\0\0	\nÿÄ\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3RðbrÑ\n$4á%ñ&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹ºÂÃÄÅÆÇÈÉÊÒÓÔÕÖ×ØÙÚâãäåæçèéêòóôõö÷øùúÿÚ\0\0\0?\0þ‚¡…aÚ%|yŒpGjšDòb‘°þt—0L‘[ª4»‰;GSô«QÛI=ºÄÉ¹\\|À×ã	3¡œ„ŽáË:i¤!@«»D‹nÊ\n9þÒ»)l¬­íÂÆ¸œ!îšç¤‚$Øî7°lGZÒ4û˜J]YRG&ØA«±¬.‚(ÈÃ¶3ýÓUn,§–EûªÜ¹Ú:åV„Ø[‰%¡ú×m-¢Ó3ãgS0’LB%(ã®}ñZ7z•­¹ó\\4‘…\n9äV;ÜËI5äa~Ñ À^psÚ£û\\ö³«B‹)¹R€?|×G´hÝ+ljÎm¦\'ÊCò©É5nÊÎØGæ6\\LHô÷5ÍÉo5„ÐËÙ›Í$Ê§¢ñÐS­µ	å™Äxq9¾k)Uoq¶[ŸL†;¹äUÀ\'yî)ñéI2²*™Ü·oñgµlYKeyb¢|Åv7œ|£=Ö§cˆ­ÉÂÍbÌœû4VRF%âuaHÇ‘Vh]ƒ@R5ásÐ×qwåÜ\\F±‚Ñí€zúêF†Ö|[•£ë‘Þ³’±~ÓK#…ó÷HˆÎa—ká5v]MØÂÇ¾0­O}dÊSË€¿ï¶çëQM¤Ÿ)÷’_ý‘ìi.ÆWèIc®=á„ªÝžÞõÒO¨»:[Å\'Þ_â>ÿ\0Jóßì¹,œQ¶mÀ’>òö­9\'¶`¹óQìœÞµŒzÛˆºNÉ$­è ÿ\0\nYáá›;ùÀ¹ñªJ÷‰>g„»c¿­_ŸPƒ<¿¾Îsè(ä¹´ˆ¿l-oHƒÀ3XëºuÌöSËXw›!‚É\0.xcžé_ÊÏí¨øXÞ$ˆæ4²»‚8hÁ…IèIõ¯ê‡öÔÕ-×Áú}¾ç2K©C<J£ˆ¤ÆÝÇ·?Ò¿’Ÿ—×z‡ŒüDÏre»mVpÌÝÊ¹úsÖ–%sPöoÔû>Ì*ÆQ¡N7»×Éu<ši¢¹Cºmî÷¬	4YŒ“]n\nÝ÷5¨Ö‹iiºÜíÊóŸZÌŽ[ÒTO!x‰Èô×‡ì™úÌeecSŽW0jM?Éb¡3ßžÕRSÛ)¸Q!+ÐöoX¶–æ6Š9<´f›Ö™§hÎöÅ­ÜN9É\'æÏÒ«ê‘IÕ{œ²Œ}¯:Ü¥,ÑËû•§¯j,ÿ\0Ð‹ÂSÒ‹…·•Ê\"fEÀ>ø«¦?4Fá„hoÓÉ-45Qvr!–îêÚE6 21ÉÏ­k¾½<–Æ$³Øà×7m4ÑÝ,s¡{q!ÇÞÑjV0Û¤Û–·.IÈ­iI%bcRN7‰ËßjjíÑâFQ±O½Ge¨On^[ÔY[Ë%OÝ\'½X¿Ò×S$º›&\0IþµRâ5¶Ø›vó¸½v§¬fñucï\"¥î³5ç‘¶ß;0eþÓ3GlÑ£LÛDmÎ;Õ{‹½…V8ÑÜnÇLúš²~ÎÐÑ²í\'pjê¥YDàÄb§VW›Ôç¢´‚©n…°[ye8cÛ?ãS›IÃHR<µ]–òÞxVÝîöŸ”÷ªóÈb{FcòïÀ½mí5ÎG‡Œ´ln—4¹»Ðl¸8Éë[òº­Ä3ÛîŽ4$c¹ÿ\0 m¢¸»·™¦kt…·mñVmõ2æéÚHdb¹#æÕ‚f5p±0ïoÕnœ3:¬ãÓ êE„ËmyY>Îï*îã9í[7&Ú%Žåc-21ŸáŽ÷*ìû!Û?JÊœb¥r)ÓŠ‘ZÞóai<Ü9«+xË›‰\\n<b ûåÕQE19©oa·\'#kÈ\0=ëÐ•TçÌÎª‘¼®d]K-ÄâdÆÔëôÍUºq©Ms®ô¥jÏoæ…Žßä…[¯÷‡¥6Sn‰`ù7‚2µÛCË¢9gsa6W,Õcóò¥ª`áÜ<¥FÓ¸Ö´¶óFË2É¿Œâ¢x’æ	.öÉmÉ@~õ{ðªùt8äôµŒ›XÅ¼ÌÉóí¬;¸I$íÈ$T^(€¬QNþsØTÖ³µæøEEUï\\Ó\\Û˜ª–0íâwmÃí2’£w¥,w/	šÖâ,™“†_á?áSK¸cœÛð3Ú eÜç!¯^ô¡æN«¾ƒd)\nþù¼»‚\0R;RÂÏ±A;åe<š‚uKÉ3˜ccwcSAn`(Bý× êèpT“Ü€¼¹ÆÒÈ¹äÿ\0i™Z(uË#¸¨#Y„Œ1ò¹Ç±É`ž)ZIŽQŸašÎ^k´sÆ¬ž¨æõÛ†|Å´˜¤^1é\\ÓZ\\Û*\\Â¶zJèµ’cÔ D…–$6ÞÍ*Ln`}ÐÃ^†IneVR’ÔìþGk¨ø‹NfËÉu7¹Ï5û5àkXŽƒfòÚ•gƒiÇÝR8ãÖ¿#>ÛJ¾\"ÑÞÎ%õ$C»¢î8ÉÇjýŠÑtû+8\"AnŠB†lr:üWÅ|T-Øûœ~á?RùÓí«-ìeÐHc×Þ©Ü¬SBýœ/©à{×M¯”§_9f`{\næ®f77ÉhÑ•Ž8Þ¿4§xË™GN|¤LñÆWóLm·ýÐ}=ªÒÇ4Ê·q¹ò±µAöëùS&ŠÒÕÚ0ßƒÀàTöÖMåIr°–·\'$/Sï]1«-Ù¯%õ1nã{Çh<£;Ê1ùÕûKÓ¡0$†w•‹³^üô¦E:™¤Hç’Ô•®˜:=¼‚DÏïAïŽÂªUXãJæäb7E‘%kwdŠih&gC	n¿{ ÷ª	n[t“¿“8ÇËÔýZ²Ú„ðºÚN q×ëïŠâ–÷*Tî¹YbIá’K}Ò<_)÷5‘kÃ	%©ˆ6\0ªÌ7³A!þÏ„n˜ü¸éïZ2˜RàA)(×=8Í)b$´9%„îX‚/\"H·ÜÇÆ#Û§msþ~NÓàù¬ èÎ^áJÆ2£–=9«ñZ †+…9i\\äœW8òÉ´jE-«5Ðy&,6äc½^Ei62©¹^zNŽXbØ¨¸ôŸ=Ô1°Þ6y‹ËzzºsKrùz™·;EÊ£>É8ÚÞþÕfXçÕ¢báF_>½xª·q[êJIµ rwŽ§Ú¦±WjÄÃ’oZô)é¨:fTºuÌ¾uÝ»‡‘ÏFéžõkE³º¸yî$¸;Uvm=ãZåšÐËºÌüž1QGv‡Z§”¬H<q]N­µ´¢ y\'Ê&{šÊ}°IªÂ8¥`3Ñ½jÔæW#—1ƒÒ’R²ßIiÊÂ—íÈþ+Ï©U±°‚ÝžhÏ›²\\`ÿ\0Z¾»Ï1®HNO¨<‘Âª©æ…ÜnõVÞ8mœn”³.pÆ±r%ˆ³ÎÒl0WÔÑ=Ì±n\0~Z¿›ö¥%Æ[8?Ý©ÖTx¤åÎ7w5p—CH3š1««)>Qea“ï_ü]?¹¸ŠiHŠÝˆÈìsýkìÛÙà[yß¹ž}+àßŒº¼’Cxbƒ{½À;OSÖ½¬’Mâ ¼ÎiË.ÇÆzýÀûk=›p9þWÍß›Ï¸Œ³(u9p½½+è½V›‡Ð„“Å|µñ–;¨áF-7%ÏÖ¿ª²çj1‹èÃó_Þâ\'V+wsË\'ÙdRv“Þ£7oòÃëŠ°Å#lHøÏ=ê—t¢A_¥z\n7<¾[-Ø’JûØšU‘_\nlçš‚&r	oF®2 Uy­7_ ¤”ÚdmÝ€ô§ˆžß³Ì2Žé`Ficf9…k:¾	=j%ätÁisÐü¦ÊdQ+mFPß}û>èòß|døkcjÎ®þ-²–\'Œd£¬ƒWÊß|»¹ÒÕÌ&2 á#¹ö¯ÐØŸÃ×Ú§íá¥«]Ûé×M<®7\nTß—*8¬uêV:”\\ý.x.Õ¤ðõƒ¡”ùQÆ®²õÞ¨3^£¦ùÜ´ð!ynU#-Ž˜õöÀiqÜizM’¾du†=Èwr~¦»m\"ì›¨äxÌz`ÖGÏÉjKñQðKÙ²‚.®â©ù‡óÅ|‘<Â‘QÜIÀ#–#®+í?Š>¤Ak}¦‰ ¸ûí\'Jà‚¿­|³<pÝ»B B&A#•úøÌÑÿ\0´HõðNÔÕŽ2×ÅW’Ánå—ÜsŸjÛµñ0Z¢\\Èf¸ÉŽ0QÕ|*ó;E\0T#$qÏ\\×>¾™Ø*<N/ÓÀ9îw¶W‘êÃq\0ýçñžâ˜ú-œÒ¼?kâLÔãÐt®F!{o+DòŒÄÃoµHÚ­úKñB¤€äûzÕs38\\Þ´µŽf´n&bÙ|òOr9ëYóøNþÌŠ€+¨8y­3^TdmFaåÉ)b½Nãß5×Çâ]2æ€gqïü85¤e}Í¯¹åÁ­i0N°Ú™Vb8jØë:£@`–!†@ûG9oS^©h¶$ÏÊŽ0äñS®‡b—7¾dY¦pU‡sõ©”µ$ç´Ú<°Û	ÈÂºX¼L÷÷°;\"¥´	³hêß­G\'…­üŒÛ\"Û˜ÈÜÊN}«\n]æÕËBL‹ž}Z‡P¸ÎÛ’ú®œÑ¬Qé7‚3¥f]Øi×%DlX*F:­yí¦³o¨a-åŠd£ gÜw­ÛKëØ‘7³K&ìñÓ&±4ÝÙ2ÕÜÑmä$r”Büb›wouk*$qÜì¦jõ¶¦cMÓ\"ÂêÄîç-Ÿð®ŸM¾¶¼€<ù!fÀYyõúV.š3ŠêgÙë,,!p,›\\ú‘ÁýkfÛZwHÈ“÷{‰½kHhö·Ö±Œ¬¬%Â²·ÝÇo¥Um;©Î\nGn£ˆ¿Æš)ÄÒ‹XIÿ\0ytøä.}\0¢I\"šëÍ´h?ÅXSèw©*Io\"ù88yâªOý¡k<PBIFuèl¤–¨å©Nç{FêÈN$”‘º¡m:Ù¦˜OiP–þ3í\\¬Òº8|Âºn&\nÒ³8ž~j#$\\$Ñ‰q Â‘ÌÅC¾üˆÇjÏ¼°»0À‘©óQÉW;MwP\\éÓZÍ3\\®T³ûÂ¦7Æ. rËÀÚÝTñ©jû{Wku`×QDí9?4„«‡ÄÙ~X†€Ä»7 çüú×s}¦¤±À×VââPÙU‚sëíøuïYÒè6ÓDð<k±òJvç¨¥Z™ÊZŸã;[ç*ìGìç¿ ­7^·‘§ò®G•°,˜=uÍyE×…–+Èã·‘¡h™Š/¯E Þ[0H¤‘Œ²(à\nì‹hÂ/±ìV·öÒ4Ú|6Àì˜ÏLôãÞµîb³¹·†)bËùà?û¾ÕäÐjgK¸hÉ0Íä>ö}jsâ]WíI3/›ÁF^gòçô­%W¹¼eÜôÍ	#Ûgp8a <Šç\'Òœ½ºÆà–•Ðäß~kVÓÄm*$·W!rŽ‹=ªÜ²/š IýÃê{×,¥sNdspi÷Q¼žh\nÄmã¡\'°¦Gy¨ÛÜ%ªÀRØ‚rˆÿ\0:ím5?’e¸³]¶£ç§áVg°·+HjÇ?LÔ˜œå–¸‘ÎËuy†ÖíŽõÑ¶¯êŒbH‰ÉÏ¥dÞh+pKv$À¥²1óJã®lµH‘àÝ-šE>óå’<Üý:Ö”ÀôY †ú?*!öA/Ë!ÏoZ›(|ÈïYFÀÇ©^Õçw:–¡hUæ,îà`¦£¸×oaØÒÂË*bÎ)J¡\\Ìïî~Ìðu·c°¤Ž3õ®{SÐl¤dxÕŠ“¸ƒÁÉëëN´ÔÓPž)eˆ	%@ /85´%†åãó.>@\0\'ñPª¶Í•IÔšçÉxËO©,ŸÝ€}³ÇåP¬ZÝ¶d{/*Ýµ³œ^¯d‘¬r£lpDì)ŒË{äÆÖÅ#”v#­tÓ™.¬ºžO/ˆÞC<$ª08=³[Öž\'˜Ú\'+;·#w\\ÿ\0ZÜÔ48>n€àcÔ7¦kŸÂþL²Î§ý°v¯9c[ÎµÖ¦J=Ž…µ¤ÝD7nŒuõõ®ÚÆöIì$y +¶!…Xzþ5ãSésÛÊ©÷q’:U_¶ÞÚBñ.é­ÕJ‘Ü×IßAj™ëSßA¨$1_…¹KF&Ë,úV]ö‘³)QÁ	Üíï\\N•âˆÈ†D\n°±#ðçñéZ«â}&âédµ¸˜É{ƒ‘±H<õù¨nû‰\"+ï‡Éoiy-¬‹Üö®ÊÀŽ™Ïzâ­´D\'yäòM¬[ŽP;W¹ÜH\'ºD7!â*>pzñO:rD ¿Ùõ©jû”|ùmâ-NØÅi°6lç`åyçÚºsã!-ÒÝOIr‘uN¤üñ^™.ax²=Ý¶ýèT‘÷—>•ÎËá„E’k‘åù’s~1UmL§.¦xšÒöV„\\±rLmÁn>•ÖE¨ZÝˆíL{ÄˆÔÿ\0ÑŸÏç^D†ÒKY¤ínË=}øéYÚ­¶½¡ÁöÒÓÛ:Ëû¦9åØu¼Vê£ÜZ½|imk6¢ÒÚ¤J6vrJäíÑü©WfòÀÞ®	îîæ[›èÉó8féš¶±Ilæ4mË€ÃÁ¯æ¯³ITÇ:Kd’ûŸùŸÐ~å*8ÖêÛf4vs[)•æY˜óòvúç®ÌcJÁÁeNj[–xro—8Á÷ªÑyH¡-ö.îÇÝÞ•ù\\§ÊÒîUž™ÉRaØzuRj{{˜­­Ö0¦IÂá:€i‘Ø#<K%ÙŽÙ¥Üížpk[Áms$XdSå¹êA®*õ¹®˜1·’Z¬¤r\'\0˜ëÒ¢kT•PFpb9U=ô¤š”(|´|LÔ<1ÌŠÊ%hÀ^Œ+=,l¶ÐÎ‘Q#T\'tÉ)ãÐVMÔ—;”[¹yHÊïs[q,3ÂÌÃ8=È¢æd³EVûîx­¥&Õ™¼bÌ{›i–Þ9Ba]‡Ê¿Â{ûÒÙDËt’9%ƒŽ§è*òÝ;ÂÁ£Ÿ {\nž[Y-¤†åH*#ëžC±~Bƒ\"›ÄÄÙæ©ý£Êic ’ˆG\0ŸzT¼g)þè±ÏÍQh¥Øù‚wŽB[#íYK%N†(«óUdX–ýñŠÓŠÕàDI$Ú{‚±c¸N>R²;+YîßÍf—äxcÎ+±$R[iZgwo%r@Í_ó~Û#Û°ù#\0`ôÅ$Q¼‘³;î‰ úŠµGa1&æn3é]4§%©jE(¬öÌNæ!¹Ó5¢Ö…­|¶Ož\nÿ\0QQ	g1ÉÍÿ\0s>µvÇíK%ÄÓFªŠƒ9Ýøz×]\\eIünæ±­%¢2îmBù»¢…$}ê­wgo5½µÊ9i\\äc¶=k¤da.ÛÌŽCòä÷=…6TµHÀÈ³ûÀŠQõdÊrz³µ°û¢ÇÈÉ9üjËÙ¬Ûòü VÃD²#G¸ª“ò°íP¬’bç|›@Bœî®ÿ\0¬Ka:ò(ËÇ°_–t:\\ŠÏ<Nc.cO4å½A®ƒìÈÿ\0g”…ÝŸ|Ó®RŽåxÁ=ÿ\0\nÊ·,ÝäsÕ—6æSi¤ÄB§ír[ê*C¥ÑvlXþÿ\0¸5¥kèI na»ê*µÌ’üî£$6ÖÏJºT\"ÑœRNå…·…¦ŒY&ØÓš’Vº¶¬“¬LË¸Ï–zÆ<ÕŒ3áXöê+âãÊ™¢ÉiÜn…a‰‡2I”	müÄ+#îGrr;úqÖ›±‚àÊ¡ÒÀÿ\0lcùþtËSqu™„*›={ÖŸÎR¹R\"zþ5Ë:j÷gS­e¡t€ë²Ú|áOñÒCm.ž†agÜ?ÙÍt³¹XvÂBÓîi$MlÈì%›i š®VÎ*•/©†/¤µg)9ØëÀ#•?áÞªyÒs3ïIŠµòI#Cgf#ÞÀçŠmœP^Ú<œ˜Y¶;öÏµfè©@!0³d¸67t¬Ö¶y¥ÈVHç¹ô­»kycƒrçöj”É2Ý!òþVÀaèk7KA¹Žˆ*¿<õ¦Ï:FbÉ-.3Ç ª×0L³!…œãÐ}iñÇµçšqÁ@NzqþF„or½¡¤º„„Ff™Uº.î?úÕEÌŒäÇ\"ÀÎIÿ\0$ò®|/’qœ÷ªò„@å-¾8ò+Õ¥^Q\\¦>É6îXd‚Žó7˜$Ü0:‚þ%Ô|—îDf$ýk_	]„ÒŸ!$8céQ‰ü×/h7BŒ:ñœÕJ§6çM(òèrƒ€K&ì=«Cä*$aû¸›q>Ÿ…ei;@ðCn¾X˜¶@çuÞ)\\m%Ï5‘»+@à>7œHXw¥Ž`—!2Ldz}ÓR¸ŽYœ\0;V¬¶òÅ—ùŸwB+Ç˜â¯b´ˆ²Bï ,Êr1ÛëTZ0auPyù±ï[ev»–Ï’SÍgy¶ëpÊ(•On2+xG©ÇR™ÌIkæ¡ Âs××Ö¼¯]øaá`O­áø®å–Fuç÷oÙ‡¸¯}Ž%e™ÏÌ¬˜ìk.kfË²ñƒï^Æ,=ER›Ôå«…SøÎÿ\0þÆµë}VÚîÕ¯cb¨„°þØÏû]ÿ\0\nøOÆßðNÏØ^ZCá­NÓ[ÒõcçÌJ4OÝÇÍœP>•ûÜºW3²\0O(•cXÏ¢G\n¼Iæ«¹Ê?ðjý$ñ7º¤ÓO£_ågøžn#$£Q¾xÞçóãŸØ¿âÿ\0ƒ]æ¿ðúêÅ+ˆçµ‘ð2pÎdzšð½gáÞ±§Z½åå¤°¯˜c,q€Êz{Šþ¸®ü3§Ì·wPÇµç9ÿ\0ñ?þÍ¿üP¾£á;3¶1º$k´/P@Æ2+õL§ÇJRŸ.*6^ZŸ.\0¤åh½åb=%\"’_LÔqY½¼l7Hz\nþüyÿ\0ñð´°ÝxWW‡@’+?-#–3ˆHôÁ9èµð—Ž`‰vŸm]WP¶K–Ùµ¶ÈÊ;í#w`ýânS‰K–¥›ï¡ó9Ÿb)Iª^ôV¿×Có¢ygž\'[w¢ãi=qSéz¶¡kå´glÐ6Dž•ê¾\'øñ;@¸KwðF¡å4†2Â\'à_—¯×æWZ|š|“Aå˜Þ+\"‘Ê‘ë_eN¼+CžéŸŠÃJpš³Fö™ãísFº{‹öY§ÊÉŒe‡å_tü!ÿ\0‚™þÖ_.¬fð¯ÅÍi¬í£U0K2ìP§ŒÐ{ŠüÚšà,È™%EP–îææ	ÌhQ1Ï°ª4õ<Ê´SÔþ§~ÁÁ¿¢-¾.iPüFÓ¾ÍvÌ%Øñ\0>v	„~5ú«ð·þ;û.ø¿D’ë_ñ5Ç†üK˜ÓÈ»„”ºd‡Ï½>•üY]Ý[\"2NpªÖ·—ÆÃmœ¤‘¸±\\ü§=kÎ–Í´yËù9¹zŸé¡ðÓöŒðWÄô7:Ò5ql®¥$UXôÆO©\'Ò¾„}^ÇM²†âóQµ‹sÊ$_œœq_åÿ\0ð×ö…ø“ðÞñï¼ãßÉqû¹M›`L£¡ ädvé_¤ÿ\0	ÿ\0à±ßµoÃ‹m+K¸ñGü\'ú>xe¸¶Õ‚î»^>PUT\\O½B¡+“õY­ï}jÆê[w´º_=&$íôþ\\þ5›«xÃž%Ýˆôû]zÑ†ÒŒr$Ü0C`þ•üÈ|4ÿ\0‚ìü:ÒôÅÑüiàX¬®ÌÉ-Â™Lq4Ýv`³nOwÁ¯¥¾ÁC|ñP»¹ð×Ä‰uX\'C<)ä„òØŽd@VDÇLqÇñW](É£ž­F¾#ô¯â?ìû*|Mó\\ø]i£?˜Î¯³êÔ×åÇø7×à7Œ§mÀ:·Ù<I©M ÚÊ\"KUr›Ir­×ºsé_¥?¿jßíí>êmgL-œ¡|Ø]LrÎ<²Ò1#¹èE}c¢øŸCÔ\'†{kÑ}¢?Èx0Îé‘[ª–4Ž+¹üC|nÿ\0‚~Ô K¿†Þg}IáÒŸ,¡Ñ1ŸcŸ­|)©þÆßµg…õ[ÝRøG~/ô¶E* îfn0•Iüõþ’±ëKl™öF¤þï³Cìk–Öl<ã·Ÿ_ð¥®¥4ÊLÑñŽ™0r;ƒï]ñ©hoéŸç	ã¯Ø—öŒ·ÑìõCáü×6rLQ£¶pÒDÃ®äÀoÐ×#áŸØö™ñRÅq¦|:½¶Šy6¯ÛÆ\'\0’Gß¦;×úøóö_øc®Û,z7šyFøIÞ“Ü–É÷ÆûÕòGŒÿ\0b/èócÁZì:Å£nÙHrÄ(;Š7aÙqzéŽ;±¼1Vw?1ÿ\0°ý¦ì ¸Ò¬žI\"ÞÍ¡ÄgÓäßþ>Õ£¦~Áß´Þ§-×c´´ÑÚâââ]¢@£$Æ¤nlaž•ý2x—Àß<f‹ÄöŸmå—iŠ7”\0í»\0dqÅ|›ûF|QºðgÃKVµ¸h.£µ’Ü¹/#}Ñ´ö=úqšÕæ6^öÇ±„ÌëNJœ#vÏÀ-^Ñô”]&ëþ>l›PMst\"T,ø|ðßÝÿ\0ëÖÖ½xooÍõä%ìòìzêMV[8®Bª$\\û×æøÊÎNÝÙ\'ZRI2ç›yQ0;ZSŒ¯SF«\"G³þbÝ&˜Îš~Á1ß‚psÈ¬‹»Ã1§*Í¿ZÂUÙ…J³–åÏ\"a”«:÷ëŠÏ·kk8¤ä ,wÞ›=Üqykt¥ÎÂ9ííô¬¨ œÏ½HHØä¯­ªå£\"šÖæº›uMðÌ|æbÙn1UÖ	™™Ã£¹$zY/%¼vgc{tÚ„xïYéz \nÜ÷ª\\´+ë\nž¯©jìF\"ƒ1Ëp~ÿ\0ð¨õ5j&XÔnÃ4‡z\nÏºw¸¡LJ§9þñ­-9 ŸÉ[•>rIÇ¡®©NN¬ðq˜(U¬ç§aàÿ\0Xø£XÓôBYÛT½DdS‚ÉÕ¹9çn{WÓŸ¶‰æÓì|%àèâo/EÒáHe?òÎ ›V0>ƒ&¨~Î	¶Õ¼RÞ%1Jéá˜¼öhˆÄgœ1Ï^†¾{ý¢¼cÿ\0	?‹|Kz/d»–	Š$Ž0²Îôtâ¢ŽÊJH¬Ë5Œ¯d|ã[ñ¨nD:7ë^¥û*øüiñoÀº0Ô$Óïo|@’\'–lÛüàñÎ;×^Ou4ÅÝ	ß!?S_®?ðL…w÷¾4Õþ$ÌiÖÐ8v÷‘pWqázòG8…}•rÃ•t>S%g\'ØýÏøw Zèz¾‰j¹³Ó,PDWøGN+Ø´«†¶…\0G ç¯5Àx~ÎêÖÖ9%˜q\0ƒÇÓð®¦-I‹By~XáÇVÿ\0ë\näå¹ñ	BÚÜ2$è·ó<lG…Isòœ’¡Bd.z)®bÚæá¤wØ#‰8Nõ½c©­É$9À*Aô¬ý‡fe(EîmÛGä´[áp€û(ªò:©*¢S·’—¨kæÊãÐV¬S<p”(\\²a³ü5Œè¤iQOBõ½ÛÞCòÂ|ëeÂ“üF¶­oXJ»m¸XñŽÀ×7mÊå	1£œqÚ¶m>Ì®ä>Í£$½ròØë.üÛ˜™ºùZIU¾pÃUYžS‚Õ2;‘UŒÞRH¶í4•É3O™­†§cN98¶;3(l¯Ö­.¡sp3ùk	Í%Œ‰¬1HJË$‡ yü;Sæ´2< 0ÁÇ±©u¯¹\\ï¨Û‡*ë$HdG$dõ–›Öf±.`ÕÍ«…-ç;*\0rNÜg€3¯Níx^m¾cã>¸¤ê]ê)Jæå¤òy®÷*#É;@=?ýtûÅ0¾ÔßGz‰¢K¨™K	g*Oj©,WJ‘&á$E€988­\'šÇAá’(ZI?îÿ\0$òCpÄÚÊƒ µb­˜·I¼ù•d\0g=5rÊi-ogÌHÏ³\nÆRw»=ÍDkUˆ(¿Ÿ—û§Þ«Åqpì…ÕÎ¨f	 »–âFEV\nO=ù¢`ÖH×Ëe ¾¾µ“•‰”nYŠxc2ñ.pÍü&® ¸užwTx‚¦Ã“œrOù5Vçìïk´N®ç’GLÕ›O9!¨Ê¶2	â¥O¸£Z\\º£Ë$&W€Õ§m/ÚGRÈÙýš«ªY0©’\n÷?…Ko\'”f½1ëRÙi–§\" C¢5Ü	î*w¸!‚/\'ÎÞÙnùúVHu9Ë¹iŠ\"G€rÄþ|þ5¯rÖFá¡Š6‚Xc›±#¨®¸iª&reãä²)aÀ\\{­U´_ô¢Îv«ÆQ}øTl³È†5ilc\'\0ûýjâ¶Äò‹¶Ä¡³ëVs¹;Ë»lp]â8Í=#ŸÈf`ØÁçüšÏ†m’+É°0bX¸=…iÇ\'™ }¡\"B@=êcžS¶¤¤xÐu†F*£#}*öÖh‘þxØêiŽÏ#K8>¸¨¢{”ó!Ý¼ã=n¢sÎµÍ2É,1ÚäÂ¬ÀöÏzÚÓQac(hã@A=ó×üæ¹¨÷Î‚à¾É#\'²ÖœW!Bb0J¬G´/Fù¥º´3-ªÀ¤1^Lƒ=j³h\"½‘Cûå1ME	z¯0Ù²\nût­;rÅ¤32–/€ËßjÞ¤ÊWÜµ+È¶æÇsÙ«ZrÍoæYd]Éx\\ÿ\0Ôâ„±ži|¨ØotÜIè+m’Ñço!FìqSìÌ*E	f™wx“÷/Ö?ß±­Hvy­îhÆ>SÐçëUÙ6ºº6\"nm¥rJèª1ž2:×DbÑÍcZ9!†5¦ó	É#€~µ±imk+Ä×+óBÁ=Ç§áXÖ2Á\"I\nÆ]Á úÜ¶mPë…RqíŠèú5c¦ò•Œ-ŒÊY°OðñÚ¦¼›ä\\¾ÌûœUx$óG›\\ è;ã¯ã[×–1²[Ï“$Ž\0¿?á[)K—”N£ååèmØ™¦<ƒœu®›MFóy±•Ys×\"±ô»wÊ#à`’Ã½tö±¼“”Eùw~ƒúÚ”lgZwV7¬‰W,{Ðø\néìd”‘•åp29éé\\Ìt€K:Hƒå `õãÖ»­2ªHŠÇ’[ÌÇéí^Í$yÕ$tV~íFÿ\0Ûò®ÃJ±¸ˆ€X©|~U‘cm(NÀÒ>èk©…<¹ÄŠŸ¼Ï í]tÎînÛYI-È¨m©0õú\ném-BOæKôuÇ=ª*6ÙûÃ¸¦N=+poeÊ¯9â´¹tàU[hd•C1ÚŒH¯²H|ŽFê­§Ìì%]¬§·z¿BgmÏåÈIÆ;{ÔÍè{¸Z‹kgKæ ùŠ…9ô«”€m\0ÔµÏ=¢¥QX¶\n(¢€\n(¢€\n(¢€\",ŠÈzÂ¹Ò YBÏ´’NÑÐÿ\0õë ¦°-‘ž1[Ó«ÊrWÃsî~]ÜÝ[LÃím<1 #ÒIVÙv±Þ@äs‘ÛÉr\'\0™ÝžœÓÅ·Ù¤ŽÚLˆØƒŸc_’ªHõªJÆÜ:›µd‹ÌPÜÚ¬\"Á?žÒ’!Q×¸®u£08Û)ÜÌxíQ[\\‰à%‡˜Nìw>µirwWgU¼P:‘ßs­HúWšHíß$îÿ\0•Hjž—d„¶‰rýÀVÏö‹ìhgq\"ã¯p*­¥ÊÉµ„:„†$ÎÂåsýÜSåÒ³™_ÞB~F­hœ&é‚m„Ë×ÜÖë[-Í¸T>SÊ§nzïMÞ×:c+2Ø‘™‰ù\0ù˜ôƒ<SCq?ÙÔÜ×5é‚Å­”G:«æ>@åsY‘!œÙìØ œ95DlÏ>H§™™öyEr:µl[ÍwjìdB_½q]+iíöó,pl…F\nâÇëT%´k·º”P¤ü¿Êª;“8Çs9nÛÌÞX<»÷ã9ÛŸÖ¯[ê‘Á1YT™¦jÁ’ÒHˆÁÜò*½Ç™qäÏjªY’	éô§4`ÏDŽñnÕ\"t	€9õ5ZéVÔiÏ™À®M§ºX¡h˜, üØéõ§É«ÜR·#¿Ã«{Ô¤™n+æ¹wO,2	Êÿ\0Ãñ«&È­Ü’S¨#ñ¬Ø)dIÔgàûæº{xQ¢y‹?–pTw1‰w£I02™ŒO;}ëŸ—O™òáÝ…v,·1ˆ#\\`žWÒ±Ý,ò-Üaáv;qÈP=khS5Œ‘ùóûeÛÞŸEpdcÜów\":ð£¨`Oå_ÊßÅ›ÿ\0¶x³Ä6R[,YxŠö Sø•$*yêQ_¶¹Ã!ï¤Kk;]M&ûB¶Z(H;°1×‚:9¯åCâ©s¨ø†îæÊHT™ž²€ÄøÔâ¨¯ewÜûîtÔ¥\'¿èy>¬uXÂ¾`*sÒ³$/K@ªË2}ÕoSÜ×Rú‚ZÏreUIvî\\ôb{}köú	U¼È—{s“ï_)*îö?Ku!Õ™Ö—©-¬–®|É‡¯sšè´ÉôË;k†kr%Ûøq1¬qNïÛ¼–ÏjÑûTGd·ùÎ\n;‘ÜÖn­Ìý¼.É8%º™ä…U¹aŽÕMðy\n›\'?ÅY O=ã4n<‚Àî>•­*Z±ÂBc›Ö‡n¦q­tâŠñÈâë” zû{ÖûH¶ÈÒ·˜ŠÇ?v£ŽÙAŒùŒ§©ª×qyû–8úÓŠ7(ÁÄÊ¸É$É»x®xÜÍ,Ó‚Ù‰Â®É¼Ïöw¼¨e9ÏCM¸w}é\n„ò2}+¾ŒYçâ*;‘GóïE$|U‹Ö•¢Iƒ9UõÏµU»/i$–Nõ^yîf†>tDwÅèy‘=´´²3®%+À=êÔP-È*#É¶—#ýœÖ Ë‰žo.7Ú9“XrbwòcË;ÙïŠ™¶mJª›$¸Žx[&|9n3ïIÌ±N)W`x*8Ï½V¾‘Ÿìò4ŠÒFû€\'½&çeû™V8À¬*\\êu4|Ùg{‰î°ë&\0ö«{y‚˜0#RKc½Y¶#…¬™7\'$Ÿ­g$qEæ—fùI?Z˜ÆæoÐfÁfºˆ™e•Øz}k>hæ¾Š%’æ‡$H{VŒ‘Ê›^DÚ„ƒÍ=Ù°ñòÙO—=keÔ™ÎEUSfnYgî{U?:ÇyÒ±·žÕ5´qÊ²KyÒ6AÏEÅE!x¶íM¹pN;Ö±i3’s–æ.Ì«$›rp‹íTm–â9î#”‰°§™®ºO²<Ñ»›`PqÞ²¥®®†Æ)\nŸ™Ïp+Ö§ŠoK²Mu2o%Á\02ãŠ#´·¶F¸EÜø¯aíPÜÆ¢W[XœŽ•“…|õe†hí]³’S±z›FŽOµAåäçµÇO’iJËå·WÐVï$æ,\\à·SU HþÑ#H€©RTbbæÈ|èÑíÝ,c­Mæ³7úæY£\\Ž+VÞ,0h¡ÁÎN{šÌÉ¾–IP²KÀÇ85º‘ƒÉ–o*;Ëî$1ô©í¾ÒÈešl¡pœäõêvG¹f!ÖP@SKå4®»]•™Båv­)Å-—²åZõ;»y$\07VÏj ±#‡˜¦\0ý1YzŒQÛM#Èv¹b>µjÊýZÙá•Rx>ÕßMYò«m¢~À³øŽÖmù‚POb¼×ë‡–ÐZÚEˆg¨áŽ+òçö]ÓVóÅÒOh‹L·’gÞ2¸\'{‚~•ú££Û[Meù~l3ÇŒ…~â=U}Ÿd}ç;á“~f³­Ä…¦b¬ŒÛFOLV3YÎo–íHDHðÅ»f®µ›Ã10»·‚ÀóúSšÚiG˜¬<²ü)þ#_ë­ Œ™Ì]Ivg{s	™·pTñ]SYÛ”`dNTô³Æ°dù•ˆzç5NëÎ[c<Ë·l˜¹5^ÖêÈëŒŒ’>Í¨BÐÚ\"Ip¤»¸íZþ\\1l ùÎGzÌ…dòiäPÅÉ{\nî#³CºÊÊ‰:‚»»’**L»²‚¼­²¢qJ7÷RÔï­¦H™£o·‰ÜGß\"´\"Kˆ<Ô”	!WÈÅBòZÉt±„ê{×5J¢ ÓÙ&‰\"*DÐ@ì¹­Œïi¤Aæ.*Ë[¹ŠAj|©0X{ÕD¾e½»;˜Ã½c{êRÚ±|‰¼ÕqíZ¼blìˆ DO@;šË­g{5ÃnxösŽæ­ØÌÒùåyÎ\nÕÆ0b¾Û4kÙÕç_3hDêÆ´#™ïÄhñ}ÌYÁ9Á58„E%9vn3ü>õ‹\'ÚÖð[¼ƒç~ðÿ\0ÿ\0Z¢TP_¡m5´ÆYSiYöo¥^±º¼{‰2íYÊ²ŽqWQ¼¼ÁqyXçÓÔU	ÂöE¸lõÅlë=¯µ{2ÅôÎ¨6™ŽA\'±©të)V52ÌÈŠÝmmß{y­´Î¢Ò¯KI!‘>bN?•)Tl­¥ÖäÆ\"L$¤éTÒp\'hd\\9àIýïj›ío4ØnhÁuaþ5LEàÉ>Ù\\eG¥e)1É,•¡uÎ3éP3¬OåczÆN94¶ÆéívHØ`Hü3R¨’ÝÖ@»×nw7­\"Ì§Ð±ardpUü¬vÅk¹Œ´žc.Ð£$õ\0ÖÕ¤±Èé&fï¢ƒÆjAæII(ÀgÞª1].¤z¢ÛEcz×hRÁ¹aüGÛÜWæÇÆ-M¢¼»1(qs!EìƒkôSÄr½æƒ©Yí1››vŽ?öHéšüÁñÝå¨žââõ¾xäaÏ|W»ÃØiO¹ì*µ¹`ÛÐùÒòVk+É¼à\"O3xþè¯òoŠ\\Ýß·rvHq»¸¯§5.¹£“Ú™Á5òç‰®R{ù¢‰±åŒ}+ú²…>XÙ‰Õ«}NNp\'i$eè8>•Ëï„­*Ì_ÊG;œöïW¢óY–”u®øœSëˆþPcn†ÁX|cê)/6 ÄoóÛœÔ‹0+Ê6=6Ìbõ“²>QF@È±­uºó ,ëûüð+.Ø<AäÆïO­Y¤i’GÅÍ`uS=§À>zZº°ýî	L{õÍ~¦ÿ\0Á64IµŸŽ®´¨é†<0É#GºK—ùI\'²íçÕù…á˜Zto!å·zWí7üD´¶ºñÞºd”j¥¬qãäŸË!Ùº†\0zçÔTÏbkEÚçî¥„7	(YDQ²¿ÿ\0¬×m ZÅy²æE¸òO¸›‚ö®¥vÄÁwêØ¯CðŒß:0Vhóå¸ïžÔWVyåßµ{ãsk¦Ã\'Ú\\`üÌpr:“é^&¥qg$äo’yá¿­}ñB+	/(B}­ \\î¸<þâš–‚·VP¬²”»$6ÐzgÒ¾+Ö‘ëÐøÌÉâ»[Èðd6¿7ºæ·´Ýn³û=ó	îcRD£«ŽÞÜWþŽÓ~ÙŒ·~qÞ­¶\'íOæF€ã…rI»Ó7–Î†kÈÐHG,z“WWHAòŽ^^@=Ø××÷šff%ãD;[ë¬°Öï x\nœäñÖ”Ù\n:Ö<<°<\03üØ8èµ•.}3éàf\"¿{øòyÇ^~¼Waÿ\0	žUvÉëÞ´úÖécùRè\0íU ™È[jº¥œ»eMÉ´qé]\'‡ü`²¼éu#>Çã#aô­{hìo|ËULs©Ûµ]—Â6HðªÃ¶õˆbõÁíŽ”îE ëv·0Ü,§_âÐAy¥ÞŒŠSn3žEy¢øn{y£o8ªFç8î=ë\nâÏV¶¿bšÙ_r²{Ö.DI6zÍ¼k,óÅŸ%NF{óÞœú4²ÅyIK¿ÃŸLçŠá,µBÝd!‰œt º¨<Q4)žI.y<rsïéÆ—´¹”¹¬ž’tÌLKnù‰¿ÿ\0\\ÖEå¶±mŠÞ’V#Üã§<ãñ®Øk0ÜZÆé\'”T`{šÔŽÿ\0N¸†9¥Ý=²W\\Q“<ÎÃP×l£•î-LŽ1”C…_§ç]™âÛøne~Ldõ•ÓIok>é!%•Ï\0ÖdþÓ§	4<2³’ÃŒbª1¸›×rK_&§raü…Û§®}+¤íré$K,rG‚½sPxr(Nè-ÃÉ\"s*÷Ç¯Ò«6›¨´ÑÈ.î¤#ƒ÷¾µN6Z”tWVvª#¹$g¨ªòhÉq±æi\0çX—“ê²©S¹vƒ³Ÿ—Ðf­¿‰R	á±‘üã¹U	ô?¥JÜ¸Å®ŸvFWù`V`:Çõ5›§¬Úi£9ó_ä	Çóé]¬^È+r×k€Of=°=i÷öðN°KÂF–R›Wøqï[¥ÐÑ-,ÊQx©Ú×z\"Î‚Ò0õÁ©­µØ.¶ÌÈ<®qÉüè—@XmÙ£Q¶lå1××ó®_ûQŠØ+Ú2 v €vŸ¡5ª‹&I‡ºuâ³ Y¯Puîƒü+^ÁGÙÝ]79n®+ÇãƒY³{ˆÕ¤†	mŠ•AËn÷ÿ\0ëÖöâMbÖæ2ý¤;páô¬ù™*½Î¹ô˜34›G› 9Èë“RØxzÖâãœ*ºpçõ™ˆ§–áÛ“€îÿ\0×Ú´cÔÑdÁfiiQéïC—pl¯©xJ\'d‰ÜüÑ†p?ýuB=kOªn£ í ç\0wúšô	ïæÞ(„1™É8 {}jìq+[ÛÈ¤7œÇ öÇ,gœZßÜ3,’e¿1ž\0¾}kxk±¾ÈgE•‘†î>µkQÒì$‘cdáÏÌ£ ÅTŸÂ±]$WDˆÈÂ0ojÛ:4º¶—N3Bvù B£ÜV-´ù‚æó³Îz=ó\\þ¯g«Y@|¸åy #åÇÍÐŸjÈ†çX…&\"vYpLlÃ;[ééS)X‰Iž’ša“!ã^@Ïð\n†o\n[KÜÂ¦æìåNî7.¥ai>!gDKéš€.ãëß5ÑZë€«´mi@Êîæ¹åP¨¶÷9ÖðuÉi’©%Á>¾•^[í>Ü-´eÔ™={WwÌw/åÈV%„ül=)o\nÊ‚m‘!8²jã.§\\cÐóK=nöÊFódƒŽ…}ë£Å$6fy7ËhÄ&8=s[Sè\\ê®¶þmË S!<‘éé\\½ç„n`Ùyå[<¿_Àþ½tFeÊ\nÇH÷Ðj²6ÂÉj°‡÷É«–óßgœ%‹¢…èpú†‘uj°•w9ÄeˆšÅƒS¾Ñ§–ÅãâX3ƒ’\'ó¦ê™»º\nÙýéoò+.k{Ó—l‰•!xÝ\\‹ø¹Ñ—Ï·*ÄHää÷­U×-®$g†vòÎçÀ8Ù#õ57êe+¶dkžƒìÜ#mýÛsŽÛ=ù®&ÇÂÚ„S¬ñ]˜£©Ô·lŽ˜¯oKÛMBÆeUY¡xóÇñÏzl–“Dëê¾c_jc~g‘¤úå”r%ÌísðÊ¬y\0‚¶­ü{¨£%Äî\nŸC“õÉÿ\0\nô	ôk7F¸K}ËŒlô>£½sóøSNÕ?ÔÌÖ[ó£ lúÒ%²;ˆt·M×mdfÚ°ã\'·éô®Æ;=¤LÊ^N¥OC^[wðÕã¸G±î4Ü|Â\0>ý«>æ~	á··šE˜ï\'¿ÔÓ¹„ž§¸Û+DË$þE¼êJªôïVu¢éhDÅ\\!yÏÓÞ¾Ä^#ÒšI¤¶–ô<¤Êé÷ÈmãÖºwñóÝÆVîÝ¬ÕP6%‡½!ÆïC._ô›û¨¡@–&6uÔþ5$šzAÜ:·E9üëK»¶òâùY\"yX©é{Ô‘H’\\\\\"6C1ëßü“Äø—‰ÅÎ£îÏëÂ,>’èMv.G\"¢Ok‚÷ÏåÍQŸtP2«‰ºç¸5`ÊÂU·ÜÅ·dŠ‘-ZåÊÝ91ä…Øû×ÈVo›¹^ÆÑ•€`n¤äúÖŒN—; Œ³m|`t$zÓâ·x¤Û!Ì\0qŠÑHcŠÞIB…PÝ»×ãp{Ü­z°²ˆwî¹@»°z/¥bÉÌìðÆFÃƒëV™<ë‰.¤ÎÆŒ\0|zÕ–2¡T‚1´€wù¦©3+U·¹K‡|ÊØØÕ‰)®\nÜ)uVÈ«wbê ïaËz\nªÍ™¤iÆ±ä)þðõ¢Q:iÌcØï—pù6x54öë$fUFÈÉªÆÐÌÊby3qò€;ÖÐµh¡[{–%0Jÿ\0ö÷®yìn¼Ì! š9AÊ²óŽ¨ÆLpÊŒÄîMnÏÙ¢}©\0£·ñýi‘CöøÚA4qG\'Õ½…cìï¨Šá£UY‡f#¯sV<§¸¶œí*ˆ\0*$}jœQÛ–(£†ÈÇ¿s[Þ^a>\\¥™3¿Ó5Ñ]Ì‡\nepä¯<þ5j-HÙºùàº\"óÅM{‚D¹VG9Çñ}iÒ@ÊŽV¼‹©š•÷$mN²|ÖÎx$Z°JÊ’6ÌœàVOú;Z•x™Êý­YcY!,\"ˆ÷`?­.DZ.~ëËPé“æÝ¨¹,I–óŽ*¤w‰ðÈÁùºbž.7™ðˆÊp{(«öch©ÀR¨§\'µN†¬0ªGÞéÑ»´AwÜTW1ìtŠ\"f!†ì{Ö¶³jÂ_2_‘þ^€Ÿàö«7+™šW2nIö¬Ï*ÙO”¬Ø\'z½XâV°Æ6C]tüÌRIf[ˆ’Ø3[Uê*Åå“í]ÄcÎ7P/œ\"ù<àž„Ÿð¨ïÚKŸ!e“>KnÝŽõ×4ÌÙRÖe†K[}Ž 	1Ÿ›ž¿þªMB/>p@AúV„·Éñ²4³¯÷W×ñ¨¥‰.$›lc¦Úå«5c^c6ß6ö¶ècÜŒ»‡­h³Š]×÷²©õæ¤u[p¢³¤§i^¸ªÓA´–à¯S^\\äžÂÕì@¶¢ñíáV\'85Bê0<¡åù~caIàÎ®$Ík\"ÉnN7v=ªfÝä5Ó§€ƒóÖ´§%uqJ•dÌP½ Q.Ü¿ÂHçóïU­àæ]ÉÛ{\"p¸ÓÖ¬4›fy6¤¤—ø>”Û=­;Hç—ÝÍu$ˆ”,‹uY¤}¡ð;µVš0î¾S‰ÙÅ]šG”T+$móßÚ‘c†ÕVá$ýÿ\0™÷;`T:}XŠ6Ë™D’X÷ªWsAÍ)²å½­ž`g·]ò»’79ÿ\0\nÌÕlåßà¬‘»m#?wÞ®4Æ¼ÊR+<Ù¦FŠ°åÝ¢á¿Õm#Ÿá­Ä‹P–a”£ò°êÇéU&Ñ¤’ÛmÅËÛ‘(o/³`qžÆ´²¹¬cÔæ\'i÷¢Gmçåçp=jìÿ\0~ÅbxH8Î¨üjeƒË?ë¼†ìÝ±ïJÚc5Ã$òyêq–=øãW§cQ¸xKŸ|[Ëa{f²àÔ®å=Äe6ž\0ô­«Ë–Ãj’qéYÐ¢åþðÊû[çµW\"ªÍ6åÙC+lBØÁô®¦9]fbpÑ0¸ÿ\0ë×,‚8!¸hÛwqÔVÌK4Á1¿•à.=sB¦‹Üé ¸ó7%Ä„@ŒH_sQËådHs0Ÿn˜÷ªm\0ŒùP*¾AÞÌx\0Tq3¶\"ß€ëž½EZÐÎP%Sö³ûËuD(ì)#ŠPIË£‘×µEsuäDîÀ¨€jœ3bH(Ï&F;æ·r2”Y~O*\')ýû‚séY’iÍpZebC?\'®Óÿ\0×«¬âiYZ\"æ<®jÔÌ!’MÞ_˜)S)8³îÂÞ…ÙK6ùI¬ù£{|—{ŸJÖºûDaW~áÔñUCG§¦go—åmÉå¹ƒ=Œï4wW©]ùçÚ£Õôëµ±©i€@ëø×J¬GÛ…Áõ?zÈ¾¶n»—~@¯V–!	Ò<¿Yðo†µU“KÕ´(õ+ãÛ.üå‡bÁ=ˆ¯›¾ ~Ä¿\n¼am¨­ŽŽ°I4-ÚFà-÷¿yØ\'œÃÚ¾Õ†9.šB‘fUæ¦7(D±¹¯oñ¯¨Ë8Ë‚Ÿ´¡7úv3\"Ã×ƒ§R:3ðÛÇðMOÀ¶²øGZ²¸YîšmnAr	I\'±à\nù#âì«ñGá³É«¢E}” û&ö?ˆ2)öèkúnhêVó•‘Xð}ªº†ƒãI½L–ñGØå€=G®}­±ñŠUbŸÎÇÎTðÿ\0ÝÏãÇUðÖ±§j7séòÚ\\ÂÀ´$”ozç.­¶ß5~vn8ï_Ôÿ\0ŒeÏ…$Ô.À–¶:ÍñÄ—ñ¨óåÇ«œãØŒøÇâücM—K½¼ð÷‹ž-JK¿ø÷—caÜ„°íÛë_¬å^-exŠjUeÈú§ßü¼ÏÎñÞâáUª:Ç¡øT“4ohq·©4ùõyüÒ$rËÆ\0ô¯º¼wûücÑ…åÎ™§VÞÕ7cI0WÜlö¾E½ø]ãîçÕ|9g¨c!ž] uÆà+ô,s„ÄÇžDþhùœÃ‡±XiZ¬èq·¯vI›([Öº›OxŠÎÆ;k]A¢XáÚ«þÏ¥c*âÝ¼£;†áÐE€¦et;²=ë×ŠGƒ,,^çÒ¿¿k?Úá»ù>ø¯«i–’FŠmË‡‡(r¿»`ËÅ~ªü	ÿ\0‚Ù|aðUî“Œô›oÄ—Ñ·VòšÚ00^%å¸ jü’åbp§ œÖu¬¦{©#1´É‚”£ÐÉà\"ô?´O†Ÿð\\†~5Ô`‹_ŽïE[N;HSB¬Üö(y?E¤Wë7ÁßÚ§áÅ§‚ÛÂ~4´Ôæ¸®%Hð\0\'HgÜëè	>Õþn±ëÚ¢J©ãÃòc\nz]‡<uãÍö“âÝ>îÍƒ[ÍÎ#ŒW2Ái¹Äò›u?ÓsBñŸˆ´èotç€ºfekgó˜¼0$w„íVåÔn-â•žF$·`ùé_ÀÂø*í;ðÞ]),|pÞ\"´°*BI“þÒ°9-îAÏzýVø/ÿ\0àº6Ö6Ÿ|,n!qöÛÛiV`~î\"ÂŽß9ç¨«XvŒK©ý:ßk2ê:qƒXd¾·†wh–eÅžàã5üñÿ\0ÁbüSák/GðÞ Ûiz¾¹,ÏsUŒaNã·ý®3Ž™¾¡øwÿ\0_ý—þ*-¥’xå¼#¨Ü2Go©Eö–~~fÜÄ{áX\nü(ÿ\0‚‡ü|·øóñ§Qñ¨‹¯\néZ|VVë‚D‘Ä¬ý¢Çaõ®<ÃJR¹ípôZÆSmõ>Ô)ƒFDˆ`_JÎ±Óoœ™£®ãƒá«w7R:,q6760kWD\"Ü”9IÉÎÓ_w?oŒSFÅ”ñIžÆpÍœŸâÇ­Ic½Ô“&<‰#ÈéVo®Xî€ó\\öB9â¶šO42\0¹$Ç§çYò±òD¡+EsvÐ„ó^Üþõ#ÙË<öŠ€‚xÁëN·±ó®¤¸FêOëU5o-±¶=Ê2=…ŒãšIèRŽêiïM²)Ø~_«·y¥<WI1]Ê @jÜV·‹l—ž@N9”GÒž÷&J™IÉ=Ï­5&pÕ÷3%»Y‚ÁïýçSØ×`²[†#[…@pGõ®*ÛOŽÎþníÇÞ½ÃQ-æ«mo2‰ZeHÐ¼ÇúÐæÎyÀûSá,×þ	ø!âÏ\\Û‹{Féìau y†(‹±Éàç8ÀÎ~güKÖMÜÒÈ\'Þ÷Nîßð#_¢Ÿ|]k£|$ð\'Ãkke±³ðæžnJF>Y¦¹Á‘‰îÙÕù9ã	\'–rÁÎw`{Ù|VÇ‡Šn÷‘ÎªµÝÔV@ýæÉ#°ï_Ó—ìUà9<ðgÂv»æŠoYE|ñ²í\n\' ó{ž¹ö¯ç§ösðœž<ø·àÏ	5±¼moWXÙW®ÕœSŒzþ«>hwZ.™§éW!¶³Ž.zF#\n¢Žz3ª¢¬|¾w\'È¢\\µµoÚd\'šDd÷R9ÍušzÙH‚)-ÆW¶k”ˆå†-01»UØÕ®#-åùŸÝä8ÿ\0ÅNñÐù˜ÅÚÖ:IæØBYÈQwa‰þ1éô­ˆ\"ˆí‘Œàf¹U`@I¸ƒÐö­;\\–D™]²p{‘Cz»:”‹k»³€`g¥nGr«´Hxqœúå®hâˆç,XÇaZöê%0´“l\näŒîÿ\0õV3“êi÷7šñˆœ„=Ï@knÚ{}‘Ü;,Š²œ“Ðb¹†`¨“\\E˜S?Z±:Á-º@–ð0u^íÅ)mvt¥¡Ö\\N‘9YfB8PsøñU‡•.ÉXáIÇ­eÛ·U-·yÑpðR¢Æn¦´ÈÚñ‘ó6“è+6dmÆöÒI‹‰$ŒðÃ¨Í[a4whKP¤“íXÖ³&Ÿt€G„gù½ñZ2^Kpïˆñ\n†®yne&ú—ÌË;¹ûÝíSÇ¦ÊóÃw0K¨ÉôÏëU!’\'ÞLÊ¸ÙéïøÓnfŒÈr”tªŠ¸œ™¦cr$ù‚*1éÞ©Ì&wÂåG~k.ÛÛÛÉvû40Œnë%nI{o12®n&?2ž«Žõ¿+Í)#3–·y¤gøÆ;Zd!uµå—Ž=*¨¶yËH×³hl}*híÎÓq¶çEv¬§¡ÌÍ9-¤µIF@~RsÚ¥¯âks,qÎŠ1ÉÁ#·OO¥fµÄñ[ÛùìåU$€{Œ:}+FÜ5ÉW‘IÉýkžIXèZÇ#Z“æ7™ =½kTÜî·óHÚCàc¹ªRíýçÆîÝMB¶ñÊA„0Ørsß5˜‹Ð33Ç#HÆÝ«^ßnæ\0U$Þþ•FÖÍ%VŒ»5£l‹„É ßœqÛ´ K¸¢F…¤Ñ¶ÁÉÚ3×¥\\¹¼ÒÇ¹“ƒÕ‰¦¥.$Žc¼Œ`÷÷ª‘y·ž`£\'/sšê&Z—à¿ƒxŒ3-ý[5«%ÍšÞ¤1äŒÀu\'±¬K[X¡ºl¢BŠTßš¹0·¹¹[¦›!ä7µmÓC’¤¤–†Ä–“Âö‹`#’ JÎ§æ$óëQ[‹Øþi”NªFÌc9HL.C;¯”¯!ükRKƒå„EÙ_½ÜÑc’¤Ù§ó½¬rˆÌWçp=Çùö«Æâk–I\0 t8¬=ñL‹+yžzƒ·ëZñÈËpÑDá£q†^ }=é“kšqGmï8ïiò[9<š“ËŠF\"ÊMå]³÷ÇÓÛê*°D†Yäå›W?w\",°9ŸjÊ{™“›hZGA\'	ÎOÖí´¶ÌÑŒ²¨ãý“XvïhLŠ\'c‘†úÕý5¤-9¸_\"6?!Ïßýj ŒæÍ©ßÌ)åÆrŸ¥kDÏå#,\0½ÿ\0Š²’B‘…‡÷+aAïZè~BJ\0„ù{ý+¦13,ÛÈ÷Á\"mPCŽõ¾®ÙÊAe÷ª–ÞtBHÜU¶üÝñZ1}šãiSz#üŸš´05­-í µ†I<¸Bàg©=ë^Ýfb±É·q\\ƒÚ°íA‚ai>Lÿ\0Ô×I$RÜùDÃ#¸®ˆG¡•CkÊÚ²Åpð@ôú×c¼òÆ²Fš^ç§zç¡Ó%’pœÀ_\\ŸZÚ´ž+yù¬ª„ÛÜ×LbfÙÓ¨’HbÛ3”ò=k ÓâI$ŽWï·nÃÒ±,¦6ÒÆÎÒH÷®ºÞö/*xb€,ãÕ˜õü«ªœZ’5­­á>c«ïr6¨=«±Ðc™§H<ˆY—<·=Ö¹-\"ÏËžo7%§\0sÚ»{u‡Ê’\"_vF}0yÍvÆéXàªÎ§Jiîoæ<[1ãŒl ô¯@Ž;Rm•S{QX:lP,(AÞ_œ×Wg|Ÿ/œšéLÆ+S¡¶\nø¯íZpÇ#Ê#Ý·Š¥jƒÍ_,ˆ£ÀÎ;×Cjò	\0iàÑsÔÃÒ¹˜–2Ü1ófxHv²õúÿ\0…m˜Fõt*{Ó•w9%¾íOHú5QE`ÙëSˆQEŠ( Š( Š( Š( Á%È¸òˆòÕ@ ô5}£g†ÁyHéX×æò!´íG9$w«+ªý™TM~w:v;*ÃFj,1Äƒvâ\\½EQhT:„Mžh<Žæµ-1}ËH˜bùO÷úõ£[.èe‹/åŸÖ¸eR7µÎ%Eîr––TŒ®Ù’v ’zT­-¬å!q èÌW@tÄbÀÈ]d$V4–OÒFa&(Û¿FÍk	§¡¬!bŠê’ž¬˜ük«ƒ[2Fª[÷AFŽŸ×Šã?ÚÙch­w—,kj[r‚aÉFãZ8ŽRiDW©r<ÉrÆÕf;øÞ½Bˆœ‘žÂ¹(PÃM;å||Ã…ÇsRÅ<\"}¬¥Ä ûÅK€ÕVt©t…•‹DÝ:ÔwÂ3:1ƒ±¬=ÁgB¤ˆ\0ÂŽÃØ\n†ëPš+ Ê7ì^1ü>ô º–ê;\\Qc$óæp}j„VKsäÉùúzž-vÒYE¹XnÎ[–n0}3žkdËmuž\\‹²È4MÍÔæ$´I·Qk9¤È+ÎÍ£Õ¿úõ×$ÌðÉjØÞ„0<\nŽêÎC#˜cÜ±Ä0ÙûÇ¾GjÌÉ§¼.£Ëfpƒóª’IÌ(J0({úvâº6†ææÝâŒ+ÄëœýÜŽ£¥c-³À|‹„Ý“‚Ozi1W.Újh¥¶·MŒŠ0æ³oµ„‹ÎŠ;ô…CËýÒÞµ¥œ‘Í©òíeþ/é\\þ³d¦ßÆÐùÒNÍÈúôúv®˜Éu:©Àü­ý»u¸ãðÜÐÜ»œFóyC+´mÔŽq–;~‡Ú¿™ß¾›kªjÚ\'Ú<û†”—þÇ?¡é_ÑGíè—„¥X£†K¢ÁLñæE–È$dñ×§Zþl|m;FH\"m®Ëü]r}hÄÊÔ“è}Ï	¥Ë$Ï<½‚&”Þ\\¹••È+ýìU‹¥Ý$HBžqÚµî\"ðLMpØ\0w5ÝÔ‹Ä…KÆJáˆúWÆU½t}ë­O—]ÎjÙD“29>Tkèµh[Ø˜ä\n§ÖžÖxL¾s@ìß<Þ©¬lb¦˜¶DÀžÂ³ºF0‡3Ñ\\ç—$ÅoyMæ3Ð\nµ&Ÿ$¶Ó·œ§\'&¡bó†š¢dmªûÕu#R\"^£\0?½T§ØÚkX³¦\"¬DHÛð€Q]ÝÛEç C–àu©m®£µ”¬k€I=*JÍd_5‰rFßzÍy’~í™ÉÝK<ò,Ûö®óÃwªIŽÎbqH ;âº9!Å¡ó;òzšç/m%š¶µ]\\½z8Ykfqbi]h2w·¶¶Ûç$·#§¾{Vu”¥¦&\"øàŽµÐÃ£ÀmÓÍ*Ó+RÝw¹ECò+²-eZvÜŠîÜÝÎ;[€qÚ«ý™åi†æó#W½_³i9.È2BÌÜ‘Î^µi|™\'µŒFÀ’IéøÒç2•(·fs±éSOuåïo¼kY ŽK†·}Ö«\'~GûU(þÔ€Ü©&¤\\2³ßK²wlsºœ¶5T“(ds \0ˆÐœ·J¯¤ÎŒw² psí[ÑgA6åQ©¬¹Õb‘ 33#.ãŽÞÔD-7qºa…|g7Ò«Kr“[5¼oºEàŸjÑò!Œ£Ls	Qz©$¶;C7|ÌSV­Ôçp}Ì©#–Îµ~VmÌËVsÄ0”cw÷Oµ=Y{w0ÙP}*)d‚VE;úü5OÈÊK£)\\ÛÎ¹s.@\'åôªñ½ÊZ\\Z<Ãd™Ûê)·WÓæyÂ\0`~ë&y.#\'æ™\nž½+¶úÎœ,Û©‘¾gŠ«<aæŽ\\¦NìÔ–×G~Xl:Žîek…»·¢Œ}«¶Ÿ7S’­—1ZëKóeA~äg>Ô—:dB0Ð¹\0ç?ÅZ–:ƒ_ÈÈ«±“±Ú²õK›x%y|ùJ{×ZŽ‡9DÆcqæ¢‰iœp}jHä0ÊŠXyª1?Ú£žá‰*d8µ\\‡(Ì*œUj´4Z¸X¥@Þ_™ûÀFzŠ\'Xí‘A|ÊÙ u\0Qfñ‚Á×hY\\ôæ¡+Ï&P¼¸üzÖ´×qÎ\'9}š^I\0lG¥TÓ¬â¹½·7•nÒƒV.Ô[4«¼É¼pj–Â¨<òB«î$uß¡åT‹æ>ìýž--lõ†Ò$·’x•&›û±3uÿ\0_¢62Ãl‰Ž$e@£züíý˜PjW7·qnòl^52Ýºw÷¯Ñ=5VÞÑ.$`u#\'’qÔ×àž$SrÆßúÙ¥e-¬%;2®È¤–w‰$Þ£„)‚ExI]¼õéíYè£PÛ,lY<Ã;\nÔ0\\˜Œfc\n°ÇËÉÅ~|éõg¯J£¹šdkR­~t-ÈÝÔTWxºhÚr²á‡÷MoE	Dãt›kéêÏ<’@ŒdýìU§‡£*°åÓr94Ø•‡–˜†P	lôÅm$ÜÚÆÁX¿ðúâ©¬~dkR6GŒ™«ö6âÆI#(ÍŒG¡þµ<Ìç”¯±L5Ã;D²,§šÎ“M¹Všõ·>¤Šé&Š0Ñ^h¼¦ÀUþ/zÏŒÍx·’™6$d Õ\næ\\2Ý\\©’ÞM€’\nûŽµ°o\"‡)rI•cÎkm/­Ê%ž<¤³á÷«ÉnHe»e•·õô¥¡\\ÅõGO,Ñ~åø~ZÚµŠhy‹¶y#§ÓÖ²´ÄiðcŽä¨Œõâô«/wr÷QÇäx>aŽ ®ˆ¦´cQ4.÷ºNds?\'ýš«kmåŒ}ýÝ3S‹äž9RXw¬™Y3ÔÕ$žI#˜aY\n þèöª“w%Ç[	<µÏÚ¾ðÁI^´ZÅt.¦>{Kl|ŒxaçšÞo5ÀFO›Þ¡óR&Pˆ¨êú×%Föbhäu$¹šp¥ž¡b~^­]…´!¬¡6ÐmEŒÝÛž¢{‹–ŽwÃ³d:\0ÿ\0ÓH®bµkqIƒÇ~µ\nob£.‚òQÌÂ–äâö§ÛÛ‰.åü¸\"§[xEXåV¸ôö§^J‰:Æé‹’AÀïU6tAw-È\nàåÑPô0oð¬FÔf½“ìåËŠBxO¥M$æ[‹xWr•mÇœ{S«Fï™VWÞ-­Ðç¨»eTXl”uª^¹³Ž\"Ïæ/Ãr´Ö{—Û<ß9v¨!}©/ -—\n;ð§¨­c/#žláü]{<>ÔçSæ¼öòF§¸f•~WüN”ÛZËouKpé¸ô&¿M¾\'H°èñ!tvîìõ¿/~%KÅì–—ñý·Ê”¾O\\ž†¾ë×ûtYågÕ-„ûâ±Zé2’[Ì·ç|™¬H—w2ÀL`¶w­_QxÖé“<J›IR ý+äí@ƒ;¸2Äcé_ÒpZ‹Ê§C>9Ìg,¥¤ÍOûœ’>v4ø­Äé™NÀ¹©VÑTƒ¸1õ®˜ìbÙÑ¸thÇÍÇáW¥ó%Ž5A¸dæ«ùo(Ržbüê×Úã\\0ÎTæ˜!±—(ª §Ìy5³m€‘”Þäçê+%\'\\Û™ÔiG?vö1¸	Î_Ž+–Wèz­Ô÷Á46¬¾lwzýòÿ\0‚`xvÏLðn­®_Ûy÷…ü¾PNr®v†Îzñÿ\0U~hÃi¦ÁÃ\0ÎO¡\"¿£ŸØ\'J/ÁßÈ-!½´‘”mä™˜ú¶{â±ÖâÄJ>ÏCôÎ9­\'Ýåùp™;÷¯\\ðÄV·1ý²ê7VbÊáŽ0½ˆ>ýkÉíšYJÊÎdMçú×¯h–žnt²$nqwÎÜóíÎ+ÆûžGÜù\'â&¯wŠï­ÕþÙ§C3G«ê;ŸóÖ¹›mmBf‘ÍÁ›ë^Ÿ¯Xi3ÞÈüÇ¹™ÉFçnkËoôK™QÒ²Ž½p==ëóÊ«šnG¯Nê4 ¾·ÔvDdD“yA¼Œ¹†kfÆæ(Ï—\"|è0[±Þ¼WûQ¶“˜Ì¾fW<ì\"¶cÔ5»p±Ü2•,\0Ùü_Z™Ð”wêi*Mnzå•ÍÔRZ2ÎªCn„Õ]K@7‘¼†½œàs\\õ¦¸!+§–…@P¾¢ºM{ÉhËHV%o™{0¨”lG#2¥ðýÊGæF^ëfÑµ\'ôª²YêÍ,ò£¼ñŒ…_»zô?R€´Ï¹ÈÏzÒŽ™QÒé›êGÕ&/˜ñyu›K•xãck¸|Ã¨=²?úõÚiºÄÐ6òÍ\"mÎ$</°®šOYù©4 ÛD‰÷:ä“×šÍ›Ã…×È·ùÕØŒ‘ú\nw#™\0×m0ñ¦Éø½jö›¨Æ`u›%rž£ð®è·©m3N®¥8P½jÅ¥í°óžÎB¸À$(õ;kLY¢˜Ì¯,Ä)þuNïF¹yÛÀ¬÷Uvæ¹ûi%äVRÆüé]E—ˆ2C1;OPübÞÅ;¯ê¶ðáUrûª{üÕJÑõK$>j2~óïŽkÔ ¾·½±óàu*å†ÒÃ9SŽÙïM‹OŠx~Ö\nùÎpc$mÿ\0Z¨Ææv<¶]VýI3î•	ìü;Öþ›ªÃ\"s‚ÍÊŽÀw­k¿AsçO\"›­Äƒfü¹¬»o	¼–®ðÎG–¿ÌæµQ±.q¦_Úº$vó)ðÊzµjGQeÐ	WÌ&@:à×”Üéš–—ûÈD™†<ý=ò)-uëûT’7&¶Rwy¦E7å¢Öð4ãä¤ƒŠâî¼\'Ìã!ÖyÝyã¥7Jñ$·±˜®“¼¯š}GsìkzÃZÓæœYÊÁü²HÏLÓöe)3˜’ÆþÖÖà¦Ó±N:~U_Ï¾·E€d°@	ÿ\0^œ·	,2ùmå¸sT?²üöiiböüiÛRã.çoâÇGlò”¼ÿ\0ÔZøÆÞæ²¹*ærú“U.¼m,òL·;nÊa\0qï\\×ü\"Ú…ä@”HæÏÞ?Ž+gæ˜ôM&x5;Iïä#Šw<(m µ7\n±ºMÑ†Èé‚+Î¢Óï­–LLwOVÙÑE.›y<Jë†Œµs™4Ï@—F{µ1ÀëHØgÂ=kOÝé’ÜÚ}µep¡‘Ô÷†Fyô¥‡Ä^R¯–:ŽAîkj-ON–™ºwl±ã>µQÈ’1¦K¨¼‘pŒ€à©=ýÅm¯ˆE³Ú­Â9.Ü2ôzÖæ¡£]IiÆ÷)\0 ñG`zþušfy¾DŽdþè}+ID¨£F=zÅ¢o:obTöùÖ„sÌÊ.|¿Ýnúgüû×)ÿ\0‹‹Vygq,oœýjÇ»³Ôá²º‘ s5ª¡B1—ô¬š¶å§<ÐK±åŒÞ)‹nAÆâ}ëœŠÚ+hÃÌFwàƒ\\…¯ŠoôÑ	ÔùRª1÷sý:ç\\7nJËå° •=½ëß¨3¡—A±½¸YB\'aüXõ¬‹Ý>þ£šÚÝQZgRK`ñÐ‘è~µ§¦ëW3‰b0½hÉpnWeÜ{sŸ”t®nFóé.uëi\"’Wy FÝ…Ôt«Wž!ÕHLÀbÜ¿p>+Ðìà¡\"	1Ô7aíT¥±Ñä‘Ÿìøtl€zVñv6Š}N\'DñMÏ˜\"½*	;OåÒ»KmJÂõ™1·•»Y²xsO}÷VÐâEbÇ«H¿[©$ieŽ™×ÀÇ§½hæS½\\ˆÚyèÞk:q¸t¶vì$1¦ï´8SJóèoîmä2¾å8ÞŠµOˆ<„e2œ‡Ý Öbg@¾Šöw‚xü±D’1¿§ç\\åç„eµ-(ûIÂtäzÖœ> ‡S‰Zi–I-ßçÚr+^UþM÷z¨ù3ü>˜¦­ÔÏ™ž{w±e$0Ïgœ£2m nosÆ+.?ÞiWp%ÁqËØçÖ½oð4bäKÔ0ÏéXÚ¿‡,ánLqÌ\'eRr:qÜW\\79­?Æ°K2ÆfeIÛ=k©¶Öô©œ:ÈO Þ¸é<¦¬5¬«°“×Ú³[EÖ>E´‘ #$f«•T=}$27ÙÏÈ r*XôŸ(¶¡+)µ\\ïÏSšðËoÄ<¯oi#G|ÌŠñç;TvÇÆµ¬üK¨Ï†í\nr@qí‘Ó8¥(¢£5=ù¬o‘VE·Ú£3\\\'Šô;%²IÁs)‹¿vë[o‰|ðÑ\\íÒÜî.ÝïšçüW«ZÝª6ží4ÑHÈl®ÝÄ’G#<ú~5Å™b*›è™êeIVÄÂœz´s¶±OFd}û€8?Â[ò£prûYŠµ¦XÄ¶©#ÈnÆàIû§Ó•qGóÎHYUñÇ­!fM{Y)w?ª(ÙEÁ’i£\0†4>¾õ2²Ä 1dcƒëŸéW¤¼‚híÐÛïeÈsýÑIr¶ëº…·¿M£Þ¼\nü¦Å¹\\»ñµFOÒ¥ŠÙ<–‡ÍRð½ˆ>¾ô×‘#Ku’ÙžMƒ2¹©œ­¥»Hðoß‚«Ü{×/!q‰N+I/	rž1þ{ÕµI Œ|›äÃýÚ³§ÞKù¡W²zóQKw²„I‰Š79×žõ´bmc4É=Åœža_7íGû¾µal-ßÈG¸1áydf­ß4+´@¾``‡úÔ¸Q´ü‚³;•b„\nðÜœ–k#aˆïëšÓ»b³ÄÞkmÛLÔ,æ“lCç?^ŠÓds ]²¦qî+ž¥£Ú÷3–¸TKÉí^¿Búe£`«˜1ªŸÇW¢¶(]âb¦Qƒôô«¯e0	ƒb\\p@iFŠsF5Î›··X$óœH$ õÈéùRØG2ÇæÎ¥ôVô­;x…ä›IÙ*©9ãæ¨$Ó¥óÑ¯/|È‘yUàä×G2ìa)D§,NÒ™!C¸0%}G §]ªËµ1¶G$dvªžTRS¹vœ÷ª©m ¸7ù=¬j3Ê°Ä7üÄäöÅ\\i°¯æåFÕèâÆaòÇš_‰ñéQý…ÚèÈ¨71ÝÓëE83:Iï%‰aš]–èC…ã‚Z|TÂz`ç¸­9‘b.xÒdpzòxª—’%Æ]”Æ‹ò«Ÿãã¿Òº9ÊÓßh¾Pªzš–u†áÛdy ç©>ÕN8årÚ?Z¾·tpL¢8|±€=+:ˆ\'.„8ó\\KŒ|Ãæ=ªùˆy±+®VVÆOjk*•—aÚê2=?*ª^Gu¾äÚ0}ûÔF¯c!\'¹–ÖSÇçB¨Mf=Úòe%X|Ç=1RÜÎñÊ¢c±]°¾õs-¹œ£)”·_a[GúÆ‹6çK—`Y\\ü§½H—Æ\'H•CbNz€k%¤aåìBQOQÎÐjÊÁ.Û˜¦pó8w\0í¬å+—ÊÖÆ²ÈYÕ\"\"/0‘¿Ò¢¸I-Ð€z?cœÕUdŽ\'™ØFr*šÏ$¡–5Þ­×>¦¹¹t¸àm%º›Ì’ädg±ªRiÌT9œùÈÝB*”WVS€£¹ö§Opå­e•	ŒÀ<²·­8È±ÂIYäöäpOv©–9¦cª´;Õ¸ÒÖC•hÕ¾¸ª’ 4mòçëÞ»©Ì¼P@#ÞÛ¹ÇsýjŽ©Ä¸YÚBü0#š˜ËrÙQSe¤ŽòÎpx{T°A#I}!;’I<œÖÒ’Q¹<·e7dHfUF<zæ©^¼¡ÞtPÐD¤á»ýkRb¾$IUHd#ioóÞªy¤–?0ò6žù®JxèÉû§GÕÜhžeDhAm€Ðý*	VE3“0sŽi&¼x¤ŽuI$b1šÏ/p®¦FÈó§<WVïR\\l¬‹2ÇgXÑÊ‚n}?\n¡m¢ø\\ìÿ\0FPx~‡ØUË¸þÍfe±·O/º˜·¿l¶9Ê¥e(êc=Œ{é\"¾2:Û4	 “ü]³Š‚ÛM·‡eÀ˜ýÞ„zÕ™bîþ1êÜT-‰&t‰7ã‘Ï­+™ÄÔkKMÂMØäÛß>õnTQÂ³åªšá‰åXÁÎx\0R-ÍÓ“ 9pøkU(¾¦·!»ºÙaUàž;ÓHã8PyíEË¢]«H | t$Sæ’Úò¶Ž?!¥a´žÃ5WInLÙOÄîrXä6GQS¡‰bk€sòžÂ³ÛÏÓÞâ„\\Dè@9Ç$sùÕ‘4I!¹ÉíPê#&0-ÝdÆBÌXŽÕ½EgyÚG¹–làŽ\0eg%„mh$Ï>µ]­æI_>\\OÓ±:—z$ž¤±‹»«\'•û–nXž•bT³l b$†GÁÇz°®‹ûÈ¨äíª¥Påb\nù$®:ñO™“ÈÑN³„6bûËQýi·û\" #§ â¬ä—o™å±ÐäëVmŒ52Ysös]4ê>ÀîRBžqòË*BÃõª+«¦–aå–‡¶;UÈ\'Œ¼‘Ë#Ê[<‘Wå¶µòÑƒ‡¸9ÀÍoÎ]Ì%³’o-œŸÝßÖ£PÁÞ(P–ÈëÞ¶‹­²mdûAvÉÍXóá. 9\0óI«“\'c˜ŽÕãwóÐFZBF;ýkšÔeùþÎEÈVùô®žy\'¹gÂì@ÃžÜÕìíÕÖu\'ÜVB?ˆWM8$õ8å=F+•w:lbÀ•>ÇŒûWâ?é+·kwEµ¼µ}ë¿hÊèF{Å­Ê7îwldÇk†™hÎõhã¥	óÁ´üŽzôáQZjèø+Æß°çÂ/¼g–ïI‘Îeœ‚Çø¾mÃ?@µò?¿à>&‚ÚæçÂ¾\"µÔ%”KiÜ±ˆ£ô¿g.me–vwa€ƒ8ô¨~Ék,MÍ¢¼9 ·qô¯Ðr3,,yc;¯=O‘Ì8GZ\\î6~Gó-ã/Ù3ã‡\'ïü.%…®Z!$/XðHL×ƒj~Öôa,ØÉmvŒAITƒú×õis Û8‘¥Óã{q1U8<÷æ>\"ø!ð¿Å¢àk^Ó®n„eIòÀ;=»sô¯Ò2ßiò/­R×Ëó>cÀ0å½	ëç±ü±=½ìr6•mýMMs5Ñ	9Q÷—±û¹âØ?áˆn.¡ðòÝ<¥öHÇŒt‚¹=þn;WÉ`ˆúAy¥éÞÚ]E&\"‹‘´ã¨\\\0ÝFòµúFGÇùn:ÑŒù[èÏ—Æðf6œy’¿£ÔüÔ´¼;d$r¹â«‹ûÈí9òyï^Áâoƒ5ð~£=ž·áÙì¢im¤Æì:€øÚqìk€¿Ò\'´€Ãx›&L§¨¾ÖŒ¬Óº>G€«Mþò-×u]CT´¶¹/ržb€<g¥};b%‰ùbc»ge5â_´—}ND`îº)ÿ\0úQo4æÚ4/\"€\nùlþ¼£>Eµ§á\\ª3µ{¦B,£™Ñå@%É\\úRäÒX¼AŒn0Üõa¬n¢‰wcÉÇøAþ•GT–òHó#„(SŽµòW±únÆF±:^È\"‘ÎÈÀëVå‚i­–F…^Ë\0žr;Ò-°¸‚)VyBdg­W²k©\'ŽÙ×Êv…=3ZªÎÖ9¥K[¶AäI{rB<„óÞ¤[o3Í!ƒ\"(Î†´on`”dŽ˜í\\ôëºÌR„<ýá]1w9§_SMeHmg…³8\0õ³¬nMÝÊ5ÎvÁü\'¢­A£I$’Â 9Ï­jDÚ}ÂHÖò1˜œ1ÿ\0=©T›LˆûÉ2F\"»Žh‰hÀ\'ií^‘á³¾©¤Ìm¹Šñd,=žkÎâ¶Ýyk‚bÙÎ{Œt¯¤¾xüamâcûCì°énÄ dÌXsÇÅqU¯«Éèo3“²<GãN¯ªx‡]hšåþÃºypç!>ŸZù[-vñmÚªNs_¬š¿ìýâ]U$ŸKÓQ¤x‚ùó}ëúWÈ~0øQâ-3\\ŸI×ü,ñêk Pnó<# æ¾“.Í0ò§Y#çñyUXÍ¦®}ÿ\0Îø3o©üBO‰7öò‹Ÿ\n\\nvå\"I÷éþE~ï-úÚ1¶ÅóŽçÿ\0¯_›ß²}Úü<ðkèº<rm[ôžê7À;ŸßØ\nû~ é7+íÂÃ6ýëž8§Öi¹M´ÏÍ©KÛÉv=­5¸´Ø^âîàÇæî@úV¶›âk™C[L\'IPCýkÆ§ñVŸ¨<oÏúç\n«ŒôªºEŒ–sN–ó²+JÏ¹OÝ$óP§cÎtÙônŸ:ý±CæN£øEuvÚœÒ:ù;ß$níŠñÍU{mÖ»1Û‰ûÌMt_Úërd “$§pzf¯Ú‡³îz“l•|Öƒ9\'¥]Œî³‡Éœ»¤ÇðÅq:n·‚;Iÿ\0yƒ•éZ«y»É- óî	*QþéŽkêJ‹gm#Ox‘D?v›²Øþ*Ð’HàòüÃæ)`¾k‘´Õ®d‚R¡#’G\nc\'“ô­ˆî¦#]@³GÎ	ê1í[_K—ÌŽ‰¯˜º°>\\lƒ9ÜjÂZ£–S›ž»ÇoÆ¹xnVëmÍËù(¥tê6±ÈˆÃå8^;W<ç`›4¥ÝKð¯\\÷¦Å~îòA*cæÂí5”ó»$‚3¹uÏÝ«ð=¤Ab&M«¹þ•Ì¥©Œ•ÍëËˆ­ŠÊê?Ò€ éÆ9£Ì7h\"ÙGQÔCíYZ—ïà†(üØ„?xuÉëš†9nZäj±¹Û©»W\\ŽŽÙˆ’8–=‹	![ÓëMŽí.é)žøª³jJ×Š†)eˆgžõe¥As+”‰—,ÃOô5mX¨1]<›(üÃäSÈx‰š8÷µË€GÓÔU?-4èEÂÜŸÞ¶2{š·*ÝÌ–ïfï\0uàœTI–â‰~ÐÓ‘ãsƒÁìµ³kû¸Îé	Á<õ„¬Ë>6«Ç°pÝÎyü¨”«Jó	YŸËáz¨Æ=Nj±¯g©]ÞY¤1_÷³Öµ[d	òÊrûXoÐG$3ù‘–éÕ½1Z·¤2G\"ðww­½”^¤)2õ´“*É3H[’T\nû\n­ºxåIYö¬îN¿¾*+#4®6åŠ“ÁïZÖö*ÎÒJS ÀÆHÔ8DÕ7Ô$a*‰$F<Ÿñ«6;#DÊI#V±gŽ7Ž8C®æÁ?ÅWd·–e!$0n éJ™h*ý’\'gvp¬0½T	½\0\\;’M\\ŽxÊù2HÂH›j¿©§3Ç\n	éÎMÌ‰-D¬ª|ÉÙºü z{U¨uI\'’ÊX$Ù*a\nöoz¥ºè¡™T7pj†žîá–gªÌ2Wµk¡Ç8VÒÍÓ¤ÒÚ„+á«ÚtsÃ¾PÅ]Øž?MVHÜ8Ã†8MnDa]±…ÞÁäô÷¦BDÒ^›‘vÝn@\\r§½hE,Á„6ò´k*I¡`C¹ÝcÖ¶m!uXæ#™	\nIè u¤âŒæ»–•Ê3éÞ·CkÅò‡,zoSùW5cåM4åÆ$”àgœ}+}!t‰aÞU‹v¦‘ÏRæ­Š¼jÍ.\nnù7uÿ\0¯[ƒ|Ð\0¶ÞT{×?T³»¾k~›\n‘‚Ár\0«‹2žÆŒQÌÃÎc…Àmè2Ê}«f(Ýp“¶Ê2\0êMs¿k–Í·1(ç«¡³f¹·%—*«‘šÔÂNÚT+°…e1)\0äWIePâq;N‘®vb¸ûuX•œ›u!Š±àWG`·VÒ6å-?Ë·Ðô­á#\n’êu¶²ÜGÉ·yGÊ}?úÕ½¦™ÚÝbœù»›æ\'øˆõ¬Õ?,o#f#Áõµmà-‰·î“©5ßMµ$Î‚Ú;Á•·bNWµ×ÚX³!+Þ#Œ’¯õ®NÂI¡Q@*Î2Op{W¢+$p¢ÆÊ¬øÎO5ßrÎNåø¬å™™\"rÌøk¶Ò`¸0íádW·qíÍ`hÒÉÞ±ï®;×mbUx$nÛüU¼cÔälßÓìÜU}êzóë^§mŽ#ªY\00äœ×1¦Ä‹’5Úd]†›H§q\0¹¶Š¹TãvlZ-¸G%‹¼f¶-öl\\!þu“¤Ab`óJÓ¨#]Ä|ÜUMA§w©z1Ôúš’RÖ2‘ô´ãÑQXEPEPEPEPEPà#Zˆ•¥U³¾N(…#¹fYÅ°}ìpk]T¦÷Ü&ŽVÆ-Ã«B‚b –N6AÒ¿4•{š{k™†V°—1Jv€?Õ_íÉpÖóLf’NóŽ§žØ¡q;Á{âIì*¼še½»¿•˜ìA>µÉì¢åÍÔÑTèZ¶Ö¼È8ßæKzãúÕéäi°»ÈŠAÆ+[LÊ±€cBÄ¶;æ u‘¢‘áÿ\0kŸç]TÄæŽŠO!1”Û±ƒ9n€U¨wYå„W=¥¾ø¦vyv•ö5nÒx>Ë½_l;È\0ÿ\0+£–ûÎ]N„´FIUS)ÃûÙ§Çio4«$Ž«u8¬{}BÝBÎÛÝæ$dŽ\0<Z¤a„‘HbvÆr9_§Ö«Ù=Ìœ™sT²¶ŠHcY\nÅ¾^Ù¬I­&gy`”¸@Ï¥n…ŽéùãÄç>•Py±mÉ÷µ›¦ÖæˆòëÛ´¿k¸ã	*ž3ü\'ÔT2ê—v¸#0 º»{ëHï\0Y CÆ;UuÒÚ:Ën#ÇÌ@:VrO¡¤n:ÇUÝJ‡—†ç½k¦²†UEÏ“.2¯½fÅ¦¤Q¾Æ>NÒ*Ïd°´Òùìr7l5“ó%nt×o’9LÍ§€CTd‘Úå0Ÿ—ŸOA\\ÔÓJÏgàž€ÖmµÝè\"èÎD}ÿ\0îœûÔ¶uAž’Í¶\'~â6û×7ª\\E(c¸¦‰ªVú´BÖO2c=Áo¿!ÆâzŸ­Ey}›Ìù °©­##º–ºŸŠ_·>“{¦Ü]Å<7rÚéÚ‹ÜÈ‚«\';A=Ô×½:ž;’Ö}Vâ`Áîm›Ëp>ò¯bkúXÿ\0‚†ÿ\0bÚø{[µÓfKMN}ÜIX\\ý¡„`{“†Ïç_Ì‰ŒÖWZŒ’[µÍrþg=|Ë;«{ÂR¼&š9ðRé’Ù#i„—Y®~½+&	!Ô v¸}’‚N>”ô¼ HÉPÜœz«-¥œäÇ,åGCþ\"¼¹Àû.Æ\\°C™bY\0M¥¹=sSXO…ò”™bN9íQ_½¢²@`ùsH²É¦\"*¡hçùCW©ÚZ¢ýÉ´‚2£/;¸#³VGÙíà…®DÓ7Õ\0u’#2Â&‘;¿Æ¹¶šk©\\8Ù´Ÿ•º/Ò±•3OomË3¼¶×ÎšdbHoLÖ„Ï,ˆ„LP¢gëQÚ;ÞÜ¤{qä ÉöªÚ¥Ë6ä^Ë–¦1Ô©Ôëb¸y/Æn|É <ôªòI5³«J€‚yõ5Séò ,.T9AßëZr%Íôoä¨Fá¸ô®šhå«S¡™8¸ºŒ¬\0¿RÛª­´SÞGs@$šÖ0[\'§ÓÖœ~ÛD¾\\±^õ^9îá¹WSÞ?Þ®úq<\\F!½Yb{æŽˆŒ*¨qÚ›§]ÌÑÜ¯˜b†\\¦Æþ/ÿ\0]W½™%!Ð6b#?2Ú<æ3–#Œ÷5ª¤rªÏ™j>äKmŒ¯å¶ìçÒ¨È¦tY–l~µlØÌ·\n·n¬‡æ^¹©šÙä¹†8`s]^ëV°ãBMß˜‰,eXS2lÏ$zæœå\"ewEyÂ`Ã4š„Ry­$ì\n3žÕ*Øˆìfi[t›1X8¦îJ–%«!2	&_4œc/j³i?4¯¶HÐµŸ°ÅÖª6¼ˆ9@¬»k&Ý¤¸“ËRûÞÕ&¥HGrä‹^M\n¾wô?ÝÍ`]y°NÄÆ®AÈ÷­»ÕIdˆø8ÅS[bÛZBYÉº#¡æÔš“ÐÍ¾½‚h’ÞÞÜ«È¸lûŽjª@öö±ÂäÉÃ[·˜³rñ¢1Þ•—$Ó02p§‘Šì§Ø…AjgE,%ç¶Y‚Œ«ZˆÄU >fçÐSZW•â€†ÞwP²K*l‘O+ÔvéS¤÷9«G¢Em\nsÖ¡I±öå	îsPjVpìÓšGãªÍÄvñÚÅ4RàÊGXŠ¯u;ÅRËf\'¥n£Üò%MŒ‹L{8ˆC‘/\\ö§ÚE,M<k9•e\" –kË´G…Ãn8ØOÝ§È¯f‰–2JGZreÓƒ5î-!ŽÚ5•z>ò}jçe¶uFfÒrjUÿ\0I‚#)ß ç5Ÿsn‹nv–äÓ‹ìnè¶ŽðÇÌr>j¹$ÕÛ#væFßº2¿wÖ¬IeÌ®3¸ûö¤¶’H¤há€†CÛ¸ÓNKvyÕ©½ÐoÙnÎãOq˜I³ÔÍºï9Âº’?Í~…Z¬ÞJÅ!YU#ôè+âïÙƒH¾¶Ð,Íë¨g¹{ˆÏ÷C¨À?JûR+üÀ#9U^¹áI¯ç~3ÆªØù¾Îßv‡èÙnØxFýÛÛF¾cD¢ÉQÚ­Û;ºLq¤ã=é—M¸0”ÃžÇzhVŠhŽUÉÎkäÛMîzÌ#–Ùd\"PÝxÏ­S¼ÎÀ$²yÀ‚J¶ú\\eÅÜŒ~Óäí_OÊ«ØÙ]Ëæ-Ãˆÿ\0xT4‰’&JÆ6H¸ç=ÇµOŒ.6Ÿ2uá§½,6K¾åÆÐ>_Jš@w¤¨Û‘2hœA”«ùÏ…Á³T!Ùn$I•ž\'P§ù¶³»«+®7`óíS•iqæ7È¤ü¾´r]Ùš(µ« #HísŽ;TVv¤…’gi[pº=MO”I+¨Ø¯ÏÝÇ¥S»º{ËIÈ$¹5QJéHÚ*7\\Û–V‰§Ës*!‘ç*XäãýkV¹–yfKcäãúÿ\0ZµQhbÝ¹”ÌˆÓ·É±œ\0öùÕÅ¥ô1n£‘Uhœ7éZ“ÜÂ±hSîŽ„U‰\"]A|¸“ËÚ~ozbÛÌªñŒyÊ£ºS”ÍzêgÛ}¾ä³ˆvÆ„mÜxÅhH€Í¹€É¶*Â³$GuÆbuOSõ>õM¬b‘òïVr¸Ù^9 ’2¡þYÝi÷mwimiÁÏûÕÛBÑyŒ‹ÉÏ?\nš)ç—vòYaA†™ZØ–RvUAdØúS/nd˜€‡oEGiäªªdo<{T—R[YÛ™B1b˜Ï½z›@ŠH<ø#‘çh› Ž§~µÎ}‹S‚ØOLq“Ë}}«ªÚ·6öÏ4\'$Ú1M¶µÔ.àXÕíÝ†Â:¨>µÕN¿+º75ôÙ]`‡ï6¾ç2B÷Ž×7|ã+ë´õëc[uKiÆùW%±Û>•nž8Ìê#·0ø@ô­c&ÑÃRG‡üb½º´±šÊôÇ½6ÿ\0õù¥ñåãÔ;afV>àWèÆ©o®–žb-í vÇlžæ¿0<YruH»‰l\0Øç+ô¾§Í‰‹[žW_R•Ñäþ0`Ó\'ÌÎÅŽáØWËºœb9ÙÑŽâNsÚ¾‚ø4–ì‘£™#Àô5óåË4×9QÚ¿ ©ì~9ÈC½Ê¯µ\n’>i÷íW,Žæ\nÃr#*íäê„èEtG`öehãó’7v¨~Ï€ÛäÉàÓ¢¹bÅ¿:k³¾Cƒ¸óš$ËQDéLH7môï]g†[}E\'¼N@Ç¥rÐÂ£)-žµÝøh#N±\"n‡OsX\nÉß£ÝßX¤VSl¹xÀëŽONkú¹ýš´…Ñ>øf]9,mßJ‘;–B¹`sëÁ¯åÇ@³7úÎ‰¡{™5kè!UCóœœc¾ýgüÓ’?ønõây´KUœÓIí.Àœ8ìÏVV9q2J:á§\"Émr¾zàµÙ¾lôKéË|ñYË/ª½+“³³µm±Dû®žFa´û×S¬Éö?Êf‡Ê•ãÚx?>HÏµpN½“lò$ÛzÜ]jw¨N-Ù-ÕÞCƒÐwüê1­†µ·]ä„°\'«{ìoì¢†Vh\\\'Ÿ+…N ý{cüâ¹Ë¯Ü5©¾Ûæ2¶6ƒÉÏp+áÚÕ³ÛŒˆ¢Ô´»©bŠFòßv\0PqøÖ¾•§ÞO\'˜ždƒ˜Ï§­r2è×6²3¢)àýÚu¤×ÖKuæ3:)\0÷³NRn×æú”š¦[þÍ·\'¨ÍK¦Ü¸–<²©ŸjÑŸ^xZÚåÔ£7úVÝ†§¤Jk³ï”³nsíXÔfrék};Ð‡9=¾µ¹iâYÒ(üåÊ×Ÿþ½uksg,cŒ2ÏN§üinôû×‡yÞ‰ÈÉêyY¼XÄñ<“K¾B dtR;þ5×ZêV{#-p\0“¹®hoöI­m\\6é3†ë×µ5tJÁ¾Ùœ×žV‚•\n,Îq=vÚóNš7O9RTçÉéŸj·•Ô‘>@QÇ+ÛšòèËÆŠ²GæÜLw`uB é[oˆ%½žîÏ-ŽÅi	8öçÓëEµ±„£czúÑ¢u*$8=F;×=¦Ou!iP¯•ÃõÐ\\k0r-òž§ïcÚ¡YYv-ÀS¼ž´ÚÒä„‚òJè‰%”à€N0\\šê-gÔÚè•r~EÁÇJÐoÙ°7\nü¾„sšèí,àKT–áÄr=¸c³Ž3ÐÓŠ`bÇu4Ló•@Næ©o¬[Kb.2qþÑª7Ú[j$JÀ lË·ÞÂ¹õðíâLyŠ\'%YÁéèqT›½™m#½}ZFE•rãïf°.´Kgº2O<P2Î<¶ìq×õ®cS‡Q!dF¹Ä«÷z¯½l¶±ª¼ÐY[æRrFTàucÔ~FZ“Eá‰äœAá‰A~qÞ«-„‘]N c•&~žæµ¶ƒ0á@F#øÀõ­È5+K¦tD@“ªåÇ\\ŠÓBÁMs¬X]4FCöYgž3þ5ªž\"–VŸ›¦Ì×i…Œ!šÄ]à\'ùtª×~Òî%0­¢­´²nEÿ\0ž@öÏ-š©w3´oÙÜÎ#”—óÚ9\'¶3Ôèä¹†T2H‡$‡%GóÍsº¯„ y’ádXÔFy}NÞ…½ûqéYØj6îq¿Ï“\'¶{Òlwèwž]¨‰UW%Éõ5|ÙiÑØ˜DQå†wÉõéÍpñ1i—|¦p[¨¶š¬‹µÂlx³’?T£&mL¶¶…ši$È÷”ŸéøS£ðÒEÞBs)”nAÜzæ§Š}1µ•žVOœŸS]dWAb”9Æ:V–GŸÜ¥ÝµÛ¬ÁÒ&Aå¶8?CW¬õ³6ñ8%ÞBCëÚåZÝÌivÖí¾0üì5@ZXÜÆ±¾÷»i†FÀ\n[°útªhq‰`ø†Ö;r&Ÿìèr3‚wU¨¬®Ò*}¡BƒvSÁ§Ýøoí…@¨ P?+‘ëî+]#QµÈ‰<×Lð™ç57/•w:htýWòßS‚0#œ6NÜ÷úwªÚÇ…ío€Ì\n&<™#8$g¿^?:à[Õ§y­yaMÄd‘éþ:¾šôöË1„m»©öƒ]ÄâO?…o‚Ëg´ñÉ&AéÇaYRÛø“L„Î&_´£D¼ï\\ã¸í^‡‰­G-½Á™È*½jºêvw1Ë4Ñ¼ å¹üóY¸v3R9kkífE;¦·LŽçêk^ËX†-±_¾)Ëÿ\0ŸÊº½?JÓu	 d2Ùô®cÄÞû<íS<œmÁSnôãL£L^XÆèa¸Þr71\'j†8Ï\0ýÚÖ·ƒj¤wßnÛ1;Ú#Ò¼–ÛKºvF[f®>ñÖÕž­}Ì±,/±æ.1ŸÆ¯ÙÒšÇL’iî6žÝîÂúý)÷~±šÞi`A•èOy®Z×ÆV7°¼\0Ÿ,ÌÇîœã#¯çÔ¶³my¾;Wm°Gò‘ÑÏ©öªöEêyÍß…`gŽîËy¤‚§·Óüþ5•>•¯Y›¯,ãdòÚ3ÈtÇ^?õ%K²b‚5!\'¯­nùp*Œ*\'qÔ{ÕFŸsÇnµmkLµ25¹Šá§ì88>Üwë[–Þ)†ê$3NŸh’3¼7\07×Ò»[ÝNÕ-àBn!WÛÎBî=³œW«xZ1î -œÕØË™^çGkynLl.vóÐžI­ÉuKyQ\".>õxÄ~½Ê3–rîèqYÒê¦“$%¼Íl­ƒ´·éL|ç´´v³2CæŒ£îo`k6ÿ\0Â÷S,Ö!].b³6Ñ=Y¾Ÿyõ¿ˆ¥ûL[¼Æù7—a‚ÀŽ8õ®êÏÄPªmy›~ŠÀ§õ”Þ¦¦Eß‚] h`;âhþbÍ÷½qÅq)¢6I$YÚæÛgÊ¬»J¶+Ó\'ñ…´ÒHC[€AÏ!ˆõöük‘¹k›ù‰ƒM»j¨áTvÁ¯ÍüLÍ*a²ÿ\0Ý»]Øûÿ\0ðQ«Œr—ÙEwämò-ÌÒ>3èµ˜ œ,’–?<ŒO<ŠÙû,ÈÌUü¦QóŽÄÕMÌÐ¹?®kùš¥g+¶ÏÞãDÊ3Æ¼ç y‹Ü}+f	g‚3pê‰†b>÷Ò«´PÅÄdª6±^Äv¥–2Å-ëÒ¹Üy‘Ð©hlÅ<f%™¤,sŒw©ÒE—Ë™Ésœ=`ÚDDŽ.	dßÂ¯¥_¸É€¾O–ù\n½ªylh•X4ô—{ÊJ„çw¯øS³Ì¨ZG+åÈI>•VßT¹Ž(ãÞ%Hÿ\0=iñê’43[½¯”¤³y™ûÄÑ½l–ž<ä&ãÈ«Ðºª3…1¶â>µNÏÍp¡œ}ÝÇéVKb@0G¥(HM;’ýøŒR¦ö3wö«òÈª„“´aýk+SÊ@öäì\\†?^ôÔ¢–2õ«¢kÝ¹“Ù¶÷6ì¥Hç†GÞ5Ñf(Ãnmç§jŠ{iVX\'Gœã¶=~µ}ddžI Ž4iÃðõ¬gÏb‰‰ì|¦<0ú\n“SžÌk\n´ÓIÇŒÔS971ÆÒ—‘Ø}*ìñl˜*\\¨ó”xçD(­ˆu.îÌ™|èí—zùb{·¹µ•\\cûØ¦É,Ë2æD`F:f­ÀY]ed(}ëo©Ü9Ê«\'–!$Õ#<ßÞ-ÆÍ}Ï‘·µ<\\½eo4—<úóéZ#ÏŽ]‡ä;ÄHÿ\0ëÔ}Q­n\nfg—ocû¹\0ÒKgÐ·!óƒý=ê+%Äo \'tNHÚ9&ª]NÒ¬h!xÕw)ÏB9ëY;¥b¹‰d†FrùH;Ô’}š{ãµ.uæ—Æ9ëþy¦ÛF©+ÒO±„x\\ðqéïU.+º61E»­õ©¶€çÜŸÍy#f’&8—ÀûÕJà‰Â,grG‚r0yéR†I0yÇåŒ§­eùhò±†B’3\0¦¥Ä¢{“o A\"Ÿ5µ’ö–³¹¸É-‚§®·Ip»])Ïr*¤·O4Ž°ÁÛÈ¼…xúÖr‹5•å<2ÈD›NUSüÓîÞxÑ%0°yÇSÚŸí“&ÉZR¸>çŠ·#ÙàC%Ã}¡Nàyõ¬½îå™[ÝÝUäù$#°¢–§@›Ñä ýÿ\0ÃÖµÙc	dó€a¿.=V¸¶2Élë¸‚ç­m_Bâ“*6¥ja1;0yœ„pßSW-Ú	¼µe¹UÜÑå·OcRÇ$vr³‡V,¸Ú§½MJz p/ÁÄ;Èf`Êp‡¨5U™¦åvÊÃØÓ£¹¾	—„’=Áõ>Õ2²;	ÛÉ­©FIêfÊpos$ÿ\0>zžiUÝÄ3°g‚©àçÒ¥‰’öíÖ×÷J˜ÞØÏùüéò³d¹†H®$•ÊrÛGoZëŠ¾ŒQ™+î{•Dh×y=ñþ4åŽxÑ”LJÙ8Æz~\"´etÈ”®7“Éõ¦@É&ûI[þëw_oÆ¢8jqÕ#©W}YÏ®š2ºåã}Üwª!î¦u”7•S•=­vSDñ0‚`Q†zs—1¤‘3*þñ›ŒÖ¶ìÌ¥PÌ’(ÆF»p=\0¨¥!’$!œà}ì\nÓš(ŠÚ”3´Ç ëŸóÒ Ž$Xu¿Ì˜=x¬çM™s\'¡YSí0„WÞÈ‡“E¤ECª|Á>cŽÙ©Õ¢…‰P (w:ã>ŸçnÞràŒ,N	Ü+žHiX©mN“·+>@jƒ`Wû8;ã(7;ðZ¯Å#yAfŒ¤ìËíëUÀÁÎ>3íZ@¢£$R€\0É‰úúTÊKÍ˜†ÀyaÛ³[˜‚îln…69`XUKŽG#½jéè#ÐR4òƒ§Ò[ºn‰“£cžõ {eVN_\'njA<_)/¸0kÓg;1#·½ŽâE_šÞg<à•ÐC` eÚ¨Ä–ïœÕiæ(«±|Èåôê?\n²Ê%‚8ä;C¾µÑFžº…Ç6ÙÕ &²nàÄm˜®ìŽ:àÕ™e•_dlQrÅU.\"œ‚&;¸ÿ\0ë×­Éû¦NRêc¤žTm²=ï÷~¸¥kufì.L´¤gÔÖå´H)^0—))Þ>ŸãXšˆÃÉ Äãþ&oJ%¶m±cåC1FRãL¶µ¸Óï.Ý˜ºÈ‹€z\\ûÕ‰7ÎálgA|vkj0&F.Êz\nËÞ4ŽÅq7Ÿþ«•SùU+i?~ò]+KIÜ;ÔÌò©`°n€˜ž†©ù†6sýÔ¸Ê“À«åîEFC½äVEŒ…i˜çéPÝÅæmXæì77ùô¥š[†Ìv­å»G°>•@?“¶9di$˜ãéZF]Î\nŒGŒÁ}o*NþSü¥S¦~•&¡ij®’˜>mÎ«üf¥°hb.°4fáXîWã\'ëVeü°ÓÎX‚ðŠÒ5Ð\"×Cš–&ù¤aµdúŠÏY6‚JïPr	­»•I$&9°0>R8üë\nI„acûçr:Öñ›µÆNgÊùªfŸsŸZÆž¡’_ 4×S¦íö5»e*<Ì®‡¿b{UF9Õó*Š¸ÆOÞük^vŠ9™áû;™¥EÇýÿ\0Šâ6¸¢,Q¤^qèk¡h\"•Uåsæc•šñl>T±nï]ë>æRç!ðV‡­C§ØjT3ÅÎJŒ°ÏLã½|Åñ;ö:øUã¦¿þÅ:|­pÄùD³Ç»²’Gµ}¡voàò<ÄJ)o3Øú×)­ë–æÆv”ù8ÈôÀ“_Y•ñV;eJ£²èõùkÐàÄàéÕ%Et~)øÛá‡ÂßÜhšuÇÚ¡‚|øiŽ*•£ùóF»&Xúú×mñwS[ñf¥q\0Û¨Š½¶ñú×bëO©äÛ,*A¯µ~ù†ÇÎ½T›»i?¼ùá!BN4Õ‘y=Är´Hm;?Ù¬»+T½i>Þå÷(ÀëîjMN(Úá®\0/\nž­ØéN[”1‡ŽTnB°þð­y¯©Ï*šÑJšdS¼j^U(Î•I¦Û½ûM{{/—1\0pE-ÆÙÊ:|®N:f³®n/!qäFLGþ½iÆN¥ÝÙOZžêW[üŠN+œF‰7$›Fq×5v{Ï\"gŠH|ÙYrûµ,\n&¼äÙ*HHjëk$ŽYSm²¼	jñ\\é³Gç!‡­hÙÙÇ§ÛH°?›pSœõ8©¬n,à”?‘–cÌ:‘E´E.‹¡Änå³éSV­÷\nT¬u6’@K\0dÚ=	¯Ðÿ\0ÙÏA´Ò<\'¤ˆBO&©©¼ó’Xî\0Œ÷\0+óÛ@°½×<C§iZ}»¯¦(›¼,u¯Ô…Q¦‘o¦Ù\\ZdÓŠ,hŠøÞ.­àä¯¿ü9íeÔÜª¥kŸR_[XÅ•´U‘\n\0@cPµŽ‘sj£PÒ ¼„õŽT»Z{”6ááPÍ/Z,õ<µœ\0¸ÏjümâfÚwØúW†¶èÇ—Â:m´É¦éé¤,²–>H\0þ\"³×ÁnÚy¦›¾aŒJïå¹ó\\³Êêßö™eX%¸0¤õ^+è°œc˜Ó’’ŸË¡áf<9„Ä/ÞÃSÉî´BÛ÷.7ñÂ/ÝSþ{ÕH5ŸiÒÇž{XUùyÓ¦{&ž‘<$ê%”6y¯]éz\\Ñ9’D`r¸àšú¸ø‘R)sÂýú+à<<¯*Rqzÿ\03Ëô¯‰Z²È«zòOäLw*œn_®+ÔôØÞn’	–Ø_66#åÏ®k»ðm´ó<ºvÈPƒ½{Ÿ¥c/„.\"óÝ¥XÙã–Ç­}Ž°ušŒŸ+ó>CÂXºfþ‡Óš7ˆeÜ’	P¯ú¿Qê;×E¹¶|ÊÏ¾ó!Ç8Ïôükã«OO¤K2_2KþçÌ…Çò®¹~(Ì¾]­â²«d«Eƒ“ñ¯´ÂbcVÒƒº>w†•ãQYŸ^Yë¤Š^`…ÉÈPk«Mi!XMÄÛÑÎBž§ßñ¯ì~$é7°<’Àï¦AÔþ¯FÑüEiv.Œ·ÊËkm¤ójï¹ç3é+mQhÍ¹\0‘¹s[ud±·™pÓ\\£…8R\0$zð>¸Íx6‰â‹g“fIu\0\0Üc=+­ƒÄÿ\0½•J	¡ügœú×-[…ºž©«nTïiÀ×µž%·$`¸ÈaÖ¼Þ=^$cÌû@À#oojè%Õ­\'ŠßÉO&MÇŒõõœwÔÊ«:;id….$B6:}ÓØTÖò]ªIp«½•IÀþ/þ½`Ø€Ì×;Ûrärx\"¶í\'óšuvˆ#a<qßú×Te¡…Øô¹_+.=û{VÅ’aÔ¸ÝÎ9¬$arR<ª!È/ßó­]ÑÃrVU),@M)TfôãÕ×ºu´\"àéŠž0ö›ƒ?îåoV\\H\'ŸÍŠPÀŽ½ˆÿ\0’{iAyÆr©ò«3šž}u*^fÃE¾ÓJÛšL¦ÏåIøtu;Ø ôsTã¸o ¬äå[#Ú®Ø·Êè1Ì¹ç°­ã$rÍu,I,¬„î%Õþ÷uýjXåãWýärJ>FÏÌGn9©™¹!O.Nê!VòöÞ¡$šé‹]B0¹:Is§±xNõr[µm›É£º\0äœdV÷YE.äVûÃø}ÍJÞuÄÐ¤«¶%n­Ò¢Iu6äfÝœ‰l{»ŽÜvö«‘$\"Éå\\Z´d«Æþ„ˆªñi! fØÈùºb i®|èü®™P¡ÍsÔŠ¹rZ’G$¤np«+‘ßa?Ñ tÁš7Ï\0õú{Ö{,‘BÈr#<.{\nÛŽÖá­Ùìˆu‘9Y8ëD#¡Œê²/>:–EŒ}ÑÞ›¦.es$·\'%¸â›.­±Á8’:Õ¥ƒÌxÚ/’N‡?Ä+¢+C+—cÛáFÎ¥HŠK!(KHÇýÒ¥P’ÒepcReˆgŸçZðÝÙKµK34j¶:·z¤®A1ŠuòüÈ‹ùÎÏj×HÑdY±n˜U^‡5žn]îG–`hÀúcükbÑRÔ9…a“Š¸Ã¹j47-\0d‚7vaÈ®ŠÒy.ˆ’Cóý ¨®vèLr[ïå°Pö>¸®‹LƒxËÜ1ƒÛëfÎYK¡¿äH6åp8Þ­XÍqi#M$BhˆÀû¹ª««¬|žASÐV ”ÈëÐ`Vùþ‡Ö‡.d¥­˜fÛ;,êH íõ&º[iÚL¨aæqœÕ‚ÒZ¡4°>Sß?ýzÖ±’Þ< 1IžHî(V2œz,q›°\0æºÛBÎ¢¨	ÏN:WÎX´hH;O¡ÿ\0ÞµšwdD¹Éß½tS‰Í8lFY‹Ã;„W#fÃÒº«$q2œ|£ŽõÇÅml²Ç$eÙœcqþ*ê­®fÞ±F\0ù±]ð‰Ë%s´Ò7yA²[èz~5ÓYÀ…DÎ¾r“ÎþÕÌiÞt`»³ü§=‡µu°˜•”Faº»!±Å4tšJÎòÆ‘I±²}Á¯NÓá¸m˜a°H7ÜWžé0êà‰NÕ ô5èV›<Èä@7Cüë¢1ÔéÑÏç‡•ØBÂúŒ*îmáŒ±dŠä4Ùc¹(¡‰Û÷½ë´·Q–VcòŽƒ½tÇc¢’-*H—\n¾^õÛÆº/.)\0VùÈ²bB†bvdõí[0)©\'%¹¨¨}žº2WŠuŸZ+ž£>ŠêQEfhQE\0QE\0QE\0QE\0QE\0~[^C i.•>6Ž~o¥ZŒÁs*Í²+óÿ\0?úÕš–¢O7ÊyÛ‚ÄsþE4Aq,Š~EÏ=+òþR½•ŽÒÖe·ŒÊÑ‡óOµEWÝ(\nžcÜõ®M/ç†Uó_äPX€zUXo»‚RÅ„W€þ÷4Òèv– wpŽòíU&q4Œª»GËõ®vï\\Ü-ìë#²g «ñ_Á;«ù‚ÚRìgŽõ´PÓYÃpêÝSæ?‰=sQÉdð€\"íA¹€=«F´;dSç$ã£{Ö¬MGH±%‘ó•ì*“-ËC;¯‰@þ\\JyÞ¥m9-Bø(NYÏ\'úV´P]F¿h	´ƒ‘Ú«ÜÙ<±­ÔÎJ#týU^Ò]Çc[Øb‘QÝ•G9^õ uë[ÞK‡óç\"ààgÞ›íÉ†?™OCŠ¥wµÃ–âåw¢Fm—¿µÒâÙXíÝÑ»ŒœzZÚ¶ºûZÈ*zóEŽåÝ¤š/%¡£\\qøÕÛmJæi#”³[‚ÛPý+77Ðô(É™d@R2:ô$ÕNÚ;…‚hÐ†cƒ…ô®NË„œ‰f8GVÆ~÷ëE5{›«…Š7H­¤‘Uøû¸ïß8¥ì›Ô¨ÁîfÞE§lH¡Ý\"¦íàŽ•˜Öv×ÀÁåˆ#\nw2Šèo® iKE!+\n^1š­k$,ŽdW˜Aeõ#¡¤é3C(hq€±DÈEùYÀù1Îj¶±Å²ùkö¦ÀÏ ÿ\0*é¼ç¼¯’ rX÷tò6•;’ ç×¥/fk­Š?ðPyínl|C¦ÜF‰¨›(ž$UÏÊ‰¼àõÈltì}ëù³ñŒÓ> ©ÞÎVPGý Á@^MO\\Õ%·î-lü²G-\nP³¼¶ò¯çƒÆá·zÍòCswæc…=+“QFV?IàØ¹áå/?Ðòÿ\0%$1ªEÉoJ¯©LŠ•x‰ãÖ¶oÒŠc,àp=«•¼–ÚÒ%ÉiD„z×4¤™õi™ËqüåV>TäTÐƒ}(†éÕ?¸|ZÎ­nÒ\\YÊêRÇ=p¥Q„™ç`ìÑ*g½kšQîvRw:YV1o<¯”‹,qüF°>××[JH¸HAéKiœ¥ªcn[Ö­]-¯Úmîá¥¸TØÙïXÎÑ÷&‚o² XŸ÷¥NO­9 /’EÄo¾ýÉ«0[	Š™S‘ŸÂ«]äÚ”U1Æ²ã9ëB¡ÜÑÒ¾ˆË[k{—Ib9»W>ŸZ¯+Ío(Ï$«|À*y!Ž\0·1ÍóŸNÕ‘¤×™cøVô©+êy¸å(è¼F¹PƒÊ( ±?ÅŸê+*âgg$—qSWî\"‚T‚yP£ÄÄáz°ÇO¥2[hæÃ«bØAÜþ5ÝN1LðëÓ›ÐžÝ!x˜ü½ýªXç²(DJÄÜ/­B‘¡ßL\0/z£6Ëhe#ÌÎãæô§-tCTÝîÇL»%‚LiË­kÃ¨@°ÈN?*çžF1ˆäbL:Š®V·G1<|ÏÍSË¥e6¶5Ì¾mÀ³ÉéíUçÔ-â`ØQ%`ŽqøÔW{­ÙFõ\0üT³Gk¨\\Ù¢&ßó±ïŠ;šÂ¼­ û=&–Ú[b`þó×Ù­&gFËöd89ïVMÜw¦\"ÛÑ†Ü”ÙçŠ8cmÒÊä‘è+hÀçÄr½deê%¡HÚ\0xQÀ?­aÅ©µ±\0¦’U«^Úf•ØH?˜¬Ë›{{·\"50´/Èõ¢¦¶gG­ÑVv®3æõ×SÄ»:ÀÉ€[·°«²ÛºZãí85d¿i‚A9-²R>¤W]8‚œ‡ÄÄE&äÊíš°ÜMÂ	ŒrƒÀ‚\\šIíS!‹#œcûµR:@eyJÇ‘ëÍzîLæØ³Á%šÛ7•ßÇŽõSUºŽXâ…£ œò*åî¦÷lpö¬Å‰n$Ì×e¸âº:­2(‘!&o$ÐgüóR\\ÏÅ¸ð3Ú¬2 -®ãƒŸJ¢ÐåÄ/ûà’žßJÆIL¯)-å¯”‰’@íQÜM;#¡ŒlNOÐÖ¤ÿ\0f0„JL¸û½ëœ¿Õ.­f¬ò“´8Tã}ˆ­;-Y‘·|à„ù‰|zVŒxØ°FŒØ$Öt7l‹*È…ÉëZþ‡dÒMx|Ëcÿ\0}rkª1i]ž|¥wcõköi´eðN‰®TMr_ý–-O¶1_][Dsç`´ŽÄWÍ\0ÄVÞµµ´ˆˆ$¹Ý†q¶Ž3èG5ô¶˜÷­Àó²Gµ0çÕTñ•gœŸæ~«‚£ËJ1}Bö×*ˆ¾jàÒzNÕ†)¸½†Wê+Fú<ðå”À÷k*Ksò\\F<ù$\0óíë^2fþÌÓƒPUäc¢mØ¨\"¸ÎÛK-€jèŠ)åÛòïÀÈ©<”öìÚÃ§½7&c(jhý.HÅÊÄý‹ÿ\0ô¬‰Ý$$","ÿØÿà\0JFIF\0\0`\0`\0\0ÿþ\0;CREATOR: gd-jpeg v1.0 (using IJG JPEG v80), quality = 95\nÿÛ\0C\0			\n\n\n\n\n\n	\n\n\nÿÛ\0C\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nÿÀ\0\0 \0x\"\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0	\nÿÄ\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁRÑð$3br‚	\n%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹ºÂÃÄÅÆÇÈÉÊÒÓÔÕÖ×ØÙÚáâãäåæçèéêñòóôõö÷øùúÿÄ\0\0\0\0\0\0\0\0	\nÿÄ\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3RðbrÑ\n$4á%ñ&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹ºÂÃÄÅÆÇÈÉÊÒÓÔÕÖ×ØÙÚâãäåæçèéêòóôõö÷øùúÿÚ\0\0\0?\0ûÚëRƒì(\\lŒ¶qÉâ¿¿Ewý¯sw4E¼Ë‰ óËWî~•ûO|ñ„®Fâûx/EŒÄY^f	Y‚‰ï?îçšüqÕ>|Yñcý¯Aø{©Ë-‰^ÜÆNpÏ_[‡´f¦­ÞêÇÑå*ÓUc8´ôÝzž_ðM:_?ö‰hÒfwÌdãIŽƒ×õî›.™6çÓïá \'	 à}:×û~Éº¶£ûKÙéŸüö›yô;éÒÖÚñÄŠSËMÛ¡`WQß¾¶ñ_ü‹Ã:ý­Àð·‹uY#`ƒQŽ;¤BAÁB7ucXcòê9šXT³µ»­õÔo3ž³§(]oæ|gÿ\0±ðíÖ«ñ{âï.ã$³ÚÛ_úoq$øäzB3ô¯ÐM[83€:×Î?\0ÿ\0à›?¶Oìq&«¨üñç„¼ee©Ü¤·Úf­fÐ½ÑŒ‡-Ê0ÞÃå•zõ¯M_Úk]øsv–´ìûâŸ¸m¯ªØÁý¡§ë¸a”{”ô¯[Êê+l’_×üÊöu+{Ð³¿Dõû·û®{=º2„Û¸ííU§²k‰ÌŒU€;@aØ{ýk;Â¿¾øûJþÓø}ñHÕâH÷ÉµÞÉÐÍ%þøÔÖ%°wÄ·c/“ÑO¦M|wó¼)%ñJþ¶_ðQïpÄ9q³œ¾Ê·Íÿ\0ÃÞÙ ‡j)N:ã\"¹ícMŠVmûv”ìGqŠéä¾´ž&’	‘û¦¹½bD.IÀõ¯Î•j}Ú©¡â<ð÷ÀÖ<i ØÍ O¤“ÜÜxvþ]=®]T•ˆVlœH˜¯™¿d¶´Ð5Wã–³“q¥ÊòYÜ·ð7•\'œøè~W#ñ5ë¿ðQ·‡~Gá«y™¬ß$e	çÊOˆÿ\0ð*ñoH>þÌvú4»ºÖ‚«Žø“ç|ÿ\0ÀßÆ¾û(©þÎŒ}¤¯9%^‰n×cçñ”°Î¬½Å¶ºoê{÷Âø,.‰nñ[|Pø{ul¹\0Ýés	ýâ­ƒùf¾ëýn¯Ùwã7ˆ,,ü)ñwH7³Ìª4ÝFémnþÙÊUˆíòƒÔWá,ñ¬ïýÕåOzµðâÆ[½h^I‘åòzqÒ¾æý’æzŸ+ˆÉpø•ËãøŸÙ†fÓôÿ\0Û]ùñ-¼vŠï\"·Ê.IÍøÿ\0¦ø—ûFj:>©£Oñ‡Åá²4K¡Ë®NÖj„c1TãºE}ÔÅRU!wÿ\0\0ù¬M:˜*¾Â->].}¿âoø\'Á+íBOÃ·šŽ‰$S¬¾TæÀä0<¬™ qü%i5¿Øá{úŽ§{©íFÓyH°Œù“_TßZé_cv3![æÈÀÀ9®vOÚËó+{cóÏ\'ËÜù½”oèzŸÚ˜îNWQÛÔù—Fýš¼àKûSÂ¶Ó§HÙÕ¬\n²°$¸ç9<â¤Öf:tNš¥ŸháÊmaøð¯¤WÁ¶ò1-\0V\'ˆþèw°3M	ô¬°¼¶PÑÿ\0XçÖzžá}oÃ¾BíÀYŽUÓƒø÷¬Ú_ãÃï‚¿	¯<yâ¥Žx­¼öÁL—3?	Á$û3^µâ/ƒzš †è+ËÄjšùCö¸øcsªümðï†üE´èú–uH­ä<My49ôÎ8¤Ç¼Ùì+š¼åB.O¡¶±˜¨ÓOsã?ºÚøæY¼O¬h¶>.êÚ}ž‰j‹21<4ÒmÛ¿Êêz×Ïþ\'ø¿ûDx\"îm[Nø©«_E\0ÒIvß!Ï¾qú\nû·â?Á|Vy48u?&iä\n“¤gåaža´ý3_þØ>!þÊ>,´‹ÅV+}£ê±·Ô¡Œ„Aù‘”ý×^>£ŸZåÂbjœ³‚wî‘õx¬¶ž4$Õ¼Ù7Á¿ø*wÄÿ\0j±Y|J‰uí(0Iîcˆ%Ä+žXãï~=}kîO|HðÏÅÚxïÁú¢ÜØ_À$‚U9ô#± Ž ‚;WäW‰!Ð[Q¶×¼3Kç°DŒ0IÆx ŽkéßÙsö­ð?ÀëýSág‹ïF›¡ÉdÚ…­Ä™-åXCÈ\0IWÇ@8|qópñQÅa¾³„…¦·Kªò]Îl³:ž·±ÄÏÝ}_OŸaßµÖ¥sñ?öšÒ¾[6ÛMHã˜(Èÿ\0¼ÿ\0ß?*á¿jO›ßÙøJÑ¿s¤Ú•T`	$Á#þø	ùšõ_ØÇÁ‘þÐŸ¼Oñ­]nmÃ¤\'?rY’9èQ\0GSãWìñŠ÷ÅZ§Šü+}k©-õÓÊ¶Óƒª¤ü¨	Êœ’:W›†¯…Áã¡†«%gküÏÀõê*•hº°WR};-—uYZtÑòY°yë]çÃ/\nO-ˆ¶ŠæÜ¸QÎ3Ç¹¤ÕgŒžÕAñWÃMbÒ<Ý}žëûÄ?Z÷ÏÙá÷¾%hÚjé“Qp…å0¼{ãÑOÆ¾‘8â$£MÝ>Úœ>Õa¨Ê¤ô±öçÀÏ\n[þÍ_°µï‹æQ«ªÀ¶¶?.¤[þ»åEhþÚ:Ð´X´ÿ\0‡6ÒÍ¦x\'JYµ{H‹ÉqxêBŠ¼»à*€9$‘EvfØ¥„®¨)òò«|úÿ\0—Èòrœ$ñ4w¹»üº~·üwöŽñßì·¤Ëñ7àçÄMWHñË\\Á—áølóNñ0’E‰b–#dÀ°Hþlø®ŸIÿ\0‚ƒ~Ñ?²ÂêßðRÙòÏKÕuùšÛO“áþ½¥<×W™Ú¦9HWÜèí+Ë®åSOþ\nSð[Ã_´WÂˆl5‹»«Ký#S·¿Òµ]>QÍ¤ñ¸ehÜ‚ã<‚:q_žOÇO‹¿¶íªß¾%xÚÿ\0Åo…ì¿±4ÛRÚ6º°ŽR±BˆˆÎêIÀÏ\'$×¡V­:4¥;},±U£O§Sëƒÿ\0Iý¼~(|H»¸øQðŸÃ†‘ØCg«Á5ÝÈŒti%ŽT@øÁ* …Î2Ýk¼ðíáñãÂž0°Ô~4x~mCA¸tÅÖ˜VO±ÆNþÎ\"a-ò3’\n6w/§É¤xM‚+˜D`¯Îäç$dôéš›ÄÞ,Ð4ÛX5oíO.)PùqIÉÈöë^\nÌk9ÝØú7ÃØGO•oÜµûzÿ\0ÁH~*ø;âO„<Kû;ü¿Ö~éz ‡ÄŸæ°‘ô©®åÄfRˆ÷H¾kþèÎU2JÑøÕª\\üNý¦µ=^ËK½}ÊH¼A>Ô†å¥´‰–Þ5Ý¸Y™¸NyËTß²Œ|;ñÛÃ1ý¾)xãKÐ|7{5¾µm=ó*—²7A¯m¡bÊ™‚Ç;Lò62pß<iðò/ŠÚê|Y›LŽ+—·Óü?Ðù@™Œ‘“€«´©+ÜUfˆUÂÇ•jÿ\0C—#ÀO˜Î3_\nµûÞÖüµ2<)àÚ~$Ãaomá)<1ÛniÌéwåpT®VnNsÀü:ø(çÂ=âì©Ûø–Ê¿Ó\\X>Î|Ð1€}ÆEv_¾,izÂ[Ê¥Y@…tÿ\0<>3xBËÃ6·¥´²æêGl\0£®kÅ£RnªiZÇÔâh¨Ó×[Ÿ‚ü5ñA¾7þ³šâiK=¶ß™@ç>ãÊºoÅöÚO†¼C}¯ør)›XðÜºe£Í»[ÈY_r‚89Ld:äâ¾Üøû1_jŸ`ð~›ðéô¿XZ^m×„âº•-šH¥VˆÂAyïŠøSöž×|<ž0×¬ü&ý ë³/j0	lY‚0ÏO”Œg‘_]ƒÄÇ¥JKEgøŸ™`~ ©ÖOY_Cí_ø\"î«¡Çð7ÄV2H±´~&|ÝÌ0%-CiôÚ\0àŠûGÑ-/¦_-REl`¦5ÀÁàŸš»ÿ\0óÑ~+j½ÖŸ¬øËV½ÔZcµÒHVCD¦8bÎ3žsœ+ê;öñ·‡õ„šÄZßÁ¼n›O˜Ã&=J’êkà8‹!ÇVÌªâiFé¾šôí¹ëå9ÖžjNÒZk§ã±³û?üÒµ›»u“J÷á¢¯­ìåðÂžMNëá\'‡ìþmÅøÒ!³\0qûÀ»³’{×3û8|0Ò|9Ïªê×)$Ê\\Â@c%Gå]/Ä¿Ýjú£øcM¹¬§Ÿ*)Üò¹þèãñÍxùn3£vÓ‹}uM%¿Ï±–g¡‰«AÞ+3æÿ\0‰_±ÏÃÍkQ»ñ›áË8®î®æYV—œîç8<ö4W¼Ý£GË,BàñEz•òÈbgÏU¶üÛ™ÙC6«†‡%;$|—ûDÌSÂ—q9ûÉ_œŸ³‡àð/íWâk%6Ïgs­ËtwG,ª®w)\0rÌä$ãƒÅ}ññ—Äw>\'Ðg†Þ2T.Ix¯Íï´OÃO´]…÷Ž#Õíuyt–à5œÖóÈ¢G—$lde\' €=ñ÷yŠ©RŸ-5sƒ(ö›•gf—ùiüOý“ÿ\0g/©k®|QÑÒg°•&…Òòhæ—8ØèêS©àp\\ßÆOøÇZt?\n¼Má2y,ôÏÙÔÄY\0&ÙFrºƒ•<\0CVN½ã_Å>’ÓÁ×ª··P³¼²b5b8fÇQô¯ˆ¤ƒö¶ðÏíaãOüMÔu™¦Õ ‡UÑÎh­`‰œä’<½¨	#æ%€=Nx¸u:iËáÚç×G	N¯4¡ôÖÖÓÏtþë¿#Ó>3|+øÍðkQÒ-¼âmÆºüà7iÚ/fµe.ÅŒJá‘9ÛžyÍk|ñÃˆš¡yñ£ÃÖéâ³Ô:¾žQ2×årK}¦½à7ˆ¼WâoÚÏO×ü=cª^Ãáûgšñ¬mÝÕ†ÕI\nƒ€y rxŸí‡ã½Wã§üTñô+ûÓ|&\n5¯“(ºyÉRàŒ“°Œd\"»hà+íœ¹e¯M™K/ÇûÃš6[=V‡_â?Ú7@ø{ª‹O‡Vh––üGacN~êÐ{+Ð¾~Ø?~2øªßáÇ„¾KâûÆû8´†]±Ã‘ˆÀàò;O×Ç^†çÅbMÄ*mîà¸2£Ì½Cž20Aïšûïþ	ü¾ýŸ>xÃã °Š-BÎÙíôpÊ12gŒòK@[©ÞÙëçPÃ7ŠT¥+uoÉj{xŠÔå…RQ×¥Ï@ñ¿Àx->k?¼{ñ_N·Ö.tÙlÒÓD±{Ëm!™NË$‘™Iù‚Œ‘»­~^xßþ	Õñ–ëÅw¿4ŸÚ_[E­E+xÖ}\\Á¨±0	 \n†“\'åf,ƒ°çëÝKãf¥{«!½–æîêR@¹årrI÷ÎI?S]ªßXÂK€×/þ¶P~èþêÿ\0žh£›UÃÎ^Ê)Eíý_ÀáÄdø|Zµm´}ûünÙ{öqðGìá¤|+²ŠÛÃZ$V×wók]\\rÓJ±…Ü»ägl61»+éßþÓ>ÕJFÈY¹ó#»WPb¿5n<vÚxcö’î3‚½WÐ¾2xŽûWM9/åPòÚ®yúÒŽiŠ”õw¹Å_‡²Å¼îÿ\0ÌýšðwÝü1–ŠËo4`¬±¨møü=j¸¿²wvòGÌäîÚ2së^[ûZø‡Rø.uá,±És¶ÒI“\0|Û}GAŸQí^Ü¾€ÀÅ‚GnµîBJ´¥ÔøŒB†*pwIîfÊÐÍ))Î8R0(­FðÐ… ‘ŽâŠæxW}Ž˜ât?/>+üM½ðn‹|a¶Y<ª«wëXÿ\0²ÏÂoÙ7öáµ¹øyñ_öW}3Æ7Þ¹µ_ª=ÄèÙöÑ’2ªÁº,‹ÏÊË–<÷Æý}.>1ÙxQhÄ­,Ê;•ÆæJõ„ž3µøkã½Æ«t¶†Êfå0Ž9#hˆ=@W\'Õ­lt¨c#Mí³ô>‚m•H¿{uòîxgÿ\0`OÚoö`Ö#ðOÃŸYøöÚv–ÃI¿Ôb¶ÕáµB.¨e0eIô¯ø‡àÛÆVz„_cÍeµ;g+¨_K¨ZH-Nê’“œ{#¨¯Øêš7Œ|\'gâ½OWÓou‹kÉ¶ëñëùŠŽ9Œ`\0\0ãåšúÿ\0Àû=+ÃÏ„|á›_K¬_½Üš®“Gí3È«ºà®9rBƒ¸rsé×,ª”¥í\"´zÙ_™• «B>ÍÊÏEv¼õ}ímRI½ÏÈ¿ø%OÄŸÿ\0³Gü\'zgí[ûGi1x‡Ää­íÞ—6ÛWÈP‰pDQWËùvs“É¯+ý«o´]sã¿‰âøoãH%¿\n§Oho”ÆÑ4hTÈe‘ãÝ¸v\0:×Ò¿¶7ü_ø·ñßYø—ð‡â‡4?O;}/L¾lW<›‡Ž5Œ.{íÞ<äWÆÿ\0¶÷ìÉgû/~Ð~—Â½ÿ\0‡ï4g´µÖãf?h¸R•`I¸‘CmS·dd–ÆU}´¨¸M+Gku·è}TèðÞT1XÓi¤ªBIZ-¥}RZßT½çkÝ”¾ü3ÕOÅ›Ç¸žâõcŽÜ½ÓÄDsIûÌªž˜@xöõ¯°/luKßƒ7?4ÍbßO–óX[»Ë›ˆŒ›¡QB°Á&<dôÐî¯/ø1ñ¯á‚ü½ðÎ§áûù¼Eá]Gtry»aKkÆ, `ò<ÈÛƒŒ3ñ÷ª8>\'ëz´íö;f¸šWÄvðòyéZññöçƒ»”¹µY*µ6µ™ÓÚh>	ð™.†{©ß\\¹ÂŽŠ¾ÃŸRkWñîç0Û2p­iZ|0ñÖ¯{·Š!þÍ’hÖAÃm}­Ðzg:×oðßà7€¿´æ‡Ä—×SÌ°†¶Š$«ÉÁdmß7Ý\'²çŽrÃdÙŽ1§Ëeç¡LLc¤u8¯‡þñÏÅ-rßÃþÑ//®îdµ¤#ÈÇ°Ušûûö9ÿ\0‚B6›}gãŸÚày±è0JÍŒq+/ŽGÊ>n¹*k­ý…|_ðßá•ªé~ðÖ™¦Oq\n¼—0 iÙ‰Ûç pAÏ\'qÚ\0Í}w¥x¾Ó^´ŽîÓQ€I°²8ýðþò÷ïïšú¬7C9>gÛ¡òùÆ#2œh+.ýàtOéš5•¾‰¡YÅigkŽhb#AÐ\0:V«YÓkFºÖm4»¯²ÝÈ¨ì àÀæ+ZËÆzUÿ\0×8ê¯šÞ¬•­±ñ*•Jm©n>kT+´&xäƒúÑVRúÒáv¤èr>ë+/f‹ægàoƒüI\'h;‹«Ù¼Æ†Øœ“Éf~Oé^Õñ£ÃwzÂ»ýAekeM•þÑå–ÚN^;WÉß³‡ˆ/o¿i5··¸A²ynCrNBÍ¿Jû»Çºd¾1øUscqûènlÚ\'€6” äõ¯™ÆB?_´žš£á¥(`×‘Û~ÊÖÿ\0	þ,xkþK{­KÃ¯dm­5{k™\"†Iä“ÑpW.ÎÆOºð;×ºø¯ã.ƒ øWYÐt/^Ñ,ü\'®gÏw«é³0¹Ês-¾wI4,ÓybN™VÇ\n|õð»Åúg‚t}KðßŠ¼)cšÊÑZÿ\0Ê]Ñ 0©–1ˆÔ8]À‚JäkÓ¼AûQhñÃþð&¯e®=åçüOÌQ³ÈÊà¢yg…Q¼õ\'yÚE}u(Rœãe+Y6¯éÕ;\'®êþGÇb9êTPiµ/{wdÓëufÚM.šù“Yü;ñÍ÷Š<Q­|N}\'VðâG\néÚuœÌeÚ±n¸Y‰à¹fùTvUÉŽ>]ý¾üà»ß„Þ0ð?‰´-;RÑlõtÕ¼!©xrÉç¹Ó¢Xƒ³É!%xÛt¬Tccä‚GÓþ<øyã_øãh¼!¥Þë’j(Tðì7‘ë_wÎ…æ–Pð<˜Ø5b‚&8Áñíu®|Qøªø÷[øÉ­G¨xÛZÏá½-Ä)+	-JÝÛ°ò±³”e%NâpQ^ƒ–NÚëŸèz9MgSÊK[Z:îšJËnge{n¯vŒ¼â_3kž‘àëÃ‘Æc¿ñ¹kåIzÑäã2aÈSÉ;UéÍzŸìçà),üR<]«ÄŸfå­ÛÌg=UC”ðFHí_)øÏö›ð‡Ä(­¼h£OðÍÂHlíáÞ©o-°ªõÜBðsõ¯®~ø—]ñŸ…ô}kÄ£O²Óu¥Žm\nÚ”	íÙ1àÍÈ,p[ \nùÜ\nXšüÍYEŸ¤æ™wÔ8s):‘æÓ¢¿_ëÊúÕâ­Yõ]3ûb-YÄÉìˆ0WÐ7oN3ý+›²½¿ºš+øK[Ê&sÀ#\0>•¿©è6°Zy³­Ä1ŒÈñ’ÿ\0Q–ãéÐTPêÚG…Q!mno¦m‘Eqx×wüôÏAÓç\'·$}Ræ”¬Ý’<¨áà¥Í#Ñ¾ßjZ¶´÷óêÂÂÐ>d¾w Ã;‘q–a»®9èIôúOàÆ½6ËÄp|ñÆ¼-5‰a¹µHÈ2!VÂã#ž›°{|Qk®ø™üCý©pÛOerÖ±XäŒ•˜w ú¯Ö¾£ðÇ€4¯ÿ\0SÆ>Š;}{Jui¾Í6œqÉ†÷ÇP+ÕÃVŒ“Kâ_‰–2µ*Pº^ëÝö}õä}u£x]u•—Â!Õ>Ñ4P<–±±Þø<e*O?+Ùþg©x«\\ð¦ læ¹=7E È¾£Ó¡v ŽÕ‹û9þÐº´Ò§„>%Bmµhœç\0bwUÚ%‰LpÈp68\'Ñ¾.x[Lñž•¦ê6I/®7¸†‘#˜«2¸“êÊ Œç9â0ê´\\£¿õ¹ñõ°SxžY«ólÖÏþþÏX||ÔìSÎXzœÑ^¨x»Æ²gÔfŠñ_5Ì%„š??a¿ø›\\ý¤æñUî‡5¾5¬¶ÝMŸr8LôÎÔlí_ªÞºM[Á^@ÆF?\nø7Á°µøgkg¡Y¥­ÍŠ$új€²\'Ìÿ\0{Þ5ôïìûñ«KÖ|+nâ|cÑŽ\n·p}Áãð¯Œ«[ÛWç>ÿ\0T©)S,z/ë¯sã_†^-ð—ÁïÛÆú7×^Ö¤ŸÄW0[ÚÏãŸ°ÚÅ˜Î±°¸a\n¼fPªqÜ“öG…?oOÙ“Â³»øoIµðþ•â«kîì<7e,W1#o”ÏqèËm•fœ\0#?ÿ\0ÁYþüFð7Çû¾Ðç—ÃZÝ­·Ûî¡„´Q]¯îÈv–QàœãœŠóOÙ×âo‚®<gc¨ø·@Ð§¹H¥ˆÙxš,ÙNÍ*³Ê	V!¶–]Ûväf½Xâ±´bšw‹ëÛî×Cè0ùñ=ÔåF´b¯¤§$µ³“²rÙ+£ô×àŸíý¨|Vý¶µ¯ŽzoµmÀƒÂYh¶:pŽÇJ™c‰œÉ¹°e2yÊ%V.V@\nìäÛ÷þ\n7áßÛgÄ¶ÿ\04ù:u¦§çÙ\\^²©kÈ÷èYr–YJŒõê:ŽËö?ø[áïÙøßöñoÅYdÖ<C¨(‡TðÞ3éèÛ•EÀ‰Cq›r´Hª©÷ÝyI©øGà?†f>3ŸF&M%õt…Óüèu;§W	—*¶©nê8#iÏŽÆ%ìù®¥{ÚßÕ—æÊË2<›+ÇÇS4¡ìùe8´”t|÷V‹”ÔMû·j÷>kÕ|ñOÄ‹à-7K’-Á† ùÏî×\0=€ôëßœ|ø~¿u=7\\ºÑmïÌMe~V[yÈ`””)ä.Póø\0ü)ñ‰àùnüG®OOzþeÃÆ€|„ä ô½çÀ­>3xFf;^Fd‰Y7aÝÏá\\”ñøœ#J/Í™çxŠY†k<JZm-h­¾ýß™ØÚø—Ç_¼eâßƒ>=¶¸Ógd†Õä04‡ø— sT¶AÈ=*+-ã/‡´Å»×ü2Ø<²[Á7›,¤}ý¹=F	éÎ+À<eðGã\'ì¯ã|aðãÆw6ºF¥2ÿ\0hÛÛÜºÛ«îÿ\0XÑî\n¤ô/ƒÛ<f½ƒáü+ãŸÃÛk[?ik{¸*xD‘L0FVNN¸ÝÏØ¯©Áâiâ©ó­¿&y´¨NzIßð¿Ç:wÅ}:×RÒïVRÕ>Ë©ÛË€ÌAà}F8¯uø1â¿~Î¾0²ñf…¨âÊä…½Èˆ‡Ì½ÕN	plÕÙk_øÿ\0Ò5kø|=â½:¸¶×-!0Éq	ÈùeLB7$6ìdqódIwð§âÏ€õy¼ˆ#Ôd´Ÿ0Ç©*«¾;‰vÈ¬§î°^sØû4iÞ*¤ÌNR¢Õ»§·Éö>„ñÝ‡‡¾ èéñƒÀ–ÉNûuÍ2/˜Ù]Ë äíÝÈõ8÷ô¯eÖmíü®[¬ð\\…K¯,3|Ù.€Ä)nxaž+çƒ³x«Á~$¾ÒSPû¥Ë­½õ„ß(ÜÀ”TÈÆv–À=BŽµêzwÄ=Âþ&þÁ°Ð–k;ÅÔL{Žìcæ<ä{ð¯FoVx²ËeN^ÊZ­ãÝÁ_¡‰ûW|Ô<!ñTx“I´hôo\\É${Ð/Ù§|Ä8à) ºŸî·µìŸü1«üQýœµM…šê]Qe{<˜ÂÊSd\n2qÔQ^u\\#ç¼Uîy2Ë1Ø—zNéi¢¹øGð/ÆÚüú-žŸã->M?S[t7V3:—‹#€Øû§%O#8<ƒ^ÑðwSÑ¼+¬ê:{2¬WR‹¸sÑY†Ägþ^AñCáG‰|	ã;Ö¹‚XnËÉÄq*–$0=Á¦hŸµ[W•­Õ5+]-¾ÊÒ?Ë»#>‡µ~ŠÁÊg:kÝîá1‘ÅÓTçñ~gÖ÷zç†<MàíKCñœúÕ¡‹QþÑÇ”b‚On{ú×æÿ\0í»ûéÿ\0³¿ŽbOß­Ï†õï2M.##Jö¡væ6r¸#æI;°9é¸ýkàï‹Zæ©ã´Ó£Ðá»ð¦¯ábuˆ\'ut^pç;‘•Ê²Ÿî|ú)øUðk_ðZé-¥Ý=ÁH ¿s&Ž=;V¸HÔ’i„0Ž]U±ò÷ìƒ«üIÓ>Ùi–¼·sÝˆÏÚo\'Xgµve/\"D¬[(¬ñ´‘œŽ•±ûc^øTðu…·‡<o§Ü]‹£q¢iPÝFí#ª4f+uV\0.s‘ƒ‚[ /Yà?Š^ñ-Ï…~hâ@aU‚ãnå†Â¨pÜã$ã§ƒ¿aÿ\0E­7Äê6í« /\\+ÌºYxˆuÁ_ºNqØú”àêK–KMŸ…WKûÏw_]?­¬|¥«~Ìÿ\0í¼)ÿ\0	Gˆtkéã”–t²ËÃó60\0€x8Ç\\òF\0¯¤¿bßÂž°Ðåa·+î|¼Â»o	u-\n=>ÞÑu[Ÿ$¶›§<¬¶öë!lM19|)sœ¨`ã›öqñ_À;5ño„ç—PŠX’}Z™AÎB–!W‘œó‚Iäišå‘ž{šŸSR‹¥i¾§¨üiÒtxB}.å]üÈˆd7±ë7àÏÁÍ_Å_!ðŸt”];qxèðäáås×‚	1sá4oÙ®¬²$¥+uVˆ<ƒ^{rë µñ”Åå‚UÇáà*âhsB×ß¹¥)Ôk–,Îð_Œ,þ	þÐŸ®ü¬­‡†L‹©ÙÄÉ­\nˆÜ0ãwœg¨ŒWß?ü 5H¬|gá‰­ü‰£\"2ØmÑ0ŒIê£×¹ùy |ñÄ[xæûTFòí,V)1&ucŽ˜Û•æ¾íø®øÛÁv†ËJñ:[i—[çÕåš˜3Ä¤3Àí!@û¿xm¯½É©K†äŸ]OK[IQœçŠi«hÖÿ\0~ö;;ýSÂ³èÐhŸ®<FW³’1æL\n¸ÚûO7\09ÇàŽé©4Z=Ö¬iMéo&K¢&*YzÛAEÇë‘^9â[¿|EñÌßVÒ¤­°‚5…„‘Æ9q×q`H •^s×jÛÆòø£á”—z!1G¥_,d!hßÌbx?/ÝŽ½yMjŒs,}œ$´“z«è¯Ðú;Âß´/\\ÿ\0bÞ$>]Õšÿ\0fÍ7>`.ß»vè\0?.OvoQ’¼gCð®©ñ+á}½¾™m%Ìö’0n$L9Ü¤‘»©ÔV|öÖ×¹ÃK•j«Tå’vz_oF¬y¾xkÇQÒ|I¤Gqa#æŒú«E|Ãñãö:›Ã¾šæù5	Ì)j ùÓ#?3/}@¯ºG”•B~µŸy tYü+ä%ÏsóØT”‡çwÁÍ5¼	kªi×+åÌ’#\')ûÑƒŽ9Ïíf»KãG…ô˜¢°Ó¼ÙQ€«d®qÞ½[ö›ðW…´uM7BÐmmïõ&2_M\03&zî}=+Ÿø=û\"Oã]cÄQKkcœ¢*âIþ™è=ë’4\\&ÔOigU–4¬½Þ£g-ZÛÇÎ§­Imr.!|À6ìcŸÏ*?*öô[y¬üëbUÔ|ÀŽõ¹á¯„þð>œ4iÚD\\ Ë9õby\'ëW#ðüq]mgm¬0@®ºQäŠLò«â\'ˆ«Ï\'©ò~§ñ‹ÁŸþ7Þü0ñO„m4á«^î²×Ôí‚[—ˆ8K€ü\0O³·v2\0;‡¤Ü^è–ºF«­£Er÷lËa,Ñº®JF§ÍåäÛ‚ðÜ±#\"ÛöR´øÙá	môt[]bØ‰tÛ÷ØêrÇU$WÍßi_|yþ	|[ðŒÐêVÓ¢·™w¶HíÃdˆ·)DOÌ¤A$drß]ö-*«ÝïÛÕ~§Ôå˜øW£ìfõ[>6ðŽþüFÓ¼Xu+4Ó5(È¸Ól1+u$p2NAÏ$œ×±ü7×Ÿã„,¶ò.g\"¦¥xb+ÉçÉ\\ã.ÃöA$ögá®“eñÞ±^OL¸³aw\nÌÆnÞnÔä‘žÄ¯kÑ4/ü9ð%¯„|<–°§žFŽÔ>ÑŸ™Y¸ùò¾§Ž2\"º!—a«ÖUÖß™ô4iÆ•)[®ÆwÃE(‚þêËÉm3Í»öü›QE\06œŸN•æš·í¥j?¬~\0Û™%Óî¥+­kWL½Ã2yP‚?ybÚÛ÷…Rý¦h³¥é—ÿ\0þj»5ÝCiÖoR5O„áŒ{ñË±Àï…\'¡5ñgÇÿ\0||ø5kiã/áå—‰4-8F×\"ÍŠÜ[9c‚”=rÆw,Ë\nîŒ§i/»Òç’ç<.#Û?²üúuÒçèï‹]Ðt¸¼7¬ëÌ×]­Õ­Üm‰%EWPÌúûýr+[àDQ]x£ÄµV[ëvrO1\0Ù:æDÀê	\n}à|û>ÿ\0ÁPÓã£j5¿ÜÇyréåÜšŠ²H0œ…8*K)c‚@-À\0WØZ>¥ãÿ\0êq|Pø|²F‘È;uùíf`.:îÊ“‘Ô`Ž0ku‹¥9>WvºyÔëSÆ¥$ÒRŽe}Ñõ×ìQáå»¸½Ö…ÊIglTÇZ²0“£œp9#Žàô\"Šï¿f¯Oà…vÚ%åÌ“Ý<K=Ôò6D’67cÐ€zEyÕ*Ê£?Ï±²Ææsš~êÑz/ó<e4÷¥6M3óýoÉh‘¯Ì1QùpãóÑÞ÷8o|3ðÇˆ5;}STÒcšæÕ³­œ¯å×ñ­{?4`öÒ[i©+y¸ü(¸´W®8^ÂªÁÍsÔt×[–,˜¡ÅPŸLpâE¡ÏÝ>Ÿœ=*Å‚.B ¸¥°Ó¹Ê]h°ÝC‰\"ÆáÐ×‘üpý•þücÓÚÃÆ¾µ¾ÆL:bXûÑÈ¸d>êE{ô¶KéTæÑÒVÈ^hi4i4ô?.þ(|ø¿û$øíu/„^.½Õm¢„g+{hœ†@Ê1ë†õÏ~ƒÆÿ\0ðQüBÐ_ÃÞ\nÐG†ï¥A þyi£ÀF¬ªbç8ÎvŒ#¯¹~0|°ñí’Ëmo^Å²H0HÁ@ÏGÿ\0^¼/ÅßðN¯‡>+g¾ñDÒµðÅ5òLGÙ‡\'ù{W,©b)ÂQ¡.U.ßÖŸ#ÝÁçU¨G–nëñ>aøumá¸Yç¸ßsq&ùä-’Çêzõ¯EÑ¼icu·™«# Ö7ÄØgã€æ{¯x5»dÎËKìCp£Ð8ù_êq^[qâ¿|;ÕKñ×‡ïô©ÀÀ°}›î‘ô5óÕ0¸ª-¶®z´ñÔ1IkæmøËörøkÄkoü6H4«×¸óµ->(¿Ñ®Xs¼ #cg©r2s_W|øÇâÝE«­…„VñZ¨(û¥2õ\';9è+ätñœWŽºœÌÏÜ#rkÑ<ñQ¯tS`±•røpç×¸¨§ŒÄ©]»~gUÒ¦¡-cØýý—þ1é_¼u[1sÇÛ˜\"?(8á‡ 8<{Q_3ÿ\0Á.|v]»ðÄ÷@}¦Ù‚.ˆ|Ãôó¢¾ÃQÖÃ©=ÏÍ3ü-<&e(ÓÒ.Í|ÿ\0àŸÿÙ","7620_IMG_0594.JPG","image/jpeg","/../ximages/item/9","2207950",Null,Null);
INSERT INTO item_image VALUES("2","22","ÿØÿà\0JFIF\0\0H\0H\0\0ÿá(Exif\0\0MM\0*\0\0\0\0\0\0\0\0\0\0ž\0\0\0\0	\0\0¤\0\0\0\0\0\0\0\0\0\0\0\0\0®\0\0\0\0\0\0¶(\0\0\0\0\0\0\01\0\0\0\0.\0\0¾2\0\0\0\0\0\0ì\0\0\0\0\0\0\0‡i\0\0\0\0\0\0	\0ê\0\0\0\0\0\0’\0\0 ê\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Apple\0iPhone 5\0\0\0\0\0H\0\0\0\0\0\0H\0\0\0Microsoft Windows Photo Viewer 6.2.9200.16384\02014:04:18 00:11:21\0\0‚š\0\0\0\0\0\0>‚\0\0\0\0\0\0Fˆ\"\0\0\0\0\0\0\0ˆ\'\0\0\0\0\0 \0\0\0\0\0\0\00221\0\0\0\0\0\0N\0\0\0\0\0\0b‘\0\0\0\0\0’\0\n\0\0\0\0\0v’\0\0\0\0\0\0~’\0\n\0\0\0\0\0†’\0\0\0\0\0\0\0’	\0\0\0\0\0\0\0’\n\0\0\0\0\0\0Ž’\0\0\0\0\0\0– \0\0\0\0\00100 \0\0\0\0\0\0\0 \0\0\0\0\0\0	 \0\0\0\0\0\0À¢\0\0\0\0\0\0\0¤\0\0\0\0\0\0\0\0¤\0\0\0\0\0\0\0\0¤\0\0\0\0\0!\0\0¤\0\0\0\0\0\0\0\0ê\0\0\0\0\0\n2\0\0\0\0ê\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\02013:05:13 09:07:26\02013:05:13 09:07:26\0\0\0×\0\0o\0\0í\0\0~\0\0Oµ\0\0-5\0\0\0\0\0d_Çqq\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0î\0\0\0\0\0\0ö(\0\0\0\0\0\0\0\0\0\0\0\0\0þ\0\0\0\0\0\0‰\0\0\0\0\0\0\0H\0\0\0\0\0\0H\0\0\0ÿØÿÛ\0C\0		\n $.\' \",#(7),01444\'9=82<.342ÿÛ\0C			2!!22222222222222222222222222222222222222222222222222ÿÀ\0\0 \0x!\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0	\nÿÄ\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁRÑð$3br‚	\n%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹ºÂÃÄÅÆÇÈÉÊÒÓÔÕÖ×ØÙÚáâãäåæçèéêñòóôõö÷øùúÿÄ\0\0\0\0\0\0\0\0	\nÿÄ\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3RðbrÑ\n$4á%ñ&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹ºÂÃÄÅÆÇÈÉÊÒÓÔÕÖ×ØÙÚâãäåæçèéêòóôõö÷øùúÿÚ\0\0\0?\0ïf$oE\'ô¯nr$bGV&¹ÔÞŽÌM#ckî mÜJë—\02k×m3X5­ÌÏÂZëWÇÌÎ©Ÿ©$× Ä›@Jé’³9™dgŠa]Ç·¥rbŸ¸o†øÄeÿ\0­4Já•Àea‚§¡Jó’Ôï¹©Ú[ÙXLa/J˜•¿v[ÝWô®{Ãåm<ÝIþôYÛùs^*·†§,áftºwì›h»ŠHOr>a]÷‡5?Qš?³]Å!\'î†…vGs†¤ØôÕÛ\0“…š+}È½‘æªYÜØNayLvîç§¥x£ØÝNs¼Œ=B×—S²”mthxcBiuÍ—p8S0ÚÜö®ªãÁÆHä×%)Í_ðÇò­.¤cRêZz?†|Eá¨æEi}®”1ÜHïÚµã×íâG¨[\\ØÉÓ÷©¹1þäîÆ•Íxç†h|È&Žhñ’Ñ¶êD”¦¹1*éa·c‰ªÒu5Ãc²ç#âû¿.É ™_‘ì+ïýBŽÃK€™®ÊQ÷R1“³0È\0sRØYüÅb¥yWeìd¬÷=_ÁšÎ¹wc4W:•Ì–ÅJ„‘÷`{¿­ÕbqMZLê%ð]§˜¯ïÖk|Â–_Ûãç™ØËòŠáöO¶\"ƒD·²ÉoGÚT·r*IPw®}Åh—.†OQÐ<X {«®]ÙXé¯=Ú£G¡vîÜO@(¹)jy½ó‡všM<älXúþ?ýjÃ—ZÕí\\·Ú×=i(©8—ôßËŠ—è2pd^£ë] ž;‹tš&Ž ©õÅ‰¥Éª7£>ec…ÖœßxŽ;qÊÅ…?ÌÕn}÷«û±(êkZjÖ@õ¹”ù8´, ,Š rÄWCÓB#ÜõkXF‹àï0q4 \"þ=h­e>[#™.mOPtM‡§CUL\0Ó±ÐŸf<Ui´øÜ÷¤ÕØ\\£.š‹Œ0Éè+“×lÚmbeÿ\0Qn‚@w=ÿ\0ÿ\0¡VsVF´u‘{¥C~J$ 9<âµËkìCw1ºä0èÂ³ƒw:æ•Œ	R5™Z,mcÈ®»B×-¬cžÆw	j^2Ý‡qþ­j|Ð9£>Yðå™Ô®®¯ÏÌ¬Äîy5WPðÖ¤\'–TQ0v-ÇÊy®EQFm<¼Ñ1ÍÌ<\'?ÄµÓøsO7z”)·å]1´¤Œ¤ívÞ\'½†\'rmì£‚ÿ\0ú\n)VÖV(û¦—µë¿©»±¹\"è² ³dÞ³äàc¸5v/\\é:u´ž(Òe±šl„òXJ€È‚/zè9š¹‹ÿ\0	þ·w|ÿ\0bÒ KPHkØ÷Ç£gâÛ¤»ŒjP‘EÃ*g¿@GëY©š:VE?øÙìµË(ì¬d›MVÙ-ùSå=”ô8úõ¨u\'7~\"º*$1¢¨óOÝl¨ÀZš¿ðëÞ3-\"Õ¾Ü±›k³+ŸyÝŽÜbã6+Ï´’(ób!”Ö1Üë’Ðñï³LŽ0YäJ³<Ñ‹[£,@´±„ðs]Ÿ8ä¬ÎçáãFt\\€DÌ2Š»8á@\"¼Šÿ\0Ågm?—¤Ã9UxQìVºøGô›Hw¥„ê2J®Þ\nt§Ê®e[tŽjïÃ6ÅÞDˆ,XŸsE9¹JW5„Ôcc\'Æºdz­¤21Ü[Ê²Ç\"õRpK¬_x›Åmwy7Ú\"…<¨È]ªr½zrØã‚¼‘ÖÆ#µAõÅ:yc@pÚÀàæGe“Ð~„ñëšmÇ†®eŠb–9oùç»$/¾Wÿ\0¬û«˜ÚúYîÅ,vÛñÒ®néQ¤Í;ØäÚ}qŠ—X²:¼pŒl?xûVQ7’8	ô}úËÀ–ÒCo±2}ÐÄþUÂêòF\'‘!9ˆJÛ¢ö®š.ç-ukÍðóÂ¼euæ”šëtÌxÁ8˜®’/]A ùr¹ëJæ¯C™ÜTëòèuÚ=šÆ¡šN@èj{Ëƒ$†%ÆÀFO©¬aEÇp”¹¤DØÆ(­´ÎGX?èî=«Î<=µ×n£!~k0„ó]]•‡E]Üê¯|?a©¼sÎò)ƒ®Tñô5[R–ÖñœKsk7)ÆÎ3íX­NŽ[³”ÔaÔ4©bd–K›ŒgUä¯\\œU1¬uvžíSÎV*Á¨wÜQi;1ÒkÙI¶ß”^\0­=;Ä7”ÂÎ+GžIM«ïS\\ôW5õ&I4©ì§ºnš2Š-åûþ¯*ŸÂ—òÎÖkjK$§uÎýª@cÚ¶„”49ªCšÌö¯êÑéZ5Ž™“„·…P³?R5ÑÛêðIê‡½¥Ì]lÅp|€}j0SÐuªz£=˜ó‚8¢¢Æ—8-Jc4-­yÅÖ«g¦øLï\"LÌWoÊÁ_Âµš¹­\'c¦¸¹šH[ÈTí¦k‰Žç\\‹\\Ž[‹“2¼^ ¥Béô¬b´:Ò¾§S¤]HÞ&I“{,JIÂúö®{ZºþÓñì¥L*¶á*íËg¸­anMN:­óègÚ†¹`Ø\"½Â¾V£]ß…`\nÇíšÊ+Þhénñ3[Rs&v?™«	#(ëów>•ÝË°¦ì§9æˆu)ž@¡\'¥8‰´z—‡<Étd2äüÇÚµþÌ1]i{§—\'ï°òp(¥aÜòëûãm‡nq‘Š­¤hÚ‹!’´ÙRüÀA’•†{Æ=¾•WÖÆÍir„þÖôG®5Q•*Ád\n=EbÞVTsi¡^A;™“îÖ\\º1«djø\næÓM·¿‹VÕ­–êá¹Vb¥O¦zb°õ¼¶¯wöiÃH\0nÝW+ZÈ\'ë³(i6ý£&æ/´®O©®ÂE‘ô¡i\"“.÷-éíYm#I-2SæsÕÏô¨dºç±o°lImmqy\"Ç\n;³\0­wþðWKOåãpˆu?ZÞ”ÕœÕªYXïã·XÑcB¢€ŽÂ¥ÛÅt(iQE+x®£(mQ ê,Eli—\"Êú)Á\nFWqì`Ý¦vÆ7Ö@±ÜGËyOr	S#/;IäN“KXme·µ„[4Ž\\°Ãn\'©®›]Êv<³]øqsw¬Oq§Ïo“±.Y¹Sßÿ\0¯\\—ˆ4“¡øŽÙ#bðI	\'÷ñÁýk.V‘éNºœcÐÞ°Ô,²B•Ý[¹Cé†$Šh½‘ÉÀ,Ià\nÆl‹Ü™lîe|H6ƒƒïW¬ô›ríæ¹b9\0wõ­)Ðî&ÏBð¼–VQ…†ÑÈ¿r>µÖ¬Â@H÷µÛÊ’Ðå«`J‡ƒïS,èÕ‹9Ú¶ƒ²L($ð;Y~Õ¬ÈÌsµ™­J\"–Û¶|§æô®I+Ìô£ðˆ¶—ðù¤xB…Y#m ’{æ¶¦Ôá[wHšD[yL,Ó)äOP}k®=Î9Y”–Òåæºkõ­÷-cnJãœþ5Èx¶ÒØé“Ásx‚böóÃóO¨ëS%îšÓÕØá­e´a9Š\"–ünžO—y™ô­mÔ¥ÁšQò&qîkk$u»îÍÛ‡,žha»½WG}ë ûÊÀƒ]ˆ•M=¤y	V½©í]F—¨	$[¤òçÁô£Ú¶Z!ÍhÍÅ„ÊûÔRCÿ\0âf›™!r¤ò+9£…«²UÕ™zÑP‰å<OD™›\\ crßwW±›9‘¹VR¤W,¾3±|%ë	…ª[$-n‰~Þ9ôõ­95˜¿´míâhçóù¤|Äg¦+¥|\'$£¨Ë‹k–˜C¦Ê[³´“MÞfz€ÙàŸ¡®#^žóMMGûKf¸0€¡IR¸#êþ…M¯tÒ†’Hó»fÞì\'Ú>KhØ1_aÚ»1æ¸†/9Q@j¢žŸ­aJ\'§]$Ò]Y\"\0`¨Ç4Ž(îÜ5º19åù€µŽäí]BÙ­õ’_YafŒä‘ÔCZEßB\'+jmhú¹›Î6N¹ãßÔ{õkS·IÌ‚sØ3Çµ9jsµiÛ\\{ÑX1Xñï]É6»$¥‰”¨cëž•ê¶äIic\\²~ñ×R)3Íô»˜­<A{ÛÝÏ™YB	Â€ ôÁÇóÚÃâM\"ÛD@‹wq®ño¸1ÚŸþ½lª[@­„wN;Ó<X×^*½¾7F}5 ÌQÆŸ,xõ÷ükŒñ_‹-üMp–ñ@vFÅÑ›Ôuý(•Ot¼>ûTßKsÚùþÎŠFr_ð­»I¿³,£¶˜ÜbpêÊßtý=>„TÂ|¦¸…z­[Íysn’ÙL\0@ÔT`ÞCi¢#‚ß{‘Zè1Zšö—	~‰,L7¶E÷½¤ÝÏ£Ý)S˜¤áéøÕ%fCZXÜºŠ7	}kÄNrGüójØÓï„ê°H£“ù0þ†´ò9í¥Œ[N{MH…‚R]	ùqê?\n+­LäîÏ0·c±O)B´XdOñ®«KÔRKt õ\0×îÎé.§›øæÎâÇ_’ö(ÙgÚÅ»oïU4‹›yn’(™Ê²ì›î“ŽáZ4va«®G	nuZŒvÖ—ÚL×Án$œÄ‡fÐ¼áº*Åkm6\0nqóÆ®±»„ŒúÕ2ZŠ2”3*éòElIç,kv<jªà¸dgÞ¡÷1”®ïÜÉ{=K@º&Þr-äaòîùAþ™­í;Ævâ5º€7$|Ë×ñ®ºnè˜£´ÑãÓ<Sk4‘CöKÈÈ%£ùwÐûÒ}’ú»”£Cu÷ú×BÕ\nÚØÓÓh^HK~é›­ØÖ¤7qÃpaT!I:ú{U£7H¹ây¯´	–-†,˜Ë6Õ-Û>Ç½-ªhðý6êGÊRM ²¢¶t×Ž‘;Þ¾Ù¯2Öf÷æ‰§)‚îÊH.U]­»§5æ~\"ðùÑïDHÛ —-=@÷­tw7´î—M‰0K;m`\\¨e=IÇ·­/ˆ„-o†hÙƒŠ1ŽsÙqÚ´µô!MÜçeÒ.ÒßÍ™d*pp½\05Õøzä(Ôÿ\0\n…üª+FÈØ¿ªÅÅ«!ç# ¦Øé¦ëNŽ+ˆ†Á‚	ê(¥+&Rv5të¡§xŽÇÉp¶ñ¡IPwSÅw:…±óh°C}EuÑøMZ³^dÐÈˆ³³\núœzÐqÑ¸Ã/Ý?îÖæ5#ÔÒŠò 	>mÊçøÁíE$gì¹µ<>êÎk[§È!ÃŸZtwÌLÛz©òæ¼éÇ©9t5 ¾i.Þ‹}œ°ùíW¤Ó¬n-82\' y”A\\ß—Ý¹`½¶ ´‹\'\0ô¸¦Ûxjt“ísl2(àãúV‘ÜçødX¸H6æ;(»¾PsT¿²çÑ€–=òFpÏíô¥XóDê‘­c<w$á«BF\"ùÆâ¹\"µ©“k¥ÜÜ_GpÍÄŽ¯p+¼¶¸¸6ïIÜ·ÍÏzô)«\"§+Ùe{‹‹Ù.G’@\0ÀzûÕ†¹3X$‘ð¶‘ìjî]E±hB÷VP¼y,‡9Wè¤ÈSQÐÈºÓ¡»l¨¡î+–Õ<>Öå|¢\\HJ·šäjçžŠšrýž9õÁ>ž•}õcÂ©\' ¨Z^ÓÜ/hî.^Y~}ÃŸJÖ1ŒdVˆæ›¼Žy/ímõY,e„FÎÄ¤ŸÂç®h¿•äJŽ€³’œóžáZ§}¸>hœì¶÷:V¢ŽÅ2”_n+nÎA©Œ¨ýÂ»jËÙûÅÃDmÙG›Ì#%.~¸â³ÿ\0µ#žù4µ$\'ñJ­ÑÇA]IhD_¿rôÍ,kr6[vGqô©tÅ—VÆTºgÔPm?#¥ðÜYGQHÀ÷¢¡³ÉÄTýã2b£h‡¥bŠ9ÍfÖ°‘DŠò|ÎEC§ø|ÜáåÊÇØw56úðXEm—ýéâ Ö¨G?â=ûFÐan#!‘|v5…c®›Plobu™Ër vúT·gszR¶‡Ekn549>dL£\'Óÿ\0¯[QÅoii\0Nüó]×S±laëZ±É§éì<×?¾îO©®+T¾Ô4—K²	 B	xú®=jkJÆ2ÓS_Iñ¤zœÈZ	9‰aÏÒº¸žéçVÃåbvü$úÕ)©«jz•Ù´äˆ’Y@$žæŠ–ÏkšM˜[!Ž Ø¯-Œ2È²:ËÐÔËÑ@täÔes@\nÑ†ŠÄÕ<?g¨ƒçÂ¼>†‹\\«Øãn-õÞîµ™çŒN>ð‡Ö­^x²KÈv‰äáÎîGÒ³çpV:éÔº±RÍÄ#“–c–5¢“£¬‚a}Jz™/£[A¨¥Å–nÜñÿ\0}«°Óu9mŸ~ÈÂ`p{â´S®¬z&“|—Ö\"TôÁ†ŠéZ«žeEË&Œí R`TšŠh+Í\04 =i…\04­Fc‹›¨ékt(úzÁ¸ðu´Ùwb$ç?—šL´ùL;¿j„˜X\\ í÷Z³EÓÛÉåÌ¯ú5sÎ7„îKöàÖµöøBÆ³F—±ßø&ërI	=W }(®Ø;Dóñ?Ä?ÿÙ\0ÿá9ghttp://ns.adobe.com/xap/1.0/\0<x:xmpmeta xmlns:x=\"adobe:ns:meta/\" x:xmptk=\"XMP Core 4.4.0\">\n	<rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\">\n		<rdf:Description rdf:about=\"\" xmlns:mwg-rs=\"http://www.metadataworkinggroup.com/schemas/regions/\" xmlns:stDim=\"http://ns.adobe.com/xap/1.0/sType/Dimensions#\" xmlns:apple-fi=\"http://ns.apple.com/faceinfo/1.0/\" xmlns:stArea=\"http://ns.adobe.com/xmp/sType/Area#\">\n			<mwg-rs:Regions rdf:parseType=\"Resource\">\n				<mwg-rs:AppliedToDimensions rdf:parseType=\"Resource\">\n					<stDim:w>3264</stDim:w>\n					<stDim:h>2448</stDim:h>\n					<stDim:unit>pixel</stDim:unit>\n				</mwg-rs:AppliedToDimensions>\n				<mwg-rs:RegionList>\n					<rdf:Bag>\n						<rdf:li rdf:parseType=\"Resource\">\n							<mwg-rs:Extensions rdf:parseType=\"Resource\">\n								<apple-fi:Timestamp>-264753123</apple-fi:Timestamp>\n								<apple-fi:ConfidenceLevel>281</apple-fi:ConfidenceLevel>\n								<apple-fi:FaceID>12</apple-fi:FaceID>\n								<apple-fi:AngleInfoRoll>270</apple-fi:AngleInfoRoll>\n							</mwg-rs:Extensions>\n							<mwg-rs:Area rdf:parseType=\"Resource\">\n								<stArea:y>0.802</stArea:y>\n								<stArea:w>0.141</stArea:w>\n								<stArea:unit>normalized</stArea:unit>\n								<stArea:x>0.342</stArea:x>\n								<stArea:h>0.188</stArea:h>\n							</mwg-rs:Area>\n							<mwg-rs:Type>Face</mwg-rs:Type>\n						</rdf:li>\n						<rdf:li rdf:parseType=\"Resource\">\n							<mwg-rs:Extensions rdf:parseType=\"Resource\">\n								<apple-fi:Timestamp>-264753123</apple-fi:Timestamp>\n								<apple-fi:FaceID>11</apple-fi:FaceID>\n								<apple-fi:ConfidenceLevel>277</apple-fi:ConfidenceLevel>\n								<apple-fi:AngleInfoYaw>45</apple-fi:AngleInfoYaw>\n								<apple-fi:AngleInfoRoll>270</apple-fi:AngleInfoRoll>\n							</mwg-rs:Extensions>\n							<mwg-rs:Area rdf:parseType=\"Resource\">\n								<stArea:y>0.618</stArea:y>\n								<stArea:w>0.159</stArea:w>\n								<stArea:unit>normalized</stArea:unit>\n								<stArea:x>0.273</stArea:x>\n								<stArea:h>0.212</stArea:h>\n							</mwg-rs:Area>\n							<mwg-rs:Type>Face</mwg-rs:Type>\n						</rdf:li>\n					</rdf:Bag>\n				</mwg-rs:RegionList>\n			</mwg-rs:Regions>\n		</rdf:Description>\n		<rdf:Description xmlns:xmp=\"http://ns.adobe.com/xap/1.0/\"><xmp:CreatorTool>Microsoft Windows Photo Viewer 6.2.9200.16384</xmp:CreatorTool></rdf:Description></rdf:RDF>\n</x:xmpmeta>\n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                   <?xpacket end=\'w\'?>ÿÛ\0C\0		\n\n\n\n		\n\n\n	ÿÛ\0C																																																			ÿÀ\0À	\"\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0	\nÿÄ\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁRÑð$3br‚	\n%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹ºÂÃÄÅÆÇÈÉÊÒÓÔÕÖ×ØÙÚáâãäåæçèéêñòóôõö÷øùúÿÄ\0\0\0\0\0\0\0\0	\nÿÄ\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3RðbrÑ\n$4á%ñ&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹ºÂÃÄÅÆÇÈÉÊÒÓÔÕÖ×ØÙÚâãäåæçèéêòóôõö÷øùúÿÚ\0\0\0?\0þ‚¡…aÚ%|yŒpGjšDòb‘°þt—0L‘[ª4»‰;GSô«QÛI=ºÄÉ¹\\|À×ã	3¡œ„ŽáË:i¤!@«»D‹nÊ\n9þÒ»)l¬­íÂÆ¸œ!îšç¤‚$Øî7°lGZÒ4û˜J]YRG&ØA«±¬.‚(ÈÃ¶3ýÓUn,§–EûªÜ¹Ú:åV„Ø[‰%¡ú×m-¢Ó3ãgS0’LB%(ã®}ñZ7z•­¹ó\\4‘…\n9äV;ÜËI5äa~Ñ À^psÚ£û\\ö³«B‹)¹R€?|×G´hÝ+ljÎm¦\'ÊCò©É5nÊÎØGæ6\\LHô÷5ÍÉo5„ÐËÙ›Í$Ê§¢ñÐS­µ	å™Äxq9¾k)Uoq¶[ŸL†;¹äUÀ\'yî)ñéI2²*™Ü·oñgµlYKeyb¢|Åv7œ|£=Ö§cˆ­ÉÂÍbÌœû4VRF%âuaHÇ‘Vh]ƒ@R5ásÐ×qwåÜ\\F±‚Ñí€zúêF†Ö|[•£ë‘Þ³’±~ÓK#…ó÷HˆÎa—ká5v]MØÂÇ¾0­O}dÊSË€¿ï¶çëQM¤Ÿ)÷’_ý‘ìi.ÆWèIc®=á„ªÝžÞõÒO¨»:[Å\'Þ_â>ÿ\0Jóßì¹,œQ¶mÀ’>òö­9\'¶`¹óQìœÞµŒzÛˆºNÉ$­è ÿ\0\nYáá›;ùÀ¹ñªJ÷‰>g„»c¿­_ŸPƒ<¿¾Îsè(ä¹´ˆ¿l-oHƒÀ3XëºuÌöSËXw›!‚É\0.xcžé_ÊÏí¨øXÞ$ˆæ4²»‚8hÁ…IèIõ¯ê‡öÔÕ-×Áú}¾ç2K©C<J£ˆ¤ÆÝÇ·?Ò¿’Ÿ—×z‡ŒüDÏre»mVpÌÝÊ¹úsÖ–%sPöoÔû>Ì*ÆQ¡N7»×Éu<ši¢¹Cºmî÷¬	4YŒ“]n\nÝ÷5¨Ö‹iiºÜíÊóŸZÌŽ[ÒTO!x‰Èô×‡ì™úÌeecSŽW0jM?Éb¡3ßžÕRSÛ)¸Q!+ÐöoX¶–æ6Š9<´f›Ö™§hÎöÅ­ÜN9É\'æÏÒ«ê‘IÕ{œ²Œ}¯:Ü¥,ÑËû•§¯j,ÿ\0Ð‹ÂSÒ‹…·•Ê\"fEÀ>ø«¦?4Fá„hoÓÉ-45Qvr!–îêÚE6 21ÉÏ­k¾½<–Æ$³Øà×7m4ÑÝ,s¡{q!ÇÞÑjV0Û¤Û–·.IÈ­iI%bcRN7‰ËßjjíÑâFQ±O½Ge¨On^[ÔY[Ë%OÝ\'½X¿Ò×S$º›&\0IþµRâ5¶Ø›vó¸½v§¬fñucï\"¥î³5ç‘¶ß;0eþÓ3GlÑ£LÛDmÎ;Õ{‹½…V8ÑÜnÇLúš²~ÎÐÑ²í\'pjê¥YDàÄb§VW›Ôç¢´‚©n…°[ye8cÛ?ãS›IÃHR<µ]–òÞxVÝîöŸ”÷ªóÈb{FcòïÀ½mí5ÎG‡Œ´ln—4¹»Ðl¸8Éë[òº­Ä3ÛîŽ4$c¹ÿ\0 m¢¸»·™¦kt…·mñVmõ2æéÚHdb¹#æÕ‚f5p±0ïoÕnœ3:¬ãÓ êE„ËmyY>Îï*îã9í[7&Ú%Žåc-21ŸáŽ÷*ìû!Û?JÊœb¥r)ÓŠ‘ZÞóai<Ü9«+xË›‰\\n<b ûåÕQE19©oa·\'#kÈ\0=ëÐ•TçÌÎª‘¼®d]K-ÄâdÆÔëôÍUºq©Ms®ô¥jÏoæ…Žßä…[¯÷‡¥6Sn‰`ù7‚2µÛCË¢9gsa6W,Õcóò¥ª`áÜ<¥FÓ¸Ö´¶óFË2É¿Œâ¢x’æ	.öÉmÉ@~õ{ðªùt8äôµŒ›XÅ¼ÌÉóí¬;¸I$íÈ$T^(€¬QNþsØTÖ³µæøEEUï\\Ó\\Û˜ª–0íâwmÃí2’£w¥,w/	šÖâ,™“†_á?áSK¸cœÛð3Ú eÜç!¯^ô¡æN«¾ƒd)\nþù¼»‚\0R;RÂÏ±A;åe<š‚uKÉ3˜ccwcSAn`(Bý× êèpT“Ü€¼¹ÆÒÈ¹äÿ\0i™Z(uË#¸¨#Y„Œ1ò¹Ç±É`ž)ZIŽQŸašÎ^k´sÆ¬ž¨æõÛ†|Å´˜¤^1é\\ÓZ\\Û*\\Â¶zJèµ’cÔ D…–$6ÞÍ*Ln`}ÐÃ^†IneVR’ÔìþGk¨ø‹NfËÉu7¹Ï5û5àkXŽƒfòÚ•gƒiÇÝR8ãÖ¿#>ÛJ¾\"ÑÞÎ%õ$C»¢î8ÉÇjýŠÑtû+8\"AnŠB†lr:üWÅ|T-Øûœ~á?RùÓí«-ìeÐHc×Þ©Ü¬SBýœ/©à{×M¯”§_9f`{\næ®f77ÉhÑ•Ž8Þ¿4§xË™GN|¤LñÆWóLm·ýÐ}=ªÒÇ4Ê·q¹ò±µAöëùS&ŠÒÕÚ0ßƒÀàTöÖMåIr°–·\'$/Sï]1«-Ù¯%õ1nã{Çh<£;Ê1ùÕûKÓ¡0$†w•‹³^üô¦E:™¤Hç’Ô•®˜:=¼‚DÏïAïŽÂªUXãJæäb7E‘%kwdŠih&gC	n¿{ ÷ª	n[t“¿“8ÇËÔýZ²Ú„ðºÚN q×ëïŠâ–÷*Tî¹YbIá’K}Ò<_)÷5‘kÃ	%©ˆ6\0ªÌ7³A!þÏ„n˜ü¸éïZ2˜RàA)(×=8Í)b$´9%„îX‚/\"H·ÜÇÆ#Û§msþ~NÓàù¬ èÎ^áJÆ2£–=9«ñZ †+…9i\\äœW8òÉ´jE-«5Ðy&,6äc½^Ei62©¹^zNŽXbØ¨¸ôŸ=Ô1°Þ6y‹ËzzºsKrùz™·;EÊ£>É8ÚÞþÕfXçÕ¢báF_>½xª·q[êJIµ rwŽ§Ú¦±WjÄÃ’oZô)é¨:fTºuÌ¾uÝ»‡‘ÏFéžõkE³º¸yî$¸;Uvm=ãZåšÐËºÌüž1QGv‡Z§”¬H<q]N­µ´¢ y\'Ê&{šÊ}°IªÂ8¥`3Ñ½jÔæW#—1ƒÒ’R²ßIiÊÂ—íÈþ+Ï©U±°‚ÝžhÏ›²\\`ÿ\0Z¾»Ï1®HNO¨<‘Âª©æ…ÜnõVÞ8mœn”³.pÆ±r%ˆ³ÎÒl0WÔÑ=Ì±n\0~Z¿›ö¥%Æ[8?Ý©ÖTx¤åÎ7w5p—CH3š1««)>Qea“ï_ü]?¹¸ŠiHŠÝˆÈìsýkìÛÙà[yß¹ž}+àßŒº¼’Cxbƒ{½À;OSÖ½¬’Mâ ¼ÎiË.ÇÆzýÀûk=›p9þWÍß›Ï¸Œ³(u9p½½+è½V›‡Ð„“Å|µñ–;¨áF-7%ÏÖ¿ª²çj1‹èÃó_Þâ\'V+wsË\'ÙdRv“Þ£7oòÃëŠ°Å#lHøÏ=ê—t¢A_¥z\n7<¾[-Ø’JûØšU‘_\nlçš‚&r	oF®2 Uy­7_ ¤”ÚdmÝ€ô§ˆžß³Ì2Žé`Ficf9…k:¾	=j%ätÁisÐü¦ÊdQ+mFPß}û>èòß|døkcjÎ®þ-²–\'Œd£¬ƒWÊß|»¹ÒÕÌ&2 á#¹ö¯ÐØŸÃ×Ú§íá¥«]Ûé×M<®7\nTß—*8¬uêV:”\\ý.x.Õ¤ðõƒ¡”ùQÆ®²õÞ¨3^£¦ùÜ´ð!ynU#-Ž˜õöÀiqÜizM’¾du†=Èwr~¦»m\"ì›¨äxÌz`ÖGÏÉjKñQðKÙ²‚.®â©ù‡óÅ|‘<Â‘QÜIÀ#–#®+í?Š>¤Ak}¦‰ ¸ûí\'Jà‚¿­|³<pÝ»B B&A#•úøÌÑÿ\0´HõðNÔÕŽ2×ÅW’Ánå—ÜsŸjÛµñ0Z¢\\Èf¸ÉŽ0QÕ|*ó;E\0T#$qÏ\\×>¾™Ø*<N/ÓÀ9îw¶W‘êÃq\0ýçñžâ˜ú-œÒ¼?kâLÔãÐt®F!{o+DòŒÄÃoµHÚ­úKñB¤€äûzÕs38\\Þ´µŽf´n&bÙ|òOr9ëYóøNþÌŠ€+¨8y­3^TdmFaåÉ)b½Nãß5×Çâ]2æ€gqïü85¤e}Í¯¹åÁ­i0N°Ú™Vb8jØë:£@`–!†@ûG9oS^©h¶$ÏÊŽ0äñS®‡b—7¾dY¦pU‡sõ©”µ$ç´Ú<°Û	ÈÂºX¼L÷÷°;\"¥´	³hêß­G\'…­üŒÛ\"Û˜ÈÜÊN}«\n]æÕËBL‹ž}Z‡P¸ÎÛ’ú®œÑ¬Qé7‚3¥f]Øi×%DlX*F:­yí¦³o¨a-åŠd£ gÜw­ÛKëØ‘7³K&ìñÓ&±4ÝÙ2ÕÜÑmä$r”Büb›wouk*$qÜì¦jõ¶¦cMÓ\"ÂêÄîç-Ÿð®ŸM¾¶¼€<ù!fÀYyõúV.š3ŠêgÙë,,!p,›\\ú‘ÁýkfÛZwHÈ“÷{‰½kHhö·Ö±Œ¬¬%Â²·ÝÇo¥Um;©Î\nGn£ˆ¿Æš)ÄÒ‹XIÿ\0ytøä.}\0¢I\"šëÍ´h?ÅXSèw©*Io\"ù88yâªOý¡k<PBIFuèl¤–¨å©Nç{FêÈN$”‘º¡m:Ù¦˜OiP–þ3í\\¬Òº8|Âºn&\nÒ³8ž~j#$\\$Ñ‰q Â‘ÌÅC¾üˆÇjÏ¼°»0À‘©óQÉW;MwP\\éÓZÍ3\\®T³ûÂ¦7Æ. rËÀÚÝTñ©jû{Wku`×QDí9?4„«‡ÄÙ~X†€Ä»7 çüú×s}¦¤±À×VââPÙU‚sëíøuïYÒè6ÓDð<k±òJvç¨¥Z™ÊZŸã;[ç*ìGìç¿ ­7^·‘§ò®G•°,˜=uÍyE×…–+Èã·‘¡h™Š/¯E Þ[0H¤‘Œ²(à\nì‹hÂ/±ìV·öÒ4Ú|6Àì˜ÏLôãÞµîb³¹·†)bËùà?û¾ÕäÐjgK¸hÉ0Íä>ö}jsâ]WíI3/›ÁF^gòçô­%W¹¼eÜôÍ	#Ûgp8a <Šç\'Òœ½ºÆà–•Ðäß~kVÓÄm*$·W!rŽ‹=ªÜ²/š IýÃê{×,¥sNdspi÷Q¼žh\nÄmã¡\'°¦Gy¨ÛÜ%ªÀRØ‚rˆÿ\0:ím5?’e¸³]¶£ç§áVg°·+HjÇ?LÔ˜œå–¸‘ÎËuy†ÖíŽõÑ¶¯êŒbH‰ÉÏ¥dÞh+pKv$À¥²1óJã®lµH‘àÝ-šE>óå’<Üý:Ö”ÀôY †ú?*!öA/Ë!ÏoZ›(|ÈïYFÀÇ©^Õçw:–¡hUæ,îà`¦£¸×oaØÒÂË*bÎ)J¡\\Ìïî~Ìðu·c°¤Ž3õ®{SÐl¤dxÕŠ“¸ƒÁÉëëN´ÔÓPž)eˆ	%@ /85´%†åãó.>@\0\'ñPª¶Í•IÔšçÉxËO©,ŸÝ€}³ÇåP¬ZÝ¶d{/*Ýµ³œ^¯d‘¬r£lpDì)ŒË{äÆÖÅ#”v#­tÓ™.¬ºžO/ˆÞC<$ª08=³[Öž\'˜Ú\'+;·#w\\ÿ\0ZÜÔ48>n€àcÔ7¦kŸÂþL²Î§ý°v¯9c[ÎµÖ¦J=Ž…µ¤ÝD7nŒuõõ®ÚÆöIì$y +¶!…Xzþ5ãSésÛÊ©÷q’:U_¶ÞÚBñ.é­ÕJ‘Ü×IßAj™ëSßA¨$1_…¹KF&Ë,úV]ö‘³)QÁ	Üíï\\N•âˆÈ†D\n°±#ðçñéZ«â}&âédµ¸˜É{ƒ‘±H<õù¨nû‰\"+ï‡Éoiy-¬‹Üö®ÊÀŽ™Ïzâ­´D\'yäòM¬[ŽP;W¹ÜH\'ºD7!â*>pzñO:rD ¿Ùõ©jû”|ùmâ-NØÅi°6lç`åyçÚºsã!-ÒÝOIr‘uN¤üñ^™.ax²=Ý¶ýèT‘÷—>•ÎËá„E’k‘åù’s~1UmL§.¦xšÒöV„\\±rLmÁn>•ÖE¨ZÝˆíL{ÄˆÔÿ\0ÑŸÏç^D†ÒKY¤ínË=}øéYÚ­¶½¡ÁöÒÓÛ:Ëû¦9åØu¼Vê£ÜZ½|imk6¢ÒÚ¤J6vrJäíÑü©WfòÀÞ®	îîæ[›èÉó8féš¶±Ilæ4mË€ÃÁ¯æ¯³ITÇ:Kd’ûŸùŸÐ~å*8ÖêÛf4vs[)•æY˜óòvúç®ÌcJÁÁeNj[–xro—8Á÷ªÑyH¡-ö.îÇÝÞ•ù\\§ÊÒîUž™ÉRaØzuRj{{˜­­Ö0¦IÂá:€i‘Ø#<K%ÙŽÙ¥Üížpk[Áms$XdSå¹êA®*õ¹®˜1·’Z¬¤r\'\0˜ëÒ¢kT•PFpb9U=ô¤š”(|´|LÔ<1ÌŠÊ%hÀ^Œ+=,l¶ÐÎ‘Q#T\'tÉ)ãÐVMÔ—;”[¹yHÊïs[q,3ÂÌÃ8=È¢æd³EVûîx­¥&Õ™¼bÌ{›i–Þ9Ba]‡Ê¿Â{ûÒÙDËt’9%ƒŽ§è*òÝ;ÂÁ£Ÿ {\nž[Y-¤†åH*#ëžC±~Bƒ\"›ÄÄÙæ©ý£Êic ’ˆG\0ŸzT¼g)þè±ÏÍQh¥Øù‚wŽB[#íYK%N†(«óUdX–ýñŠÓŠÕàDI$Ú{‚±c¸N>R²;+YîßÍf—äxcÎ+±$R[iZgwo%r@Í_ó~Û#Û°ù#\0`ôÅ$Q¼‘³;î‰ úŠµGa1&æn3é]4§%©jE(¬öÌNæ!¹Ó5¢Ö…­|¶Ož\nÿ\0QQ	g1ÉÍÿ\0s>µvÇíK%ÄÓFªŠƒ9Ýøz×]\\eIünæ±­%¢2îmBù»¢…$}ê­wgo5½µÊ9i\\äc¶=k¤da.ÛÌŽCòä÷=…6TµHÀÈ³ûÀŠQõdÊrz³µ°û¢ÇÈÉ9üjËÙ¬Ûòü VÃD²#G¸ª“ò°íP¬’bç|›@Bœî®ÿ\0¬Ka:ò(ËÇ°_–t:\\ŠÏ<Nc.cO4å½A®ƒìÈÿ\0g”…ÝŸ|Ó®RŽåxÁ=ÿ\0\nÊ·,ÝäsÕ—6æSi¤ÄB§ír[ê*C¥ÑvlXþÿ\0¸5¥kèI na»ê*µÌ’üî£$6ÖÏJºT\"ÑœRNå…·…¦ŒY&ØÓš’Vº¶¬“¬LË¸Ï–zÆ<ÕŒ3áXöê+âãÊ™¢ÉiÜn…a‰‡2I”	müÄ+#îGrr;úqÖ›±‚àÊ¡ÒÀÿ\0lcùþtËSqu™„*›={ÖŸÎR¹R\"zþ5Ë:j÷gS­e¡t€ë²Ú|áOñÒCm.ž†agÜ?ÙÍt³¹XvÂBÓîi$MlÈì%›i š®VÎ*•/©†/¤µg)9ØëÀ#•?áÞªyÒs3ïIŠµòI#Cgf#ÞÀçŠmœP^Ú<œ˜Y¶;öÏµfè©@!0³d¸67t¬Ö¶y¥ÈVHç¹ô­»kycƒrçöj”É2Ý!òþVÀaèk7KA¹Žˆ*¿<õ¦Ï:FbÉ-.3Ç ª×0L³!…œãÐ}iñÇµçšqÁ@NzqþF„or½¡¤º„„Ff™Uº.î?úÕEÌŒäÇ\"ÀÎIÿ\0$ò®|/’qœ÷ªò„@å-¾8ò+Õ¥^Q\\¦>É6îXd‚Žó7˜$Ü0:‚þ%Ô|—îDf$ýk_	]„ÒŸ!$8céQ‰ü×/h7BŒ:ñœÕJ§6çM(òèrƒ€K&ì=«Cä*$aû¸›q>Ÿ…ei;@ðCn¾X˜¶@çuÞ)\\m%Ï5‘»+@à>7œHXw¥Ž`—!2Ldz}ÓR¸ŽYœ\0;V¬¶òÅ—ùŸwB+Ç˜â¯b´ˆ²Bï ,Êr1ÛëTZ0auPyù±ï[ev»–Ï’SÍgy¶ëpÊ(•On2+xG©ÇR™ÌIkæ¡ Âs××Ö¼¯]øaá`O­áø®å–Fuç÷oÙ‡¸¯}Ž%e™ÏÌ¬˜ìk.kfË²ñƒï^Æ,=ER›Ôå«…SøÎÿ\0þÆµë}VÚîÕ¯cb¨„°þØÏû]ÿ\0\nøOÆßðNÏØ^ZCá­NÓ[ÒõcçÌJ4OÝÇÍœP>•ûÜºW3²\0O(•cXÏ¢G\n¼Iæ«¹Ê?ðjý$ñ7º¤ÓO£_ågøžn#$£Q¾xÞçóãŸØ¿âÿ\0ƒ]æ¿ðúêÅ+ˆçµ‘ð2pÎdzšð½gáÞ±§Z½åå¤°¯˜c,q€Êz{Šþ¸®ü3§Ì·wPÇµç9ÿ\0ñ?þÍ¿üP¾£á;3¶1º$k´/P@Æ2+õL§ÇJRŸ.*6^ZŸ.\0¤åh½åb=%\"’_LÔqY½¼l7Hz\nþüyÿ\0ñð´°ÝxWW‡@’+?-#–3ˆHôÁ9èµð—Ž`‰vŸm]WP¶K–Ùµ¶ÈÊ;í#w`ýânS‰K–¥›ï¡ó9Ÿb)Iª^ôV¿×Có¢ygž\'[w¢ãi=qSéz¶¡kå´glÐ6Dž•ê¾\'øñ;@¸KwðF¡å4†2Â\'à_—¯×æWZ|š|“Aå˜Þ+\"‘Ê‘ë_eN¼+CžéŸŠÃJpš³Fö™ãísFº{‹öY§ÊÉŒe‡å_tü!ÿ\0‚™þÖ_.¬fð¯ÅÍi¬í£U0K2ìP§ŒÐ{ŠüÚšà,È™%EP–îææ	ÌhQ1Ï°ª4õ<Ê´SÔþ§~ÁÁ¿¢-¾.iPüFÓ¾ÍvÌ%Øñ\0>v	„~5ú«ð·þ;û.ø¿D’ë_ñ5Ç†üK˜ÓÈ»„”ºd‡Ï½>•üY]Ý[\"2NpªÖ·—ÆÃmœ¤‘¸±\\ü§=kÎ–Í´yËù9¹zŸé¡ðÓöŒðWÄô7:Ò5ql®¥$UXôÆO©\'Ò¾„}^ÇM²†âóQµ‹sÊ$_œœq_åÿ\0ð×ö…ø“ðÞñï¼ãßÉqû¹M›`L£¡ ädvé_¤ÿ\0	ÿ\0à±ßµoÃ‹m+K¸ñGü\'ú>xe¸¶Õ‚î»^>PUT\\O½B¡+“õY­ï}jÆê[w´º_=&$íôþ\\þ5›«xÃž%Ýˆôû]zÑ†ÒŒr$Ü0C`þ•üÈ|4ÿ\0‚ìü:ÒôÅÑüiàX¬®ÌÉ-Â™Lq4Ýv`³nOwÁ¯¥¾ÁC|ñP»¹ð×Ä‰uX\'C<)ä„òØŽd@VDÇLqÇñW](É£ž­F¾#ô¯â?ìû*|Mó\\ø]i£?˜Î¯³êÔ×åÇø7×à7Œ§mÀ:·Ù<I©M ÚÊ\"KUr›Ir­×ºsé_¥?¿jßíí>êmgL-œ¡|Ø]LrÎ<²Ò1#¹èE}c¢øŸCÔ\'†{kÑ}¢?Èx0Îé‘[ª–4Ž+¹üC|nÿ\0‚~Ô K¿†Þg}IáÒŸ,¡Ñ1ŸcŸ­|)©þÆßµg…õ[ÝRøG~/ô¶E* îfn0•Iüõþ’±ëKl™öF¤þï³Cìk–Öl<ã·Ÿ_ð¥®¥4ÊLÑñŽ™0r;ƒï]ñ©hoéŸç	ã¯Ø—öŒ·ÑìõCáü×6rLQ£¶pÒDÃ®äÀoÐ×#áŸØö™ñRÅq¦|:½¶Šy6¯ÛÆ\'\0’Gß¦;×úøóö_øc®Û,z7šyFøIÞ“Ü–É÷ÆûÕòGŒÿ\0b/èócÁZì:Å£nÙHrÄ(;Š7aÙqzéŽ;±¼1Vw?1ÿ\0°ý¦ì ¸Ò¬žI\"ÞÍ¡ÄgÓäßþ>Õ£¦~Áß´Þ§-×c´´ÑÚâââ]¢@£$Æ¤nlaž•ý2x—Àß<f‹ÄöŸmå—iŠ7”\0í»\0dqÅ|›ûF|QºðgÃKVµ¸h.£µ’Ü¹/#}Ñ´ö=úqšÕæ6^öÇ±„ÌëNJœ#vÏÀ-^Ñô”]&ëþ>l›PMst\"T,ø|ðßÝÿ\0ëÖÖ½xooÍõä%ìòìzêMV[8®Bª$\\û×æøÊÎNÝÙ\'ZRI2ç›yQ0;ZSŒ¯SF«\"G³þbÝ&˜Îš~Á1ß‚psÈ¬‹»Ã1§*Í¿ZÂUÙ…J³–åÏ\"a”«:÷ëŠÏ·kk8¤ä ,wÞ›=Üqykt¥ÎÂ9ííô¬¨ œÏ½HHØä¯­ªå£\"šÖæº›uMðÌ|æbÙn1UÖ	™™Ã£¹$zY/%¼vgc{tÚ„xïYéz \nÜ÷ª\\´+ë\nž¯©jìF\"ƒ1Ëp~ÿ\0ð¨õ5j&XÔnÃ4‡z\nÏºw¸¡LJ§9þñ­-9 ŸÉ[•>rIÇ¡®©NN¬ðq˜(U¬ç§aàÿ\0Xø£XÓôBYÛT½DdS‚ÉÕ¹9çn{WÓŸ¶‰æÓì|%àèâo/EÒáHe?òÎ ›V0>ƒ&¨~Î	¶Õ¼RÞ%1Jéá˜¼öhˆÄgœ1Ï^†¾{ý¢¼cÿ\0	?‹|Kz/d»–	Š$Ž0²Îôtâ¢ŽÊJH¬Ë5Œ¯d|ã[ñ¨nD:7ë^¥û*øüiñoÀº0Ô$Óïo|@’\'–lÛüàñÎ;×^Ou4ÅÝ	ß!?S_®?ðL…w÷¾4Õþ$ÌiÖÐ8v÷‘pWqázòG8…}•rÃ•t>S%g\'ØýÏøw Zèz¾‰j¹³Ó,PDWøGN+Ø´«†¶…\0G ç¯5Àx~ÎêÖÖ9%˜q\0ƒÇÓð®¦-I‹By~XáÇVÿ\0ë\näå¹ñ	BÚÜ2$è·ó<lG…Isòœ’¡Bd.z)®bÚæá¤wØ#‰8Nõ½c©­É$9À*Aô¬ý‡fe(EîmÛGä´[áp€û(ªò:©*¢S·’—¨kæÊãÐV¬S<p”(\\²a³ü5Œè¤iQOBõ½ÛÞCòÂ|ëeÂ“üF¶­oXJ»m¸XñŽÀ×7mÊå	1£œqÚ¶m>Ì®ä>Í£$½ròØë.üÛ˜™ºùZIU¾pÃUYžS‚Õ2;‘UŒÞRH¶í4•É3O™­†§cN98¶;3(l¯Ö­.¡sp3ùk	Í%Œ‰¬1HJË$‡ yü;Sæ´2< 0ÁÇ±©u¯¹\\ï¨Û‡*ë$HdG$dõ–›Öf±.`ÕÍ«…-ç;*\0rNÜg€3¯Níx^m¾cã>¸¤ê]ê)Jæå¤òy®÷*#É;@=?ýtûÅ0¾ÔßGz‰¢K¨™K	g*Oj©,WJ‘&á$E€988­\'šÇAá’(ZI?îÿ\0$òCpÄÚÊƒ µb­˜·I¼ù•d\0g=5rÊi-ogÌHÏ³\nÆRw»=ÍDkUˆ(¿Ÿ—û§Þ«Åqpì…ÕÎ¨f	 »–âFEV\nO=ù¢`ÖH×Ëe ¾¾µ“•‰”nYŠxc2ñ.pÍü&® ¸užwTx‚¦Ã“œrOù5Vçìïk´N®ç’GLÕ›O9!¨Ê¶2	â¥O¸£Z\\º£Ë$&W€Õ§m/ÚGRÈÙýš«ªY0©’\n÷?…Ko\'”f½1ëRÙi–§\" C¢5Ü	î*w¸!‚/\'ÎÞÙnùúVHu9Ë¹iŠ\"G€rÄþ|þ5¯rÖFá¡Š6‚Xc›±#¨®¸iª&reãä²)aÀ\\{­U´_ô¢Îv«ÆQ}øTl³È†5ilc\'\0ûýjâ¶Äò‹¶Ä¡³ëVs¹;Ë»lp]â8Í=#ŸÈf`ØÁçüšÏ†m’+É°0bX¸=…iÇ\'™ }¡\"B@=êcžS¶¤¤xÐu†F*£#}*öÖh‘þxØêiŽÏ#K8>¸¨¢{”ó!Ý¼ã=n¢sÎµÍ2É,1ÚäÂ¬ÀöÏzÚÓQac(hã@A=ó×üæ¹¨÷Î‚à¾É#\'²ÖœW!Bb0J¬G´/Fù¥º´3-ªÀ¤1^Lƒ=j³h\"½‘Cûå1ME	z¯0Ù²\nût­;rÅ¤32–/€ËßjÞ¤ÊWÜµ+È¶æÇsÙ«ZrÍoæYd]Éx\\ÿ\0Ôâ„±ži|¨ØotÜIè+m’Ñço!FìqSìÌ*E	f™wx“÷/Ö?ß±­Hvy­îhÆ>SÐçëUÙ6ºº6\"nm¥rJèª1ž2:×DbÑÍcZ9!†5¦ó	É#€~µ±imk+Ä×+óBÁ=Ç§áXÖ2Á\"I\nÆ]Á úÜ¶mPë…RqíŠèú5c¦ò•Œ-ŒÊY°OðñÚ¦¼›ä\\¾ÌûœUx$óG›\\ è;ã¯ã[×–1²[Ï“$Ž\0¿?á[)K—”N£ååèmØ™¦<ƒœu®›MFóy±•Ys×\"±ô»wÊ#à`’Ã½tö±¼“”Eùw~ƒúÚ”lgZwV7¬‰W,{Ðø\néìd”‘•åp29éé\\Ìt€K:Hƒå `õãÖ»­2ªHŠÇ’[ÌÇéí^Í$yÕ$tV~íFÿ\0Ûò®ÃJ±¸ˆ€X©|~U‘cm(NÀÒ>èk©…<¹ÄŠŸ¼Ï í]tÎînÛYI-È¨m©0õú\ném-BOæKôuÇ=ª*6ÙûÃ¸¦N=+poeÊ¯9â´¹tàU[hd•C1ÚŒH¯²H|ŽFê­§Ìì%]¬§·z¿BgmÏåÈIÆ;{ÔÍè{¸Z‹kgKæ ùŠ…9ô«”€m\0ÔµÏ=¢¥QX¶\n(¢€\n(¢€\n(¢€\",ŠÈzÂ¹Ò YBÏ´’NÑÐÿ\0õë ¦°-‘ž1[Ó«ÊrWÃsî~]ÜÝ[LÃím<1 #ÒIVÙv±Þ@äs‘ÛÉr\'\0™ÝžœÓÅ·Ù¤ŽÚLˆØƒŸc_’ªHõªJÆÜ:›µd‹ÌPÜÚ¬\"Á?žÒ’!Q×¸®u£08Û)ÜÌxíQ[\\‰à%‡˜Nìw>µirwWgU¼P:‘ßs­HúWšHíß$îÿ\0•Hjž—d„¶‰rýÀVÏö‹ìhgq\"ã¯p*­¥ÊÉµ„:„†$ÎÂåsýÜSåÒ³™_ÞB~F­hœ&é‚m„Ë×ÜÖë[-Í¸T>SÊ§nzïMÞ×:c+2Ø‘™‰ù\0ù˜ôƒ<SCq?ÙÔÜ×5é‚Å­”G:«æ>@åsY‘!œÙìØ œ95DlÏ>H§™™öyEr:µl[ÍwjìdB_½q]+iíöó,pl…F\nâÇëT%´k·º”P¤ü¿Êª;“8Çs9nÛÌÞX<»÷ã9ÛŸÖ¯[ê‘Á1YT™¦jÁ’ÒHˆÁÜò*½Ç™qäÏjªY’	éô§4`ÏDŽñnÕ\"t	€9õ5ZéVÔiÏ™À®M§ºX¡h˜, üØéõ§É«ÜR·#¿Ã«{Ô¤™n+æ¹wO,2	Êÿ\0Ãñ«&È­Ü’S¨#ñ¬Ø)dIÔgàûæº{xQ¢y‹?–pTw1‰w£I02™ŒO;}ëŸ—O™òáÝ…v,·1ˆ#\\`žWÒ±Ý,ò-Üaáv;qÈP=khS5Œ‘ùóûeÛÞŸEpdcÜów\":ð£¨`Oå_ÊßÅ›ÿ\0¶x³Ä6R[,YxŠö Sø•$*yêQ_¶¹Ã!ï¤Kk;]M&ûB¶Z(H;°1×‚:9¯åCâ©s¨ø†îæÊHT™ž²€ÄøÔâ¨¯ewÜûîtÔ¥\'¿èy>¬uXÂ¾`*sÒ³$/K@ªË2}ÕoSÜ×Rú‚ZÏreUIvî\\ôb{}köú	U¼È—{s“ï_)*îö?Ku!Õ™Ö—©-¬–®|É‡¯sšè´ÉôË;k†kr%Ûøq1¬qNïÛ¼–ÏjÑûTGd·ùÎ\n;‘ÜÖn­Ìý¼.É8%º™ä…U¹aŽÕMðy\n›\'?ÅY O=ã4n<‚Àî>•­*Z±ÂBc›Ö‡n¦q­tâŠñÈâë” zû{ÖûH¶ÈÒ·˜ŠÇ?v£ŽÙAŒùŒ§©ª×qyû–8úÓŠ7(ÁÄÊ¸É$É»x®xÜÍ,Ó‚Ù‰Â®É¼Ïöw¼¨e9ÏCM¸w}é\n„ò2}+¾ŒYçâ*;‘GóïE$|U‹Ö•¢Iƒ9UõÏµU»/i$–Nõ^yîf†>tDwÅèy‘=´´²3®%+À=êÔP-È*#É¶—#ýœÖ Ë‰žo.7Ú9“XrbwòcË;ÙïŠ™¶mJª›$¸Žx[&|9n3ïIÌ±N)W`x*8Ï½V¾‘Ÿìò4ŠÒFû€\'½&çeû™V8À¬*\\êu4|Ùg{‰î°ë&\0ö«{y‚˜0#RKc½Y¶#…¬™7\'$Ÿ­g$qEæ—fùI?Z˜ÆæoÐfÁfºˆ™e•Øz}k>hæ¾Š%’æ‡$H{VŒ‘Ê›^DÚ„ƒÍ=Ù°ñòÙO—=keÔ™ÎEUSfnYgî{U?:ÇyÒ±·žÕ5´qÊ²KyÒ6AÏEÅE!x¶íM¹pN;Ö±i3’s–æ.Ì«$›rp‹íTm–â9î#”‰°§™®ºO²<Ñ»›`PqÞ²¥®®†Æ)\nŸ™Ïp+Ö§ŠoK²Mu2o%Á\02ãŠ#´·¶F¸EÜø¯aíPÜÆ¢W[XœŽ•“…|õe†hí]³’S±z›FŽOµAåäçµÇO’iJËå·WÐVï$æ,\\à·SU HþÑ#H€©RTbbæÈ|èÑíÝ,c­Mæ³7úæY£\\Ž+VÞ,0h¡ÁÎN{šÌÉ¾–IP²KÀÇ85º‘ƒÉ–o*;Ëî$1ô©í¾ÒÈešl¡pœäõêvG¹f!ÖP@SKå4®»]•™Båv­)Å-—²åZõ;»y$\07VÏj ±#‡˜¦\0ý1YzŒQÛM#Èv¹b>µjÊýZÙá•Rx>ÕßMYò«m¢~À³øŽÖmù‚POb¼×ë‡–ÐZÚEˆg¨áŽ+òçö]ÓVóÅÒOh‹L·’gÞ2¸\'{‚~•ú££Û[Meù~l3ÇŒ…~â=U}Ÿd}ç;á“~f³­Ä…¦b¬ŒÛFOLV3YÎo–íHDHðÅ»f®µ›Ã10»·‚ÀóúSšÚiG˜¬<²ü)þ#_ë­ Œ™Ì]Ivg{s	™·pTñ]SYÛ”`dNTô³Æ°dù•ˆzç5NëÎ[c<Ë·l˜¹5^ÖêÈëŒŒ’>Í¨BÐÚ\"Ip¤»¸íZþ\\1l ùÎGzÌ…dòiäPÅÉ{\nî#³CºÊÊ‰:‚»»’**L»²‚¼­²¢qJ7÷RÔï­¦H™£o·‰ÜGß\"´\"Kˆ<Ô”	!WÈÅBòZÉt±„ê{×5J¢ ÓÙ&‰\"*DÐ@ì¹­Œïi¤Aæ.*Ë[¹ŠAj|©0X{ÕD¾e½»;˜Ã½c{êRÚ±|‰¼ÕqíZ¼blìˆ DO@;šË­g{5ÃnxösŽæ­ØÌÒùåyÎ\nÕÆ0b¾Û4kÙÕç_3hDêÆ´#™ïÄhñ}ÌYÁ9Á58„E%9vn3ü>õ‹\'ÚÖð[¼ƒç~ðÿ\0ÿ\0Z¢TP_¡m5´ÆYSiYöo¥^±º¼{‰2íYÊ²ŽqWQ¼¼ÁqyXçÓÔU	ÂöE¸lõÅlë=¯µ{2ÅôÎ¨6™ŽA\'±©të)V52ÌÈŠÝmmß{y­´Î¢Ò¯KI!‘>bN?•)Tl­¥ÖäÆ\"L$¤éTÒp\'hd\\9àIýïj›ío4ØnhÁuaþ5LEàÉ>Ù\\eG¥e)1É,•¡uÎ3éP3¬OåczÆN94¶ÆéívHØ`Hü3R¨’ÝÖ@»×nw7­\"Ì§Ð±ardpUü¬vÅk¹Œ´žc.Ð£$õ\0ÖÕ¤±Èé&fï¢ƒÆjAæII(ÀgÞª1].¤z¢ÛEcz×hRÁ¹aüGÛÜWæÇÆ-M¢¼»1(qs!EìƒkôSÄr½æƒ©Yí1››vŽ?öHéšüÁñÝå¨žââõ¾xäaÏ|W»ÃØiO¹ì*µ¹`ÛÐùÒòVk+É¼à\"O3xþè¯òoŠ\\Ýß·rvHq»¸¯§5.¹£“Ú™Á5òç‰®R{ù¢‰±åŒ}+ú²…>XÙ‰Õ«}NNp\'i$eè8>•Ëï„­*Ì_ÊG;œöïW¢óY–”u®øœSëˆþPcn†ÁX|cê)/6 ÄoóÛœÔ‹0+Ê6=6Ìbõ“²>QF@È±­uºó ,ëûüð+.Ø<AäÆïO­Y¤i’GÅÍ`uS=§À>zZº°ýî	L{õÍ~¦ÿ\0Á64IµŸŽ®´¨é†<0É#GºK—ùI\'²íçÕù…á˜Zto!å·zWí7üD´¶ºñÞºd”j¥¬qãäŸË!Ùº†\0zçÔTÏbkEÚçî¥„7	(YDQ²¿ÿ\0¬×m ZÅy²æE¸òO¸›‚ö®¥vÄÁwêØ¯CðŒß:0Vhóå¸ïžÔWVyåßµ{ãsk¦Ã\'Ú\\`üÌpr:“é^&¥qg$äo’yá¿­}ñB+	/(B}­ \\î¸<þâš–‚·VP¬²”»$6ÐzgÒ¾+Ö‘ëÐøÌÉâ»[Èðd6¿7ºæ·´Ýn³û=ó	îcRD£«ŽÞÜWþŽÓ~ÙŒ·~qÞ­¶\'íOæF€ã…rI»Ó7–Î†kÈÐHG,z“WWHAòŽ^^@=Ø××÷šff%ãD;[ë¬°Öï x\nœäñÖ”Ù\n:Ö<<°<\03üØ8èµ•.}3éàf\"¿{øòyÇ^~¼Waÿ\0	žUvÉëÞ´úÖécùRè\0íU ™È[jº¥œ»eMÉ´qé]\'‡ü`²¼éu#>Çã#aô­{hìo|ËULs©Ûµ]—Â6HðªÃ¶õˆbõÁíŽ”îE ëv·0Ü,§_âÐAy¥ÞŒŠSn3žEy¢øn{y£o8ªFç8î=ë\nâÏV¶¿bšÙ_r²{Ö.DI6zÍ¼k,óÅŸ%NF{óÞœú4²ÅyIK¿ÃŸLçŠá,µBÝd!‰œt º¨<Q4)žI.y<rsïéÆ—´¹”¹¬ž’tÌLKnù‰¿ÿ\0\\ÖEå¶±mŠÞ’V#Üã§<ãñ®Øk0ÜZÆé\'”T`{šÔŽÿ\0N¸†9¥Ý=²W\\Q“<ÎÃP×l£•î-LŽ1”C…_§ç]™âÛøne~Ldõ•ÓIok>é!%•Ï\0ÖdþÓ§	4<2³’ÃŒbª1¸›×rK_&§raü…Û§®}+¤íré$K,rG‚½sPxr(Nè-ÃÉ\"s*÷Ç¯Ò«6›¨´ÑÈ.î¤#ƒ÷¾µN6Z”tWVvª#¹$g¨ªòhÉq±æi\0çX—“ê²©S¹vƒ³Ÿ—Ðf­¿‰R	á±‘üã¹U	ô?¥JÜ¸Å®ŸvFWù`V`:Çõ5›§¬Úi£9ó_ä	Çóé]¬^È+r×k€Of=°=i÷öðN°KÂF–R›Wøqï[¥ÐÑ-,ÊQx©Ú×z\"Î‚Ò0õÁ©­µØ.¶ÌÈ<®qÉüè—@XmÙ£Q¶lå1××ó®_ûQŠØ+Ú2 v €vŸ¡5ª‹&I‡ºuâ³ Y¯Puîƒü+^ÁGÙÝ]79n®+ÇãƒY³{ˆÕ¤†	mŠ•AËn÷ÿ\0ëÖöâMbÖæ2ý¤;páô¬ù™*½Î¹ô˜34›G› 9Èë“RØxzÖâãœ*ºpçõ™ˆ§–áÛ“€îÿ\0×Ú´cÔÑdÁfiiQéïC—pl¯©xJ\'d‰ÜüÑ†p?ýuB=kOªn£ í ç\0wúšô	ïæÞ(„1™É8 {}jìq+[ÛÈ¤7œÇ öÇ,gœZßÜ3,’e¿1ž\0¾}kxk±¾ÈgE•‘†î>µkQÒì$‘cdáÏÌ£ ÅTŸÂ±]$WDˆÈÂ0ojÛ:4º¶—N3Bvù B£ÜV-´ù‚æó³Îz=ó\\þ¯g«Y@|¸åy #åÇÍÐŸjÈ†çX…&\"vYpLlÃ;[ééS)X‰Iž’ša“!ã^@Ïð\n†o\n[KÜÂ¦æìåNî7.¥ai>!gDKéš€.ãëß5ÑZë€«´mi@Êîæ¹åP¨¶÷9ÖðuÉi’©%Á>¾•^[í>Ü-´eÔ™={WwÌw/åÈV%„ül=)o\nÊ‚m‘!8²jã.§\\cÐóK=nöÊFódƒŽ…}ë£Å$6fy7ËhÄ&8=s[Sè\\ê®¶þmË S!<‘éé\\½ç„n`Ùyå[<¿_Àþ½tFeÊ\nÇH÷Ðj²6ÂÉj°‡÷É«–óßgœ%‹¢…èpú†‘uj°•w9ÄeˆšÅƒS¾Ñ§–ÅãâX3ƒ’\'ó¦ê™»º\nÙýéoò+.k{Ó—l‰•!xÝ\\‹ø¹Ñ—Ï·*ÄHää÷­U×-®$g†vòÎçÀ8Ù#õ57êe+¶dkžƒìÜ#mýÛsŽÛ=ù®&ÇÂÚ„S¬ñ]˜£©Ô·lŽ˜¯oKÛMBÆeUY¡xóÇñÏzl–“Dëê¾c_jc~g‘¤úå”r%ÌísðÊ¬y\0‚¶­ü{¨£%Äî\nŸC“õÉÿ\0\nô	ôk7F¸K}ËŒlô>£½sóøSNÕ?ÔÌÖ[ó£ lúÒ%²;ˆt·M×mdfÚ°ã\'·éô®Æ;=¤LÊ^N¥OC^[wðÕã¸G±î4Ü|Â\0>ý«>æ~	á··šE˜ï\'¿ÔÓ¹„ž§¸Û+DË$þE¼êJªôïVu¢éhDÅ\\!yÏÓÞ¾Ä^#ÒšI¤¶–ô<¤Êé÷ÈmãÖºwñóÝÆVîÝ¬ÕP6%‡½!ÆïC._ô›û¨¡@–&6uÔþ5$šzAÜ:·E9üëK»¶òâùY\"yX©é{Ô‘H’\\\\\"6C1ëßü“Äø—‰ÅÎ£îÏëÂ,>’èMv.G\"¢Ok‚÷ÏåÍQŸtP2«‰ºç¸5`ÊÂU·ÜÅ·dŠ‘-ZåÊÝ91ä…Øû×ÈVo›¹^ÆÑ•€`n¤äúÖŒN—; Œ³m|`t$zÓâ·x¤Û!Ì\0qŠÑHcŠÞIB…PÝ»×ãp{Ü­z°²ˆwî¹@»°z/¥bÉÌìðÆFÃƒëV™<ë‰.¤ÎÆŒ\0|zÕ–2¡T‚1´€wù¦©3+U·¹K‡|ÊØØÕ‰)®\nÜ)uVÈ«wbê ïaËz\nªÍ™¤iÆ±ä)þðõ¢Q:iÌcØï—pù6x54öë$fUFÈÉªÆÐÌÊby3qò€;ÖÐµh¡[{–%0Jÿ\0ö÷®yìn¼Ì! š9AÊ²óŽ¨ÆLpÊŒÄîMnÏÙ¢}©\0£·ñýi‘CöøÚA4qG\'Õ½…cìï¨Šá£UY‡f#¯sV<§¸¶œí*ˆ\0*$}jœQÛ–(£†ÈÇ¿s[Þ^a>\\¥™3¿Ó5Ñ]Ì‡\nepä¯<þ5j-HÙºùàº\"óÅM{‚D¹VG9Çñ}iÒ@ÊŽV¼‹©š•÷$mN²|ÖÎx$Z°JÊ’6ÌœàVOú;Z•x™Êý­YcY!,\"ˆ÷`?­.DZ.~ëËPé“æÝ¨¹,I–óŽ*¤w‰ðÈÁùºbž.7™ðˆÊp{(«öch©ÀR¨§\'µN†¬0ªGÞéÑ»´AwÜTW1ìtŠ\"f!†ì{Ö¶³jÂ_2_‘þ^€Ÿàö«7+™šW2nIö¬Ï*ÙO”¬Ø\'z½XâV°Æ6C]tüÌRIf[ˆ’Ø3[Uê*Åå“í]ÄcÎ7P/œ\"ù<àž„Ÿð¨ïÚKŸ!e“>KnÝŽõ×4ÌÙRÖe†K[}Ž 	1Ÿ›ž¿þªMB/>p@AúV„·Éñ²4³¯÷W×ñ¨¥‰.$›lc¦Úå«5c^c6ß6ö¶ècÜŒ»‡­h³Š]×÷²©õæ¤u[p¢³¤§i^¸ªÓA´–à¯S^\\äžÂÕì@¶¢ñíáV\'85Bê0<¡åù~caIàÎ®$Ík\"ÉnN7v=ªfÝä5Ó§€ƒóÖ´§%uqJ•dÌP½ Q.Ü¿ÂHçóïU­àæ]ÉÛ{\"p¸ÓÖ¬4›fy6¤¤—ø>”Û=­;Hç—ÝÍu$ˆ”,‹uY¤}¡ð;µVš0î¾S‰ÙÅ]šG”T+$móßÚ‘c†ÕVá$ýÿ\0™÷;`T:}XŠ6Ë™D’X÷ªWsAÍ)²å½­ž`g·]ò»’79ÿ\0\nÌÕlåßà¬‘»m#?wÞ®4Æ¼ÊR+<Ù¦FŠ°åÝ¢á¿Õm#Ÿá­Ä‹P–a”£ò°êÇéU&Ñ¤’ÛmÅËÛ‘(o/³`qžÆ´²¹¬cÔæ\'i÷¢Gmçåçp=jìÿ\0~ÅbxH8Î¨üjeƒË?ë¼†ìÝ±ïJÚc5Ã$òyêq–=øãW§cQ¸xKŸ|[Ëa{f²àÔ®å=Äe6ž\0ô­«Ë–Ãj’qéYÐ¢åþðÊû[çµW\"ªÍ6åÙC+lBØÁô®¦9]fbpÑ0¸ÿ\0ë×,‚8!¸hÛwqÔVÌK4Á1¿•à.=sB¦‹Üé ¸ó7%Ä„@ŒH_sQËådHs0Ÿn˜÷ªm\0ŒùP*¾AÞÌx\0Tq3¶\"ß€ëž½EZÐÎP%Sö³ûËuD(ì)#ŠPIË£‘×µEsuäDîÀ¨€jœ3bH(Ï&F;æ·r2”Y~O*\')ýû‚séY’iÍpZebC?\'®Óÿ\0×«¬âiYZ\"æ<®jÔÌ!’MÞ_˜)S)8³îÂÞ…ÙK6ùI¬ù£{|—{ŸJÖºûDaW~áÔñUCG§¦go—åmÉå¹ƒ=Œï4wW©]ùçÚ£Õôëµ±©i€@ëø×J¬GÛ…Áõ?zÈ¾¶n»—~@¯V–!	Ò<¿Yðo†µU“KÕ´(õ+ãÛ.üå‡bÁ=ˆ¯›¾ ~Ä¿\n¼am¨­ŽŽ°I4-ÚFà-÷¿yØ\'œÃÚ¾Õ†9.šB‘fUæ¦7(D±¹¯oñ¯¨Ë8Ë‚Ÿ´¡7úv3\"Ã×ƒ§R:3ðÛÇðMOÀ¶²øGZ²¸YîšmnAr	I\'±à\nù#âì«ñGá³É«¢E}” û&ö?ˆ2)öèkúnhêVó•‘Xð}ªº†ƒãI½L–ñGØå€=G®}­±ñŠUbŸÎÇÎTðÿ\0ÝÏãÇUðÖ±§j7séòÚ\\ÂÀ´$”ozç.­¶ß5~vn8ï_Ôÿ\0ŒeÏ…$Ô.À–¶:ÍñÄ—ñ¨óåÇ«œãØŒøÇâücM—K½¼ð÷‹ž-JK¿ø÷—caÜ„°íÛë_¬å^-exŠjUeÈú§ßü¼ÏÎñÞâáUª:Ç¡øT“4ohq·©4ùõyüÒ$rËÆ\0ô¯º¼wûücÑ…åÎ™§VÞÕ7cI0WÜlö¾E½ø]ãîçÕ|9g¨c!ž] uÆà+ô,s„ÄÇžDþhùœÃ‡±XiZ¬èq·¯vI›([Öº›OxŠÎÆ;k]A¢XáÚ«þÏ¥c*âÝ¼£;†áÐE€¦et;²=ë×ŠGƒ,,^çÒ¿¿k?Úá»ù>ø¯«i–’FŠmË‡‡(r¿»`ËÅ~ªü	ÿ\0‚Ù|aðUî“Œô›oÄ—Ñ·VòšÚ00^%å¸ jü’åbp§ œÖu¬¦{©#1´É‚”£ÐÉà\"ô?´O†Ÿð\\†~5Ô`‹_ŽïE[N;HSB¬Üö(y?E¤Wë7ÁßÚ§áÅ§‚ÛÂ~4´Ôæ¸®%Hð\0\'HgÜëè	>Õþn±ëÚ¢J©ãÃòc\nz]‡<uãÍö“âÝ>îÍƒ[ÍÎ#ŒW2Ái¹Äò›u?ÓsBñŸˆ´èotç€ºfekgó˜¼0$w„íVåÔn-â•žF$·`ùé_ÀÂø*í;ðÞ]),|pÞ\"´°*BI“þÒ°9-îAÏzýVø/ÿ\0àº6Ö6Ÿ|,n!qöÛÛiV`~î\"ÂŽß9ç¨«XvŒK©ý:ßk2ê:qƒXd¾·†wh–eÅžàã5üñÿ\0ÁbüSák/GðÞ Ûiz¾¹,ÏsUŒaNã·ý®3Ž™¾¡øwÿ\0_ý—þ*-¥’xå¼#¨Ü2Go©Eö–~~fÜÄ{áX\nü(ÿ\0‚‡ü|·øóñ§Qñ¨‹¯\néZ|VVë‚D‘Ä¬ý¢Çaõ®<ÃJR¹ípôZÆSmõ>Ô)ƒFDˆ`_JÎ±Óoœ™£®ãƒá«w7R:,q6760kWD\"Ü”9IÉÎÓ_w?oŒSFÅ”ñIžÆpÍœŸâÇ­Ic½Ô“&<‰#ÈéVo®Xî€ó\\öB9â¶šO42\0¹$Ç§çYò±òD¡+EsvÐ„ó^Üþõ#ÙË<öŠ€‚xÁëN·±ó®¤¸FêOëU5o-±¶=Ê2=…ŒãšIèRŽêiïM²)Ø~_«·y¥<WI1]Ê @jÜV·‹l—ž@N9”GÒž÷&J™IÉ=Ï­5&pÕ÷3%»Y‚ÁïýçSØ×`²[†#[…@pGõ®*ÛOŽÎþníÇÞ½ÃQ-æ«mo2‰ZeHÐ¼ÇúÐæÎyÀûSá,×þ	ø!âÏ\\Û‹{Féìau y†(‹±Éàç8ÀÎ~güKÖMÜÒÈ\'Þ÷Nîßð#_¢Ÿ|]k£|$ð\'Ãkke±³ðæžnJF>Y¦¹Á‘‰îÙÕù9ã	\'–rÁÎw`{Ù|VÇ‡Šn÷‘ÎªµÝÔV@ýæÉ#°ï_Ó—ìUà9<ðgÂv»æŠoYE|ñ²í\n\' ó{ž¹ö¯ç§ösðœž<ø·àÏ	5±¼moWXÙW®ÕœSŒzþ«>hwZ.™§éW!¶³Ž.zF#\n¢Žz3ª¢¬|¾w\'È¢\\µµoÚd\'šDd÷R9ÍušzÙH‚)-ÆW¶k”ˆå†-01»UØÕ®#-åùŸÝä8ÿ\0ÅNñÐù˜ÅÚÖ:IæØBYÈQwa‰þ1éô­ˆ\"ˆí‘Œàf¹U`@I¸ƒÐö­;\\–D™]²p{‘Cz»:”‹k»³€`g¥nGr«´Hxqœúå®hâˆç,XÇaZöê%0´“l\näŒîÿ\0õV3“êi÷7šñˆœ„=Ï@knÚ{}‘Ü;,Š²œ“Ðb¹†`¨“\\E˜S?Z±:Á-º@–ð0u^íÅ)mvt¥¡Ö\\N‘9YfB8PsøñU‡•.ÉXáIÇ­eÛ·U-·yÑpðR¢Æn¦´ÈÚñ‘ó6“è+6dmÆöÒI‹‰$ŒðÃ¨Í[a4whKP¤“íXÖ³&Ÿt€G„gù½ñZ2^Kpïˆñ\n†®yne&ú—ÌË;¹ûÝíSÇ¦ÊóÃw0K¨ÉôÏëU!’\'ÞLÊ¸ÙéïøÓnfŒÈr”tªŠ¸œ™¦cr$ù‚*1éÞ©Ì&wÂåG~k.ÛÛÛÉvû40Œnë%nI{o12®n&?2ž«Žõ¿+Í)#3–·y¤gøÆ;Zd!uµå—Ž=*¨¶yËH×³hl}*híÎÓq¶çEv¬§¡ÌÍ9-¤µIF@~RsÚ¥¯âks,qÎŠ1ÉÁ#·OO¥fµÄñ[ÛùìåU$€{Œ:}+FÜ5ÉW‘IÉýkžIXèZÇ#Z“æ7™ =½kTÜî·óHÚCàc¹ªRíýçÆîÝMB¶ñÊA„0Ørsß5˜‹Ð33Ç#HÆÝ«^ßnæ\0U$Þþ•FÖÍ%VŒ»5£l‹„É ßœqÛ´ K¸¢F…¤Ñ¶ÁÉÚ3×¥\\¹¼ÒÇ¹“ƒÕ‰¦¥.$Žc¼Œ`÷÷ª‘y·ž`£\'/sšê&Z—à¿ƒxŒ3-ý[5«%ÍšÞ¤1äŒÀu\'±¬K[X¡ºl¢BŠTßš¹0·¹¹[¦›!ä7µmÓC’¤¤–†Ä–“Âö‹`#’ JÎ§æ$óëQ[‹Øþi”NªFÌc9HL.C;¯”¯!ükRKƒå„EÙ_½ÜÑc’¤Ù§ó½¬rˆÌWçp=Çùö«Æâk–I\0 t8¬=ñL‹+yžzƒ·ëZñÈËpÑDá£q†^ }=é“kšqGmï8ïiò[9<š“ËŠF\"ÊMå]³÷ÇÓÛê*°D†Yäå›W?w\",°9ŸjÊ{™“›hZGA\'	ÎOÖí´¶ÌÑŒ²¨ãý“XvïhLŠ\'c‘†úÕý5¤-9¸_\"6?!Ïßýj ŒæÍ©ßÌ)åÆrŸ¥kDÏå#,\0½ÿ\0Š²’B‘…‡÷+aAïZè~BJ\0„ù{ý+¦13,ÛÈ÷Á\"mPCŽõ¾®ÙÊAe÷ª–ÞtBHÜU¶üÝñZ1}šãiSz#üŸš´05­-í µ†I<¸Bàg©=ë^Ýfb±É·q\\ƒÚ°íA‚ai>Lÿ\0Ô×I$RÜùDÃ#¸®ˆG¡•CkÊÚ²Åpð@ôú×c¼òÆ²Fš^ç§zç¡Ó%’pœÀ_\\ŸZÚ´ž+yù¬ª„ÛÜ×LbfÙÓ¨’HbÛ3”ò=k ÓâI$ŽWï·nÃÒ±,¦6ÒÆÎÒH÷®ºÞö/*xb€,ãÕ˜õü«ªœZ’5­­á>c«ïr6¨=«±Ðc™§H<ˆY—<·=Ö¹-\"ÏËžo7%§\0sÚ»{u‡Ê’\"_vF}0yÍvÆéXàªÎ§Jiîoæ<[1ãŒl ô¯@Ž;Rm•S{QX:lP,(AÞ_œ×Wg|Ÿ/œšéLÆ+S¡¶\nø¯íZpÇ#Ê#Ý·Š¥jƒÍ_,ˆ£ÀÎ;×Cjò	\0iàÑsÔÃÒ¹˜–2Ü1ófxHv²õúÿ\0…m˜Fõt*{Ó•w9%¾íOHú5QE`ÙëSˆQEŠ( Š( Š( Š( Á%È¸òˆòÕ@ ô5}£g†ÁyHéX×æò!´íG9$w«+ªý™TM~w:v;*ÃFj,1Äƒvâ\\½EQhT:„Mžh<Žæµ-1}ËH˜bùO÷úõ£[.èe‹/åŸÖ¸eR7µÎ%Eîr––TŒ®Ù’v ’zT­-¬å!q èÌW@tÄbÀÈ]d$V4–OÒFa&(Û¿FÍk	§¡¬!bŠê’ž¬˜ük«ƒ[2Fª[÷AFŽŸ×Šã?ÚÙch­w—,kj[r‚aÉFãZ8ŽRiDW©r<ÉrÆÕf;øÞ½Bˆœ‘žÂ¹(PÃM;å||Ã…ÇsRÅ<\"}¬¥Ä ûÅK€ÕVt©t…•‹DÝ:ÔwÂ3:1ƒ±¬=ÁgB¤ˆ\0ÂŽÃØ\n†ëPš+ Ê7ì^1ü>ô º–ê;\\Qc$óæp}j„VKsäÉùúzž-vÒYE¹XnÎ[–n0}3žkdËmuž\\‹²È4MÍÔæ$´I·Qk9¤È+ÎÍ£Õ¿úõ×$ÌðÉjØÞ„0<\nŽêÎC#˜cÜ±Ä0ÙûÇ¾GjÌÉ§¼.£Ëfpƒóª’IÌ(J0({úvâº6†ææÝâŒ+ÄëœýÜŽ£¥c-³À|‹„Ý“‚Ozi1W.Újh¥¶·MŒŠ0æ³oµ„‹ÎŠ;ô…CËýÒÞµ¥œ‘Í©òíeþ/é\\þ³d¦ßÆÐùÒNÍÈúôúv®˜Éu:©Àü­ý»u¸ãðÜÐÜ»œFóyC+´mÔŽq–;~‡Ú¿™ß¾›kªjÚ\'Ú<û†”—þÇ?¡é_ÑGíè—„¥X£†K¢ÁLñæE–È$dñ×§Zþl|m;FH\"m®Ëü]r}hÄÊÔ“è}Ï	¥Ë$Ï<½‚&”Þ\\¹••È+ýìU‹¥Ý$HBžqÚµî\"ðLMpØ\0w5ÝÔ‹Ä…KÆJáˆúWÆU½t}ë­O—]ÎjÙD“29>Tkèµh[Ø˜ä\n§ÖžÖxL¾s@ìß<Þ©¬lb¦˜¶DÀžÂ³ºF0‡3Ñ\\ç—$ÅoyMæ3Ð\nµ&Ÿ$¶Ó·œ§\'&¡bó†š¢dmªûÕu#R\"^£\0?½T§ØÚkX³¦\"¬DHÛð€Q]ÝÛEç C–àu©m®£µ”¬k€I=*JÍd_5‰rFßzÍy’~í™ÉÝK<ò,Ûö®óÃwªIŽÎbqH ;âº9!Å¡ó;òzšç/m%š¶µ]\\½z8Ykfqbi]h2w·¶¶Ûç$·#§¾{Vu”¥¦&\"øàŽµÐÃ£ÀmÓÍ*Ó+RÝw¹ECò+²-eZvÜŠîÜÝÎ;[€qÚ«ý™åi†æó#W½_³i9.È2BÌÜ‘Î^µi|™\'µŒFÀ’IéøÒç2•(·fs±éSOuåïo¼kY ŽK†·}Ö«\'~GûU(þÔ€Ü©&¤\\2³ßK²wlsºœ¶5T“(ds \0ˆÐœ·J¯¤ÎŒw² psí[ÑgA6åQ©¬¹Õb‘ 33#.ãŽÞÔD-7qºa…|g7Ò«Kr“[5¼oºEàŸjÑò!Œ£Ls	Qz©$¶;C7|ÌSV­Ôçp}Ì©#–Îµ~VmÌËVsÄ0”cw÷Oµ=Y{w0ÙP}*)d‚VE;úü5OÈÊK£)\\ÛÎ¹s.@\'åôªñ½ÊZ\\Z<Ãd™Ûê)·WÓæyÂ\0`~ë&y.#\'æ™\nž½+¶úÎœ,Û©‘¾gŠ«<aæŽ\\¦NìÔ–×G~Xl:Žîek…»·¢Œ}«¶Ÿ7S’­—1ZëKóeA~äg>Ô—:dB0Ð¹\0ç?ÅZ–:ƒ_ÈÈ«±“±Ú²õK›x%y|ùJ{×ZŽ‡9DÆcqæ¢‰iœp}jHä0ÊŠXyª1?Ú£žá‰*d8µ\\‡(Ì*œUj´4Z¸X¥@Þ_™ûÀFzŠ\'Xí‘A|ÊÙ u\0Qfñ‚Á×hY\\ôæ¡+Ï&P¼¸üzÖ´×qÎ\'9}š^I\0lG¥TÓ¬â¹½·7•nÒƒV.Ô[4«¼É¼pj–Â¨<òB«î$uß¡åT‹æ>ìýž--lõ†Ò$·’x•&›û±3uÿ\0_¢62Ãl‰Ž$e@£züíý˜PjW7·qnòl^52Ýºw÷¯Ñ=5VÞÑ.$`u#\'’qÔ×àž$SrÆßúÙ¥e-¬%;2®È¤–w‰$Þ£„)‚ExI]¼õéíYè£PÛ,lY<Ã;\nÔ0\\˜Œfc\n°ÇËÉÅ~|éõg¯J£¹šdkR­~t-ÈÝÔTWxºhÚr²á‡÷MoE	Dãt›kéêÏ<’@ŒdýìU§‡£*°åÓr94Ø•‡–˜†P	lôÅm$ÜÚÆÁX¿ðúâ©¬~dkR6GŒ™«ö6âÆI#(ÍŒG¡þµ<Ìç”¯±L5Ã;D²,§šÎ“M¹Všõ·>¤Šé&Š0Ñ^h¼¦ÀUþ/zÏŒÍx·’™6$d Õ\næ\\2Ý\\©’ÞM€’\nûŽµ°o\"‡)rI•cÎkm/­Ê%ž<¤³á÷«ÉnHe»e•·õô¥¡\\ÅõGO,Ñ~åø~ZÚµŠhy‹¶y#§ÓÖ²´ÄiðcŽä¨Œõâô«/wr÷QÇäx>aŽ ®ˆ¦´cQ4.÷ºNds?\'ýš«kmåŒ}ýÝ3S‹äž9RXw¬™Y3ÔÕ$žI#˜aY\n þèöª“w%Ç[	<µÏÚ¾ðÁI^´ZÅt.¦>{Kl|ŒxaçšÞo5ÀFO›Þ¡óR&Pˆ¨êú×%Föbhäu$¹šp¥ž¡b~^­]…´!¬¡6ÐmEŒÝÛž¢{‹–ŽwÃ³d:\0ÿ\0ÓH®bµkqIƒÇ~µ\nob£.‚òQÌÂ–äâö§ÛÛ‰.åü¸\"§[xEXåV¸ôö§^J‰:Æé‹’AÀïU6tAw-È\nàåÑPô0oð¬FÔf½“ìåËŠBxO¥M$æ[‹xWr•mÇœ{S«Fï™VWÞ-­Ðç¨»eTXl”uª^¹³Ž\"Ïæ/Ãr´Ö{—Û<ß9v¨!}©/ -—\n;ð§¨­c/#žláü]{<>ÔçSæ¼öòF§¸f•~WüN”ÛZËouKpé¸ô&¿M¾\'H°èñ!tvîìõ¿/~%KÅì–—ñý·Ê”¾O\\ž†¾ë×ûtYågÕ-„ûâ±Zé2’[Ì·ç|™¬H—w2ÀL`¶w­_QxÖé“<J›IR ý+äí@ƒ;¸2Äcé_ÒpZ‹Ê§C>9Ìg,¥¤ÍOûœ’>v4ø­Äé™NÀ¹©VÑTƒ¸1õ®˜ìbÙÑ¸thÇÍÇáW¥ó%Ž5A¸dæ«ùo(Ržbüê×Úã\\0ÎTæ˜!±—(ª §Ìy5³m€‘”Þäçê+%\'\\Û™ÔiG?vö1¸	Î_Ž+–Wèz­Ô÷Á46¬¾lwzýòÿ\0‚`xvÏLðn­®_Ûy÷…ü¾PNr®v†Îzñÿ\0U~hÃi¦ÁÃ\0ÎO¡\"¿£ŸØ\'J/ÁßÈ-!½´‘”mä™˜ú¶{â±ÖâÄJ>ÏCôÎ9­\'Ýåùp™;÷¯\\ðÄV·1ý²ê7VbÊáŽ0½ˆ>ýkÉíšYJÊÎdMçú×¯h–žnt²$nqwÎÜóíÎ+ÆûžGÜù\'â&¯wŠï­ÕþÙ§C3G«ê;ŸóÖ¹›mmBf‘ÍÁ›ë^Ÿ¯Xi3ÞÈüÇ¹™ÉFçnkËoôK™QÒ²Ž½p==ëóÊ«šnG¯Nê4 ¾·ÔvDdD“yA¼Œ¹†kfÆæ(Ï—\"|è0[±Þ¼WûQ¶“˜Ì¾fW<ì\"¶cÔ5»p±Ü2•,\0Ùü_Z™Ð”wêi*Mnzå•ÍÔRZ2ÎªCn„Õ]K@7‘¼†½œàs\\õ¦¸!+§–…@P¾¢ºM{ÉhËHV%o™{0¨”lG#2¥ðýÊGæF^ëfÑµ\'ôª²YêÍ,ò£¼ñŒ…_»zô?R€´Ï¹ÈÏzÒŽ™QÒé›êGÕ&/˜ñyu›K•xãck¸|Ã¨=²?úõÚiºÄÐ6òÍ\"mÎ$</°®šOYù©4 ÛD‰÷:ä“×šÍ›Ã…×È·ùÕØŒ‘ú\nw#™\0×m0ñ¦Éø½jö›¨Æ`u›%rž£ð®è·©m3N®¥8P½jÅ¥í°óžÎB¸À$(õ;kLY¢˜Ì¯,Ä)þuNïF¹yÛÀ¬÷Uvæ¹ûi%äVRÆüé]E—ˆ2C1;OPübÞÅ;¯ê¶ðáUrûª{üÕJÑõK$>j2~óïŽkÔ ¾·½±óàu*å†ÒÃ9SŽÙïM‹OŠx~Ö\nùÎpc$mÿ\0Z¨Ææv<¶]VýI3î•	ìü;Öþ›ªÃ\"s‚ÍÊŽÀw­k¿AsçO\"›­Äƒfü¹¬»o	¼–®ðÎG–¿ÌæµQ±.q¦_Úº$vó)ðÊzµjGQeÐ	WÌ&@:à×”Üéš–—ûÈD™†<ý=ò)-uëûT’7&¶Rwy¦E7å¢Öð4ãä¤ƒŠâî¼\'Ìã!ÖyÝyã¥7Jñ$·±˜®“¼¯š}GsìkzÃZÓæœYÊÁü²HÏLÓöe)3˜’ÆþÖÖà¦Ó±N:~U_Ï¾·E€d°@	ÿ\0^œ·	,2ùmå¸sT?²üöiiböüiÛRã.çoâÇGlò”¼ÿ\0ÔZøÆÞæ²¹*ærú“U.¼m,òL·;nÊa\0qï\\×ü\"Ú…ä@”HæÏÞ?Ž+gæ˜ôM&x5;Iïä#Šw<(m µ7\n±ºMÑ†Èé‚+Î¢Óï­–LLwOVÙÑE.›y<Jë†Œµs™4Ï@—F{µ1ÀëHØgÂ=kOÝé’ÜÚ}µep¡‘Ô÷†Fyô¥‡Ä^R¯–:ŽAîkj-ON–™ºwl±ã>µQÈ’1¦K¨¼‘pŒ€à©=ýÅm¯ˆE³Ú­Â9.Ü2ôzÖæ¡£]IiÆ÷)\0 ñG`zþušfy¾DŽdþè}+ID¨£F=zÅ¢o:obTöùÖ„sÌÊ.|¿Ýnúgüû×)ÿ\0‹‹Vygq,oœýjÇ»³Ôá²º‘ s5ª¡B1—ô¬š¶å§<ÐK±åŒÞ)‹nAÆâ}ëœŠÚ+hÃÌFwàƒ\\…¯ŠoôÑ	ÔùRª1÷sý:ç\\7nJËå° •=½ëß¨3¡—A±½¸YB\'aüXõ¬‹Ý>þ£šÚÝQZgRK`ñÐ‘è~µ§¦ëW3‰b0½hÉpnWeÜ{sŸ”t®nFóé.uëi\"’Wy FÝ…Ôt«Wž!ÕHLÀbÜ¿p>+Ðìà¡\"	1Ô7aíT¥±Ñä‘Ÿìøtl€zVñv6Š}N\'DñMÏ˜\"½*	;OåÒ»KmJÂõ™1·•»Y²xsO}÷VÐâEbÇ«H¿[©$ieŽ™×ÀÇ§½hæS½\\ˆÚyèÞk:q¸t¶vì$1¦ï´8SJóèoîmä2¾å8ÞŠµOˆ<„e2œ‡Ý Öbg@¾Šöw‚xü±D’1¿§ç\\åç„eµ-(ûIÂtäzÖœ> ‡S‰Zi–I-ßçÚr+^UþM÷z¨ù3ü>˜¦­ÔÏ™ž{w±e$0Ïgœ£2m nosÆ+.?ÞiWp%ÁqËØçÖ½oð4bäKÔ0ÏéXÚ¿‡,ánLqÌ\'eRr:qÜW\\79­?Æ°K2ÆfeIÛ=k©¶Öô©œ:ÈO Þ¸é<¦¬5¬«°“×Ú³[EÖ>E´‘ #$f«•T=}$27ÙÏÈ r*XôŸ(¶¡+)µ\\ïÏSšðËoÄ<¯oi#G|ÌŠñç;TvÇÆµ¬üK¨Ï†í\nr@qí‘Ó8¥(¢£5=ù¬o‘VE·Ú£3\\\'Šô;%²IÁs)‹¿vë[o‰|ðÑ\\íÒÜî.ÝïšçüW«ZÝª6ží4ÑHÈl®ÝÄ’G#<ú~5Å™b*›è™êeIVÄÂœz´s¶±OFd}û€8?Â[ò£prûYŠµ¦XÄ¶©#ÈnÆàIû§Ó•qGóÎHYUñÇ­!fM{Y)w?ª(ÙEÁ’i£\0†4>¾õ2²Ä 1dcƒëŸéW¤¼‚híÐÛïeÈsýÑIr¶ëº…·¿M£Þ¼\nü¦Å¹\\»ñµFOÒ¥ŠÙ<–‡ÍRð½ˆ>¾ô×‘#Ku’ÙžMƒ2¹©œ­¥»Hðoß‚«Ü{×/!q‰N+I/	rž1þ{ÕµI Œ|›äÃýÚ³§ÞKù¡W²zóQKw²„I‰Š79×žõ´bmc4É=Åœža_7íGû¾µal-ßÈG¸1áydf­ß4+´@¾``‡úÔ¸Q´ü‚³;•b„\nðÜœ–k#aˆïëšÓ»b³ÄÞkmÛLÔ,æ“lCç?^ŠÓds ]²¦qî+ž¥£Ú÷3–¸TKÉí^¿Búe£`«˜1ªŸÇW¢¶(]âb¦Qƒôô«¯e0	ƒb\\p@iFŠsF5Î›··X$óœH$ õÈéùRØG2ÇæÎ¥ôVô­;x…ä›IÙ*©9ãæ¨$Ó¥óÑ¯/|È‘yUàä×G2ìa)D§,NÒ™!C¸0%}G §]ªËµ1¶G$dvªžTRS¹vœ÷ª©m ¸7ù=¬j3Ê°Ä7üÄäöÅ\\i°¯æåFÕèâÆaòÇš_‰ñéQý…ÚèÈ¨71ÝÓëE83:Iï%‰aš]–èC…ã‚Z|TÂz`ç¸­9‘b.xÒdpzòxª—’%Æ]”Æ‹ò«Ÿãã¿Òº9ÊÓßh¾Pªzš–u†áÛdy ç©>ÕN8årÚ?Z¾·tpL¢8|±€=+:ˆ\'.„8ó\\KŒ|Ãæ=ªùˆy±+®VVÆOjk*•—aÚê2=?*ª^Gu¾äÚ0}ûÔF¯c!\'¹–ÖSÇçB¨Mf=Úòe%X|Ç=1RÜÎñÊ¢c±]°¾õs-¹œ£)”·_a[GúÆ‹6çK—`Y\\ü§½H—Æ\'H•CbNz€k%¤aåìBQOQÎÐjÊÁ.Û˜¦pó8w\0í¬å+—ÊÖÆ²ÈYÕ\"\"/0‘¿Ò¢¸I-Ð€z?cœÕUdŽ\'™ØFr*šÏ$¡–5Þ­×>¦¹¹t¸àm%º›Ì’ädg±ªRiÌT9œùÈÝB*”WVS€£¹ö§Opå­e•	ŒÀ<²·­8È±ÂIYäöäpOv©–9¦cª´;Õ¸ÒÖC•hÕ¾¸ª’ 4mòçëÞ»©Ì¼P@#ÞÛ¹ÇsýjŽ©Ä¸YÚBü0#š˜ËrÙQSe¤ŽòÎpx{T°A#I}!;’I<œÖÒ’Q¹<·e7dHfUF<zæ©^¼¡ÞtPÐD¤á»ýkRb¾$IUHd#ioóÞªy¤–?0ò6žù®JxèÉû§GÕÜhžeDhAm€Ðý*	VE3“0sŽi&¼x¤ŽuI$b1šÏ/p®¦FÈó§<WVïR\\l¬‹2ÇgXÑÊ‚n}?\n¡m¢ø\\ìÿ\0FPx~‡ØUË¸þÍfe±·O/º˜·¿l¶9Ê¥e(êc=Œ{é\"¾2:Û4	 “ü]³Š‚ÛM·‡eÀ˜ýÞ„zÕ™bîþ1êÜT-‰&t‰7ã‘Ï­+™ÄÔkKMÂMØäÛß>õnTQÂ³åªšá‰åXÁÎx\0R-ÍÓ“ 9pøkU(¾¦·!»ºÙaUàž;ÓHã8PyíEË¢]«H | t$Sæ’Úò¶Ž?!¥a´žÃ5WInLÙOÄîrXä6GQS¡‰bk€sòžÂ³ÛÏÓÞâ„\\Dè@9Ç$sùÕ‘4I!¹ÉíPê#&0-ÝdÆBÌXŽÕ½EgyÚG¹–làŽ\0eg%„mh$Ï>µ]­æI_>\\OÓ±:—z$ž¤±‹»«\'•û–nXž•bT³l b$†GÁÇz°®‹ûÈ¨äíª¥Påb\nù$®:ñO™“ÈÑN³„6bûËQýi·û\" #§ â¬ä—o™å±ÐäëVmŒ52Ysös]4ê>ÀîRBžqòË*BÃõª+«¦–aå–‡¶;UÈ\'Œ¼‘Ë#Ê[<‘Wå¶µòÑƒ‡¸9ÀÍoÎ]Ì%³’o-œŸÝßÖ£PÁÞ(P–ÈëÞ¶‹­²mdûAvÉÍXóá. 9\0óI«“\'c˜ŽÕãwóÐFZBF;ýkšÔeùþÎEÈVùô®žy\'¹gÂì@ÃžÜÕìíÕÖu\'ÜVB?ˆWM8$õ8å=F+•w:lbÀ•>ÇŒûWâ?é+·kwEµ¼µ}ë¿hÊèF{Å­Ê7îwldÇk†™hÎõhã¥	óÁ´üŽzôáQZjèø+Æß°çÂ/¼g–ïI‘Îeœ‚Çø¾mÃ?@µò?¿à>&‚ÚæçÂ¾\"µÔ%”KiÜ±ˆ£ô¿g.me–vwa€ƒ8ô¨~Ék,MÍ¢¼9 ·qô¯Ðr3,,yc;¯=O‘Ì8GZ\\î6~Gó-ã/Ù3ã‡\'ïü.%…®Z!$/XðHL×ƒj~Öôa,ØÉmvŒAITƒú×õis Û8‘¥Óã{q1U8<÷æ>\"ø!ð¿Å¢àk^Ó®n„eIòÀ;=»sô¯Ò2ßiò/­R×Ëó>cÀ0å½	ëç±ü±=½ìr6•mýMMs5Ñ	9Q÷—±û¹âØ?áˆn.¡ðòÝ<¥öHÇŒt‚¹=þn;WÉ`ˆúAy¥éÞÚ]E&\"‹‘´ã¨\\\0ÝFòµúFGÇùn:ÑŒù[èÏ—Æðf6œy’¿£ÔüÔ´¼;d$r¹â«‹ûÈí9òyï^Áâoƒ5ð~£=ž·áÙì¢im¤Æì:€øÚqìk€¿Ò\'´€Ãx›&L§¨¾ÖŒ¬Óº>G€«Mþò-×u]CT´¶¹/ržb€<g¥};b%‰ùbc»ge5â_´—}ND`îº)ÿ\0úQo4æÚ4/\"€\nùlþ¼£>Eµ§á\\ª3µ{¦B,£™Ñå@%É\\úRäÒX¼AŒn0Üõa¬n¢‰wcÉÇøAþ•GT–òHó#„(SŽµòW±únÆF±:^È\"‘ÎÈÀëVå‚i­–F…^Ë\0žr;Ò-°¸‚)VyBdg­W²k©\'ŽÙ×Êv…=3ZªÎÖ9¥K[¶AäI{rB<„óÞ¤[o3Í!ƒ\"(Î†´on`”dŽ˜í\\ôëºÌR„<ýá]1w9§_SMeHmg…³8\0õ³¬nMÝÊ5ÎvÁü\'¢­A£I$’Â 9Ï­jDÚ}ÂHÖò1˜œ1ÿ\0=©T›LˆûÉ2F\"»Žh‰hÀ\'ií^‘á³¾©¤Ìm¹Šñd,=žkÎâ¶Ýyk‚bÙÎ{Œt¯¤¾xüamâcûCì°énÄ dÌXsÇÅqU¯«Éèo3“²<GãN¯ªx‡]hšåþÃºypç!>ŸZù[-vñmÚªNs_¬š¿ìýâ]U$ŸKÓQ¤x‚ùó}ëúWÈ~0øQâ-3\\ŸI×ü,ñêk Pnó<# æ¾“.Í0ò§Y#çñyUXÍ¦®}ÿ\0Îø3o©üBO‰7öò‹Ÿ\n\\nvå\"I÷éþE~ï-úÚ1¶ÅóŽçÿ\0¯_›ß²}Úü<ðkèº<rm[ôžê7À;ŸßØ\nû~ é7+íÂÃ6ýëž8§Öi¹M´ÏÍ©KÛÉv=­5¸´Ø^âîàÇæî@úV¶›âk™C[L\'IPCýkÆ§ñVŸ¨<oÏúç\n«ŒôªºEŒ–sN–ó²+JÏ¹OÝ$óP§cÎtÙônŸ:ý±CæN£øEuvÚœÒ:ù;ß$níŠñÍU{mÖ»1Û‰ûÌMt_Úërd “$§pzf¯Ú‡³îz“l•|Öƒ9\'¥]Œî³‡Éœ»¤ÇðÅq:n·‚;Iÿ\0yƒ•éZ«y»É- óî	*QþéŽkêJ‹gm#Ox‘D?v›²Øþ*Ð’HàòüÃæ)`¾k‘´Õ®d‚R¡#’G\nc\'“ô­ˆî¦#]@³GÎ	ê1í[_K—ÌŽ‰¯˜º°>\\lƒ9ÜjÂZ£–S›ž»ÇoÆ¹xnVëmÍËù(¥tê6±ÈˆÃå8^;W<ç`›4¥ÝKð¯\\÷¦Å~îòA*cæÂí5”ó»$‚3¹uÏÝ«ð=¤Ab&M«¹þ•Ì¥©Œ•ÍëËˆ­ŠÊê?Ò€ éÆ9£Ì7h\"ÙGQÔCíYZ—ïà†(üØ„?xuÉëš†9nZäj±¹Û©»W\\ŽŽÙˆ’8–=‹	![ÓëMŽí.é)žøª³jJ×Š†)eˆgžõe¥As+”‰—,ÃOô5mX¨1]<›(üÃäSÈx‰š8÷µË€GÓÔU?-4èEÂÜŸÞ¶2{š·*ÝÌ–ïfï\0uàœTI–â‰~ÐÓ‘ãsƒÁìµ³kû¸Îé	Á<õ„¬Ë>6«Ç°pÝÎyü¨”«Jó	YŸËáz¨Æ=Nj±¯g©]ÞY¤1_÷³Öµ[d	òÊrûXoÐG$3ù‘–éÕ½1Z·¤2G\"ðww­½”^¤)2õ´“*É3H[’T\nû\n­ºxåIYö¬îN¿¾*+#4®6åŠ“ÁïZÖö*ÎÒJS ÀÆHÔ8DÕ7Ô$a*‰$F<Ÿñ«6;#DÊI#V±gŽ7Ž8C®æÁ?ÅWd·–e!$0n éJ™h*ý’\'gvp¬0½T	½\0\\;’M\\ŽxÊù2HÂH›j¿©§3Ç\n	éÎMÌ‰-D¬ª|ÉÙºü z{U¨uI\'’ÊX$Ù*a\nöoz¥ºè¡™T7pj†žîá–gªÌ2Wµk¡Ç8VÒÍÓ¤ÒÚ„+á«ÚtsÃ¾PÅ]Øž?MVHÜ8Ã†8MnDa]±…ÞÁäô÷¦BDÒ^›‘vÝn@\\r§½hE,Á„6ò´k*I¡`C¹ÝcÖ¶m!uXæ#™	\nIè u¤âŒæ»–•Ê3éÞ·CkÅò‡,zoSùW5cåM4åÆ$”àgœ}+}!t‰aÞU‹v¦‘ÏRæ­Š¼jÍ.\nnù7uÿ\0¯[ƒ|Ð\0¶ÞT{×?T³»¾k~›\n‘‚Ár\0«‹2žÆŒQÌÃÎc…Àmè2Ê}«f(Ýp“¶Ê2\0êMs¿k–Í·1(ç«¡³f¹·%—*«‘šÔÂNÚT+°…e1)\0äWIePâq;N‘®vb¸ûuX•œ›u!Š±àWG`·VÒ6å-?Ë·Ðô­á#\n’êu¶²ÜGÉ·yGÊ}?úÕ½¦™ÚÝbœù»›æ\'øˆõ¬Õ?,o#f#Áõµmà-‰·î“©5ßMµ$Î‚Ú;Á•·bNWµ×ÚX³!+Þ#Œ’¯õ®NÂI¡Q@*Î2Op{W¢+$p¢ÆÊ¬øÎO5ßrÎNåø¬å™™\"rÌøk¶Ò`¸0íádW·qíÍ`hÒÉÞ±ï®;×mbUx$nÛüU¼cÔälßÓìÜU}êzóë^§mŽ#ªY\00äœ×1¦Ä‹’5Úd]†›H§q\0¹¶Š¹TãvlZ-¸G%‹¼f¶-öl\\!þu“¤Ab`óJÓ¨#]Ä|ÜUMA§w©z1Ôúš’RÖ2‘ô´ãÑQXEPEPEPEPEPà#Zˆ•¥U³¾N(…#¹fYÅ°}ìpk]T¦÷Ü&ŽVÆ-Ã«B‚b –N6AÒ¿4•{š{k™†V°—1Jv€?Õ_íÉpÖóLf’NóŽ§žØ¡q;Á{âIì*¼še½»¿•˜ìA>µÉì¢åÍÔÑTèZ¶Ö¼È8ßæKzãúÕéäi°»ÈŠAÆ+[LÊ±€cBÄ¶;æ u‘¢‘áÿ\0kŸç]TÄæŽŠO!1”Û±ƒ9n€U¨wYå„W=¥¾ø¦vyv•ö5nÒx>Ë½_l;È\0ÿ\0+£–ûÎ]N„´FIUS)ÃûÙ§Çio4«$Ž«u8¬{}BÝBÎÛÝæ$dŽ\0<Z¤a„‘HbvÆr9_§Ö«Ù=Ìœ™sT²¶ŠHcY\nÅ¾^Ù¬I­&gy`”¸@Ï¥n…ŽéùãÄç>•Py±mÉ÷µ›¦ÖæˆòëÛ´¿k¸ã	*ž3ü\'ÔT2ê—v¸#0 º»{ëHï\0Y CÆ;UuÒÚ:Ën#ÇÌ@:VrO¡¤n:ÇUÝJ‡—†ç½k¦²†UEÏ“.2¯½fÅ¦¤Q¾Æ>NÒ*Ïd°´Òùìr7l5“ó%nt×o’9LÍ§€CTd‘Úå0Ÿ—ŸOA\\ÔÓJÏgàž€ÖmµÝè\"èÎD}ÿ\0îœûÔ¶uAž’Í¶\'~â6û×7ª\\E(c¸¦‰ªVú´BÖO2c=Áo¿!ÆâzŸ­Ey}›Ìù °©­##º–ºŸŠ_·>“{¦Ü]Å<7rÚéÚ‹ÜÈ‚«\';A=Ô×½:ž;’Ö}Vâ`Áîm›Ëp>ò¯bkúXÿ\0‚†ÿ\0bÚø{[µÓfKMN}ÜIX\\ý¡„`{“†Ïç_Ì‰ŒÖWZŒ’[µÍrþg=|Ë;«{ÂR¼&š9ðRé’Ù#i„—Y®~½+&	!Ô v¸}’‚N>”ô¼ HÉPÜœz«-¥œäÇ,åGCþ\"¼¹Àû.Æ\\°C™bY\0M¥¹=sSXO…ò”™bN9íQ_½¢²@`ùsH²É¦\"*¡hçùCW©ÚZ¢ýÉ´‚2£/;¸#³VGÙíà…®DÓ7Õ\0u’#2Â&‘;¿Æ¹¶šk©\\8Ù´Ÿ•º/Ò±•3OomË3¼¶×ÎšdbHoLÖ„Ï,ˆ„LP¢gëQÚ;ÞÜ¤{qä ÉöªÚ¥Ë6ä^Ë–¦1Ô©Ôëb¸y/Æn|É <ôªòI5³«J€‚yõ5Séò ,.T9AßëZr%Íôoä¨Fá¸ô®šhå«S¡™8¸ºŒ¬\0¿RÛª­´SÞGs@$šÖ0[\'§ÓÖœ~ÛD¾\\±^õ^9îá¹WSÞ?Þ®úq<\\F!½Yb{æŽˆŒ*¨qÚ›§]ÌÑÜ¯˜b†\\¦Æþ/ÿ\0]W½™%!Ð6b#?2Ú<æ3–#Œ÷5ª¤rªÏ™j>äKmŒ¯å¶ìçÒ¨È¦tY–l~µlØÌ·\n·n¬‡æ^¹©šÙä¹†8`s]^ëV°ãBMß˜‰,eXS2lÏ$zæœå\"ewEyÂ`Ã4š„Ry­$ì\n3žÕ*Øˆìfi[t›1X8¦îJ–%«!2	&_4œc/j³i?4¯¶HÐµŸ°ÅÖª6¼ˆ9@¬»k&Ý¤¸“ËRûÞÕ&¥HGrä‹^M\n¾wô?ÝÍ`]y°NÄÆ®AÈ÷­»ÕIdˆø8ÅS[bÛZBYÉº#¡æÔš“ÐÍ¾½‚h’ÞÞÜ«È¸lûŽjª@öö±ÂäÉÃ[·˜³rñ¢1Þ•—$Ó02p§‘Šì§Ø…AjgE,%ç¶Y‚Œ«ZˆÄU >fçÐSZW•â€†ÞwP²K*l‘O+ÔvéS¤÷9«G¢Em\nsÖ¡I±öå	îsPjVpìÓšGãªÍÄvñÚÅ4RàÊGXŠ¯u;ÅRËf\'¥n£Üò%MŒ‹L{8ˆC‘/\\ö§ÚE,M<k9•e\" –kË´G…Ãn8ØOÝ§È¯f‰–2JGZreÓƒ5î-!ŽÚ5•z>ò}jçe¶uFfÒrjUÿ\0I‚#)ß ç5Ÿsn‹nv–äÓ‹ìnè¶ŽðÇÌr>j¹$ÕÛ#væFßº2¿wÖ¬IeÌ®3¸ûö¤¶’H¤há€†CÛ¸ÓNKvyÕ©½ÐoÙnÎãOq˜I³ÔÍºï9Âº’?Í~…Z¬ÞJÅ!YU#ôè+âïÙƒH¾¶Ð,Íë¨g¹{ˆÏ÷C¨À?JûR+üÀ#9U^¹áI¯ç~3ÆªØù¾Îßv‡èÙnØxFýÛÛF¾cD¢ÉQÚ­Û;ºLq¤ã=é—M¸0”ÃžÇzhVŠhŽUÉÎkäÛMîzÌ#–Ùd\"PÝxÏ­S¼ÎÀ$²yÀ‚J¶ú\\eÅÜŒ~Óäí_OÊ«ØÙ]Ëæ-Ãˆÿ\0xT4‰’&JÆ6H¸ç=ÇµOŒ.6Ÿ2uá§½,6K¾åÆÐ>_Jš@w¤¨Û‘2hœA”«ùÏ…Á³T!Ùn$I•ž\'P§ù¶³»«+®7`óíS•iqæ7È¤ü¾´r]Ùš(µ« #HísŽ;TVv¤…’gi[pº=MO”I+¨Ø¯ÏÝÇ¥S»º{ËIÈ$¹5QJéHÚ*7\\Û–V‰§Ës*!‘ç*XäãýkV¹–yfKcäãúÿ\0ZµQhbÝ¹”ÌˆÓ·É±œ\0öùÕÅ¥ô1n£‘Uhœ7éZ“ÜÂ±hSîŽ„U‰\"]A|¸“ËÚ~ozbÛÌªñŒyÊ£ºS”ÍzêgÛ}¾ä³ˆvÆ„mÜxÅhH€Í¹€É¶*Â³$GuÆbuOSõ>õM¬b‘òïVr¸Ù^9 ’2¡þYÝi÷mwimiÁÏûÕÛBÑyŒ‹ÉÏ?\nš)ç—vòYaA†™ZØ–RvUAdØúS/nd˜€‡oEGiäªªdo<{T—R[YÛ™B1b˜Ï½z›@ŠH<ø#‘çh› Ž§~µÎ}‹S‚ØOLq“Ë}}«ªÚ·6öÏ4\'$Ú1M¶µÔ.àXÕíÝ†Â:¨>µÕN¿+º75ôÙ]`‡ï6¾ç2B÷Ž×7|ã+ë´õëc[uKiÆùW%±Û>•nž8Ìê#·0ø@ô­c&ÑÃRG‡üb½º´±šÊôÇ½6ÿ\0õù¥ñåãÔ;afV>àWèÆ©o®–žb-í vÇlžæ¿0<YruH»‰l\0Øç+ô¾§Í‰‹[žW_R•Ñäþ0`Ó\'ÌÎÅŽáØWËºœb9ÙÑŽâNsÚ¾‚ø4–ì‘£™#Àô5óåË4×9QÚ¿ ©ì~9ÈC½Ê¯µ\n’>i÷íW,Žæ\nÃr#*íäê„èEtG`öehãó’7v¨~Ï€ÛäÉàÓ¢¹bÅ¿:k³¾Cƒ¸óš$ËQDéLH7môï]g†[}E\'¼N@Ç¥rÐÂ£)-žµÝøh#N±\"n‡OsX\nÉß£ÝßX¤VSl¹xÀëŽONkú¹ýš´…Ñ>øf]9,mßJ‘;–B¹`sëÁ¯åÇ@³7úÎ‰¡{™5kè!UCóœœc¾ýgüÓ’?ønõây´KUœÓIí.Àœ8ìÏVV9q2J:á§\"Émr¾zàµÙ¾lôKéË|ñYË/ª½+“³³µm±Dû®žFa´û×S¬Éö?Êf‡Ê•ãÚx?>HÏµpN½“lò$ÛzÜ]jw¨N-Ù-ÕÞCƒÐwüê1­†µ·]ä„°\'«{ìoì¢†Vh\\\'Ÿ+…N ý{cüâ¹Ë¯Ü5©¾Ûæ2¶6ƒÉÏp+áÚÕ³ÛŒˆ¢Ô´»©bŠFòßv\0PqøÖ¾•§ÞO\'˜ždƒ˜Ï§­r2è×6²3¢)àýÚu¤×ÖKuæ3:)\0÷³NRn×æú”š¦[þÍ·\'¨ÍK¦Ü¸–<²©ŸjÑŸ^xZÚåÔ£7úVÝ†§¤Jk³ï”³nsíXÔfrék};Ð‡9=¾µ¹iâYÒ(üåÊ×Ÿþ½uksg,cŒ2ÏN§üinôû×‡yÞ‰ÈÉêyY¼XÄñ<“K¾B dtR;þ5×ZêV{#-p\0“¹®hoöI­m\\6é3†ë×µ5tJÁ¾Ùœ×žV‚•\n,Îq=vÚóNš7O9RTçÉéŸj·•Ô‘>@QÇ+ÛšòèËÆŠ²GæÜLw`uB é[oˆ%½žîÏ-ŽÅi	8öçÓëEµ±„£czúÑ¢u*$8=F;×=¦Ou!iP¯•ÃõÐ\\k0r-òž§ïcÚ¡YYv-ÀS¼ž´ÚÒä„‚òJè‰%”à€N0\\šê-gÔÚè•r~EÁÇJÐoÙ°7\nü¾„sšèí,àKT–áÄr=¸c³Ž3ÐÓŠ`bÇu4Ló•@Næ©o¬[Kb.2qþÑª7Ú[j$JÀ lË·ÞÂ¹õðíâLyŠ\'%YÁéèqT›½™m#½}ZFE•rãïf°.´Kgº2O<P2Î<¶ìq×õ®cS‡Q!dF¹Ä«÷z¯½l¶±ª¼ÐY[æRrFTàucÔ~FZ“Eá‰äœAá‰A~qÞ«-„‘]N c•&~žæµ¶ƒ0á@F#øÀõ­È5+K¦tD@“ªåÇ\\ŠÓBÁMs¬X]4FCöYgž3þ5ªž\"–VŸ›¦Ì×i…Œ!šÄ]à\'ùtª×~Òî%0­¢­´²nEÿ\0ž@öÏ-š©w3´oÙÜÎ#”—óÚ9\'¶3Ôèä¹†T2H‡$‡%GóÍsº¯„ y’ádXÔFy}NÞ…½ûqéYØj6îq¿Ï“\'¶{Òlwèwž]¨‰UW%Éõ5|ÙiÑØ˜DQå†wÉõéÍpñ1i—|¦p[¨¶š¬‹µÂlx³’?T£&mL¶¶…ši$È÷”ŸéøS£ðÒEÞBs)”nAÜzæ§Š}1µ•žVOœŸS]dWAb”9Æ:V–GŸÜ¥ÝµÛ¬ÁÒ&Aå¶8?CW¬õ³6ñ8%ÞBCëÚåZÝÌivÖí¾0üì5@ZXÜÆ±¾÷»i†FÀ\n[°útªhq‰`ø†Ö;r&Ÿìèr3‚wU¨¬®Ò*}¡BƒvSÁ§Ýøoí…@¨ P?+‘ëî+]#QµÈ‰<×Lð™ç57/•w:htýWòßS‚0#œ6NÜ÷úwªÚÇ…ío€Ì\n&<™#8$g¿^?:à[Õ§y­yaMÄd‘éþ:¾šôöË1„m»©öƒ]ÄâO?…o‚Ëg´ñÉ&AéÇaYRÛø“L„Î&_´£D¼ï\\ã¸í^‡‰­G-½Á™È*½jºêvw1Ë4Ñ¼ å¹üóY¸v3R9kkífE;¦·LŽçêk^ËX†-±_¾)Ëÿ\0ŸÊº½?JÓu	 d2Ùô®cÄÞû<íS<œmÁSnôãL£L^XÆèa¸Þr71\'j†8Ï\0ýÚÖ·ƒj¤wßnÛ1;Ú#Ò¼–ÛKºvF[f®>ñÖÕž­}Ì±,/±æ.1ŸÆ¯ÙÒšÇL’iî6žÝîÂúý)÷~±šÞi`A•èOy®Z×ÆV7°¼\0Ÿ,ÌÇîœã#¯çÔ¶³my¾;Wm°Gò‘ÑÏ©öªöEêyÍß…`gŽîËy¤‚§·Óüþ5•>•¯Y›¯,ãdòÚ3ÈtÇ^?õ%K²b‚5!\'¯­nùp*Œ*\'qÔ{ÕFŸsÇnµmkLµ25¹Šá§ì88>Üwë[–Þ)†ê$3NŸh’3¼7\07×Ò»[ÝNÕ-àBn!WÛÎBî=³œW«xZ1î -œÕØË™^çGkynLl.vóÐžI­ÉuKyQ\".>õxÄ~½Ê3–rîèqYÒê¦“$%¼Íl­ƒ´·éL|ç´´v³2CæŒ£îo`k6ÿ\0Â÷S,Ö!].b³6Ñ=Y¾Ÿyõ¿ˆ¥ûL[¼Æù7—a‚ÀŽ8õ®êÏÄPªmy›~ŠÀ§õ”Þ¦¦Eß‚] h`;âhþbÍ÷½qÅq)¢6I$YÚæÛgÊ¬»J¶+Ó\'ñ…´ÒHC[€AÏ!ˆõöük‘¹k›ù‰ƒM»j¨áTvÁ¯ÍüLÍ*a²ÿ\0Ý»]Øûÿ\0ðQ«Œr—ÙEwämò-ÌÒ>3èµ˜ œ,’–?<ŒO<ŠÙû,ÈÌUü¦QóŽÄÕMÌÐ¹?®kùš¥g+¶ÏÞãDÊ3Æ¼ç y‹Ü}+f	g‚3pê‰†b>÷Ò«´PÅÄdª6±^Äv¥–2Å-ëÒ¹Üy‘Ð©hlÅ<f%™¤,sŒw©ÒE—Ë™Ésœ=`ÚDDŽ.	dßÂ¯¥_¸É€¾O–ù\n½ªylh•X4ô—{ÊJ„çw¯øS³Ì¨ZG+åÈI>•VßT¹Ž(ãÞ%Hÿ\0=iñê’43[½¯”¤³y™ûÄÑ½l–ž<ä&ãÈ«Ðºª3…1¶â>µNÏÍp¡œ}ÝÇéVKb@0G¥(HM;’ýøŒR¦ö3wö«òÈª„“´aýk+SÊ@öäì\\†?^ôÔ¢–2õ«¢kÝ¹“Ù¶÷6ì¥Hç†GÞ5Ñf(Ãnmç§jŠ{iVX\'Gœã¶=~µ}ddžI Ž4iÃðõ¬gÏb‰‰ì|¦<0ú\n“SžÌk\n´ÓIÇŒÔS971ÆÒ—‘Ø}*ìñl˜*\\¨ó”xçD(­ˆu.îÌ™|èí—zùb{·¹µ•\\cûØ¦É,Ë2æD`F:f­ÀY]ed(}ëo©Ü9Ê«\'–!$Õ#<ßÞ-ÆÍ}Ï‘·µ<\\½eo4—<úóéZ#ÏŽ]‡ä;ÄHÿ\0ëÔ}Q­n\nfg—ocû¹\0ÒKgÐ·!óƒý=ê+%Äo \'tNHÚ9&ª]NÒ¬h!xÕw)ÏB9ëY;¥b¹‰d†FrùH;Ô’}š{ãµ.uæ—Æ9ëþy¦ÛF©+ÒO±„x\\ðqéïU.+º61E»­õ©¶€çÜŸÍy#f’&8—ÀûÕJà‰Â,grG‚r0yéR†I0yÇåŒ§­eùhò±†B’3\0¦¥Ä¢{“o A\"Ÿ5µ’ö–³¹¸É-‚§®·Ip»])Ïr*¤·O4Ž°ÁÛÈ¼…xúÖr‹5•å<2ÈD›NUSüÓîÞxÑ%0°yÇSÚŸí“&ÉZR¸>çŠ·#ÙàC%Ã}¡Nàyõ¬½îå™[ÝÝUäù$#°¢–§@›Ñä ýÿ\0ÃÖµÙc	dó€a¿.=V¸¶2Élë¸‚ç­m_Bâ“*6¥ja1;0yœ„pßSW-Ú	¼µe¹UÜÑå·OcRÇ$vr³‡V,¸Ú§½MJz p/ÁÄ;Èf`Êp‡¨5U™¦åvÊÃØÓ£¹¾	—„’=Áõ>Õ2²;	ÛÉ­©FIêfÊpos$ÿ\0>zžiUÝÄ3°g‚©àçÒ¥‰’öíÖ×÷J˜ÞØÏùüéò³d¹†H®$•ÊrÛGoZëŠ¾ŒQ™+î{•Dh×y=ñþ4åŽxÑ”LJÙ8Æz~\"´etÈ”®7“Éõ¦@É&ûI[þëw_oÆ¢8jqÕ#©W}YÏ®š2ºåã}Üwª!î¦u”7•S•=­vSDñ0‚`Q†zs—1¤‘3*þñ›ŒÖ¶ìÌ¥PÌ’(ÆF»p=\0¨¥!’$!œà}ì\nÓš(ŠÚ”3´Ç ëŸóÒ Ž$Xu¿Ì˜=x¬çM™s\'¡YSí0„WÞÈ‡“E¤ECª|Á>cŽÙ©Õ¢…‰P (w:ã>ŸçnÞràŒ,N	Ü+žHiX©mN“·+>@jƒ`Wû8;ã(7;ðZ¯Å#yAfŒ¤ìËíëUÀÁÎ>3íZ@¢£$R€\0É‰úúTÊKÍ˜†ÀyaÛ³[˜‚îln…69`XUKŽG#½jéè#ÐR4òƒ§Ò[ºn‰“£cžõ {eVN_\'njA<_)/¸0kÓg;1#·½ŽâE_šÞg<à•ÐC` eÚ¨Ä–ïœÕiæ(«±|Èåôê?\n²Ê%‚8ä;C¾µÑFžº…Ç6ÙÕ &²nàÄm˜®ìŽ:àÕ™e•_dlQrÅU.\"œ‚&;¸ÿ\0ë×­Éû¦NRêc¤žTm²=ï÷~¸¥kufì.L´¤gÔÖå´H)^0—))Þ>ŸãXšˆÃÉ Äãþ&oJ%¶m±cåC1FRãL¶µ¸Óï.Ý˜ºÈ‹€z\\ûÕ‰7ÎálgA|vkj0&F.Êz\nËÞ4ŽÅq7Ÿþ«•SùU+i?~ò]+KIÜ;ÔÌò©`°n€˜ž†©ù†6sýÔ¸Ê“À«åîEFC½äVEŒ…i˜çéPÝÅæmXæì77ùô¥š[†Ìv­å»G°>•@?“¶9di$˜ãéZF]Î\nŒGŒÁ}o*NþSü¥S¦~•&¡ij®’˜>mÎ«üf¥°hb.°4fáXîWã\'ëVeü°ÓÎX‚ðŠÒ5Ð\"×Cš–&ù¤aµdúŠÏY6‚JïPr	­»•I$&9°0>R8üë\nI„acûçr:Öñ›µÆNgÊùªfŸsŸZÆž¡’_ 4×S¦íö5»e*<Ì®‡¿b{UF9Õó*Š¸ÆOÞük^vŠ9™áû;™¥EÇýÿ\0Šâ6¸¢,Q¤^qèk¡h\"•Uåsæc•šñl>T±nï]ë>æRç!ðV‡­C§ØjT3ÅÎJŒ°ÏLã½|Åñ;ö:øUã¦¿þÅ:|­pÄùD³Ç»²’Gµ}¡voàò<ÄJ)o3Øú×)­ë–æÆv”ù8ÈôÀ“_Y•ñV;eJ£²èõùkÐàÄàéÕ%Et~)øÛá‡ÂßÜhšuÇÚ¡‚|øiŽ*•£ùóF»&Xúú×mñwS[ñf¥q\0Û¨Š½¶ñú×bëO©äÛ,*A¯µ~ù†ÇÎ½T›»i?¼ùá!BN4Õ‘y=Är´Hm;?Ù¬»+T½i>Þå÷(ÀëîjMN(Úá®\0/\nž­ØéN[”1‡ŽTnB°þð­y¯©Ï*šÑJšdS¼j^U(Î•I¦Û½ûM{{/—1\0pE-ÆÙÊ:|®N:f³®n/!qäFLGþ½iÆN¥ÝÙOZžêW[üŠN+œF‰7$›Fq×5v{Ï\"gŠH|ÙYrûµ,\n&¼äÙ*HHjëk$ŽYSm²¼	jñ\\é³Gç!‡­hÙÙÇ§ÛH°?›pSœõ8©¬n,à”?‘–cÌ:‘E´E.‹¡Änå³éSV­÷\nT¬u6’@K\0dÚ=	¯Ðÿ\0ÙÏA´Ò<\'¤ˆBO&©©¼ó’Xî\0Œ÷\0+óÛ@°½×<C§iZ}»¯¦(›¼,u¯Ô…Q¦‘o¦Ù\\ZdÓŠ,hŠøÞ.­àä¯¿ü9íeÔÜª¥kŸR_[XÅ•´U‘\n\0@cPµŽ‘sj£PÒ ¼„õŽT»Z{”6ááPÍ/Z,õ<µœ\0¸ÏjümâfÚwØúW†¶èÇ—Â:m´É¦éé¤,²–>H\0þ\"³×ÁnÚy¦›¾aŒJïå¹ó\\³Êêßö™eX%¸0¤õ^+è°œc˜Ó’’ŸË¡áf<9„Ä/ÞÃSÉî´BÛ÷.7ñÂ/ÝSþ{ÕH5ŸiÒÇž{XUùyÓ¦{&ž‘<$ê%”6y¯]éz\\Ñ9’D`r¸àšú¸ø‘R)sÂýú+à<<¯*Rqzÿ\03Ëô¯‰Z²È«zòOäLw*œn_®+ÔôØÞn’	–Ø_66#åÏ®k»ðm´ó<ºvÈPƒ½{Ÿ¥c/„.\"óÝ¥XÙã–Ç­}Ž°ušŒŸ+ó>CÂXºfþ‡Óš7ˆeÜ’	P¯ú¿Qê;×E¹¶|ÊÏ¾ó!Ç8Ïôükã«OO¤K2_2KþçÌ…Çò®¹~(Ì¾]­â²«d«Eƒ“ñ¯´ÂbcVÒƒº>w†•ãQYŸ^Yë¤Š^`…ÉÈPk«Mi!XMÄÛÑÎBž§ßñ¯ì~$é7°<’Àï¦AÔþ¯FÑüEiv.Œ·ÊËkm¤ójï¹ç3é+mQhÍ¹\0‘¹s[ud±·™pÓ\\£…8R\0$zð>¸Íx6‰â‹g“fIu\0\0Üc=+­ƒÄÿ\0½•J	¡ügœú×-[…ºž©«nTïiÀ×µž%·$`¸ÈaÖ¼Þ=^$cÌû@À#oojè%Õ­\'ŠßÉO&MÇŒõõœwÔÊ«:;id….$B6:}ÓØTÖò]ªIp«½•IÀþ/þ½`Ø€Ì×;Ûrärx\"¶í\'óšuvˆ#a<qßú×Te¡…Øô¹_+.=û{VÅ’aÔ¸ÝÎ9¬$arR<ª!È/ßó­]ÑÃrVU),@M)TfôãÕ×ºu´\"àéŠž0ö›ƒ?îåoV\\H\'ŸÍŠPÀŽ½ˆÿ\0’{iAyÆr©ò«3šž}u*^fÃE¾ÓJÛšL¦ÏåIøtu;Ø ôsTã¸o ¬äå[#Ú®Ø·Êè1Ì¹ç°­ã$rÍu,I,¬„î%Õþ÷uýjXåãWýärJ>FÏÌGn9©™¹!O.Nê!VòöÞ¡$šé‹]B0¹:Is§±xNõr[µm›É£º\0äœdV÷YE.äVûÃø}ÍJÞuÄÐ¤«¶%n­Ò¢Iu6äfÝœ‰l{»ŽÜvö«‘$\"Éå\\Z´d«Æþ„ˆªñi! fØÈùºb i®|èü®™P¡ÍsÔŠ¹rZ’G$¤np«+‘ßa?Ñ tÁš7Ï\0õú{Ö{,‘BÈr#<.{\nÛŽÖá­Ùìˆu‘9Y8ëD#¡Œê²/>:–EŒ}ÑÞ›¦.es$·\'%¸â›.­±Á8’:Õ¥ƒÌxÚ/’N‡?Ä+¢+C+—cÛáFÎ¥HŠK!(KHÇýÒ¥P’ÒepcReˆgŸçZðÝÙKµK34j¶:·z¤®A1ŠuòüÈ‹ùÎÏj×HÑdY±n˜U^‡5žn]îG–`hÀúcükbÑRÔ9…a“Š¸Ã¹j47-\0d‚7vaÈ®ŠÒy.ˆ’Cóý ¨®vèLr[ïå°Pö>¸®‹LƒxËÜ1ƒÛëfÎYK¡¿äH6åp8Þ­XÍqi#M$BhˆÀû¹ª««¬|žASÐV ”ÈëÐ`Vùþ‡Ö‡.d¥­˜fÛ;,êH íõ&º[iÚL¨aæqœÕ‚ÒZ¡4°>Sß?ýzÖ±’Þ< 1IžHî(V2œz,q›°\0æºÛBÎ¢¨	ÏN:WÎX´hH;O¡ÿ\0ÞµšwdD¹Éß½tS‰Í8lFY‹Ã;„W#fÃÒº«$q2œ|£ŽõÇÅml²Ç$eÙœcqþ*ê­®fÞ±F\0ù±]ð‰Ë%s´Ò7yA²[èz~5ÓYÀ…DÎ¾r“ÎþÕÌiÞt`»³ü§=‡µu°˜•”Faº»!±Å4tšJÎòÆ‘I±²}Á¯NÓá¸m˜a°H7ÜWžé0êà‰NÕ ô5èV›<Èä@7Cüë¢1ÔéÑÏç‡•ØBÂúŒ*îmáŒ±dŠä4Ùc¹(¡‰Û÷½ë´·Q–VcòŽƒ½tÇc¢’-*H—\n¾^õÛÆº/.)\0VùÈ²bB†bvdõí[0)©\'%¹¨¨}žº2WŠuŸZ+ž£>ŠêQEfhQE\0QE\0QE\0QE\0QE\0~[^C i.•>6Ž~o¥ZŒÁs*Í²+óÿ\0?úÕš–¢O7ÊyÛ‚ÄsþE4Aq,Š~EÏ=+òþR½•ŽÒÖe·ŒÊÑ‡óOµEWÝ(\nžcÜõ®M/ç†Uó_äPX€zUXo»‚RÅ„W€þ÷4Òèv– wpŽòíU&q4Œª»GËõ®vï\\Ü-ìë#²g «ñ_Á;«ù‚ÚRìgŽõ´PÓYÃpêÝSæ?‰=sQÉdð€\"íA¹€=«F´;dSç$ã£{Ö¬MGH±%‘ó•ì*“-ËC;¯‰@þ\\JyÞ¥m9-Bø(NYÏ\'úV´P]F¿h	´ƒ‘Ú«ÜÙ<±­ÔÎJ#týU^Ò]Çc[Øb‘QÝ•G9^õ uë[ÞK‡óç\"ààgÞ›íÉ†?™OCŠ¥wµÃ–âåw¢Fm—¿µÒâÙXíÝÑ»ŒœzZÚ¶ºûZÈ*zóEŽåÝ¤š/%¡£\\qøÕÛmJæi#”³[‚ÛPý+77Ðô(É™d@R2:ô$ÕNÚ;…‚hÐ†cƒ…ô®NË„œ‰f8GVÆ~÷ëE5{›«…Š7H­¤‘Uøû¸ïß8¥ì›Ô¨ÁîfÞE§lH¡Ý\"¦íàŽ•˜Öv×ÀÁåˆ#\nw2Šèo® iKE!+\n^1š­k$,ŽdW˜Aeõ#¡¤é3C(hq€±DÈEùYÀù1Îj¶±Å²ùkö¦ÀÏ ÿ\0*é¼ç¼¯’ rX÷tò6•;’ ç×¥/fk­Š?ðPyínl|C¦ÜF‰¨›(ž$UÏÊ‰¼àõÈltì}ëù³ñŒÓ> ©ÞÎVPGý Á@^MO\\Õ%·î-lü²G-\nP³¼¶ò¯çƒÆá·zÍòCswæc…=+“QFV?IàØ¹áå/?Ðòÿ\0%$1ªEÉoJ¯©LŠ•x‰ãÖ¶oÒŠc,àp=«•¼–ÚÒ%ÉiD„z×4¤™õi™ËqüåV>TäTÐƒ}(†éÕ?¸|ZÎ­nÒ\\YÊêRÇ=p¥Q„™ç`ìÑ*g½kšQîvRw:YV1o<¯”‹,qüF°>××[JH¸HAéKiœ¥ªcn[Ö­]-¯Úmîá¥¸TØÙïXÎÑ÷&‚o² XŸ÷¥NO­9 /’EÄo¾ýÉ«0[	Š™S‘ŸÂ«]äÚ”U1Æ²ã9ëB¡ÜÑÒ¾ˆË[k{—Ib9»W>ŸZ¯+Ío(Ï$«|À*y!Ž\0·1ÍóŸNÕ‘¤×™cøVô©+êy¸å(è¼F¹PƒÊ( ±?ÅŸê+*âgg$—qSWî\"‚T‚yP£ÄÄáz°ÇO¥2[hæÃ«bØAÜþ5ÝN1LðëÓ›ÐžÝ!x˜ü½ýªXç²(DJÄÜ/­B‘¡ßL\0/z£6Ëhe#ÌÎãæô§-tCTÝîÇL»%‚LiË­kÃ¨@°ÈN?*çžF1ˆäbL:Š®V·G1<|ÏÍSË¥e6¶5Ì¾mÀ³ÉéíUçÔ-â`ØQ%`ŽqøÔW{­ÙFõ\0üT³Gk¨\\Ù¢&ßó±ïŠ;šÂ¼­ û=&–Ú[b`þó×Ù­&gFËöd89ïVMÜw¦\"ÛÑ†Ü”ÙçŠ8cmÒÊä‘è+hÀçÄr½deê%¡HÚ\0xQÀ?­aÅ©µ±\0¦’U«^Úf•ØH?˜¬Ë›{{·\"50´/Èõ¢¦¶gG­ÑVv®3æõ×SÄ»:ÀÉ€[·°«²ÛºZãí85d¿i‚A9-²R>¤W]8‚œ‡ÄÄE&äÊíš°ÜMÂ	ŒrƒÀ‚\\šIíS!‹#œcûµR:@eyJÇ‘ëÍzîLæØ³Á%šÛ7•ßÇŽõSUºŽXâ…£ œò*åî¦÷lpö¬Å‰n$Ì×e¸âº:­2(‘!&o$ÐgüóR\\ÏÅ¸ð3Ú¬2 -®ãƒŸJ¢ÐåÄ/ûà’žßJÆIL¯)-å¯”‰’@íQÜM;#¡ŒlNOÐÖ¤ÿ\0f0„JL¸û½ëœ¿Õ.­f¬ò“´8Tã}ˆ­;-Y‘·|à„ù‰|zVŒxØ°FŒØ$Öt7l‹*È…ÉëZþ‡dÒMx|Ëcÿ\0}rkª1i]ž|¥wcõköi´eðN‰®TMr_ý–-O¶1_][Dsç`´ŽÄWÍ\0ÄVÞµµ´ˆˆ$¹Ý†q¶Ž3èG5ô¶˜÷­Àó²Gµ0çÕTñ•gœŸæ~«‚£ËJ1}Bö×*ˆ¾jàÒzNÕ†)¸½†Wê+Fú<ðå”À÷k*Ksò\\F<ù$\0óíë^2fþÌÓƒPUäc¢mØ¨\"¸ÎÛK-€jèŠ)åÛòïÀÈ©<”öìÚÃ§½7&c(jhý.HÅÊÄý‹ÿ\0ô¬‰Ý$$","ÿØÿà\0JFIF\0\0`\0`\0\0ÿþ\0;CREATOR: gd-jpeg v1.0 (using IJG JPEG v80), quality = 95\nÿÛ\0C\0			\n\n\n\n\n\n	\n\n\nÿÛ\0C\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nÿÀ\0\0 \0x\"\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0	\nÿÄ\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁRÑð$3br‚	\n%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹ºÂÃÄÅÆÇÈÉÊÒÓÔÕÖ×ØÙÚáâãäåæçèéêñòóôõö÷øùúÿÄ\0\0\0\0\0\0\0\0	\nÿÄ\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3RðbrÑ\n$4á%ñ&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹ºÂÃÄÅÆÇÈÉÊÒÓÔÕÖ×ØÙÚâãäåæçèéêòóôõö÷øùúÿÚ\0\0\0?\0ûÚëRƒì(\\lŒ¶qÉâ¿¿Ewý¯sw4E¼Ë‰ óËWî~•ûO|ñ„®Fâûx/EŒÄY^f	Y‚‰ï?îçšüqÕ>|Yñcý¯Aø{©Ë-‰^ÜÆNpÏ_[‡´f¦­ÞêÇÑå*ÓUc8´ôÝzž_ðM:_?ö‰hÒfwÌdãIŽƒ×õî›.™6çÓïá \'	 à}:×û~Éº¶£ûKÙéŸüö›yô;éÒÖÚñÄŠSËMÛ¡`WQß¾¶ñ_ü‹Ã:ý­Àð·‹uY#`ƒQŽ;¤BAÁB7ucXcòê9šXT³µ»­õÔo3ž³§(]oæ|gÿ\0±ðíÖ«ñ{âï.ã$³ÚÛ_úoq$øäzB3ô¯ÐM[83€:×Î?\0ÿ\0à›?¶Oìq&«¨üñç„¼ee©Ü¤·Úf­fÐ½ÑŒ‡-Ê0ÞÃå•zõ¯M_Úk]øsv–´ìûâŸ¸m¯ªØÁý¡§ë¸a”{”ô¯[Êê+l’_×üÊöu+{Ð³¿Dõû·û®{=º2„Û¸ííU§²k‰ÌŒU€;@aØ{ýk;Â¿¾øûJþÓø}ñHÕâH÷ÉµÞÉÐÍ%þøÔÖ%°wÄ·c/“ÑO¦M|wó¼)%ñJþ¶_ðQïpÄ9q³œ¾Ê·Íÿ\0ÃÞÙ ‡j)N:ã\"¹ícMŠVmûv”ìGqŠéä¾´ž&’	‘û¦¹½bD.IÀõ¯Î•j}Ú©¡â<ð÷ÀÖ<i ØÍ O¤“ÜÜxvþ]=®]T•ˆVlœH˜¯™¿d¶´Ð5Wã–³“q¥ÊòYÜ·ð7•\'œøè~W#ñ5ë¿ðQ·‡~Gá«y™¬ß$e	çÊOˆÿ\0ð*ñoH>þÌvú4»ºÖ‚«Žø“ç|ÿ\0ÀßÆ¾û(©þÎŒ}¤¯9%^‰n×cçñ”°Î¬½Å¶ºoê{÷Âø,.‰nñ[|Pø{ul¹\0Ýés	ýâ­ƒùf¾ëýn¯Ùwã7ˆ,,ü)ñwH7³Ìª4ÝFémnþÙÊUˆíòƒÔWá,ñ¬ïýÕåOzµðâÆ[½h^I‘åòzqÒ¾æý’æzŸ+ˆÉpø•ËãøŸÙ†fÓôÿ\0Û]ùñ-¼vŠï\"·Ê.IÍøÿ\0¦ø—ûFj:>©£Oñ‡Åá²4K¡Ë®NÖj„c1TãºE}ÔÅRU!wÿ\0\0ù¬M:˜*¾Â->].}¿âoø\'Á+íBOÃ·šŽ‰$S¬¾TæÀä0<¬™ qü%i5¿Øá{úŽ§{©íFÓyH°Œù“_TßZé_cv3![æÈÀÀ9®vOÚËó+{cóÏ\'ËÜù½”oèzŸÚ˜îNWQÛÔù—Fýš¼àKûSÂ¶Ó§HÙÕ¬\n²°$¸ç9<â¤Öf:tNš¥ŸháÊmaøð¯¤WÁ¶ò1-\0V\'ˆþèw°3M	ô¬°¼¶PÑÿ\0XçÖzžá}oÃ¾BíÀYŽUÓƒø÷¬Ú_ãÃï‚¿	¯<yâ¥Žx­¼öÁL—3?	Á$û3^µâ/ƒzš †è+ËÄjšùCö¸øcsªümðï†üE´èú–uH­ä<My49ôÎ8¤Ç¼Ùì+š¼åB.O¡¶±˜¨ÓOsã?ºÚøæY¼O¬h¶>.êÚ}ž‰j‹21<4ÒmÛ¿Êêz×Ïþ\'ø¿ûDx\"îm[Nø©«_E\0ÒIvß!Ï¾qú\nû·â?Á|Vy48u?&iä\n“¤gåaža´ý3_þØ>!þÊ>,´‹ÅV+}£ê±·Ô¡Œ„Aù‘”ý×^>£ŸZåÂbjœ³‚wî‘õx¬¶ž4$Õ¼Ù7Á¿ø*wÄÿ\0j±Y|J‰uí(0Iîcˆ%Ä+žXãï~=}kîO|HðÏÅÚxïÁú¢ÜØ_À$‚U9ô#± Ž ‚;WäW‰!Ð[Q¶×¼3Kç°DŒ0IÆx ŽkéßÙsö­ð?ÀëýSág‹ïF›¡ÉdÚ…­Ä™-åXCÈ\0IWÇ@8|qópñQÅa¾³„…¦·Kªò]Îl³:ž·±ÄÏÝ}_OŸaßµÖ¥sñ?öšÒ¾[6ÛMHã˜(Èÿ\0¼ÿ\0ß?*á¿jO›ßÙøJÑ¿s¤Ú•T`	$Á#þø	ùšõ_ØÇÁ‘þÐŸ¼Oñ­]nmÃ¤\'?rY’9èQ\0GSãWìñŠ÷ÅZ§Šü+}k©-õÓÊ¶Óƒª¤ü¨	Êœ’:W›†¯…Áã¡†«%gküÏÀõê*•hº°WR};-—uYZtÑòY°yë]çÃ/\nO-ˆ¶ŠæÜ¸QÎ3Ç¹¤ÕgŒžÕAñWÃMbÒ<Ý}žëûÄ?Z÷ÏÙá÷¾%hÚjé“Qp…å0¼{ãÑOÆ¾‘8â$£MÝ>Úœ>Õa¨Ê¤ô±öçÀÏ\n[þÍ_°µï‹æQ«ªÀ¶¶?.¤[þ»åEhþÚ:Ð´X´ÿ\0‡6ÒÍ¦x\'JYµ{H‹ÉqxêBŠ¼»à*€9$‘EvfØ¥„®¨)òò«|úÿ\0—Èòrœ$ñ4w¹»üº~·üwöŽñßì·¤Ëñ7àçÄMWHñË\\Á—áølóNñ0’E‰b–#dÀ°Hþlø®ŸIÿ\0‚ƒ~Ñ?²ÂêßðRÙòÏKÕuùšÛO“áþ½¥<×W™Ú¦9HWÜèí+Ë®åSOþ\nSð[Ã_´WÂˆl5‹»«Ký#S·¿Òµ]>QÍ¤ñ¸ehÜ‚ã<‚:q_žOÇO‹¿¶íªß¾%xÚÿ\0Åo…ì¿±4ÛRÚ6º°ŽR±BˆˆÎêIÀÏ\'$×¡V­:4¥;},±U£O§Sëƒÿ\0Iý¼~(|H»¸øQðŸÃ†‘ØCg«Á5ÝÈŒti%ŽT@øÁ* …Î2Ýk¼ðíáñãÂž0°Ô~4x~mCA¸tÅÖ˜VO±ÆNþÎ\"a-ò3’\n6w/§É¤xM‚+˜D`¯Îäç$dôéš›ÄÞ,Ð4ÛX5oíO.)PùqIÉÈöë^\nÌk9ÝØú7ÃØGO•oÜµûzÿ\0ÁH~*ø;âO„<Kû;ü¿Ö~éz ‡ÄŸæ°‘ô©®åÄfRˆ÷H¾kþèÎU2JÑøÕª\\üNý¦µ=^ËK½}ÊH¼A>Ô†å¥´‰–Þ5Ý¸Y™¸NyËTß²Œ|;ñÛÃ1ý¾)xãKÐ|7{5¾µm=ó*—²7A¯m¡bÊ™‚Ç;Lò62pß<iðò/ŠÚê|Y›LŽ+—·Óü?Ðù@™Œ‘“€«´©+ÜUfˆUÂÇ•jÿ\0C—#ÀO˜Î3_\nµûÞÖüµ2<)àÚ~$Ãaomá)<1ÛniÌéwåpT®VnNsÀü:ø(çÂ=âì©Ûø–Ê¿Ó\\X>Î|Ð1€}ÆEv_¾,izÂ[Ê¥Y@…tÿ\0<>3xBËÃ6·¥´²æêGl\0£®kÅ£RnªiZÇÔâh¨Ó×[Ÿ‚ü5ñA¾7þ³šâiK=¶ß™@ç>ãÊºoÅöÚO†¼C}¯ør)›XðÜºe£Í»[ÈY_r‚89Ld:äâ¾Üøû1_jŸ`ð~›ðéô¿XZ^m×„âº•-šH¥VˆÂAyïŠøSöž×|<ž0×¬ü&ý ë³/j0	lY‚0ÏO”Œg‘_]ƒÄÇ¥JKEgøŸ™`~ ©ÖOY_Cí_ø\"î«¡Çð7ÄV2H±´~&|ÝÌ0%-CiôÚ\0àŠûGÑ-/¦_-REl`¦5ÀÁàŸš»ÿ\0óÑ~+j½ÖŸ¬øËV½ÔZcµÒHVCD¦8bÎ3žsœ+ê;öñ·‡õ„šÄZßÁ¼n›O˜Ã&=J’êkà8‹!ÇVÌªâiFé¾šôí¹ëå9ÖžjNÒZk§ã±³û?üÒµ›»u“J÷á¢¯­ìåðÂžMNëá\'‡ìþmÅøÒ!³\0qûÀ»³’{×3û8|0Ò|9Ïªê×)$Ê\\Â@c%Gå]/Ä¿Ýjú£øcM¹¬§Ÿ*)Üò¹þèãñÍxùn3£vÓ‹}uM%¿Ï±–g¡‰«AÞ+3æÿ\0‰_±ÏÃÍkQ»ñ›áË8®î®æYV—œîç8<ö4W¼Ý£GË,BàñEz•òÈbgÏU¶üÛ™ÙC6«†‡%;$|—ûDÌSÂ—q9ûÉ_œŸ³‡àð/íWâk%6Ïgs­ËtwG,ª®w)\0rÌä$ãƒÅ}ññ—Äw>\'Ðg†Þ2T.Ix¯Íï´OÃO´]…÷Ž#Õíuyt–à5œÖóÈ¢G—$lde\' €=ñ÷yŠ©RŸ-5sƒ(ö›•gf—ùiüOý“ÿ\0g/©k®|QÑÒg°•&…Òòhæ—8ØèêS©àp\\ßÆOøÇZt?\n¼Má2y,ôÏÙÔÄY\0&ÙFrºƒ•<\0CVN½ã_Å>’ÓÁ×ª··P³¼²b5b8fÇQô¯ˆ¤ƒö¶ðÏíaãOüMÔu™¦Õ ‡UÑÎh­`‰œä’<½¨	#æ%€=Nx¸u:iËáÚç×G	N¯4¡ôÖÖÓÏtþë¿#Ó>3|+øÍðkQÒ-¼âmÆºüà7iÚ/fµe.ÅŒJá‘9ÛžyÍk|ñÃˆš¡yñ£ÃÖéâ³Ô:¾žQ2×årK}¦½à7ˆ¼WâoÚÏO×ü=cª^Ãáûgšñ¬mÝÕ†ÕI\nƒ€y rxŸí‡ã½Wã§üTñô+ûÓ|&\n5¯“(ºyÉRàŒ“°Œd\"»hà+íœ¹e¯M™K/ÇûÃš6[=V‡_â?Ú7@ø{ª‹O‡Vh––üGacN~êÐ{+Ð¾~Ø?~2øªßáÇ„¾KâûÆû8´†]±Ã‘ˆÀàò;O×Ç^†çÅbMÄ*mîà¸2£Ì½Cž20Aïšûïþ	ü¾ýŸ>xÃã °Š-BÎÙíôpÊ12gŒòK@[©ÞÙëçPÃ7ŠT¥+uoÉj{xŠÔå…RQ×¥Ï@ñ¿Àx->k?¼{ñ_N·Ö.tÙlÒÓD±{Ëm!™NË$‘™Iù‚Œ‘»­~^xßþ	Õñ–ëÅw¿4ŸÚ_[E­E+xÖ}\\Á¨±0	 \n†“\'åf,ƒ°çëÝKãf¥{«!½–æîêR@¹årrI÷ÎI?S]ªßXÂK€×/þ¶P~èþêÿ\0žh£›UÃÎ^Ê)Eíý_ÀáÄdø|Zµm´}ûünÙ{öqðGìá¤|+²ŠÛÃZ$V×wók]\\rÓJ±…Ü»ägl61»+éßþÓ>ÕJFÈY¹ó#»WPb¿5n<vÚxcö’î3‚½WÐ¾2xŽûWM9/åPòÚ®yúÒŽiŠ”õw¹Å_‡²Å¼îÿ\0ÌýšðwÝü1–ŠËo4`¬±¨møü=j¸¿²wvòGÌäîÚ2së^[ûZø‡Rø.uá,±És¶ÒI“\0|Û}GAŸQí^Ü¾€ÀÅ‚GnµîBJ´¥ÔøŒB†*pwIîfÊÐÍ))Î8R0(­FðÐ… ‘ŽâŠæxW}Ž˜ât?/>+üM½ðn‹|a¶Y<ª«wëXÿ\0²ÏÂoÙ7öáµ¹øyñ_öW}3Æ7Þ¹µ_ª=ÄèÙöÑ’2ªÁº,‹ÏÊË–<÷Æý}.>1ÙxQhÄ­,Ê;•ÆæJõ„ž3µøkã½Æ«t¶†Êfå0Ž9#hˆ=@W\'Õ­lt¨c#Mí³ô>‚m•H¿{uòîxgÿ\0`OÚoö`Ö#ðOÃŸYøöÚv–ÃI¿Ôb¶ÕáµB.¨e0eIô¯ø‡àÛÆVz„_cÍeµ;g+¨_K¨ZH-Nê’“œ{#¨¯Øêš7Œ|\'gâ½OWÓou‹kÉ¶ëñëùŠŽ9Œ`\0\0ãåšúÿ\0Àû=+ÃÏ„|á›_K¬_½Üš®“Gí3È«ºà®9rBƒ¸rsé×,ª”¥í\"´zÙ_™• «B>ÍÊÏEv¼õ}ímRI½ÏÈ¿ø%OÄŸÿ\0³Gü\'zgí[ûGi1x‡Ää­íÞ—6ÛWÈP‰pDQWËùvs“É¯+ý«o´]sã¿‰âøoãH%¿\n§Oho”ÆÑ4hTÈe‘ãÝ¸v\0:×Ò¿¶7ü_ø·ñßYø—ð‡â‡4?O;}/L¾lW<›‡Ž5Œ.{íÞ<äWÆÿ\0¶÷ìÉgû/~Ð~—Â½ÿ\0‡ï4g´µÖãf?h¸R•`I¸‘CmS·dd–ÆU}´¨¸M+Gku·è}TèðÞT1XÓi¤ªBIZ-¥}RZßT½çkÝ”¾ü3ÕOÅ›Ç¸žâõcŽÜ½ÓÄDsIûÌªž˜@xöõ¯°/luKßƒ7?4ÍbßO–óX[»Ë›ˆŒ›¡QB°Á&<dôÐî¯/ø1ñ¯á‚ü½ðÎ§áûù¼Eá]Gtry»aKkÆ, `ò<ÈÛƒŒ3ñ÷ª8>\'ëz´íö;f¸šWÄvðòyéZññöçƒ»”¹µY*µ6µ™ÓÚh>	ð™.†{©ß\\¹ÂŽŠ¾ÃŸRkWñîç0Û2p­iZ|0ñÖ¯{·Š!þÍ’hÖAÃm}­Ðzg:×oðßà7€¿´æ‡Ä—×SÌ°†¶Š$«ÉÁdmß7Ý\'²çŽrÃdÙŽ1§Ëeç¡LLc¤u8¯‡þñÏÅ-rßÃþÑ//®îdµ¤#ÈÇ°Ušûûö9ÿ\0‚B6›}gãŸÚày±è0JÍŒq+/ŽGÊ>n¹*k­ý…|_ðßá•ªé~ðÖ™¦Oq\n¼—0 iÙ‰Ûç pAÏ\'qÚ\0Í}w¥x¾Ó^´ŽîÓQ€I°²8ýðþò÷ïïšú¬7C9>gÛ¡òùÆ#2œh+.ýàtOéš5•¾‰¡YÅigkŽhb#AÐ\0:V«YÓkFºÖm4»¯²ÝÈ¨ì àÀæ+ZËÆzUÿ\0×8ê¯šÞ¬•­±ñ*•Jm©n>kT+´&xäƒúÑVRúÒáv¤èr>ë+/f‹ægàoƒüI\'h;‹«Ù¼Æ†Øœ“Éf~Oé^Õñ£ÃwzÂ»ýAekeM•þÑå–ÚN^;WÉß³‡ˆ/o¿i5··¸A²ynCrNBÍ¿Jû»Çºd¾1øUscqûènlÚ\'€6” äõ¯™ÆB?_´žš£á¥(`×‘Û~ÊÖÿ\0	þ,xkþK{­KÃ¯dm­5{k™\"†Iä“ÑpW.ÎÆOºð;×ºø¯ã.ƒ øWYÐt/^Ñ,ü\'®gÏw«é³0¹Ês-¾wI4,ÓybN™VÇ\n|õð»Åúg‚t}KðßŠ¼)cšÊÑZÿ\0Ê]Ñ 0©–1ˆÔ8]À‚JäkÓ¼AûQhñÃþð&¯e®=åçüOÌQ³ÈÊà¢yg…Q¼õ\'yÚE}u(Rœãe+Y6¯éÕ;\'®êþGÇb9êTPiµ/{wdÓëufÚM.šù“Yü;ñÍ÷Š<Q­|N}\'VðâG\néÚuœÌeÚ±n¸Y‰à¹fùTvUÉŽ>]ý¾üà»ß„Þ0ð?‰´-;RÑlõtÕ¼!©xrÉç¹Ó¢Xƒ³É!%xÛt¬Tccä‚GÓþ<øyã_øãh¼!¥Þë’j(Tðì7‘ë_wÎ…æ–Pð<˜Ø5b‚&8Áñíu®|Qøªø÷[øÉ­G¨xÛZÏá½-Ä)+	-JÝÛ°ò±³”e%NâpQ^ƒ–NÚëŸèz9MgSÊK[Z:îšJËnge{n¯vŒ¼â_3kž‘àëÃ‘Æc¿ñ¹kåIzÑäã2aÈSÉ;UéÍzŸìçà),üR<]«ÄŸfå­ÛÌg=UC”ðFHí_)øÏö›ð‡Ä(­¼h£OðÍÂHlíáÞ©o-°ªõÜBðsõ¯®~ø—]ñŸ…ô}kÄ£O²Óu¥Žm\nÚ”	íÙ1àÍÈ,p[ \nùÜ\nXšüÍYEŸ¤æ™wÔ8s):‘æÓ¢¿_ëÊúÕâ­Yõ]3ûb-YÄÉìˆ0WÐ7oN3ý+›²½¿ºš+øK[Ê&sÀ#\0>•¿©è6°Zy³­Ä1ŒÈñ’ÿ\0Q–ãéÐTPêÚG…Q!mno¦m‘Eqx×wüôÏAÓç\'·$}Ræ”¬Ý’<¨áà¥Í#Ñ¾ßjZ¶´÷óêÂÂÐ>d¾w Ã;‘q–a»®9èIôúOàÆ½6ËÄp|ñÆ¼-5‰a¹µHÈ2!VÂã#ž›°{|Qk®ø™üCý©pÛOerÖ±XäŒ•˜w ú¯Ö¾£ðÇ€4¯ÿ\0SÆ>Š;}{Jui¾Í6œqÉ†÷ÇP+ÕÃVŒ“Kâ_‰–2µ*Pº^ëÝö}õä}u£x]u•—Â!Õ>Ñ4P<–±±Þø<e*O?+Ùþg©x«\\ð¦ læ¹=7E È¾£Ó¡v ŽÕ‹û9þÐº´Ò§„>%Bmµhœç\0bwUÚ%‰LpÈp68\'Ñ¾.x[Lñž•¦ê6I/®7¸†‘#˜«2¸“êÊ Œç9â0ê´\\£¿õ¹ñõ°SxžY«ólÖÏþþÏX||ÔìSÎXzœÑ^¨x»Æ²gÔfŠñ_5Ì%„š??a¿ø›\\ý¤æñUî‡5¾5¬¶ÝMŸr8LôÎÔlí_ªÞºM[Á^@ÆF?\nø7Á°µøgkg¡Y¥­ÍŠ$új€²\'Ìÿ\0{Þ5ôïìûñ«KÖ|+nâ|cÑŽ\n·p}Áãð¯Œ«[ÛWç>ÿ\0T©)S,z/ë¯sã_†^-ð—ÁïÛÆú7×^Ö¤ŸÄW0[ÚÏãŸ°ÚÅ˜Î±°¸a\n¼fPªqÜ“öG…?oOÙ“Â³»øoIµðþ•â«kîì<7e,W1#o”ÏqèËm•fœ\0#?ÿ\0ÁYþüFð7Çû¾Ðç—ÃZÝ­·Ûî¡„´Q]¯îÈv–QàœãœŠóOÙ×âo‚®<gc¨ø·@Ð§¹H¥ˆÙxš,ÙNÍ*³Ê	V!¶–]Ûväf½Xâ±´bšw‹ëÛî×Cè0ùñ=ÔåF´b¯¤§$µ³“²rÙ+£ô×àŸíý¨|Vý¶µ¯ŽzoµmÀƒÂYh¶:pŽÇJ™c‰œÉ¹°e2yÊ%V.V@\nìäÛ÷þ\n7áßÛgÄ¶ÿ\04ù:u¦§çÙ\\^²©kÈ÷èYr–YJŒõê:ŽËö?ø[áïÙøßöñoÅYdÖ<C¨(‡TðÞ3éèÛ•EÀ‰Cq›r´Hª©÷ÝyI©øGà?†f>3ŸF&M%õt…Óüèu;§W	—*¶©nê8#iÏŽÆ%ìù®¥{ÚßÕ—æÊË2<›+ÇÇS4¡ìùe8´”t|÷V‹”ÔMû·j÷>kÕ|ñOÄ‹à-7K’-Á† ùÏî×\0=€ôëßœ|ø~¿u=7\\ºÑmïÌMe~V[yÈ`””)ä.Póø\0ü)ñ‰àùnüG®OOzþeÃÆ€|„ä ô½çÀ­>3xFf;^Fd‰Y7aÝÏá\\”ñøœ#J/Í™çxŠY†k<JZm-h­¾ýß™ØÚø—Ç_¼eâßƒ>=¶¸Ógd†Õä04‡ø— sT¶AÈ=*+-ã/‡´Å»×ü2Ø<²[Á7›,¤}ý¹=F	éÎ+À<eðGã\'ì¯ã|aðãÆw6ºF¥2ÿ\0hÛÛÜºÛ«îÿ\0XÑî\n¤ô/ƒÛ<f½ƒáü+ãŸÃÛk[?ik{¸*xD‘L0FVNN¸ÝÏØ¯©Áâiâ©ó­¿&y´¨NzIßð¿Ç:wÅ}:×RÒïVRÕ>Ë©ÛË€ÌAà}F8¯uø1â¿~Î¾0²ñf…¨âÊä…½Èˆ‡Ì½ÕN	plÕÙk_øÿ\0Ò5kø|=â½:¸¶×-!0Éq	ÈùeLB7$6ìdqódIwð§âÏ€õy¼ˆ#Ôd´Ÿ0Ç©*«¾;‰vÈ¬§î°^sØû4iÞ*¤ÌNR¢Õ»§·Éö>„ñÝ‡‡¾ èéñƒÀ–ÉNûuÍ2/˜Ù]Ë äíÝÈõ8÷ô¯eÖmíü®[¬ð\\…K¯,3|Ù.€Ä)nxaž+çƒ³x«Á~$¾ÒSPû¥Ë­½õ„ß(ÜÀ”TÈÆv–À=BŽµêzwÄ=Âþ&þÁ°Ð–k;ÅÔL{Žìcæ<ä{ð¯FoVx²ËeN^ÊZ­ãÝÁ_¡‰ûW|Ô<!ñTx“I´hôo\\É${Ð/Ù§|Ä8à) ºŸî·µìŸü1«üQýœµM…šê]Qe{<˜ÂÊSd\n2qÔQ^u\\#ç¼Uîy2Ë1Ø—zNéi¢¹øGð/ÆÚüú-žŸã->M?S[t7V3:—‹#€Øû§%O#8<ƒ^ÑðwSÑ¼+¬ê:{2¬WR‹¸sÑY†Ägþ^AñCáG‰|	ã;Ö¹‚XnËÉÄq*–$0=Á¦hŸµ[W•­Õ5+]-¾ÊÒ?Ë»#>‡µ~ŠÁÊg:kÝîá1‘ÅÓTçñ~gÖ÷zç†<MàíKCñœúÕ¡‹QþÑÇ”b‚On{ú×æÿ\0í»ûéÿ\0³¿ŽbOß­Ï†õï2M.##Jö¡væ6r¸#æI;°9é¸ýkàï‹Zæ©ã´Ó£Ðá»ð¦¯ábuˆ\'ut^pç;‘•Ê²Ÿî|ú)øUðk_ðZé-¥Ý=ÁH ¿s&Ž=;V¸HÔ’i„0Ž]U±ò÷ìƒ«üIÓ>Ùi–¼·sÝˆÏÚo\'Xgµve/\"D¬[(¬ñ´‘œŽ•±ûc^øTðu…·‡<o§Ü]‹£q¢iPÝFí#ª4f+uV\0.s‘ƒ‚[ /Yà?Š^ñ-Ï…~hâ@aU‚ãnå†Â¨pÜã$ã§ƒ¿aÿ\0E­7Äê6í« /\\+ÌºYxˆuÁ_ºNqØú”àêK–KMŸ…WKûÏw_]?­¬|¥«~Ìÿ\0í¼)ÿ\0	Gˆtkéã”–t²ËÃó60\0€x8Ç\\òF\0¯¤¿bßÂž°Ðåa·+î|¼Â»o	u-\n=>ÞÑu[Ÿ$¶›§<¬¶öë!lM19|)sœ¨`ã›öqñ_À;5ño„ç—PŠX’}Z™AÎB–!W‘œó‚Iäišå‘ž{šŸSR‹¥i¾§¨üiÒtxB}.å]üÈˆd7±ë7àÏÁÍ_Å_!ðŸt”];qxèðäáås×‚	1sá4oÙ®¬²$¥+uVˆ<ƒ^{rë µñ”Åå‚UÇáà*âhsB×ß¹¥)Ôk–,Îð_Œ,þ	þÐŸ®ü¬­‡†L‹©ÙÄÉ­\nˆÜ0ãwœg¨ŒWß?ü 5H¬|gá‰­ü‰£\"2ØmÑ0ŒIê£×¹ùy |ñÄ[xæûTFòí,V)1&ucŽ˜Û•æ¾íø®øÛÁv†ËJñ:[i—[çÕåš˜3Ä¤3Àí!@û¿xm¯½É©K†äŸ]OK[IQœçŠi«hÖÿ\0~ö;;ýSÂ³èÐhŸ®<FW³’1æL\n¸ÚûO7\09ÇàŽé©4Z=Ö¬iMéo&K¢&*YzÛAEÇë‘^9â[¿|EñÌßVÒ¤­°‚5…„‘Æ9q×q`H •^s×jÛÆòø£á”—z!1G¥_,d!hßÌbx?/ÝŽ½yMjŒs,}œ$´“z«è¯Ðú;Âß´/\\ÿ\0bÞ$>]Õšÿ\0fÍ7>`.ß»vè\0?.OvoQ’¼gCð®©ñ+á}½¾™m%Ìö’0n$L9Ü¤‘»©ÔV|öÖ×¹ÃK•j«Tå’vz_oF¬y¾xkÇQÒ|I¤Gqa#æŒú«E|Ãñãö:›Ã¾šæù5	Ì)j ùÓ#?3/}@¯ºG”•B~µŸy tYü+ä%ÏsóØT”‡çwÁÍ5¼	kªi×+åÌ’#\')ûÑƒŽ9Ïíf»KãG…ô˜¢°Ó¼ÙQ€«d®qÞ½[ö›ðW…´uM7BÐmmïõ&2_M\03&zî}=+Ÿø=û\"Oã]cÄQKkcœ¢*âIþ™è=ë’4\\&ÔOigU–4¬½Þ£g-ZÛÇÎ§­Imr.!|À6ìcŸÏ*?*öô[y¬üëbUÔ|ÀŽõ¹á¯„þð>œ4iÚD\\ Ë9õby\'ëW#ðüq]mgm¬0@®ºQäŠLò«â\'ˆ«Ï\'©ò~§ñ‹ÁŸþ7Þü0ñO„m4á«^î²×Ôí‚[—ˆ8K€ü\0O³·v2\0;‡¤Ü^è–ºF«­£Er÷lËa,Ñº®JF§ÍåäÛ‚ðÜ±#\"ÛöR´øÙá	môt[]bØ‰tÛ÷ØêrÇU$WÍßi_|yþ	|[ðŒÐêVÓ¢·™w¶HíÃdˆ·)DOÌ¤A$drß]ö-*«ÝïÛÕ~§Ôå˜øW£ìfõ[>6ðŽþüFÓ¼Xu+4Ó5(È¸Ól1+u$p2NAÏ$œ×±ü7×Ÿã„,¶ò.g\"¦¥xb+ÉçÉ\\ã.ÃöA$ögá®“eñÞ±^OL¸³aw\nÌÆnÞnÔä‘žÄ¯kÑ4/ü9ð%¯„|<–°§žFŽÔ>ÑŸ™Y¸ùò¾§Ž2\"º!—a«ÖUÖß™ô4iÆ•)[®ÆwÃE(‚þêËÉm3Í»öü›QE\06œŸN•æš·í¥j?¬~\0Û™%Óî¥+­kWL½Ã2yP‚?ybÚÛ÷…Rý¦h³¥é—ÿ\0þj»5ÝCiÖoR5O„áŒ{ñË±Àï…\'¡5ñgÇÿ\0||ø5kiã/áå—‰4-8F×\"ÍŠÜ[9c‚”=rÆw,Ë\nîŒ§i/»Òç’ç<.#Û?²üúuÒçèï‹]Ðt¸¼7¬ëÌ×]­Õ­Üm‰%EWPÌúûýr+[àDQ]x£ÄµV[ëvrO1\0Ù:æDÀê	\n}à|û>ÿ\0ÁPÓã£j5¿ÜÇyréåÜšŠ²H0œ…8*K)c‚@-À\0WØZ>¥ãÿ\0êq|Pø|²F‘È;uùíf`.:îÊ“‘Ô`Ž0ku‹¥9>WvºyÔëSÆ¥$ÒRŽe}Ñõ×ìQáå»¸½Ö…ÊIglTÇZ²0“£œp9#Žàô\"Šï¿f¯Oà…vÚ%åÌ“Ý<K=Ôò6D’67cÐ€zEyÕ*Ê£?Ï±²Ææsš~êÑz/ó<e4÷¥6M3óýoÉh‘¯Ì1QùpãóÑÞ÷8o|3ðÇˆ5;}STÒcšæÕ³­œ¯å×ñ­{?4`öÒ[i©+y¸ü(¸´W®8^ÂªÁÍsÔt×[–,˜¡ÅPŸLpâE¡ÏÝ>Ÿœ=*Å‚.B ¸¥°Ó¹Ê]h°ÝC‰\"ÆáÐ×‘üpý•þücÓÚÃÆ¾µ¾ÆL:bXûÑÈ¸d>êE{ô¶KéTæÑÒVÈ^hi4i4ô?.þ(|ø¿û$øíu/„^.½Õm¢„g+{hœ†@Ê1ë†õÏ~ƒÆÿ\0ðQüBÐ_ÃÞ\nÐG†ï¥A þyi£ÀF¬ªbç8ÎvŒ#¯¹~0|°ñí’Ëmo^Å²H0HÁ@ÏGÿ\0^¼/ÅßðN¯‡>+g¾ñDÒµðÅ5òLGÙ‡\'ù{W,©b)ÂQ¡.U.ßÖŸ#ÝÁçU¨G–nëñ>aøumá¸Yç¸ßsq&ùä-’Çêzõ¯EÑ¼icu·™«# Ö7ÄØgã€æ{¯x5»dÎËKìCp£Ð8ù_êq^[qâ¿|;ÕKñ×‡ïô©ÀÀ°}›î‘ô5óÕ0¸ª-¶®z´ñÔ1IkæmøËörøkÄkoü6H4«×¸óµ->(¿Ñ®Xs¼ #cg©r2s_W|øÇâÝE«­…„VñZ¨(û¥2õ\';9è+ätñœWŽºœÌÏÜ#rkÑ<ñQ¯tS`±•røpç×¸¨§ŒÄ©]»~gUÒ¦¡-cØýý—þ1é_¼u[1sÇÛ˜\"?(8á‡ 8<{Q_3ÿ\0Á.|v]»ðÄ÷@}¦Ù‚.ˆ|Ãôó¢¾ÃQÖÃ©=ÏÍ3ü-<&e(ÓÒ.Í|ÿ\0àŸÿÙ","307_IMG_0594.JPG","image/jpeg","/../ximages/item/22","2207950",Null,Null);
INSERT INTO item_image VALUES("3","28","ÿØÿà\0JFIF\0\0H\0H\0\0ÿÛ\0C\0\n\n\n		\n%# , #&\')*)-0-(0%()(ÿÛ\0C\n\n\n\n(((((((((((((((((((((((((((((((((((((((((((((((((((ÿÀ\0ôô\"\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿÄ\0@\0\0!1AQ\"aq‘2¡±#BÁÑðRá3ñ$brCS‚%4¢’ÿÄ\0\0\0\0\0\0\0\0\0\0\0\0\0ÿÄ\07\0\0\0\0!1A\"Qaqð2‘¡±ÁÑ#áBñ3$4CRÿÚ\0\0\0?\0TÖªî›i¸ ®ä‘‰ù¡ræ¡t¹@ß¨ÄÞb‰ÔÐ‘§ Ú8þ´=»cÊmm¤(Ç¼RÞc´{ÌŠÀÆ@æ´¶Û`© À1Ÿš‰’±»`$€iv¥v†R9‰Û“ß­Tu=X2J[ÉàŽZ=u‚rD²Ñ¾u{[¤:™AÒ ÏqSÅ2dˆãÈ´ÏºÊÂŠJciÇÖ­6^2$!CrºÏ¡^Åo¢eékIó’¡·ž OLMRïmFå$ÞLÇi¹Õ‘pÎSµY13Ž\"--Çdˆ\0ç¼ušë¬R6÷„¨5b,¶Ò»vÙ3Nìtà)8Ž‘ÞŒµ`£Ô™‰Èë÷¦m5€8F#ššëÏ&RÛ‰0jƒ	J\0œ`	íVo2–‘#°ûE/B u\0ž½(–TX\'`\"sõö­\\s\'xÄ?\\ºp ¡£ê08ÍUüÇr€R‰“1Þ˜¾ñudª=½â†qöÐå¡]€1žõê92Q6ð\"MIK`ÆDˆŽ•Zq•’VÙ%>Ý;SmPóP‚\n‰ä)fåc€qÄw¬ÛÙYãjƒ¼Ú¶¼ž¦‡h”«oQÅp÷˜®\"y4\"Ç«ô¤˜`Â‚qµº-‘9Ï5d³¸–7$ö?J§Á\\EX4àEºSÚcÚªç	˜½ê1,z+¥oíT¸`öãšuäí(d÷ª¾šðjé%QµF	&tÿ\0Šºæ4•;“’xš]ÁuÏ´Pˆ±m§z @=?jÔ6•ß\'Ž†ŒSP¼qÏ½zƒº1Ž)\\dJÈ_¦ÅA³Æþkš6·mï–°¢—Š‰s]~Ý($¥CÐ¡tªÆ·á”;|§Z<‘Á=SÔËˆZ˜ 9ƒi·báö¸Ó‘ïÌUöÑ\0yjP@ÌDÕOIÐË/6¨“\0õãµ\\þh@¢²¹2£È–+ò±DñKü@¿àÄ¸˜¢´µl\naô¥ÚÅÔ¹µ(B’D™ŸÒ¥xõfÆÎeyK•)=c­q’D‰\0‚:{ÓKÍ…HZAž\'ï@ß7µç1ÈIýêŒ¹äLò6™7((•\0Rqœb„BíÆä>~(Í?Mqñ\"BfšXè¾Z†ð	dv¢Œ•Ärª]×]Ü–®ØP1µCƒˆ˜5s„»d‡$\\½T55bè ³´óþM<[Á‹4 ó‚AïPÐí\'=%9RA€¾ µDÂT9ù ]x7r°Fã#™3R¼Tó’€@êGnõå»‰	õL‰ûÏéU³s¬ ÌÛhrÌ(î{Ó+6¼»d‚>jcª©-°¥­*Q	ƒ?¥t€6è_´ÇÒ¹ŸpéˆÅDuŠ•~ÛWŠiQ$nôâ’Ü¤)õ¬Û‰ŽÔMõ¨Uùx+Ž‘ó[%’¢18Ïµ-ybGI2`$ ¥c‘ßš³Z¨_4• ‚¡‚9ÍW®Z(ƒ‰Ž”ÛÂ–Ëj[˜\0·ÅFJY·±ž“4ÔÛ[+•		ôñûPo¹½©â3îf­ÚÃmJœˆJ]å©\\!@ƒ LœäS÷A´œfU—œÅéòí…‘&9&ÒÞ[,ì*ž1Bø†éÄÞú‰âIÿ\0Aat·&xÏ<Òþ•âX.Íoq¸¡™éSiÿ\0†MÂ¼Ï/q•g?4…û)²”Lž§àTºáp,€˜ƒ1ž+‰\0!kÇ2àê@<Àù¦—DÉúÏµ*¶v€œƒÔÇÍ{jà0$ƒØÍ¦9ï ôo^‹e+ù£õªš/~é`á#\0qé®­vµ(ç~ÙŠ­ZºH R¤“ÁmI,Àg%Tž‘•õÖÖÈGæ3ÇÒ‹­Ih\nyR¨“™Ž¼Ô-,¤­ãéNB$û\nç,Ô•urZBÉLÊˆÀø¤š±ssÒ3MÎ;Gz‡Š-ÜxBÑ¸tƒÜÑžySÅ,°¤‚‡R`žõÍ™e×Þaµ­g;R\'õdÐ}¦êÜ„ì[jˆk¸áJ âwø9¤Y&âß%8Žìk’êŒ„ÈÚŒw®–ï‹î5)-¸ÖÕ%#q‘Ï*~Þð£È>©àŠ.2¹Š«HˆÚN!BFGÒ“ê¶e+ÜØ™Î8§á%·eCžôÇOµnéðÛ²0N>ô ÛaÕöÎ~–”Gå?jÊëªð¢àïQYWóV_íI\0~ûñ	lá[@ÁŒù¬eå·l’ `&7jF—Ižÿ\0äT—Ú£LÙ„­BDÀÏZ½*©œÀÖ Au]D¸âÑºT9?µW®Š	™\'©äÖÎ»ç’QÊŒâ¤±Ó^y`¹ùFE=áÔby¦Y;r¸JdwÕÇGðÊÊ‚ÜNÄÈ2{w¬ÓRÅ‚€µŒ${Ç4úÓWÂe8‘V~Üßñ‡³¥´Û !(’@ÌÔé….NÒIäð}©¾—x—ã#<‘MTÊV‚qñ÷jéÉÉëgiV¶`lŒŒÇ¿4RÀe‚sÔãëR^),9 ’DÐ¼^)D ä{VŠ‘Œ¹‘þ)KvÑ?3\"¤uj “žd(7.›dÁT¨dŸÓïLKWH(9ˆ½WÌçå˜Ä©jº‘¶Óî\"ª×ZµÓë‚JQ=rk§jº…+h0Ib>‘U{í¦„€ÿ\0\'4¦ 7sÄ-W Ê²U9VOSïFY%\n!%<ñí^\\Y×ƒŒç‘Þ¢eÅ2è1êIÈ rAFoé¡cp?~)MÍŠÒ³Éê*í¢ÞZ]0àuI¯o´´ÆæL§1ÉÇ½VÔ8ÌWÎ(pe6¦ÆGjÃ`å·¦7‚ZòâÌ ÂÓúŠc£in¨IÚÉ±AÀuÀ“e›Ç’¢­¿”sÚ*ç ÜmBNUïœõ¡W¢­\0,\'ô‘Å\nÅÉ°xÊB¤€\"&†«·ƒÒ-»˜ü‰\"~ßÚ§iÄžýcµ—’ãhVÑûÑ¶«	P3ƒÎzRl0Ø‘ÞlÚJWqÓ÷¨µ1$*03ôïD<6«w3zNkw\nTxâ_qÚjùÞ	ÀÄÿ\0Í9¹Nö®cŸ˜¡Û³LDøÞ‰/$798‰§Y0¼Î^81¾–B-s‰ïI/Žë—à‘Çh¦áA»d¦rGæ”òç‚£ŸÞ—\'Ò-¼(V¦Ó£b›=«X{kKL.@ âEZôÆZy²‡Rg1[¿¥Û(NÕ(Õ +œÁŠP`Ö6A¦@NI¢Ûµ“»§$š	n»c°(JAÄTkü2JNdüÕºušKxUÄOâ\0‘t€¯Ì:ÐISî%±0L¸Œu¥Ú…ùºÔPyÉ$s¥:nÝI	¸\'	#ŽhD™¶6÷&3±ÒË@œª0z0éí-µ%iuWáµ\0³ÿ\0Šl‹”-9ƒL.!ÕÀé*îè-U‡@ô¤îŽ=ªàáÚžÀÇïJlÖ]ÔT9H4ËTVÛF\n†)mAâY1Œˆ…–¿áTàŸëF¦ßj\n¸Äý+M!’S’i£ˆ\nQ@€8ŸéJ&_‘Û12SŽÌg¸ÊÙH±Hà/·¿jÖáöl[*Q?z¬^Ý;suæ)Gbfâ ¨dõ”beâ}\\¼Ç”Ñ9ôÈí×5Rm.‚Ûƒ‘G-^jÇót>Ôm«\06T $ä‘Þ”po³&N%_Äºs×·M%’r©1ÉÚ¦°Ð_B\nTGéV`†›\'¢rÏS[…Iãc?4êÖó9ë£ÃÏ.\nŽ\0ê+Uè®%{Hƒý*ØÅËCÒ1Üõö¬º)Bîâ$A==âŽÚzØdHÚ=â}9,(t¡K›) äýh†îD¼¢6 \0ŒDb)3ÏžRQ‘¸œqØæƒÂ ÈÏHEêÿ\0 Û|“Àà\n%›6í,Ôãñ´HèLT–Œ6ÊÕêTc¿Ú’x–îîå²Û!#\0	bhÊ¹ž¶\0”ßëkUÂÛaBO^ÃŒR¯øfçÄ7qæyML©dI=ÀZ|;pëåWäÉŽµwðÒÑ‚T„!Q€`}¨Eôuš^bV¸X×Ã¾´Ñ˜_›\nK„nR„’\'ƒCxžÆÙ-•Z²€¢$‘Ö¬\nÕÜ¼’öÀ®¡\'ÒEv”>’•	ãÚ)tõ}ãÌIî%²L¤Ø=ºP¬ÓŒSX’	X”ÁÇLZÒYCÅi09:÷z­w4f{NRà*Î	âsýRÛËqCˆ0\"µÓÖóqƒ„˜=&¬Z–‰pä¨dôþõ¦‡ ºNÝN‚•‚q×â…jõ\"8\"u_øÛý%«›—ÔÊ×€&JÊêºIF•n‘?aYUZò•ZwÏŠ.Ð¦Y3êÛ\'µTnÔ^shç¬ÕëVAü.ø!*HëUFíGŸº0Ng4`Ê~ìf³Žaz>”­¡Åa1#tÅ:ƒ± 82xûTL:C! :ûT¬¶TByOI3š²)cìZOjÞùQyäÌu£Ð¡`@>ÝBÜ!1À\'‘ÄÔÍ¨•z€súÍh\"„,cÍÝ®îúÞ¬aÂ¤ˆô§»Õ2ÕA“¼«˜9ûS1­\"\"=@ó5.vò`ü²Ç‰>®òõ+\n<A<UkûÇ#øsì:\ncpzöõoÛ‚z2ËMm[BÐ3ÔÇÏ1HÝªÇZÕ92Žó×@•-$äž±M4®Úá¨íQà*àî€Ã …%_Sñ[×ü6†ZdL=&—®ò=á£.—kKÆî­Ò ©9å4±dl”ã˜ãíT»Qû5%2T ¨sõ«¦¼ÒÒµ8nµ¤l[g5$‰\\¾µq·)\n‘Èçµ+}\0b8äš¼^¥§Ò=B\'¯QK¤…€”Á9	¤Z¦S„—W#¬©´µ²îöIJ†DÞŸiZË¤†Ý+ði»:\0©;Hõš’ãN`\"\n=ûŒW3ÃN{U¸\"rëo´JFÕíVOj‹bÂ“0ÄGÕ=Ô%™ÚIˆ¦:‰õÝ\0ˆþ´&·b–YEã¤èÀ °¢¢\nT0cƒ\\ÛÅÏ!-iÌ½]ìž.Û”¨¢\"x ôªG‹t{”º·†R«·ÍV»ƒ\"Y¹ Â´[£uf‚“‘ê“ß‚)Ý¹VÜžÂ©^¼üâZ{þÒÌÑ&:|×IBrÝ+hŒæaUj7Ù‚dæzÚK¬z¿4d{÷¯Yh)iJ²$HïÞ¼µ–Ü!$Gô¢T’“¸P\'5EâH^ðë†B-ÀFTÏµ/·`©À`ÌÌ½êfo	PC†LÆxžâ‹¢IÆzãš}™\\fX¨c™ÚÊQ\0‘\0R¦•¸üÙ’~iÝÃG;§<üPºe“×—âÞÝ>¥J¤à$u&µÆ3%•¬`«ÉŒ4ÕŒâ:wÔrLñÏzekáÏ#%Ò \0ÀÈ;Ô¾Œõ¢Kí5¡êWtûš]u(pæhÔU^â½\"‹°ÉJ„ÈÎ­\"Ômv[6dÔÕ•‹7nÚyÆà%¸“$Ò«›U‡Ô‚%díÚ&Iè)¤¼gi‰YC„Tàô2ŸmlµD1É=*Ëh mCóF\'´qPÝè×,¸¥yN\0ÚRSüÐOÏ«ì¼ÓeÒÛ©J¥”¨àžõÛ¶‚D•bg Àµí¤”à$À>þôò›ô,íPÄ(ÓÆ^mÖÉZ$œ3úPÖ6¯J`¨Àf}…ºe÷ï„Ô_B®#\nÈ?X¦ºÙ*Cl§%FzóA¶Öm·¶˜çŠ%ô§ñ;Õ€šœœÇ‚mL	M­¸êúP×—ÂÖÝN(Æ	žjw”JŽ\0ç°öªæ¬ø}a¤ŸH\"sØT¥D‘í´E7woÞ¿¹_e õ>õ¦Â„Á\'#\0ŸÖ¬–ºsÜªôÞ–&ÕEò¢ÔŸÖ«b³t€ Ž½æ–Í\'z†`àW—Wà(!±TZÈIòÁÇX34µ ºà›#>*¹ØqÞXq°§ œž}€š86²@ÝÃ¿5+¡–S9žg¯½tµpH8\0bEeˆ‰Ì)¤´Ü‘ž	=zÔ:†¤d\0½\0¥$®óßèh…•à‚°ˆ¦mW=œ9æI	˜ôûR÷ï™´R\nŒ™$b¤òœRL`ÌÄŒÐ×Z@Ž¢…¸Zõ™aðôÞ²T£¾FNLûéF¼–š\'j\0ìN~ô¯Ã`Ø ¶³Ï¤“0#ŠwptÈ##ÍI·ØË»}\'ˆŽùÅ¤	ê\0úÐ–wH\0âN¼U¡»$dârOX5úR\n€ˆèéCmÍÖ˜™…€Û€?Z!·Œóé<ž¼sCÝ2¶])þYëúæ¥´HTrxô¥\\ƒ0ÀR´pÔv½¤‡3€3…\nêÂƒ$u\'æ¥Ò¥JÈç§·9ªï\"Fsµ&£¥ûK`ïl¬yhÀ°¡K<Aª.É¢Õeâä D€b&=©ú¥¥é›¤#ÆŸôöZ¶M“” ¹ëþEeriÊ}	wP½uë…eJB |}+)ÜÐ¼1Áùˆúé˜ŒØÊ‚®Ú¸ÒP…G*¸ÚeqÌ­hËËƒƒïÅok%yÄð%U{r¯LÆ6í“¬p:\ndËI@9ùŽ¢‚KÈaLDcÞ–ßëA”\'€8§­bT)n‘õÅË6þ¥ä‰â%¸ñ\na²g¬|ã•ë‡.?9;zŠƒÉ°¨kÉé•(ûÑ²õçßô·9À’jÃáÖÌy®®TrI?Ò©m$ ÌŽx§–z¡i1#©ö¡9,90‡hé:#!¸õ	&$â)­™D‚“ïØÕÏZh„î0AÌÏn”âËY@%aP8Q’~´\"´©PÂ^Ûh<‘Ó¯Ú”ø!öÐc¿Ò…·ÕÆÐa\\ óëZ]êm­93<t?5è»VD®;b’¥ccæª:®öï\nšQI¿½_5GØÅM‘N1ÓƒTGÒ_¸QHÁ8ÔÝÀ­Yïi RBPö#õ«v®°„ï°ÏéT¦©B@ö–î=h¡¸‘îyøšØÃ¤ë+Wé:˜ÖmÜI$€rg¤õ¥Z–©n¤¥h€3Ú«Vn›ÏJ9ÿ\0Û<ýëgìIÇƒíT1&+å…<É¿J•9‰“<Î)Ž‹rÒ—´w‰ýEUßBÐ`‰÷ýM¤¾Y½0q>ô›¡ ‰/Œ‰Ò¬Ÿ	iãŽôä²‹Û}®	PÈž~*­nòTR©GÛÚœØ]Á\n‘4’f·Û!Oc)^&Ð.mîÔëbZ\'ÒÂO@(T¹eKÐP\"y\'žÕÐ^m«ûE…€LI=~kžjí;·AH> $w§ƒnáÖQò%êÅô>ÒT…¬DSd´f@¢\0=;W1ÐõY¹\0[\'ÈúWPðørí§È\n\0¨wäˆûP‹Œn<	z¬m€dÄ÷)So\0£¶NOsM¦ãj!dŒŸ¥;ÔtEÝ[ï`änƒÇÛþh_[©íjIOá’V pB§h‘òJ ÔÖÈYNqû©r×`ÆèUÏ…TÕYpùéRJ€ÈJI_Q3ÛO´í­.êåm¤¹	H< Iîbš¡A@”+wLw¯JB„Æ7»Œg¬ôôèh¥ƒ*ò&§’#žkÔ+Ñ§5¦ï÷DŒÅ`Xm&	àqCÎØé[èkMiigò<ô„p#ö¨´[TWpâeM’ÓG°äý¸j3WcÍ°uIüí1$wûMm£¶§[&fPsÕYçëBw±ìÉöÄˆ+Ž’Ò˜¨PXùÒ´¾´fí…²úÛQ\n(<*#ö©”z‘‘Àšñn‘»“×m][“ÒT®eoÅZ/Ø]Ý’/8L\0èì}û¥MáÝ	5 ¥¥Üœ­Ò8=RžÃ÷§è™3Òj)©£¥Œë±tt‹MÁ}__¬Ñ»f’e(VVN2O&«ž ´×)qpŠÍYÁ£­*ñ=›÷Zg—l‚·Ã‰RB`N`çëš¾žâ¶Æ_§P@ŽD¨^:²Ò™ôœ‘ÚØ„:¬eI$ç<E[4­âì).¡L7‰R†N:\ny¦xcMÓI]»%N¨ú”µ(ç<ñô­\'ñ¬mê~ÏÑáWj0[Ò>?×ýJ”!´“Èƒýi~§t†’B\"\'¬u«N§á¥–™ò<ÍÅN8N‰®w®³qn½®ƒ´œ+§=iŠõ*èJu‹êô–iŽ,E¯¸·Ÿ1É<Ž”×L²+Z\'¾ö¡ôËR²¡¶b´ñVky(*TmÀé¹õ4Hrq7Ô†œIÉ=8ªÝÅÐIQ$OLÅ¬Ý-vÊX˜€O9ªËjqÇJ©™çµ7K‡]Ë«Ln<t…;t9š\"ÞúÜ˜$ˆ$Žc‘K.­JŠÂÁõI‘çáK(˜)ÄGOµ`t®…Ycµy’JS²ÃÅnóMAÌ&`üÕ]FÜ•Ç1^ÿ\0Ô®n`73\0s?J¶ãÜ@Ù¡Œ~ò„ƒ#1ýLPÅå%^…DK<çÒ™pc%&Ji¡!.$:D¤Æh6\"·8‹Y£u]Ç¤¢¼·ZNðdð=©¦0	ñZ1n†€ç°­–°sÞ€ê@‹Èn-PêNà³íHïS*Oå˜‘`óœÇÍv”¾ ŸŠàÃA•æÐ_s#Šwcn–ÀÙízÒ¢ÒØpœ€rLô§JÞIâhXõAžc-£Ê\n‘\0sTÒ‡^Ô]x·Ô½©FÄô«T²©ì`c5LeÂÀZTv8¢I_%\"pÚµ4¸ ˜ÅŒ˜Ù–l™@KÀ<éÊ–¢y¬¤î^†–PÚärR@<ÄÖUOÝ”ÑjF?œål	@Soü:wuš)H 8©KÁäl\n!QÂ»u®L`1¾¾[‡cdûÐm4I’fy&Uº[õ\' þ†°$“	ëúWÂ‚\0Àš!²£\0tëG1¦8±*IŽ³FéVÍÎåŒN*ÄÚ[Rq¡ýqUÜ\"ö]·hÞ7Ž¶g9â+<Má•il— €H#‚*åá•¥§\nN\'·ïÜiZq˜Â	‘Uæ	.bØ3Œ®äŸÊ¨5%µó¬B°3hHÎ:œW€w«îP%šÏÄ+%ÅL‘3Í6{UiÖ7$Â£§nj’„o­Oæ©)Ú“ñX&\0Ç&éÛ•’žÃûS+Kh9\'¬M ÛÂ×À«*[ÚxOïWë±±Àƒ¡°@8:š†òÑ¶HæhÇ$É=*$vè\'QŒEòfž±‰Y9\n¶_Ø”F{ØR,\"ü¤ƒžõ}}ã;£Ò¡ÇÓµ\0éñ¹‰lÎw¨X‡BŽßWØÌUváµ0çþáÁã3WíA …’9\'ƒc5ZÕ-ÊÜ‘Á=©U<í2ÔÙƒƒÒî‹öÀõ\0ïÞ¬º./^-°‚µªQPH\'ÚHøªŽ’ß’áIüÓÇjìŸéC(]ó©¥¿´ž° þfx‹š=`g¤sG¦­@¬œ²mÃ·fÝn:°Ëí¬¥l¸&C3Ö~*·ãÏ:«bâ[)xJ’pBPu¡€œÆÅzÃO´¦žBÚ§pPæMs©ËŒ¯×I¿gƒTÕìCƒõÖ|Ç¤­Fä!c)$zŠï_éÛINƒh¥~wÜuGw`BGè+šøÇÃNh:Øºh-V—\n*C‘êcûóñÐÓÇÿ\0IhË&Iyð@0ô§o`úmÀðHýâCW¬eq‚–Å\0”*p‘3YbÒÒ””%8	Q\0¯“Cj)\'•QˆPJ\0jó¶_åØPvž©—Ò	›©Bv«ï5+o%hÜiêöîÈýª6p‰ô‘ïJS«Ûh§óïýÎ5ddB®W.„FU’f1P+\"# €¯­Ï¨ž°?JÔ¬Ê¿aIjuFÇbOÓ·÷,«$zãuªäú£iœN0h…ª!´©\0·:R‚²ãrD‘Ú{Qªq;ó‚DÑSZÍ^ûsõï%«Æ$ÊuAÐ³*žG¤SYä3C¸¨”ª%0 ÌñÍFµí0&?Î+†©«b¬rýJ„Ì6ÝDŸC^8|(ðGÖ´³vn ŽAåØ.Ü!fm%J©ÄSôêóNñ×ëøœkó\nmIe)[ë	Zø\n1Â§$(¨`Ç#·Í*}Õ¡ÔIqjƒº˜}ê{%î…®Ê¼µˆ$÷?j•Ô†³ËÁü~º÷Ç8ÝX\0…u5LÇ^ƒ­É…Æ+ÖÏüSLØ;`Àã3[ÂR…b!2?æ¨åªo}%”—\nR@ÉÎ*ó©¸»ª<í\0u20(.Ä[‚ãÀ)å(«œ&{zsK©ZØû=â:í#jUtÉÉü%wFð£´*ìù2$6‘*úö£µyŒ€Ãå0I^àéƒ€#’`|U©>”ãñÜW¦0:r}þµCªºÂrxö•OÓ\"íÛŸyÇ5;G­­TÅâ<§B(Hž34‘˜àv®·ãvwE½;Fÿ\0,(àÈ\\ÎÆÀ¼µDm¢£ÀÕµá÷)öÄ]´£JŽ†Af†œ~\\‰þX’}‡Ú™?§‡Ñ)U9Ue»‹=I¦™Þ¤,òDfx«®”°Åº\\|Ì§3Nzæ%c°°	RÔ´¢€R)=;R«6µ¸IRJÀ$Û¹«n·|‚¢“å¤É Hâ3I¿î«qÊ)ùø¢‚qÌd¨=f„RR6‘$œÁéZ0§-.R´dœ(²™\0íé#<šÑI!1‚$OÅG%YL¸é×Aûtô<ÇµLñÝLñÞ«=ái~Zä‡¡«W˜ÿ\0p˜çµÅ8âbj+ò›oi‹IJdøïšŒ+>óÇ¿½JL…‰MjãRe8\'Ž´¦ÎbäÍ–Ê.QÆ§½­ÉL	ç¤QVŠPTANbŒrÝ#pÎ2ïWØOiÝzLÓÕæþ^Þý*£â„©d¢!7bJ¹ià!Ý§óvþõˆ4¶µ…@‡	I}1HÙÖ^·Úy”„-¤$\'\'ŠÊë[¯9ÀãJJ’¢Íe;¸öŽùyæs–”…\'ié‚}ë×[Œ…Gji)_¤ÄTì¨¨B¿-,9Žòr%ß4Vh«…íBdâHà|Ñ^˜íáD\'§sWÝEkNm*u2@„æ;Mu–-c“ï+¬øjùI”ˆþ:ÑÖº Ø’€‘x«Q¼¹YÚÚ[l@ô5 ººléBÒyÚ”ªƒg/¸VeÇ,^‡ÐQ3¤ÕsÇÒ®!^µFïaWŸ$\\ÚíRfO$õÇõwÑzê¬}ºSjë`ôÂÑXÝº/ÚO5êSŸóµL¦V©\0uŒV%?nõ;L{3PŸ¨­“ŒÖûdW…2>õÛes,~½@ôV°”©2’<‘<w®hÑSn§U‹JÖ””†ÜöhÈ@àÅ­¬“‘,.§ž3ÈþÔ+°ëúZÅ]!ÙR	¨=ª¬“éœ‰Í[nbø9æ\níÚí®â2¤ª~•Ñ¼?ª·{d•\"Esád·§Ó¶s4ëB²~Ì¯hqH¨H&\0É1RªWå+j†u5Q¹j=ó<{Uvå^Z¾gÞ­¾™¨ÛÚ\"ñvÅvŠBV.>b\0 º2žzˆ÷¤.° “$ù¬ÖpÍ•9€zÞ¦Û`Á‰œPó’¤§ïí]³Â!?N±¾´Z^¶‡–‚IÚ½°à´‰Á®%{l¶Ö@§€Euô²ðêvÅF^³| ¿Zsó¼VGŽ»ý˜:õ}~xž‹ÿ\0òþÓ‡A8(rAB„…tãš…d¤í8÷=è-<¿øPËÃo–¨Lä”Äˆ4KÒ¡Ìß­bRºüþ±=VÍ­ˆ¯fÆ£`í­ÒJšw¬e¢‡¸ýx¥¾³]†•mbô-”àQYP#ØƒŠpTJT•HPçæ…uEÞ9àŸozþÁë_+ª’²é”Ùæÿ\0Ë„j\\j8ŸëE)p\0÷#4ºá{ÒÚ€ˆ<â‹Vq$AéÅ!ª¼5ŒGxV\\(ž­É™9éïQ oxÇ\'ã­há)W¨žóíÐÔ¶¤!+Qä˜þ¿Ö“ŸTìmBr¬ý}ºÔn©TsØÖÜ«Oµjà*IòÈÓÚƒËHA-É$ä$Á÷£½ÊQü»’\'ß(&G˜H!9ëSÄÀ\0äˆÚ‹»Ž¹0™”åÀÉ3Èì+[…JS•1“ÇµD•H„Ÿl‘Ã¹LÞ{\n®â}0{pdvê!ä©\'‰Ÿ·²”wªõ&qæ´RÄ€œÄV›80&‰»n\0ænNdÀ«„—\n”Ó`œb8úšòÄÍÃ$À;\0æ9ÅC¹\"B„$âSÈ‡ÍojvÜ „íÛ8=¿ÃLoÊÍïŸoÐc‰Ûpo|¨cH¯üV¨t\0úÐ×îá¤sÖ­j•I	#š{S©>p	Øî.µúy“]¹´#ýÄÉœÀëZ2²¸þnÓBºïq1€ØÇsŸÞ¸\\Y‰„¹M«ƒmÕnçš•¢—Lœs\0œÍJ{×¹­e\n\0»ŸéDKÙq¸p`™d—–×­yW-²q¶HïšåvŽ‹;Ë‹uªTÓ«d“üÐHŸÒºÓŽ%¢\n²z&rjŠÇ‚Jîq¨_•©Å©×[eA*$ÀQ>üÅz®ªK%„JúZÐ0%cZò}·](°BF\"f‘_ëèÚ-Ð­ÊþcÀ&ºëÞÓÜ±rÝ»Všó(Fõ\"Gæ™žÕÆ¼iáôhšÃÖì©Õ2T…¹ªR	“ZÚ-mZ¢UAã3nÐ5gÌ\'0¶”âH¢f\'á„§ÊI\'‡?5VµQ.„­X$Õ’ÝGÉ\nAÌpNéO?\0„ì=25éHéÁÁŠ‡‰ ÊdGz7i‰>ð9Ðó\'¬Â[q*GC&Ÿi—éu	J¹$“2~‘J–ÐV‘÷ƒÒ±Ó’ÊJÄn#¡úU”ÔÐ-ï,¬­\0§9Ç_“ZíQ‰ã l¯Wå•J“‚9Ž¢ˆ[»T9Ïj±\nFfµµm´Ã¤œâ*ky‚=\0ÿ\0&‚mi0 ®{Q¶î…œ§‘WU„ 2Gy²9Q	9¢•GNÔŽÖíËu¤,Ê3´Oõ`¹Am^ã­@Õˆè!,]¸‹o­’óÁD$ b²¶x8¥Ø1ÔÅe\'’;Ë“ç7˜IHàž£¨?ÓCÐ]¸q*ZIá<}M4Ót`íÊ²A8>ýêôÓ-Û0dB ¨õé\0Õ¯¸R9ë\nÖñÄN±jÍ-¥@m+ä|\n9Q¶	àÉëR6ÈH˜Hš×j•ÏsXc;nhIë7²h)È‚OAßµ8nÑ* Ú†±`5ë#fi»0S?\'4Í*YuE7–	B%$TÍ_@mË¯3nâ1)~¦º]Ì)È9šC~®‘€F:LâŸ¡þ:I$¨È•;}…¶¶ÂB†wd}êâþÅ<ÊHH\'p¤óÔ°	\0(s1¸Ê.ìÎìÈŒçæšd(xé:«Ng K$þ¼VŠ•	LÏj`»o-Å ™ÚJcûÔÖá¶–\nŽ:Ž§¶*äÝ\0E›Ñ!£öÍl4Û’D6DqÒ:^³jÊv¥Tâ#C/Ä#„0O±éS¾¾¤ÊncÐB´ÍéP¥È¬¶ÚJD¸@#¼}ê¨¾ÚHC;	ê~´3Þ\"¾^R6{\nŸ5{A”v—ð–#Ž?Z²xV×»å·\nomµµq¹¹)p×ó\'<Šå^xjþ1Ól5•YÝ-L”îRw¬¤ìNàAI*ˆ9\0ƒ5rÕ¼1¨ÿ\0§¾.²×ô·ßÔt[W®R í0°RàXÖ‚’a``ŒÍ#­¸=m@8b8è4Ž®·‘3±7µ	ó-Èm\0“ÆÕ3õ3=ê©â	[_ÿ\0êtÀ›K•V†À:™D\'ùØ=cš²6\\u¦–‡PvB±¹$|§ïPXº¤,¡@ùnHBºnÁµx$Ö]¥;ëàsí‘î>Ù_¢§UY[GhžûÂZá`Ø0Zyi }ÿ\0¥à¯»áÿ\0\\ªÙÿ\0?N¸· ‡ 8ÚÒ R*ÈV{€BHèr*U]¶Oå$¸¥×Äµ%Mv9 õGþ·OÅˆX{q’sÿ\0ÕYþÑ^©Glƒ#¼N;TJDàži+-#î˜EÅ Dv4;¦rGÈ©ˆéèBè”Ï1Ï÷ ïíœŸ©Òƒü„¨Lñš?Ž&>(L]‚x-¬ÒW§@0f¢ÁždX=X‘<Dÿ\00ÏÒ¼iPŒu$ÖÀT}=}ý«P€\'Üçú\n é#¶&û€Úf:ŸjôçÜ™=\"jHà™ö­’®•8âvÙé@Fb`ÉäûÅhRùÍxµzŽrk¬ML¸z’@Îæ¶qBR˜Ý¡ÇkMÃ*ÿ\0ÄÔhhRŒ$‚däŸŒÕ‘s;äÃb®ŠÁŸ¦+We8§cZ F`óíóRoþ‡û×Òv<AÖsp\'Ø{Ôöê%×) @\"Ú ¸‘™ëÛ5»KÚÜŸaƒEq.Ã\"në…N•p\0Ú+Ò¢`ÁW·½@\'tG«·+eÀc¹¨ÜKnï ¯iêP}&‘<OÅMlúÀ•d\0$žfjÀìHQRŒmHãë^ ’ä\0`$úš!Ü¾ d0ÏXRÖJ§tG õíS8éBÔ!Î‰Ì~(6åXŒý³Þkk‡‹dî#ÐéR-ê{ýsS$CFIRÌ“MnËm•ùhYZˆþeI¡YÄ\0	>Ã&ˆIž¼\nf†læ	Ä™IÁ­i‰Õt‹«P=°â’ŸæH={{Öét)Ãœ~QF6A\0ÆNqZ”¿xê p0gñúqw¢Û9o~ÍÕ³@©Àâ|µ¤w ö’i¨ôäOžÙWÐ7Ì»ujãl¼«`©Jl°ž»\'\0ûÁŽÕÅ¼]¦ÚhZâí,Jü„6…CŠ’	A1õú×«ÐêÞßñÛÉëøLÍE!=KÒ†’Ï¸úŠf Øgž‘#8¤Ì¼‚’\'ÕÏo­x·]R¡+12@5¡·˜ƒ\'ƒóNå{Ž†3íQ^^Ü!½¨’8&I%½«êI!$ãäš•L8-;cªdBŒÅzuÁfïÎR‰*9?ñWgÚ¹m;$Ÿ×Ïõ‹gÃ‡Ê”/ÁúVÞsPµ½KNïRIôã üÑ>3/[NNîó í)ä~(†X)Qa\'±°i+q!n¨Lb¢¹¸^7+Ó;ˆWpæo–d™¢‡ýM\nP‡pÈ$O5pÔ6ª¦9ª‚Š<æŸß¤LNo^Zí<DûjùbÅ<Âí3¹¸>oðÌ$|ÖPaERF+)s	ˆ‹Im-[mJ1ÖhÁ	ŽOÍ+ÒÔ¥1\'‰Å{zó®¨3n	_Xèi[®´˜¤’ÿ\0Xm„mVp¥Œkj¤ú}ºÕƒIð[—íç¨¨æp\0Ž(CÀÍ¦TÀZy#ni…Óàs-°ã2=#ZEÂ€t€®ÊÁãâ¬-$(6AIæ?­Q.t«=ÉX”çN:õíN´=IÄ¡Ã A½h–Ž²¸=\'¹æ?ZQªÂ* IçÚš­Ä©’`w©°þâPg\0sZdÃK9æ.º¹ÜQÄgÜRëË‚›r™æIŸ¥N°	ŽUÇÒ«~)Ô“2Lf}æ˜³žUÌ\0•÷ŠÜ}Õ$T³šÙO)˜9â˜h(nù”ÆV;@š²1f¸{UE9äÃØåN1)Mi/¾¡)1ñÅ9¶ð¬¤ï“zU¶ÒÑ´™ðhÔ¶\0ÚâdÞ¸Uˆ½RWá–Ó‘0jÝ\0 0=º}*ôûd ö½/q”¬œÁàDü©$JŸÞT?èÅ²•!Â…‚•¤å$RAï9®ëi©»â_[jÌš½œ¡ô¦2°äÇT¬B€®Xó%$ÇNEXÓmIZw‰SlâöÛê	ò&\\[WÏ)ÿ\0ö¬ïO>¢äMñ«Pt<K¾‚ó/±nÛi6 %„ŸÉÀâ:t£Ãê³º_ší(íqµ	Ÿù“P·^°¥D[¸áÿ\0±GÔ>†§*WâíÕæ×€•‘üâ0ªðŒÖÜžAúúï>€\0<ö0‹„\'ÊóQ[$ÉÆ—:¨ã\næ¼·}ë7`zÙ8)=ºÑ´‡ÓæÚü”pi&ÀæWË8==áÍ<m*Ü$Õ*rÚAÈ“ŠOdðgy#ØõÉ¥/=:ô 0Á0W´ñ%TDs¡99È3#½lI3Àà{VŠ‚;+ôš¨Ú|»Ä§¦@>Äj}†b´y\'Ð¿æB?X£+	H®&¬y—>®dòv¦~¿5¦à0~•êÎ9¹ŽFI0D3P¨m;’GÞµdÊO@08ŠÕ2’°zgVÄ¡$È\'ù•ÜÕ”v–Ça6!]\"DñXfaœ}ø¡TòÔ¹$ç?½JÃ†TU‘ü¾Õb¸„Ú@“€0AÈƒïP­Ò¥NOÞ+.W·“*VA=¨q‘ì:Í\\/QXQ#Ó“ÄÖéXIy<“‘B‘së\":&	¹ž?SSÑÂIOÁ’£RSÌ+Í+)z‡þî+B°dƒ™µóÅ¯áªyÿ\0ä;ÖÌºßVÛÞ —<äÈò°3	ZÁôÄ¬±?C<áJp}g¬d{\nÛ²‹×S»…1D­ÑçNLb0z¥y06ã=æ#qa Ó J­H	* €Áÿ\0&†·h)#w¥žäöY| mi b0:w¢&:¹À‚´î8Fä|ô»J‘¼ô$â¡Pþ Ì\'Ú ar²Ÿø¡ÖáNqùÈÛ¸Õº¬· âjUzÓ	Ç¸e\nÊ`~Ø£[2Fa#“Ø{Ó&ÒçlUÀÁÂ|§\nd˜žxïE%À”\0¨ðM/ó’¥¸á#$™\0ÇH¯[¹êHÝÐúM9¤±ŽL»!n²mWQFŸh§V7/†Ûœ­Q€}»öÅµÀíÍíÃ×nyÕ•©gOA]‹ÊKî¼„8±\0‘ØVŽé67­Ú±µÀR ”\0cägë[ºO£MÕI\'¼ÎÔi,±³»Ú|ò·—löÕ*$ÀöfÑ®ØRZVäOY‚~k¬§ÂÚ*Ñôå\"VÀQ#®LÕýAðµ½ŠU¥Z7ghÈáEð¢¥\0„dŽrq=&µhñŠun*\0©=3î$ú7©Kg2Ï¦5hmA1LóšÅÛÚ•1‚z‘\\¦×Z»°@nÞà–ŽU‘ïU·ˆ.T¥otîQyð¥„QN:Ë½Ý…ºÞüDÄq“E5bÅ¸JÜ&UoC¾vàºë†v‘y<µÙ º’2 OaC$†Úbz—ÞÂµëß=±x$‚ ‘ý©zÝÝ`s ¦ÚÕ‰Dª ó4•”—HƒüÞÂ¥²DKU¥dÃ]»&é¡½[R;“Lš|´áe~ @Hš’JÐ8þôeº›d›‹’J¢ïJ)Üþ™D]ª!m¥«t…O”·,©e[¹÷éYMÿ\0Œq™ÙnÒ“§\\éU·&$éWÏ\0è‚ãeÅÂ}_˜“Þ¹·†T¼i¥IW¯ZúÂ­0Ý’’Ž}â—ÑÓë$ÀŽak·Ch@H8ö¨i\nA‘»FNAO3Þ…ZAãþ+X =§dÄ:–œÛèT§=Oz£êúY²s{`…I§s]-@L´§TµC¨PÛ&:~Ô°Âž%Êï”Öõ4¢Ü¤È€OÖ“?uæ-K\'žzýªMY“ep´$¦b1‰¥IIRŠRq‰>ýÍ: (È‚ ô2u:’¥+šxçP7A”¨’*ï®Ü.ÖÉÂ2 +‘Þ¥Õ¾·\\EF†üF´•Œî1Ž‡¬¹§<’¦qž•Õ<?©³ª2’7”×@*T}ÅXtçôÇÐe\'${Õ«ø˜Î¢ ã=çpµf¯š9\'§nµEÓ|`ÂŸ5pF3Þ¦»ñÅ³”¬zýi€@™žIÎ\0–«Ô£nÑ1>ôi	QŒvž”&“âf5KË{=¦Î%×¥(I8Žc8šu¯Ù_è­)íJ×m°ÂŸoÔ„ÊêŸ¨zZÛkˆôøÎ[XU8aFã‘Ìdw¨`‚ÚŠI\nJÇ) ‚øŠÐëvX‡¹ïï[µ~ÃãpXt=ù®5ƒ‡3ª?pÃVº‚\'þâFv«…§újFuaô¢\n””Àçdàý?jIþžj¨N î˜µ¤±z’[Ìíq ŸÔ¼U¯Ma(Sä¤°H’žg>õóßÓ5§=××Ê}#ÂuŸiÒî=GLíªT	’ã ©…rè¡GAŸ¡ëGG¤™IÆkÍ†&h«‘Á<ØxîŽŒîèO¸þ´M¢Š¼À´íPŒó5ºTÄÇjŸbRŸH\0F`GÒ ·œÎ1‰‡`îFOµG¼“)˜äÇj‘ÀAÈè;T!’IÜJc€95#WæL•9¨Ú2üÿ\0³ ûÍx–‰ÿ\0¶g¾ìï5í´¨¸¡$\'·Zà¤r\'p‘ºà+P˜HÄˆí[4à’#ùA¥·W	H|îÊV©ˆœAµ© ¸‚J Açéþ})•Ó’¹Œ­— GJº\"%PHÌ	ŠÕÔ†P€’HÏ¨\0A9$æ–2£\n}ãå6L¶™R“š$@Ÿ½2}ÆÒnP\nI)…$G*=*áUF”d\n@ÅêÒD‰Ÿ\"{÷ÅÍâJöî@sÇZëK0²…¦çvèn„â=óšÄiÞ±åÝ¦ IqÒsö¢>Â0x“ShÊåÿ\01¤Ê•;Ag~Õîä²ÀJŒ:r¸ˆ9€;~²hE!VÌ’â \0@3óïóHÿ\0yAO/bd\'=ÌTÖ‡iG˜0½v´áO¹ù·+€HÆ?N~x¨ÒóÖ×iÕyˆp6ädÇCî+K[¦ž;JJpA#Žj{ß!w•8½ìû[ %@…ztÏÄÕ2ÛZN\nœ0“¼ûÍîÜ–Ðƒ*w(žùŠ™Kd%![È‘¸É¾)Kú²-zÜBA>‘ÜÔö—$‰YÌúˆâ;UY/N$\\/=!7-7/ Ne`äNÄF£ha`“:Èæ„]Â|¢…¬I € ã¿é[©.¯j†AÊ” ‚£ìïTØîr`NHŒ-+à\0I91ñZ´™ZTN73Þ†ráàRÛvû[*	HAÊ÷{æ¥CÀ«ËZƒª˜0‘Þkš ½9øöþÿ\0oŽ%v‘Ì‘÷Â-mÜç§œÔÔŠ„Ï…í¸¼i(*	%`ÈH˜í@¶I!(ç§°îh|ÄšðTŽñ«\nó\nq\0dŸ~Õµóû,ûŠ\0/°¾µ)ZZ’Ð«€{ÐŽ6¦Ì8 IÉPTÍHÊ‚ß„\0@Ï\'i;å3©×«J[sbSNsZ4½¢z‘ßÚ´.¸I9&dUGHL~ö—\0bG~æ§ì1ÖMÂ¡%G€8Íoæ)XLíÅ5Næ1vNaaBÏ¿Z‚êÒÖílªñ¦Þ«râB“þèâc¯JÙ ˆ$Äô&«Þ<»ÔmôŸÀ[’ÒÐRýÉZ@e¹…@™$ÌûVŽ–—µÂ‚p= -Â©&qÝU	»Ô.ße!-8êÔØJB@Nã´ÐqA!µAé=¨À ¯L0\0çBZKˆ<GÞ¾Ž\0Í·¨“ðÓëV ËIÇš@ pEtëtù@¨u!${W=ð^˜·54ÝnÚÓ3ðIéö®‚§G•»ƒñJÝ€ß•îŒv“^µø›U$§Þ«mÚ‹ ¹0µI\"¬\"íµ*NT¬GzFâ¼Å8dò}þ”îTm÷–Ô\\B¬Ñ´ÙÂz÷¯v.áakô `•¢JPdI9ŽkE>¥Æ#µ,ªXq3YÄ2N\"}ÍeDÚV	ç=+(ÃOa\'nnÂP<6ÉV¢Ù@THù®±k¨®Ø\'i$Xª?,KˆóHžsïÓö«;’yé‰4õ+µ8€äs.:n®.¡*?CÒ<¡äcØ×=ÓSr3&Jº¶µ*Ù;¹ŒÑC0ÃÕÌI\nTŒÒ„½O¦cŽb(YLýf¶q[ÑžNOÏz§B‰JñE[%Ä§ÔŸPŽj ÚÆíûa\"Ië­tÝA°¶ˆßk›ë~ÇQÜÈéþsF¥¸Úe,^s*þ&¸,4“ŽN*¼õ“n¤ÈyŠat¢ëËQõb}ºV­$îƒ’O<ý©¼s\n§hˆÎ’ {çµ]²šTô«Ì”¤)9é=;æ¢,…§Ô#œ˜¨Ù‰o4÷„ÿ\0§ž°ñ6¼?QÔ]´$nm¦Ò7ÜàîJp (á=ªÇ­ÿ\0£z›/¬è·Öú£iXt{„¾Å|‚*Œú¤­\nZ•¥hQ\nABèG ×eðñm³vºé¶Ö?úkæÎÏ4ÇXüª=GåW±Åfk[QQßW#¸šÚ§´yvð}ç0¿Ñ®ô“ø}BÑëe‘l§wÁ85nð/ô6gª‡/4à6$‘¹Ö“	>´{ pcÓ®ÕÒü[^·SpØ!CÛÒiCÞðÝúÈ¼ðõ«* ‚PT€ ñ¥dj<WK}f½UgýühúxMô>ý;¯ÞWµè^&´F¡á‹‹{\'^• ´7[:{rƒßlÕ5Ì5­ÄZ®¦óJ¿CmçÎm•:Ê‡E%Ä‚#ìGP+¸èÓt;õÜèwz•˜q@»nëÂâÝØà”¨n\n#Üb®Mºã@mRí&³+ñ–Ð¹¯~ôíž£áŸûü:FmðÔ¼e—kwÇC>WðÖ·z/šzÎ\\¸iaÄ”IõŸµ}\'§ßµ¨oXZ¾h:þÕuIø Šöÿ\0IÓ.ŸUÃÖVéºPËí %jù gë4µ²ìÒ¦p¦‚ÊÐ¤ˆƒÔÓ½Åµôx•\0\'½qð÷÷÷ƒÐé¬ÐÜTòßØöÌlIžõú•· ž• Xu½ØÜ?0Ö¼m[^€e?Zò˜âocƒ8f\0Çùô­€ukÅ+za?˜dMh¤LÁPŒW\0;È\0wž¶©tNÿ\0jñK\0ò1ÇüšÒÐEÂ‘!I)#w\'Þ‡ÔœòÔO§ù½¾”@™8„UÜûDŸÎ	Y À=GnÕ­³£ñJH\0¥ÐI\'ÍÆ=é#šˆozUêÛ™™1íSƒpí•»l¥Òõüm –ÙOn&~)šêe`qú}«Ï›º»v¸U»E÷Bà˜žÁšCª›\'œaÀŸÂ¼BVÒQ³ÌmJ\0½“Ó?J#\\¹y{šÒíÝp¥IBÖ€!<ÆãÇ¹šþ†„•]ëŽ—Ò„²¢€ðU‚®‘¶)ºTW‡s×·úý£4^?¯õ°uWZÕÚ@E£lj	ßÜO;\0ÓñA2õýÞªýÊí\\jÍ’¦X„€µõVNc¿Aéwú­Ý›7á¶lœ|5mhÐJ”\'qPì\0êyÅ¿?u~ËL=ÝþZœ•™ ŽhŠ8¥ƒqùQKn ßþýä÷öÚ›**)üBR£%…‡ |@WÉˆ¢-¯/Ú³7A‡¿\n\0—\nº»ÇsÀ¯o5éïy%ä\\\\¥jóA)…I F\0ïž½¨›EÛ—_¼`”XØ·ê.¨’âŽ \'ü+˜XÃÄ’ÌP£¿ýý	¡¿:•“ì…0Ñp¤%÷R„*y˜ì@ï‡ÝB<ëÓp[”¬lRø2ŽœN	{Ð·‡ÕjŸÅé® Ø¬•¸“n’p\0RG|~”÷ÃjfÊå•¯WY¥p,®`õÈ÷ý*@TPj#ëðœÍ±7Ð~‘>Žò®Þi,\0µ.\nA?˜rÅZZjÝÐ¥,‹¢@	R½(?”S=U“íUÔéwZvŸvÝËJh¼ê›*ço	&s˜±YeIeÅ#É&8ª–«|²?yk“Ï;«<	a·¬[\0…4âÓùr ÉÇ?¼P*<«OÀ¥)Jå\'Ë$7\0ºrhÝ2ù7nîlˆIÁ{t¨t×Y·Ö/›cim†Äm9ÈŠL3;Ç\"*!n9ÿ\0Üð]Ú±ëJÊ–2§Ô`Œp‘Ó÷÷¯m/ÑxIg`Î÷•¤´—Rðë¨¿²i§rÑéÜµ$\0ÑòÈöïÒ‡7eÀËOŠw&@ NF8þ”)r§?Ä8ª·\\¡É2ë\nrÙÖÙQR‹gal˜™¥¶->ÝÀMÛe§(…äÄàÑšjÂÙmIL‘¡÷©ïR7²@…N;b‘ÜT”÷‰(J{Ã<ä°ÂPÚÀ=OABÚ\0”3Éé4žëSnâçÊià«v 7\nWUAM­ÒáJT[p	$‘Þ¸ÒÃŒs*j5®[¼5²\'µlêRZ•ÉšÑ	Ü9RHè¤Å	tò–KI2}Gßµiˆ»›‰£ŠóI“Š•¦É;€’NO·¶²uÄúvu*?H­ÔÓ¶ê‡@<¨GòØ.â8—.¿uL%¦ÒõÓ÷©@Q%)íA´êˆ6÷\"Š`…\'hârzÓ4º±\"î“m\0ÊAJ|LÍ‚ô§Ö[üE»#xgr€Zàí\0$ÏÇ>ôÑNÈØÜbLvïKu;¨„¥j\0&`1ŽHäVÖ–ªÅ™¶â)~àœ“8Ë±»¯X={TM¿˜8ŸÚ®Þ(Ðmt”6?ã×CA­‰mU3ž3T›öƒFOå8\'5í©µmPÊrÁ±\n7YÐ¼1fížºå@‡ô¤fpiëÅ6¥@Äã9¥>ÔšÔ4ÿ\0Ã:­×¦y#¡¦:’†ä4yÞ“ÔeFã1o-¸ç¬ëa ˜Ó@±qh”LdšÝ„z’Ý\n‹ZÔÍ¨ò	÷¥U7œ´†ÛZúÌõ¬¥D¸&I8­zÝ¦ÈGP3úÕYW··–„Ž¡ ã=LÐ÷–zªØß°œðÞ[xQór}¨ëåJJIP‘•J¹°ÔÃ§u«²}šÊ	ºÂgsï:×ƒMiž£êÛ¥LòGœ­±´œuëš,)KgjN?ó^!éPÌÄO&Ÿ\\*íØÆv(>rq\0óóW+p²Gq¥R-^i vÅ\\lTÂLÌu«ã=%×¤òPñ\"`òqÍj—$ý¹¢µFÁmJ§?Ö–6£‘×¿I¤ÜlC‰ãªÉ“ìkœ¨‰[IC­ˆÉI# âº¤gŒÕ+ý@Út×	æ\'Ž¾õ4·¯‰œÝ¥`àµ†w(*3ßëÒ gbÄ£ƒ’(¶T\0È&ö­PeZZÂG?Ò¼wIt5½\0L{EHÊÂv©$’:š{g~×•±d@È\'š­„ã\"VQ®íJÁBÌø¥÷KÒž&OXâº¾¥àÝFáé»7\nJA²•® v‚Lg¤Õ^Ó\nP´Ã‰äµ]móëôØ¤ï:Oúcþ¡5â7Q k‹Ù¨”Å•Ê¿ûøÿ\0¶£þñÐÿ\00Ç#7å2Zp¥XŽ„cäù<Z,>B‚II ƒ2=+éÏÞj:–ƒnÎº¤+TmÀ.Žêîïó^kÅtTÚƒŽÿ\0^ß·Ë§§ðßX~F;`„¨§„Ÿ¦kr¾žü{ÐÉXˆ#\"AŒÔÛÖ”B¤FGzñ¥]ù|¯9ž-D’NO°þ•£m:àÜ”ÂsêQ€k>öÙ\nlAPQŒâŽx¾¡=É&~h=FC6ßH€)µ´­Â}¹‘Q«×rIûÝó´JLÇÞ¼´!×U („òG\\fj½³’é0>ZXõ(É# |PW—Ii°`v&fdÔ×îmlÉ€yï\\»xÝÜ±fØÞ§Ü		öœþ“E¡ratôïõ‘Å€RÚüPr$ÛjL£9ëZ^^±p•5z€QÁÚaI? Ö;¨u©@J¹	Ý$&b8)+6k½}Wz‡šÍ£­…´”,º	¢rPž¹Éš:¦IfàT@I{8ö÷ù	=ÎkvµÔÜC§hOš€âIœ’SŸ€¦^\\±xý‹åL^iŒ:Ï”’G©G¶RAóDênÚ_\\¢É‚SxâÂh¡_8ÏN& ¸vß@m´Z»¨ÂŸR‰Xnp”’O}¸­5Ç—´óžžÿ\0—Â32ìnIèéñÏ´WÔm­ì£å2¡ºedÄ¨’s<üP–6×š«ªzÝ)µ°PÅÝ¬¶ÒL,å_þ¸÷&ig¨:5mA¶Óon°”¶˜BnÖ“>¡¤Dñšƒ[Ôn®\\và´êÒë^ÂRƒÑ$ÄŽÕ*\0!d÷&0 ýÄà÷\'ßùúàÀ,ôMFßXiVïZ:Í²Ë†á§egz“@g’x§çKÓíõ÷õ»‹«…­n²or*)	Ï^\0õŠƒ@x/GZÉQS÷w¨ŸJFqÿ\0ªî\nP@0T®#§Þ«m®ÇhëÐüg9±˜‚zqí2ãB´¼h¢È&Òá1**l‚xRI\'âNÍ£vrl-žSáÕZ’\\V @ìzŽÕå‹4¨ó	WaŠ%„¬Á2@’Dæx“Aglm\'‰·F9i©:-ôç˜‚Ò„tâ\0ëChÏºÖæÆÊÖv¡G&>1ÍlÃ#W»[**K-(8éIÉÎÔƒÐ“úf›• !\0!¦°”¢@Hööýê¥‚.ÎòZÍ‹°u‘­—RÃ›·©\n@-@•@ÌvªŠì.ÙÔÓ§ÍÅÁH(’ âc\nã˜Žµn]Ò/<  „¦q°î~*;¯Ç]/ËKÖì5´…$)EpÝôšµÎgSkÖsÇ>ó]6ÉëK%ywM3r !!Ï,ÎI2=€\'4œË–Z¢mËÉu#Ô]”÷3Â»ŠóR°»°`°õ¤\0\\lg@™ø45Š’ËçF	3ô©p,sƒpfœü>Œ½@q½¦!$.I#òæ~À×;aõ\\ÝBD­EA)L\0	ãûv«Šn]kDKa\n\n¼W”¥fRfy8úM-Ðí’ÙKï\0ƒÇÚ>ø=:Šë.{ÀéVŒçðúúé-ºRm$žc¨ö¥ºúouÔÙØ6é·B6¼îßA\';AœûÇ=Mßš¤ðOD­A*?=«e)öÄ¸e \0–ä„ûÔª†GßŽbŠÛló3ÓíØÓ‡‚ãÉÉ1Ðñö¦È¸id,-G 3PÜÛ#U³e!@…7¸â‚Ò´«fÛQiûwH	îDZ«m°sƒ!ŠØ9õG \nÏæ\0|TWî„¸ÈAQ\0\0yÁýè[çÆšÄÜ¸Ò¤œ{GzEÿ\0TvêáN¢FÔ¦8úUk¥›Ô:H§LÖã¤¶²µæÙÜÔû›RTØZ¹*Q\'zSbáZ@*ž˜3G¡Ã€1ß2z@Y^ÃéYà}d­kçþqÄ’`ûÔ.¸³÷\n1¡ýë—*w²vz¡M¸·0¥?Ú0(ÖÖpŒ@‚x ikãlö\'­N|V?øäS´ØãÔy>ð6éx³L·»²uIAUÙP¨¬€Ÿr;ÒªÞC€›µ-ÃÌ	šéfÝ*üéHàaÓmüÖèö‰øšõâõééÙ’OÃž“]¡¶çÍD*N›mbâSl„ u\0cÜõ¯n’|µÄ‘Ví1›TùÍ¼¥FD{Rk‘æ+hë\"}ëTjSV»“¤óöil©öÛÖylHmn\'œ9ô¹V!ç\nŸQQ\'4uÁ¶”=ÿ\0¥DØ$ÈÝGH¥­Ô”;PE.ÚçžÓvmÛe¸i!)à+E¤•IcžŸXH)ÀæHœTj@ÈíÌu¥ÙÙ¹c(WŽ þr€žÛ	ûÖVêmD©T{t¬¢lÇ@&Gp°ê´žDÐaD*	ƒÈ¨4Û å¹AÎÜúf½z@‘Þbbz\nß,ØÎD=—H;°>µ`oYnÞ×+…qõJSç‚sÄëP¹tI9\'§lWn”[6Ë;úòÝ%	„ƒÆdŠ…½X¤„ªAãßëU´=*ƒˆt¯Vàß¸HOÜŽÓR@\"ZeÎÞíœ¨š«øù‚æœæÂA(\"~kÛ;•4  G¸<ÖúÍÀºÓÖœDAÔ0€!w‚³‡ÛÝ¸Ä%gŒH¦ö÷èsÇb)f¡jSrê#…1ïKö­•JOÀ¦a\\KÝ¸+Sé=AÁÔVÒ©2AÈœÏùª¶—«\0…™u_x«@¸´fÏZ´µüB—îÛJ›Xé*	”ž™‘ïQn£ÊMÛsò‘F›Î³c0_œ×Ãž+zÁ†­¯T—íÐa¹^Õµì•{{ÕÑW:ˆ-ü»ÛvoÒGå¹hÇp¾>ÄT«qû]ª±ÒôæÚVR¶ˆÁ(Wu[õ’<À‚90GÍxíoˆi]‹Ð¬¯î?1=–‹Ãï©Zá—ØæVïüáõ]¡ë»­)ôªPÛ¤:ÔöP~!Uî¯£x¾Ù,#KzÁih‚—áii=ö¬Gêiâ/.ÊŠ\\\"á\nÁmi+ô¢í¬[éÂöÉ#!	Hú§ö4šxÖ­FÂÛ‡ÄgýÃ[áG9ÆÓðúþžÅÛÇíV¨‹võ \\uÙWû“#¯n‡½“¹ˆ)0G·CK¼ûÖ?å­\'ùöDý(–nI>¤6IíŠÀ»,Ä‘ÖhùETÎ!Vkõ:Ž°}êwéÆ	â€R‹kK©Ž`öêN•HÊ3ŽÆ—#0l¼î‚>¥’ÚT¨™(& ³ËÔ›BÒRW(!R2ië„%;ÐéKu<Ñê \'UÓ8«+ƒÆ!+´0ÚÂk« ©¢#GÎ8ª3Yëv¯~âí¶]†R£\'8?0æoz¼°—.¢ÿ\0–âv‚;Ä7õ¤ú¶²›\"¶[Ph6’\0Ø&\"žÒ±C°Ñ½#° 3˜›¢¿õ¦˜ZK/•¶âáM•J»‰\0ûñVM\\—ÅÊZ»i¥¾JˆRJÐDF1ôŠÕfÃIaÛõíqM<êÒ¤Éƒ×\n¯jz“w¤¦ÊÈ()¼\nK‰ƒê@Œ×ŽGÍÕv1Â¯Ëœ}t–#Í`ç€ |ãðšøN¸Òu[•^­·RVî´¢Bäú€\"\":óQëú§|\n6`%O;¦r`qÔýhï°í¦–íÂÔÛË¹\\²¯.´	=DžÄžøžãPm†Pw`È‘é=Ë˜[”äŽ>‡ÆË<ÒËÉé˜EÍ7EkN}M)öÐU½¨¸DüóE//n­Åùuì¤z¤€¢:GŒÄÅVõëíï6¶S¶RG¼Àõ«½Ý™Ó4ý?Ob›m´mßJ*‘ÓÔxéÅ^á…G$ÂØ½¹¶ßñÒP››ICiA¨¯Ë	 zV·S6ëZŒsœDLÓÆ™ü’ÐÑ>jà­Q;LJ¹¡ü÷õK¦žÜðKg+èg·zTXwî3óâÃ¤Uh\n¬X‰LŽ(âCvJR‡uIíÐþ”v›`¤íP\'r§=»V×ö“hH®O´äÕ^Õ-Œj¶ ö)%„íyÁæ¹\0¢xÜ}„P—%l¥)NV³€xçØE?qN¨úDäfq¯?Ì¸•r„Oûæ?SúPÖÌ¶ã(—e²bÛ&]qHKITJÜ{™§V¬¡€”íh@*÷¥–~b.:(î$Ž©•íëVÖÊuf@•Â¦ÒÌp!‹p$ZËÈF•wæÄ-S €=ñ4›FÓWwz…­0”¨#Þ*&wª]¶íÒŒƒ)@2–þŸ×­~—+Ó¬e\nOâ.fNÑ«½—èÏÏá„Ö¥äþ‘[®¹¬ël€´67’„ û„ž&$ý³OmÕ ²_pü]¤@ÿ\0ÚœÀ÷çö©ôÛ\"ÕÛ$³l ’?3‡¹4Í+KIØÏ¤‰>hVÞ¥z+.qGë˜›þªÓ*P)\ny\')Ûî£ý*A©—mßKV·(#ø@ÆFÓ»D_¶[u¶‹€Ãn)\"Rg¿¿žømÀ˜	ƒ;ÿ\0‚†\n•Î9ÖêH^GÆI§^+LÓ‹—Çc­&T‚ODž;TÚêvÔ%_˜IÏzŸQ´oSÓÝaÖ›q[	h»Âƒ\n¥.Ò™vÙ^[€·…m ‘Þ«•t>ùƒ,F\'†ÏÖ!þ e‡tµ©öÛZÒ@iKR¢D‘ÇÛƒChö¢ÞVÒÂŽNÀ•ÇíHµ¿7¨Þ±o`JíY^àêDUÄŒp:w«]‚Ih)$pFA©dzk\nýäµoM\07~Ð¥3nòBVÒ9h}ˆ¨[2–Ôâ€‘*‰¢à$II	\'¨«Î!N-J)KhÁ_8êiUvÎ\"C#ŽÓG’öÙJŒ)ý\'Þ¥iÈ\0ö ;üRßÅùÏ¡0“Àì(–¡JI8\"sÓ¥0	V;xúøÂ5d/ª0\"\":ðjFT]IŽÁTƒø¡ÙPÁë‰éšŸÎKAN®`©îø£)=bÌ=¤ÉPÊg˜ïX•Äå\'þhÞ+2¥Iæ\"ŒdcqæqÔÕ«¸1Áé*É·¬òìÛ¨†¡¬HŠ¬¾„¡Â¿å‰ûÕ‹SºÚÑ`ZÓ˜þQ×ëUûÖÔm›ìœë<3p ·cÒy_¹M›S¨ë;+;£ŸµNÓgˆÅJÛa DÎ+U¨“ûZ1@¹&bbl$&@qïZIõ©\'°Š÷púÈ	2c<ÕÆ.@}VV\n”§ó¬žªÕéüÒô‰8¿ñc,\\­çj0Lò{ÖW=EÛnÊçÜMej¨P0 K6e³J»KjÚ£Ž@8$S‡\\Î™?5SÓ’KˆR‡¤’~Zw[nO#˜íGÆ&	ù‘8šæI˜œdMLe$Iûz•&J¾IàqÞ¸\0zÁ°²´ðDuþ³S©\'Ê‚2=f(—\nI`ž$ÐKx´@ƒRT$Ó¹!%3ŽßÖ¥/nmH=D`ýÅ\0¡µÈLm\"DŸÐÖÈYI3Àø ä‰ÙˆµM$;pë›AÜ&F3HÞÒ•ÇLUáá¼N1\0ôÒP“¸3Õšâ;fne•=#A¶»Ö-ØÕ.Í…›„¥W@1)&qÀú×Dé-’R•[xžé²Dqf‚>ácô¤µÖ÷}ø«†‹âÔ:+TRíÞR‰üCiÜÒ¦?:	1ÇhëŠÊ×ê5+‡Óöê0Úð»ô¶^«cðƒõÞ½~ÖãM‚n–\\…ÉpØGpH=A«mÞõ.BâGxÉþïïKÛ¹·ÚÄ¡¡cøwÊ!¥ò§õ3Ö:š\0sNÔò?üO%%QÔ¥Qê¯3ª¸ëIfûßÏãÓ3Úé´ÕÐ¡TñÛ=?ÌÒâé$ßS–`à£hYéë´ÑŒ­­áÄ‡À€«w\n\0÷ï4&˜^}âÍê¨ …\0Ü	ì¡ÿ\0Šrl6·m´68J\0“¹W–lcá˜Å¸_N$ê§m>{9èQ± U~¹)rÙ)3™9ý¨×Zr:HšÆDÀíðiv}Ç-É“X¬všÛ-ë—v6”€1\"BG¿ö£mï®©>ÂqÒ¼ÒY(S…BƒÞ0Em|’øÿ\08¡3z¶Ž’ŒÁœ é7+(I+8>ó;Ò]rý²Jw€`(@?Z6õñä%M™IHÏO­T„ßk–VwJq,¼èJÂL‚qýé5AŽLkI@c½ºeÀB-™Fí‰D³?Z¨ø³FµrÕ××ur‡Ta2Dž„@ýêÑ|áRVã ¹QÐš£7©µ{â«Ö¼Ë+T-õ Â€ z$}½óLé™.§£Wuí×úlR‡ÚÓtýZª¡½…µ4Ø—3‚¥¼ÎÙâECâõ¸ÚPT²Xøh9ÛŽ\0öé[èÌ¸Æ¬½BýÍ×Z‹\n}(Ki‘	27oÎz|Ð~ ¸- ùŠ	@$’ Ò™?ýÀ?nyÄ=kþPzÓãˆv‰©3sáÃå%-¹o,©D™å$çƒýê°óï\\TÓO- (¥µ œcÐõ¦ZEµ¶–ÍÛNÛ5¨êo©-¤ù€°Þ`\'¦ã“\'¤š´ß¹rëþ¥¬?æ($ºÍ±Ø“Ñ#‘ôaåRå³Ò|ÁS£ žÿ\0ÀçõÄçš~ËcNK®„6«„, ,\'Ô	”õâ ÕçSºUßˆ[„Ú‘x¿Ö‡:~ˆûÊsð>cƒk¹Q;ºgj{ÆÚzèÝ2H;u™ž$´;õÀQÀþe/´;ÁŒq)Y;7$ILÁ¿÷w¾œ´~Ú¢â†÷`	=#Ûô î–Ò-íÔNæ!;ù¦ºyh)oÎq>ZIm[~°f•ÊâgØêW6²eÆò”[T’Rç¼fµ¸AóP²©ÜóJ¬ø†üÅ&7À¬œŽ„Ÿ¥íÃÊ·H6L¤…DO21CjÈh›™­Úƒ®[Rv v G×?Sp‹}ˆ\06„„&;UmYä…­iZÔ\\sÒ’B„ºiö«¨­¥ô§|”®$ÀÏÎh­S\0 w†+€0zÁ/nZeñnÜ8ò¨°v?Ú¢¿Ó‹—ä:¿ý:\0R@éÊ~)^ŽC…ÕA`«>¯ÔÕ‹Êzñö6-’I+$Ìq(®G6çËÀSøÁÖ¤Ú2BPÚ€\0Àïþu­ôÛdùiÜ!¡0$þçüÍyµsî–“ÕXŸj6ÙHq’ëd&é·äPYˆY`Þž$ËTŒàv­²1ŽÕŽ„˜$d¨ÁŠwŒ¶D¨­^ÜP‚ÚJ¡=!æòÞÙ\nq×RÐÞ¨3ÒªšÅË µÿ\01$ûfy§Ï&ÏPd\"æÙ.72å&9™¥îY·¤Y¹tßœý»\\Fô§ýÞàu=9øb­¡Jÿ\0ÈÃPQ)êe‘§[a•:á	i±¹G \0qI4WKËqòFå(¨ÆLÉ1UCZ¸¿B@fÜ-¤’UØ¨ÿ\0N)ï…Ä²7(™Æ\"¬ÚcUe›©–:SMLÍÔÂ^ðÛjOÝµtòâ‹‹\nHX+&L}3KNÙ0¥R Uzœ¬6¦P€$‘Ú;š™ýÿ\0‡x6°ÊÊHJ×Âpy¥Zærœˆ‹\\äc‘\07¥)ÚQ$îQý@¡åNíN\0\0`|Åh!%M	H·CM­p¨#rNfU1Ú‹³0è*Î&3nS$×š%\0\0$úx$ä}¨”\"ÙÆ÷%^BÇ1%3=º}*\'Ñ¹¢©J\\lÂŠH…\n­ˆk#~QCnóƒ5ó’‘ùNò É“óíûÔ%KuÀTg =‡`+t%˜>Ô[,£p% ƒÓéP¿œHNdvÈ88H“SºøH!¬«ýÇî+e0Û‰Îñì•P×vN\0v,­1”Žg­7F[Ã?§çºí ±Ä	Â¢ÙpJ³ùÕÊSSéÎ!ëu…O£+G_Ú¢jÍm9	™‰ë^ëL­R¨ë‰áuy–›ÜÚ%(R·#4²<´npÄsÅm¬êfÕ¢„zÕÓUv¯¸p‡Wé@Å4ô«œã,î	â­enÃ$¶ØÁ#é\\ãQgk…@H™žþõs×*ÜyÉ uæ‘±j›…¥.b\'=US·´]_œ˜¶Õ$²3±YV§ $lK„í¬«ùs¼ÑYØ•5	O3=þ)®’`–œiôÇ·4ÒÞÔZ[™ä|ŸŒÕnòø~)Do ã¯CL›†qÚ]—˜ÑlBÊ	ê9Á©?é÷*oÒ3ÔKíïJ]JŽdÉŠ·é—ˆu±ê@ˆÌP^ý£(•«J›úeòD†Âº`ÒÅÙ]4ä¸ÂÀä«‘ïŠê„/%(PìEzí«¤	ëèT:™o!OC9r“½9¡Œƒ<Fj2xÎF+£]èÖ×	ˆ“Áˆ?z­ÞxUæÜQeÅ”Ž@™ù£VÁÄ‡Ó°åy•â©ôçq?¥¡¾-5Vqm¶Ø%.¤¬‘@ŸŠzÈÎ;q¼sG¹@“çïWUÜ¥L­ÃÓ™`N‰á½cÿ\0êÞ²‡ÕÈ¶!°zÿ\0ÛQ9øŠ\nçÀ(3gzÛ°pAIOíIÿ\0éw$e×ž>)Ž›©ë¶¥.6›ëq)òBÀî—9i+4×Ö?Âùøï™³^¯Eyÿ\0õU·=×?°ÇónÏÄžx–´Õ]Úª|ÖVô,wó$û÷§š&¤ÑSi·]Åš…[Ý¶P¦•Øˆ\0¤ôROÍ:µºÉÎúæÆç­µà´O±þ¡_JÇ5ûe¦ßT²l/0´8 …ûƒþ+ÏxeÎë—ïÈüç©ðêë©1§³r{œ|¾Œ`5Kf_çs$€•,þUöÜQo„”¥ÆÔÙáH2{Ò‚ë7…Ø…\n’àPŽüf‡jÙÛU)ZUÊØ\nÊ™_©µ{N>RA¬+ˆa¶Â>bi\näpHÕi f@¨‰#éCµ¨€vj›g\0>¡ëlüGÖ‹X° D‚‚;Ò¸<Â`¯ÞKg¼—wÿ\0)Â‡R(çÂ\\lA\nJ¢q@užFÔƒ2q[£{@ú¥$ä*‡™VPÇ ó\0y§ƒÞKhóR³1 G¿÷ •ae§^1ss.¸•nJ‰)˜å)ŸTLæŸ%CbTFÒá j\núÙ‹†Ý·J‰qP˜‰=¾™¦)´†ÐÉqÎÓÀïñ!-iáe02aT	èjzŠÞyn[éËmÄvƒç„ÏNêàU¢ý‡œ¹gJ¸Õ<ûgˆh”Û€´2 zã¼ž´.µ¯5§xžÓÎSˆ³iËhçËI*1ü£3ÌŠÖ£5]\\“ŸÈý&Ä¬×_$äçŸÃ¯Úmâk’ãˆe§¾iÀ¦\nS$ž6G$‚;R·ôÛË–^|4¹ARØir¦‰@$\0¨ö?z}á–üÏÇj	RK«i§åh}çžµö¢P½Ž´¹J£3ØE,jÿ\0Æ¢Y©òÓ ë+_‰íu\n‚…²\nH ð{QÎk©¹\0>ÂYVÿ\0O–IH“ÜZ\"ëË¸d€7 ™ ÁÌFM3ðvŒ‹vœ¿zØ…µ.íÌL	ïÌQ]ÓfHæ^Û‘{dÚvŽã7-+Wh´… îNò•	ƒ\"c™Ž±V?)›VËIH) ‚SÁzRçÛ}Æë……¨Iê½€ä	Àý©¥©]2K(YZL$)&x3ïÞ”Ë\\==?ßúùç5÷ZAcýI.Sú–¡fÒçOYIÞ…C7mÇþ(´én%M¸ëåð˜	S‰“&)vkø7A2PHóz€¨ÁŽÕx³d\0¡$ò\"Dw¡_aC…énVõ\0,Xó®(¶H;À\0\0\nØö¥Ú\nÓKücÍºÂ¥ `N‰íW‹ËîìŸ³x±p‚žÄÁï\\ÂþÔYÙ¼„¶mÖ¶ü’¦Ó¼„ñ\0Žä}ªú|X¥IÁÌ\n2œÔÃ‚Z¹[ë}ðÚ‚ÊRÂ\\?Ê7{Äã(‹¥¾í½½³‰Z¢R¡;B@íóÒ*µgz«GìÜ¹l›†Õ;9Ž1ÌÁ§7o»}n·Ü[Vl¨¨o>rÔ;ˆÇHûÓvTThR¤Ï¶„¦®Ÿ¸ÉqM6P„ç•?1é8ëSZß.ÇRIO©‡–q\n0$˜\n˜ÁñDxMô\\Ù\\\\¾ÆÆ–Ð\0;Îïc@ëƒpàYÉÎHêi7Á°¡…§ÔY¤›Ä–êÿ\0«¡\n¸CMl*@0H¿½Efëú5ók¸m+·p	2‡[æR{ŽD×Ž¥ëÝ‹Õ>\\uµ­$`˜IÚAúgÞ£ÑÒî¡¥ÞØ%H·æ•>¤•Ê=§>ßZ¶\n¦n±”#ÊÚÇ#¡þá7Ö¡7Ž%÷\n›ò\"~†¢J”H$«í^ê/Ü-•ZD–PRÆ7>Ô;6Îíþ=ÚÖy†Ò\0ªíÀäÂTNÑ¸Æ¬€RÌQ¯%Ë…2ÜJVS7\"€bÕ\nÌ]	Q9?;«nÎÙo:Ja;ñ\0óÀÏ‚p:ÁX ä¦R­¬QjòØxÌ8[QJLcíVm5”ÿ\0ô÷·ŒÁZÀ3É\0‰·NÓêÎÝ<Œ¼ë…h\nP)Ü¢H\nÆ9‰Ÿ¨%§}H¸JÁ ¤à¤ðd{V…¹· GY¥fmsêÌ¹éû-Ë»Z^yÉÃ³íÚ?Û(ŸÅ¡Õþ…nQ¢ €;z”µ©X©•ÈCÉÚd‡äÃÊLÀ$‚¶8úVs.àIê&Y@ÛºˆÒãNKÌ’ÈòÞÉ<,ö#úŠXÔ¤…âHÁègµ>}hC+SŠ!!0JLŒG½%m_~§æ©[’§2šwfwHÎÔÃmÁ ƒ$ž¿%âYB\0h) ,„æ@ï×Š….2ÂR·Ê˜á)*W)}Î ._I8Ó([Iz*ÖzrGÏâQkg|Ž‘«IÆÒyàMNÓ`å\n)ö{â—Z»)‘æ	é1#ïF¡iNBNGr*Q†0ÂRÅ\"ÒL+°­ÔB„ŽÀóZÛ\0¦„¦dNNIö5¸Zöîßþßìi¤¯812yÄÑzr@*aA8Àþ•\\×/Í’Tß™ÄÌU¨¡dÇ¥PüWj¶/B“jã-,H+p/rºâLsÇZõ>¨.æ²Ù¾ûžwÅô‰]~mcáýDËRÞqJY•+‘¥”Ü G1žµ)YJ£¡ÇÖ¤¸IR‚Ò&Fz,“Ë‘_3$’ óš#Ãz(º»u>„äŽù£íì”ðAPç·õ«V‘d›fq‚y<ý)_+/ºEk¸ó<ü\0”€>•”CŠ	YÏèk*ßäŽn+»Zl©Ü\'·zEski©¥ÏÃ\\Nqª÷ú—âa§[-–üuJR3Ü×8ð§‰îô»•op¸…Ä(™Ÿc]°ºÃy{”ætJížSjP;Oß¥2Óõ6¤.<Lç©¤í_£ROžQW Fh©ZÚ•¤¤äP˜3Øm<KÞ©Ÿ1!GàžÕdK‰RAœ>+œéo\0úA0=óý+ Ø%·™FAÁ¥mBO•1#˜Z6È‘Q¸¡ùfq™¢›a 0@öšñÆQ>˜ç¥TTËÎa‰®-_¡¨ÿ\0lpHŠosd‡Y)0qdUEÝ5ý,8²Ú zà}xì)ªõŠws îÈÞ8UÕ´f\0=â¼næÙN\06AÄ~aÔþkä+¨.6¥@¯\n´‚Gâµ$`™RGÜ\n_ÿ\0j‡ ?‘š?ú}gÿ\0ä~b9l0¸Èˆž:Ñ”)£né0cÐ¯åí«hð´«sz–¦ž¸@\0ýhÆ4†•\'R»‰áÄ¦(vx®ÛãâbŸ×RÛ‘p~bí¯w6á[sõOi­=@\"¼]«»%7{T8;gî&¤´h¤Cîy¤dØopí¥y/¦€Û¨|ƒØƒÇ×ÐžŸKuÌ¸½0}ÇC<R­´JO~\'æµ°³CEMm)2€NÐ~8©Ü$œŸÒ;V0°…U	8ö½d€v˜Ù-´&yY’=³ÏÖ„yBLž(çvç4ªí*ÉOz¢Î¤Ä\'r\\gy…-nI<psúRÛûµÛØ%@’A—	dÏùŠòÑï)ÀÕÃd²¹Nñd‘\'ž&}éy$“\n3Ú˜OCc´(¶õr%3ÃwBïÅ y¥BÙßJŽU O¿_‰©u-_Qÿ\0©ÜlzÙÊE³n—TÙõ•’8˜@“<ŠAq¤êÌjfïHml”8[MÀRB¸ÄOÈƒŠ½=¶!Õ4ê›@ÐˆATd„Ž9­k[Èaeg’0>¡¨;lYê1ñŠü1zØ±vÚè¡‡üÕ,…©)Q\0\0h\0})f¶å².1xËˆ\"O¬;âk{íE­[ÙHI4ËÃºMª­•¨Þ[²]Y„Ä9v?A8¨UÄçÅ9°÷í+–7-ºTÒœ*<ˆìM[ô‹Ç_üb\\Cm¶ÂPB! Ìcúÿ\0â‚Ô’íõß™p”¸D€ ˜$NOë[*å­H}	S¥õ¥Jl¥\"wtã9¡»}+Þ/sïÇÇw¶zsA7æT£#Ó*q=6§üš[g£&öØ?|ú¿T]S±èI=ÿ\0(°¤ž%û¦ïŸS·/¯Ö¥¬ON8\0vâ¬Þ\"Ö£éq‰QuÀ?€‚à	TUËï<PYU_Su(@^I„YÛ%ÆÐ¤‰P*êàÓV’mÙ)‚´\0 ‰${Ã×ÚƒWšcÉ~ÝÁ!i0êb;nç–Ã(qÅ¶²v€e* p~cšUh²ÝÇ¹ãó‰]f\"]OZ6òÆš\n®[q	¸/7-†ÊI +¾SÅSõ–Ze†Qä’—x\0æ	ž‘Š³jHtêkYh6—6•AJPå\"sóJÕ§•ê.9pãgjÊ›BKpG\'…wŒÓjû6ƒÆUX+nˆØÓ\"Ü¼Úâ˜(D’*ŸÍÏ=h%éèUÛ„¹p]*+C®	ÔÍ\\<£ä§zH)qnG–}ó=i]îš…Ý©HóVì¥OTƒc­½AÏ&0—œœ˜&‘w©Y[©[2õÊÖ7•¬¥.&b;Ÿjcwz—ËÅ¶ÞÚˆ!Q•ƒ<“Ò„òPÅÇðÝ³ï1+€\0’\ng=±Š>\\Ô®_°d-vàÏ0<ˆTò#ôŠ‚¡Ûv#XK>¾»F~\nJN¨¾¤ è$’°6“ŸnßZ‹Ãeõ«YRÊ	[îLä~ÑÖ¡ð­ËÌ\\ßÞ2ÔÚ8Ü‡ÜIjœ%=ù<qÞ†³umjí¼•mPp¨ü¿O©©(¾z}q4\\{ËÁ¶ÜVTúÔAô·\0bMInåŠRO”µÀü‹’N&&hm|;mª¼†ÐÚÚ -$\"zqíA7up„ÈŒæOÉæ”TÊ‚ë:´Þ ƒ×ã²ƒˆÀè9 v ugÃ¨U‹n-ÅàíLe#¤ž§ ÷àt\\]¼!Ça$J\0\0û´ÒÍ¦Û”\0gžµ\\ygqë.WaÜÜÁtW4ëä4àiL8’°áÆÝ¼…1Ìöª¦ŒÃwïî¢¤¸âŠŠÀ)D“#ïV_¾ãVLÚ´Ñ*¼•âØ€¤þS¢h}+ÃöÏÚ…8mp=Iu<Ór{}©ªßjà´=VmCsœÇåž~½£{KgìX+mÏÆ¡	$¥´€µG@*--ázÓ—òÓvµ})U×iþýê\núñ)Ro,@Gÿ\0pOÈ=GYíF¤:Îµp¶XnOœÒS\0,Æsó3J°*H=b®,÷âIr|ý%î£)Û#q\'€?È ¸qj(HK*…	5&ªë-éöön¡*¹r\"cÊîÄñ¨›&ÃÍ\0¹q\n2G×¥Wî®ZBz$q“õ4fÕÕ/tïQä…	úÍ2eK@	$‚9J‡ïZùNØ;’pP{ÝÅ-;ÒIþUvî	÷¡îÌ]ßÊL–˜ZW)m\n)$(LMxÓp¡½APyGÍhÊ¹Ä$Lƒ9öçšR©BR>„Ÿ­\\6à2~¿˜Dh…%(*P\0’N+MàªR˜§_šµ­jj&8D–ÝØC!\\ƒô4Ú¿›Çh&M°…Ü¡†·¸½‰’}€ªˆ^Uò¼Ò6¥)„v‰ÿ\0&Šºp“¹Àw…£9ö=GÚ p¡M’xžÃÞ½§…h«¡EŠwßýñþ\'¬²Ç4‘€;uýe:æP®#¸Ž1Ó’ÌšRq€ùÛ“ÇARé·h*;yÞ¶2Î³€q,Ì¥\nžzqŸ­ýß–ÚR#±4ºÒVdð1>ôÍ6EäG×§|×mè§EÊx¼wúOi¬­/ô«?ÒHY]µ¥ü¶÷Ÿ7x—S^­ª¿p£)*;Aí<ÒöÓ‚ªsâ_Üè×kÛ•ª\0Ê~iYHqP#\">¬â¤ëØÜˆW¢Dö®“¦]5¨0•´}DI9®>¹ßO¼+®+PiN¨ùCtfÅq@Ã™Kh2:Î°ÃD)1Àƒ}ª÷ *XHœò*¾‡lµ]9»‹E¶¥8Æî´F‰xmî6®@\'“Ó½\0ÒH_-¹—TÊ~+ÇîC`“Ò§·Zd,fsÿ\0šS|B®6ƒéLN¥	¨lñ3þ êÕèA)êzRíU\\¶@Dò ÿ\0z4;$%	€ž§\'è*f•#$Òb€Ö\"ôæTú†%0_^é÷mJ®PÒU*@V;AÅX-5Å¬ú`„¨–Õ=·e?Þ˜]Z³p«HöšGy¦`TˆÙÛµ\0èªÕž¤„oIâZw/±Ï÷ÄoøëGV“|Ùe}°[·©\'j¾õíÓWŒ6Í›[Ör›\\{!_¡¤-:¦’Ck€yƒŽ£Š*ÎðÛPçÊô‚zÊ/éIßàZ•É¥ƒcÇëþæþ›ÿ\0&Ó¶ªWõÁý!_e.Z>Ò“ ì¸P3Ú›hî ²óhó¤+r‹ÎyŠ ûöö¥ê¼·ºÎO”çdcŽTì%Lº…°:ÄÛâ¼æºFŸÓj•Ïåùô›´ê´úÄ&–Ï×´bï¸Èæ(gp8?ñDÀSŽEbZ./jH€$¨ðzÊÎ!U¶õ‘Ú=CN®[ÌÏA4UËaI dFPéRy$¦R9œ˜ïô£]\0Ø ‰p}æ¨Ç‘‰G8l‰SÕJ˜JŠNà$F*/ëj7ƒN¹õ#z\\“-¢›TÈ…ô=(¿$ù(NjÁºw’\\Õ½Ëy²Óh¿7¼íÄqZt²-{Ø{gÞi±C¦,Ý{|á^-eåÙ¡M6´‚DþDÇC=>ô‘ïé7ZhfúàÚÝ”þU%D#\'Óº!R ÿ\0Í;ñj]«§s™1	$í\\æÓFwT×-ìX‹Ž¢D ¸ÏÇÎ•Å&ÓÓœÂé+F«.q·˜àZ­ÄXÝ^]-}ÝÀi†’ðœ¨öN	‰5{vÕ%õÒB9€Ò8ª‰-k4Óí-‘ÿ\0MÑ´÷C,€I@Sj\'Ò;©C$~µyhÊ($L|ýjšÓÓiíª±½$õÆqí“ÇãŽ±MÃe§`) g$CªÆ^0Â’ãiOñ·v#Òs}jÏt‚AäwëŠ¬jÎ	}Â‰D(ÿ\0Ÿµ/¦9?¸ûÙ–[u›45l‰S×	\\:BF?SÛïN­mÐ†Ú%!)\0’:v¤º5Ó:§áoBAR=(n	1‘<OëVC,yžph$ËŠ&L˜ Ú¥ˆFã¯×8kÛó•i7þ!Uî—6ï8ÚTûHsÈ.,\nH3×rrG½¥[x‰«Ï:íÊJŠ”’  I9<)¹y§.Ÿy„—VVÉŽ„™öøSk‚coN¼ÅµWf#r¦Ït1¶ýæ€Ù\0‚ŒryƒÄPí¶?í´P’a`‚¾ÿ\0©ö«#ªh4Ì©·ÒR0ŸcU•¶ÓÅM<‡O¥RR\nAÁ˜£X¸DbzÊf;z¡%+;ˆZL->…8qô¡ÜÉmÂ\nÖ¨XT‘·¤Ù	[N-n8¢\nBPÛÄÔL‘}XŸp(KË´Ú¡>SkÊ‚]\nÀ’@\n3ÏùÖ—Û–À¼ð m&×Ìy‡-›Hp˜BS”¦ €z‰Î;ÒkÆoô«Ubë@•–ÊŠBÔ?ƒÉˆÍYlÖ„­RœI	P ƒµ	œ\"•\\²¶_zåV÷O¢¦Ô`’‚DíOòŽø&)šœ†þãšwÃsÒM¨^ê\n²h¾ÛvèuA\'häAž>ÑZYØ‡.˜ZÊ¶¨+î=©y»n½pÚ’¡¥ PïN¬ÞÚNÍÛbP OÌT¸(¸@ƒˆnª|û²¶Ô6€`~b:ŠŒÚy­o@!_íÁÏµD—ÒJ\0x\nÆ94ÆÚPg˜È>óJr¸ŠJ Ä[nm¶¯³·‘üDñ?5ö·idßðÔ›—¸KH2=·ƒõ=)&¹¥´Æ·t†[–\nÃ‰$€¨úMiejÒ•Çù$ö¦Æ>óÇÖ”p™%Š—~«‹Ç.	T\0è\0èoÞ®–€m@HÉˆ çÚ‚ÓìÚ$¤§©1Y~óß…Z4¿âÜi#øiêGut©{ŸÎm«Çí½Å¬8ò™¢í^§~í¿˜†éÚ’`õó\'4£VÖøÇÆ™bú–G’VâƒÏ\'®)¥ý¦dŸÇ>†”NÍÀ¸®¸O$š@oÔ5\'®Ô”´\\P;p{ž$÷¢T™vf¯Æš÷XÌÃ }{Ì°C®\\)W­Ü¥ÇââÓ•×üø«•‹)HŸO@{|Ðöm¬$?Å\0\'	HA€\0ïKj..xmUûøé7sqob0qéþ|P·K-Èmca8O;‡y¡®õf”¿*Ú\\	9T`ŸooÞ¡J”áÜ¥É @öª¢•LÌt°n!(BÜ#kªð:Q	JÛÚV	À<‚~j6:gcŠcl¯NÕDÈ#â¥\0fÁ•µÈš¶„•%&A‚$jšá€¦‡BŠT ”(¤ÇÈÍy°!ßH!\' vö£=(G\\È­\nAÁânÝ­?lm%	uMæqïTsU>aE±ÏHÌWQ*ÉÛÐô¨~4Ñ­EëW6²ÓÎ«ø„«ÿ\0ÝÄÜuæ·¼/X¨<„^OqŸÛ·á<ßé,tóÃp;¾ÿ\0ŒªYØ8û›ÜùÁÅ:ÓôðÚÁäß¥jÀJ`&ÝÍ”–„†+m-Ø8žAW<Â\\y»]¡$?æiöœèq´‘üÜjª¼¨P?Ëúˆ¯Ôœe;ÎÓÃëM%ã†1‘f:ËêÒ‚FjÊ¢«[¹ëû$ŸëYMý©}¤ù‹ïêv÷í©!dÏ¼~µÊü]áG4íÎÚ ©©$£·¸«Î‰®¦òq,ÜI\nœ‚)óèCí„:&yœýk9KRpzC`Öw$ù¸0FG ÖŠ\0HÒ¼eà²Jî´àòH+Þ¹µÃ.2émä”,rÈ¦ÕƒˆíVDc£ø‚ÿ\0J1nòËS%Š¿xkÆJºq)º€£‚Oé\\ÎÚÙo(`Å?µ`[¶?<f:W5›e5\n¬9ë>Ð<DÒ˜	+é“Lmî‘pòŠV	\'+‡h×î4BB‰§5qÒµuÛº…)^ƒ\0ýùýj¡Ã)ˆ+ÃN„DŽõý&¶JÂt¨mn“tÀu³ÌLq=ëe¤‰1Ò±J¶%óˆZ(\n}çš™’$wÇ×ïA[ªÿ\0+{Ë¤Z·æ(úcœTü¡«´ÖC¯Mo¯+s@ƒÔÖ¢¶ŠüÀ$že\">ñAÿ\0Öm®ÁBã°“ÏJQypre\'\"3™êh©á[Wr–àÇýÇŽê+ˆ–ý*ÒHl¸!´cÚ*&®mšQB|ˆWåòT>ÓK´víŸ…¼AŽ$ÆjÒÎ–ë¡+8Ó¡ƒ#Ø>k?[ávSY+¨b¾ÍŸ÷ŸÊkè|F»ØnÓŒû®?‘üÀ¿C®†Újåk<Úý©µ²Xß\0ìOiæ„¼¼ò÷1¦#Îq<¨ŸB¹þ”ºÎÍÆî’û—.Ü]•JH$$Óãéãì¬sž³ÓíÞ¹éûÿ\0¨êåƒ9úÒ‡ÍãFÙjIÿ\0hÈ?Jpù)làRÿ\0™a OÇµ,y¸òygcŠ	0H&z\n§gPØŒˆ¿Ì½ò<ýL´´;èjßËœ$ÆãíØu>ÜÍ«êMÕò‘ÿ\0¥Ùå$$AÒ§½BÎ¨Ëé†ííOš´„È6¤G·AíRj¶­¹nAÒD¦H ã½r’28öý!Ã¡eÜ8#·lÄš§‰t[†e«éqõ†‚Ú”¤™\0nïÏ^•­eâ4h¶éS…¶[ï¶J\nV¡bÌ„¤âM£è_ÿ\08EäÚX/ÎJ`ÂÜIAö¼}kß¹quãYÇ[;î*PIÊNé&=¾1Þµ6VŠ|¼çüø§D­XVrgœu?ÐŒu …°‹&ÐÃH@		™pEX,î]#ÏASå?Ä(H\0ž1óÍH–Ó<‰1Á™Àâ±÷’ÂJ—Á=\'ßûV[\\ý1˜…–›@R3|’IPÚ9\0dš£øŠÕ×ïP†Ô¥+Ò	’£“í×¥\\ZÂJ€*Qê£’éÖEï[­ÕåJ ñ¸ˆÈí“‰¤o,–¹VÏ´Uá;§î¬n\\p©K8¶	‚qÒ$ÇaúWIa´¼)a·’y\nÌoòj¹u¦\"è?m´ÙÜ,<µÆ=ŽcßîÁÄîRœÉI”}êú–g°7LýK0ãp0Xa\0F7ÜJÀÏôeÕ»H³ví¥­¤îPÈO8=¨Xº¿Õ^,¬2Ô€ eF~ôiÔ?\0§,îJÜmB‚còüöšk¸óÈúÇ°”°1Æ2ÄïBRA¸mVá=7wø)qÀ”%w.q8*œ…cƒûPeã…ûe)a×%Ò¨„™ŸHŒôãŠµià4‚8Y\'™îjÈ¤ñº¢[2¹{rlÞ¸CÍ<‹„ (²Ù.`½8\'ã4žîø<ë¦êÙªQlÛ… º9‚I€©ŸÞ®Ú×’Ö’·’§Ð¤ÈIY>¨ žµÏŽ‚»‡Cmƒµß5Ò•Ã[dÈJyÄñLªÖ0}ÿ\0O‡Î\n´ç˜ãK»¹vÝ‡O–â¥X\0‘ß?óY{nåÃmÛÜ‹¶¤’è3ÒyëHïÕ{§ºl–°Ò@B”à¢dž’=ñLíJÕ½·×¸ÂJ—R:U­‡x-DzÖ	jû@3l…\"`¨‰‚=€¦N]\'Ê†ZÚäa{6ÇÁ¢§­÷ÿ\0ÕË­ÜGå!!·e&?^EDJûeµ€`Ç¢q ¯Z:±ã˜àõtš0Û¯\\ ™ÂˆÌwÒÛrî§¡…Œ‚(v–’Rx#ƒE¤ÀƒÔDz6L)é+ºÛ›µG’a´!³=~µ–ö¬Þ¤5xÃn¤ˆ…€Hû~•±jÛzƒ…;‘½!`‚NOOÒˆÓÌ,[Þ˜‰IÏÚš\'‚§™¡)}¦xy¦@SJqL%µ¨‡¿9ûL¶CH;RtÞ¦YeL8PJ\nHQ$€y¨[¼bÆÙ&åðVS)	•|>ô±{-ôžLFËìµvžL­x—MÛ®ºú%7	K«)LÂ¢=¦\'ëEéI‚	0?ZŸNu77Ü4ß’—VTS¸“?4ÖîÁw)v¹lÿ\0 7·k™È>¯ŒQšÓ´VÇ‡Ô5h´±Ç^ð–šJPL@$àîj\"ó/.H\'¢\"]– ú’MÙ¸Ù$nÆ?øñL¬BÒ=\\ÇéK5aFs˜»RgvL5V,82€’8)ÄTnX­„oIÞ„ò 2Ÿ‘E4¡‡J6ÝDÂ#òæ ÐÐœáºEZ×NñRÀéÔÑ¶¹ s5Ú|«•¡´z) n+Ô/rHÈžsÍNÇçþä·­r!%*¸QiJTc¾{T®¼–\0îs IýèY[¨	KÎ €“ê(G|û4:‰lr´æ=ÈŠmŠ×$û.Á@Üç\0CÒ—dº™>˜ÄÏ%(mŸ9juD($D<‘ûP÷úêÒ\nm‘ÿ\02óíÅ+i*yâó¤­jä«ž2kÃü>Ôqm£n??õûÏ/âþ1KÖh î\'©ì?¹»R‘ž¼Ô¤\'ŽÃ½n†y0`ÿ\0JÛ­ª)„\0>kl!o”ò€`sa$ÎaÄûUsUº	c0 pHãÚ™®å×SÓ¿ZÇMóîwP™?4Ú¨Q\' àË•%*•äw\"²¬ë·CQ\0Àö¬¡—\0Ât‘\\øOÕÊ\\	-?Ô¢?58ðÅÛ-€ÓËq)È\n‚~†­W~-«s’8¡ZzòÃÒâJ:žÕ*Ä‘€Øé)[»nµ²ú!Cx?Sñ7„­u \\JBN°ÇZëš’­u&ahÚ¾AŒsT­QcOQó\n\'‰úé9Ym…Žäë9úSºjŠŽ±¾1ZN@È˜5Ôí-mµ“´AäG šPðHKÛ­–R•rœô£Üre8ûã™G´l\'\n\"y“ý)Ã/˜ØxÚ(›ŸÜÚ¨ãx‰ã4¹À[^Õ\"gÚ™®°xƒ8c/>Õ’Ê…»Šx\'¨«‘@XÜŸRO­qí>áiX2B¹Ÿë]BÖ¦‚VGs4¶§OÇg)Ûé1Êá$f!ñEéq¢ÃGÔLjup‹‡Ù¶aÕ¥C\n€ø&«ÇÃºË©Ø¶@3mÊ@¤ÄÖzíS‡àC6›Q`ÅhN~¬çšÓJtŒÈÚ)ö§jüâP òÈB`¨òrÅl¯´óê{^ñ\"Pƒ2Õ¢I v\n?Ñ5b}v©·²´µkW½bÕ´¡*[do	hRŒHÀ-Gˆ&™Áê3SAÿ\0ŽÛcgQ•›Kk¸=Æîo$áI)hÎJQýNMÅûúÓå×I³eNº±°¸g	HˆÛ Í+K·o¹µ7däO<œ\n²èÍ\\Ó–—RÐ)\\¨4dÏuöþÕåmÔÝig³“íÛòöØWFŸIXJ—]~r7„Ê†Æ\'üÏ&¢m2êA^É1¸˜LVÑQÚ¨\0PE«væáÄ B¹>ÀsYd9å‡_õûFâpÅH€9šNâÖÍÃo€\n% ‰‘§²ºvæé‹}‘nU»ùÔ\0&\0éõÏµrÊ\\;•ž tªòÆ[¼ä>YÚÐ]béÛ„‰õ7ÿ\0iC\nŸ˜ªîªþ«hÚÚ´}Ô±\0@^Ìô$cÚ¸âì^¥\0Ê¤ñ#°4©ªéªm~·s’Øhîˆÿ\0:Ó4d7¤dG¨?¸~sÏ‡Wá—óÎ®ãñ®«{ª+Â\0#Úi2Ú¸¶ñ{,´ÓŽ ù•7´“ßˆÔ÷Á/›«Àµ€ð-4 BÈPÊçˆ${k|Å»¶O¦‚šÚIIT:„Žfe¥.lŒç·áõÄ«[å]b‘×ùš²î ë…´µolÒPI!&¤çí[¥”0!\0©Cù•“Jü½í\"êñ÷n¥Ý© ›•‡JRAœ„ñNžLçùG\0Pµ™V	íõø|¢ïé°§·´_v£´ÆzÏ\"—øuÄ¹­ºB€nwN$	£u(ò\n–=#„Œ’x(/°´k ©²\\y\nkjN	tö©Ó(aŽý¡J-š[o‚ÛÜW¼¤¨JHùª§™pêZ{\nÿ\0ÐÚy{\\#ÔJÑñ=saµy/;}pÓm7(­èIDŽýHÈçë\\ÕËëö5•^(ïvéEÛ†âéÆ#¤t=(µÒ\\²àtÀü?¸¶$|?Üè–J)u%µD&µ×ìRò|Ò¢^l …ßÌ\"µ!±ñ’Ô”»æÚ¨`ùƒÒ=·\ntÍãz“E‹Uï”úA	ß¯R¦·¯9øó,õ°`ó[h(ÜâÔF@L\0ŸqL‹e¦\nÛ$¤G§*úžß5%»4Jw‰”¬˜ýª;å†X¸Z¡6bIJA;v ©WäŸÂŸsq\0ÕuÚ³æm[¾¢vƒ\0óæ”Y\"ææåå*è\0¥«•LÀûPV7×·ˆyµ¸¥Á*X\0qÀªÄÒ.-NëwDe0@ûg¥Ø90íZ§N²;ÝíÛf’ÅË*Jqn0w)0qÏ¿3UÍcÃú³ÿ\0ˆbÙ›‹güåˆÁ\\þüM^¹\\¼	B8\"´¾e•Û¹ä¶V\0*J\\sòéþÜQ¨½F}Ço¯¯hïStúý\"­H¶³h—®º¸Ý¹ÂPþ\"_Ú›)–\nÒ¨òA…8ÇíK‘r€ÀR—	ï?¥{«%T¥êj‹sÙÁý!EÎs$|3o«4Ò]’îåm1&§z<·lNAšç÷7Nj‡Îô]¤‰OÔmö«…¥Ë·©/kÑ\nJcö57ÒW4Ô•P	‘_).êjcp°€‚;ò¯ë}£;?–t#µ\0Õ‘YÞ´úUüÝëÐÕå¶¤Ú™¸Y´|P¥HJ€ŒvŸj` ö„`\nì´gr²Í¹Cm%ksÒL@ê£ñ@ê—Ú*ÒÚý\nBJIEÀNä7&¨F:fŒ}mÙúî”Tá¨NV£íŸÔâ‘–.uãwxØ@§0Úz$™$ÔR£«tþ`¨@Næ<ßáiöì>ö‹eéêÒÆT-“æ<\nP$§Õ\0Rûk’ð„×$ýh‹–ö®ÖùII	 `ûÐÜ££?_‡óhÜØ?_8-–Õ­E9AYç´˜4Ä¶	  ƒði^˜Ém)É	UÇáöÔyô˜öÿ\0\"¢ÃêÀ“Ä„Øñ0q¦RËHÆÉ?\\Û­ÍMÇÚ\nm¥JI0¥wŽ“Ú³¶%Û“S±G\'™ÏPÚ	0–ÙCŽÈ(œ‚2R>jrÊÙ0¨3Gw¢-˜€ûGíRïÐ¡´u\n\"iª¨`¤·ékNp9‘2”þn	ê( p¨8‰@î%)cÕ‘ÍL1íOV6/H92©â þ*ÛŸâ7ÛÜQKšoh	è>ø«¦ ¥·l©FðAONµQu^ZHžHÆkÑøu¯}x~ÓÆxÎ–ºn_ºûAßÒPœ1Ï4»>`‘y¯o2¸žIúý+-™2#ˆ’yZ{€âb1ÉÄ5¤¤ ú}]~i‹[-m‡ g1Í\nÛ!Uƒ“€:ÐúÍÁVžRŸx«w6!Tm‘=©¥n”È¬¥6Ínai?²‰´Jn\'™Ü¬u{Kó\0€®ÄT÷vÏ¦ IûæzMØV×m×èŒŽjÜÓ÷!¯5!{@äqD©ÖÑê^aÔfmªh¬4‚°°ƒÈ)ªˆ4ëk”­\nÏòàÿ\0Jk­ëW7.)¤8RHR“ƒñ5X½|6eq“œ÷ª2*œ‰&À‡\"má17\nB£qŒÌÕo~×vSù¢“ø-€ã…K;Gò‚jå}`Yw£œr*·­¬ÐBïk}m*Wv©â¢y‰ªŽ»¤°¹R\0Ü3ññWÝSjYP&@ª}Ã›·%Yqïþ\n:Üt1k†:JNÑnöÕ==èË-M	¹HB‚Ê<Ô×º+··2\'n09ïÍcáfšX[³#©íØÕžò[™uRë7â=IO…¥L…¨A!±$sœÕ®ÉJU°vù6ËZ€P\"*‘ul‹E#Ê ©&vÌý©¶œå¶¢ÅÊŒ\'JˆŠVý^ŸãÂŸ|ÔÑÑxÚ{3köÀýŒ´=«i–`ù÷LÛÄ‰Y	ÏÞ„kÄzEÈÿ\0ÓêVKœyÉìipð®˜HP“×š°Y\n ,ã$¥ƒ¸6sòÎf‰ÿ\0È/ÅC?õíßA•¤ðq÷—½¥!w}½õý³©ü».Vƒì™ÿ\0ŠÝË{]9’S°)#“œE¤Y›‹TÞÜ€R£,´¡ˆŸÎG¿AÄg¨¬í_„×¦­®kOÀGtž7}ö\nÖ±ÏÇŒ~PbÞ´UµzÂü©É	õŸŠ‘,˜ )D\'j$™íîhòŒm™’zV]\0R”$BRœ3ž§æ¼±µ¬¹Î:OF,ç\0EÍÜGBÚHRÄˆQžžÔéI&dz‡ d}Uõ‚…pby?J7N¸½´kÉq)XHÒŽYŠ¿aÒ‡e{”an§ 2ža÷m¥H&w¥	Ò˜uEë†Â™m_ÃJ²®çØ~ôeåíÁlù-6•œ	ÉŸÚy²Íª[V„„’`“ŒŸ½B–­s™@ïPž±bÛ(°KÈOžñum	B‘Áï™jUi®Ù[ßþóRq÷.R®l² úTH\'\0ƒNô§Rû¬¥ õ‚¼	Š¯ëZ®?¨¼PÅºÝ)$©Aiú9§++c”³ÛŒ|Ñÿ\0Põ,Égáü}~qÎ‹££Kvåá¼©óÿ\0o!	É;‡Iàh§%<î‚@~¦«Oxh/N¹cñ6«-´òš*PATf8ÎdQéÔõ6€ë6ªq¹Eø¹1@LqïV¶®Yllî×ñéæêÛ½ûBÝ¶ÜéZÀ”‚A<6:’­Pu­eïú™U…Ái›W%§ZWç#ùç¨Î:Fiæ·w©ê.l*[%òXHJTâ$OI9ªýºƒ›Sƒ<Œž`šcIJ!ääývih8ËþRÝþ˜¾»ïú¦žù.7á´%J!dª&faõ£ÓnÖãƒr‚6Ó5UðŠÝ²ñ‚™;Jœ‘0•`ƒú}bºV¦‰¼}d$I˜HÅwˆ(uê??úýbš”òï taŸâT®t¶Ã.žRssSxVöÎÏNfÐ/Ê|‚¥¥r\nŽ$ƒÇJvã#ÉÈGÌÒw4¤lDÏ§)·z”s*0Tƒ,í¼%\"\'§1ó[­*KHSÅ(mÙK ÕûM-³	RÐJ‚ABˆö¡,Ù¼ÓÞYeÅ„“¸¡ÉZOÜóñÉ¦¨‚Äÿ\0b€Üƒ‰w³N–ssMíîTÚ I8ÍS¬uµ¡Ev¥*BÚÈ#™ƒŸÞš[kv¤m½i$’’•J#A—TÛÓ¨öÿ\0R—R[¨›ê*·!\nw|­!¤p\'j‰?°“jøˆˆù©¨±r Õ»áÍŠ2<û{Tì-!BHÈíTsÎJË„„¬ëúc×O¢êØyiB@-\'ŒúxíïA½å?ktQùIÀU_5²¢i;A™)ïóUÝOMBÉy”BÎH\'Þœóv7–N@èD%‡\0%wVÓSq`ÕË\0ÙÁØr¡ÔßïDøfùû+Äµ¨4ð·}°½†fA&0\'³DY[%Â\"0B¹ù«`¨%¸•s÷¦ªo1…\'¼bçUB­ÌÄ´9À1Ï2i\'Œ•uo¥Û®Á×Zp>¯,Á))<ö«\nSå’ƒÓ Í)Öo´ïáXÝÞ2‡¤©*3å”Gùg~\'4JévÒ2W9ü )cæŒþ²‹`ÕÊn”ãoº‡ÖeJRŽå|“ÏÖ®ºeÅöÈ¹¨÷(‰úƒý*vôÖÐ!M‚\"d\0qÞŽe‚€@õüª¢j5\"ÞÑ½N©,Äñ»‚¦Ò=Ä‘Z-«¥/z6A––\0àˆýE”\'¤¤öäVéH\"éô¤ƒíé3Ë€rŽÝ²ÐœÄŸ½kstÕ¶Ép%ã”ŒÁ3Ôÿ\0“Y{hÝÂœ<‘’1)í[2Ê‚Û©ÜƒÐbzïI92¼Q‚Û[ßÁY\0’v…JFsN-\\A>3÷¥„»°€@È DŽ”Sl;·s»–÷™OÓ­;§m¶dò	×z‡;VßÍÿ\0oI¥·÷–ìK!²ê%*ƒØûÒ÷›¸X+iõ¨õmÅ“ý¿j‰+¤¸Š\nN>´åú³baóþ R&ozÂQ;ÜbL?­H5\'ÊaÅ{\0(­Œ„Á©\0ÀQÇ°²Ãéãá.ÈL)7¥kŠl¤r#õ¥w¶Í.åJaA@æ Ñ¥ØU#‘ÿ\0ŠáÏ-%Dœô0LW£ð:ßÌfn˜úúÌóÞ<È)ÆsÞÚ‚ð	ûžh†6ÇíêenoWN:â´¸p&g`ŽEm°ÜÞ™ãBó™¸R“?NüR«õyÐåëïÞˆ|­Ó\0½q÷¬m‚2¯®3EÜ•ð92û¤ÒÚR d{ÖT«, €¤Iîk*<×‘±Gyç…YvÙn´}II\"zs]=­jÕ­iPÀgˆ®k£Ý7fÙEÂafsõ£/]¶TËœŒë4m5»sÞ][/¿º	R‰ÿ\0¸²IüñA3n·ÜZ§<þõ\0XS¤¨îÏ#±4m›ÁN„&p:tÍ_90?xó¥åY )’Aç½ÇŠCqp	d3Þ—;õý(+¢6Ìó‰ïŠ!b¦Â!·ÚÒ.\n’d3À4ªà‚É?çÌªn“PÝ\\–F¹¤7Á³ïë¶¹ò–zp\'Ö‡Ö5W’‚Y\"‚jí/ žsý+iON\'§J„`§$­Œƒ¢»}Mçß>iôÎ>üS<½û¢’9ƒö .¬ËK/2 u#¥nÓÁÉ9ÝÀ=xéEµ†ßL­§w\"8µÔ.Ê‚CËÇÖ1¬>É‚­ØÈë5\\±I2FGaF–ŸRÓ¾³ï5EcÐÊaÈ1£—nÞ;ÿ\0¨qiB”‰19ß°ï]Q³, ye‘´\0Òˆ%8?®Y¥Ù\\Þ/{	ØÐTyÊ™žäŸŠèZ(Cí´ýã·d¾°}€ÿ\0ÉïY-ug†½§¦ð\n­ìe8=ç·lÉ”‰$\nñqrV}G“?Ò\\D¨„ÁR€ûf”…6òÞK.¡Å3a&BI’ýþ+ÆÝ§toH8žº«Aë¶e$Ý8t˜jÔaD[Ûƒj…ŽU*\'¹“ýª†€qguOÐT¶Wlí¸ó{·¶˜9æ`õ¡XÛ”Ú÷cp‚Ý£ÒD\0ž¢Œ°[NZ4ÛJ$´€’•eSßšËôKg äŸjU´r€‚Dðhc\02Ã\0¤âi¬Z4„)òáh·ê”e\\Ž)\'†5§®µBÏR}{nØ-Û¡rVVŸPÀÀÎ3Ó­;ÐSÿ\0¥vÑÌºÒÊó’R£3ô4®ïN~ÇW¶Ô¬Z[oÛ0U‚}	§tÖ-d¡<ö1ªö•z_“Øþ£óÿ\0§¶«µ¸ÕÂËÊe°€ZJ‰I2sÖ¤géÎ*Ä›ëu/Á\'r.JVZóR…¨)V`‘$?Z©¾nm¼BÞ­hËÍ„¬©Ä(m\nüÍâdñÍYÖ“~Í®«dÓÖ\\\nSk xRÓèi»-¯z=Šïóøþ’uIºÏ1Þ‘ÇC\n]²<ˆÂ‘<{Õ^ëKÜáX‚`LO5v¹¸Tãe>R–R1·ØÒm1fñ§Ú’õ²ËnˆŽ†ÔR+½…çåñé„žöU-)÷„‚cgç¥Zì|FÍËI¶Õ––n\nÐÚ$8£\0nùSÅlõswð–	ŽRr>ÕZÖZ56·$;nàuD§ò(~QôíMÓw™èn‡¬sê½-Ôwö—å¡\0y¢”ä‚¬ö¡¶FGsBXjÈ[©kU†Ô+[á2L˜)Ò>)•£Ö×–-ÜY-[¨Â\\IëØŽAA¥.£<Ö0>Gë©ë3X=\\0þ¿8²íÍ-$Â ¨Œ÷¯CwL¥ä€I¡Ô‚~\n\np íöšY`óVº›–î”]$-\n$Àq8Ûâ3ÜPÅlr£¬2å“p’¿b‚R œ§ï¦ÿ\0O¾—Ò=+!*ýZü¿QIò(gØmm‘ÒDþõZîe3’ÞeIvR\n™Iô‘9ˆïBÚêú–yøWÔn˜[óŒ«oÿ\0/ïV¤°?. tö4¯¦ËH@	¸oÔÒˆÏ¸úÓiz“¶ÁÁ+©ô¸È„1â4]Û”Û8Ó7„€”\\¬¶Ÿ Ú‰·ÔV‹tfÎâÇ0_	óYÝI˜žæªŸ€+\0) ƒÈÆKnæ¡§-\'O¹u…B`¥B3#¨¢-5ÀÈúúþD“¥RO¯Çýn]ª¦ßl%Ä’Hq*Ž¿èkdëvVŽ®Ýë†Rë`nÞJf;üŽ´ŠÂþá/ùÎZ!.¬…8»e) ¾ä£)ý©µå²u.ƒÍåöËp¡ˆ0T2Rs¯¯qz¶¶ôúúí-Ö^sÌiä©3!IRdÿ\0ÅS|S¥#þ¢ÍÕ­ÃK}×}“”b$Ó¡š;FÑZ´	R0±:Lu«\0eL8‘ž£ƒúPþÐ+°”<E#LùC‘Ø-æB7H-¸&N:óÓâ™\"á¥@Z¼¥BŒðhKï&Á	qAÕ²HIR»aé#Ÿ¨ëXËÖï–˜\0)\nIžÙ :’wàYëÄqøgÔÁ`ägúW¢ÕÐí¨‚\"‘Ú[-!ÐË–‡ ¡.nJýñDÞ[—J<Å8¦È)PRŒw©q§èÏÌP²7}~p·”TÔ+yd@+{tÆž;Ò…)ý( 8ul³rv¬üªèLpq\"ŒoWoËôZ>¥vQ>³Aj™¾çI&¶Ûéæüƒ\n ‘?nh‹t¤z‚áCŽ”ªÙõ)Õ©ËbTHÚ@ vÍ2üS%;[iD‘¨ƒíLÕXS–#œŠÀmÄ•ap2yZ¸Ä$×Œcé^4„A\0ä{Q)VÁµY½ji­jÛzðb×V®»‘>¤·‚‘»ã${PÅRð}\'0)æ±gç1½¿Î‚q=óUÒño“ž?µz%Õj©îý\'“ÖÕn•ö«§§?¤8I$™ë4¾éDÈ’9?½óŽ:Pn§r·\'ëZVð6¨™lu€Ü¼[P=€hB•ŸRÏÇ¿µ4ü>JŽT&Oö¯ ò\0 ~Æ¨´3u’B§ÆÒ’9N:g3S(¡] }ët%¦Uµc§Ò‡¼q_Âü§ÇµA¤ æPØqÌñÄ!J)­e/ráaCšÊ¦ñæ|!ïá<‡_óPŽd$È\"ªö¹bÖRdŒÌŠ«øÅçQ¬\\R\nöì\0÷Š²hl©Ût-`g9£­@â]—Ò¼)+-·¸àækdÜ*ÆÝo¨ÜÇôëËAXˆ!\'äq‘Ak×3§¨,„¬ÀQ3Ö®zó+Ze 7>&u!eX&y<Rƒâ÷Ã†D£¦y÷ª¦©©‡Þ>Q„NU}*-ï.`±nêÁêh¹9ä=S¢[ø¡—Zþ\" 2¬U{Xñ#—nmxà«“Ô„éšˆ¶u óˆ¦únœ«D½n°\0‘\"LýèyVš—˜ÇFqä¤NÓÎLÏÍXò’a_Ò«W¢›• €EowtëÀ´<œPì¬8ƒ¶¥q/)q+FÕÚ£nÊÜŽ™íB°¥ù!KäŒ™¦×A)õ@ó‘Ê­3ñ	µPMÃhÄ™à|ÕÝ›e4ß›jnž€¤±Â\0è\\WëGj7¥i\0ä™ý=«¡é—Nß[Ðg*(®¤ÿ\0˜Hpž†Æz™«áO˜EªXö¼ñw7	(d4Ú®Jv€Ùô§Ú#	ý)MÉ/Ý­H¹»\n	[ªISMÈù•ì wŠ“V»BC­Û,¶À0ûèüÎÿ\0ìIýÍ\'ÓõÂ<6¶„2%çhæg©ïXº\n:›.vûžÿ\0‡×ÇÚzíO‹×¡P,Æóÿ\0ÛæbßÞÞhŠEµªJ_y\'Ì½rêûSˆOÓõ§?é>³§Ûéni·71©]ß•´ÐJ–·¥…ûU’xCêæÛ_)Cé\n	;‡ Ž†¬~ð­¾‹l/íÂÿ\0ø*V|¦ûþQ$õ;Ö¶®6“Dë·çî~¿/i¥Öê5Ú°Û²?@>RÃxÀFNHŒŠ[lÃ†ù ”–T˜ù£ž»Z­zÇT}ª[Öš}Õ:\nåà€TfF Wƒm¥—ÒzôÞñ	}Å©²i*#¨$ô [¾.\"é€‚‘ºY§>I\\ŸÍ;{Pƒh·L¾óÂ:ÇŠªÖÀW‰ZÝ¤ˆÖÖêZ_Cž°B’ “#ßŠ€ëªô6»0´.’’PIžO·ëNßi)\0GÅ*q ‹¦Ÿ)¶°£<sRŒ¤á†c2¸õûO5•4Òƒ6m©i&µH<r\0MÕ¯53¨þ)/Û<‘èÚ[€ÁúÌ×E}€J€ë‘JnôÔ:¯P“<ñš>ŸR+ê!´—ÖŸxfI¢]½¨i¬Ý…ùoXy³*B¶œóÁ33ïPÜ¥.ê–É¾Ò™òÔK_ˆùLGß´â§Ò[nÅ…R‚CËþ8Ü¸ãëL.­Òû^[‚AÏÖªú‚¶ìsfT°à`ŸCÛã18Ôù7O%D\0NòH‰Ç·&‚kMi‚m€¢zäŸ“SjOØi®<¢›–Xl¬œoôÿ\0.î³ÆxÅ©\\¯NnãL\'Ím%.¼§)Ü;ÈÈ«à¸yÛñþ¿Ü­BÃ÷z3ÛñŠÚòßñN·ld¥€Â`‚\0ôæ?ÿ\0¡SørØÛX¾ÊÄîzëU:æãK¹gSQ.­ÇWçï$—RU÷ÄƒÐŠèV©fá†õæÒí!~±ëIÈÈïÐŠ>®’€”û¼~œGõ@Òž‡üGîcÈ þ´›\\h8Å¸8Üèluù`Ú•ì;síÞøÐ®ßNK	x·›Zƒ´%A[ˆúJiÔ—8;“`QÖIámAÆí×ozVò^ÐNVF>Ù§{ŠÂ]\no6;Ò;uµx”êV‰!]Â\"“Ü×ÜSkfÔa\nüÆ6™€}çÞ­~w?ïë¤­áwÿ\0ÌöKksË\"HÝŽ«E¤)29»þ–Ô¢!#qžõNáq@9#‹Ó0-¿9$ûŠ„ö*ƒœV9jh u#zÖíÅi÷Lƒ´”îA’\n2òK¤^›ët¢é»œÌK¸äj&ÝÀô„%€Ü;MÛµ€$ŒÑ!™\\„’I1Ò´‚ÈI)*A‚2En´ë.írÑÐà	’¤õOÅTòÝ ËOX·R[\nR\n~GéR†×ù‚3´>•ËÜÓn´íJí«îB[qH+T”ÉÛN´«WŒóò$Y\"\'æšm%iÉlý~1·Ñq»)oº,wç˜²R@i¨Þ£Žøó@é¯¸óIKì‰8)Pö)ïDÙîAB\\Q%#ÒµdÇj[v_±ÔÂ“r]Nï)Ì©#88ûi~*ZµÎS¼t\n„$6cÜãâ+vX…D‰’&zô¨Õ-²žu~Pm ¬IO¾yè)˜I\n8ƒbh>[œEÝŠðF\'[µslåµÀ*aÁ\nî“Ü{ŽETí‹¶÷/Z\\ÿ\0ßae&pH˜Ü=5oÚA€@WT÷÷¢í-ÝÝ,«}*ŒíL¡!6´¶™Ê’IŒ¨íI:õ¢›R	è¬~µ,©µ/óŽÄw¢<®â`ôÜŽd¹Â ƒ€~kp{™3C6Ø2”˜ŒóÔÅe¢ìd²S	IÁéÚ«ºý°iÄ¾„ÂTv¨‡½X©Ö•k·--£n Rä‚Pînxy=vsïò37Ä‘NÁÿ\0œYip+PÜíE¥”‘é §Ú‘»lpPHHçúQ¶+A	™èNx¯b¤gxÞqˆs­‘é¡Ò•©^¨‘Ö·zåj%$GÏ	| äÉÌŠï´\"ó VLQ¨‚«‚6“ž`Á¢ÒwœLóMÚ\n£Ë“ÜEx\\iÙ\nIO@H·RN	•:|ó˜½µ\'hÈLsÎ}ë(‡m¶(ƒÐÖS!A”Øã‰Êõ+%]ø¹ô‘!+Úà=jãon†KjX\0\0%\'ù¤ï—µK‹–Qæ,¨Çp(‹gNý÷+Q˜*ãëJNÔ–vÏK­j–úyòíÒ]tâ$ûçéUÃ¢ê~!\\>ÃìFI=Éâ¬=fn–·Ñ¼“„¤\0Ö¬Ö:•º“ü „\'ªµ¥D¸}½%ÏÁìX;/·*$‰35`i›fvìf@Ì“\0ý*Í|ÛN0¥% ’0F3óU¢L™‘’\'ôªy¬Ý`žÇn±Ó?ƒzØ‚ÒìG–[i\"ýâ\n=\0‘ŽHéP[(¼úP™•`uëW­.Ñ,´@N#1Ò©e…\"Jz¹0oiÉl%Vè\'¯SÚˆÓ–=!Ø~”ù¤ \0ût©Ô”DƒƒÖ‚š›äÃ`1(ºŸ„e%vð´‰Àj§Þ²¶µÄ”(œWj@ÛÈãÞ‘ëú“*RRðžÔv¹nõzsÊÎker„íÞs1ƒ÷Í\\˜ñ+K³òP%±€”¨˜OP}úÕR°{O¹So°‰ˆ¡Ò¢‚Gz*¾Á‘;O©»JI¨à™a¿¾üc‰ˆ§\0ö¡Ç«ƒ2yM.C“%J˜œôŸj.ÉJ¹y-[¥nº¬„6’IÈ­D)·ƒ†±½É…Ù¶ë—´ÊVã®(¡«¼WmXG©-ð06žÒ¹ö•§)*[ËÝtêaiGå	™Ú;ñ“ö¢ØÖ5Fòtí=…!J*RÞ%#“çµ×}½öT=ŸQà~½§«ðêÃ«ÍÇÖØôŽOÃ¤´?nz	ÄÀÄR^ñ»Wšµe³q|ð”2ŽBÜ£Ð|óS¿}vmJ®¯H\"TîÍ­$ÿ\0íA2ýU¯5öìÛ}­©yÂTíÛò¥º¨É=ýº‚+ÎWáÂûJéÁl~óú?	è,×W¤M÷¶>åÍ—oÛ·B_»yN²® Po´Fâd“É<šsµ·šKíá)!i>Ä?zæ†Â@ø¬Ë™ÕÊ9é˜å6¯Q%´¸EÃhHXóÂñÆ@æ±ëRNÿ\0Oj–TØÞ’B‰$àŠÇ«HJÖµ“¸˜ œdìÃzOVn‡˜–0¤™X8©[p\n%GØóPY6Cäç) Q›\0@þ•V p%_j·-Í±~ãÌpNÞDç‘R‡ß³µ}Å+Í˜I™âg­1RAé$óÒ•ëÊ Ê\0*H+TwŒcõ¢£nÂžÊþaGV´åÖ¡¤!O+cnKMH\n@\'¿ÃÃ—,_iÛÆ°Î4@Kr\nq×“ÔSÜÛèöˆ (“×¨´}M»Æ¾¤žŒcÚœ­”«TÃŸÂ0\0¶­‹Á‘\'R/4ÅÛ-N°òHä$™GJ®5¦ßèwæãNZÐ²`’™Cƒ²“Ô~Ç­_Úò¯-—¹+Œ„Dð{CB]\\4Å«ï][ºÂ[P	VàH2QQ]ì8ç¨‘V­†TŒƒÚi¢]_^i­ÐÑp-I}Ò˜Tô€0?ÎÕãÚKd®RTTI•dÏ½VukRÑõ¥;kjÒX-^’—á*$œ`ô«^•­Zj–¶¯´cÎâVw–RUýcŠ›©p¢äèIWm_äAé>Ð$´4v.¯@þMAPÒï<çÞ¦µS•›iOÜ\"ÒåÀ€%?ÌSþÓ81×ïJ¼ilþ¢âµS†Ì&‘€é™§Ú1K¼6»­(w[ÖJQRš(1ùfÁÁö«\nÃU¿>¯ŸoÚPl¯ÍÏ«ÛáýÇ—w7`?æ\\i`opÁ.ˆÎð2g0¡E²ûmÚÛÜ—’ô¥>ZJÈT¡Óµmb¶µMÞ™N‰KCÐ¤æŽÇ™IëÅÛí!HJ”S¤©(tmR»ÀþÔã‚9vn1¯ˆì}ä79BQn•A)º¬½@úVÍ&Ùçßaµ…8Êö©#&¸ÍzíåºU»Î$<ÓA{R	\nHÜãâi-«­êMºâˆví*[ŠN6+v>&=ÅsVNCq‰Õ©e<ãù–4¥Ð§Ì\0çÔŽ8ìJð%D‚€¤\0`¥PHýhýë-)§ö¨Å99ä‘ÏÖ¡»râéI_’**hN:™¡²ÿ\0ÇœªÔÄõ…ÝZ!Ë¥+l*Ÿx­Y´YµS\"zšÑÅ¨%«‚±ÿ\0ÜP>¬q4b’’Ø>¤»>¡Ò*=ÆOI‘¶‘€¡‰È\'íŠKudê/\\q×ú‰qÉˆÀÿ\01OÀ2v¦HçnDP÷ -h2c>âx¨BTâV«\n¶DXÛp f2ÇëL-Þ}¶ÂRá)\0@ –Ö¤8$…¤`‰íS¶£iIŒÕÎAÀ„±ƒakªAªPpAHÎg¥DÊFî7Ç\\Tˆá*l T‰3ÞjvÓ‰ŽùëGE,FãüÅ³·¤ŽæÜ¾ÉCO)‡PârR}ûŽâ‚nòí³åÝ4ÚÔ=*Û Í8O<L¡¯Ð%ÁÎÒµÑ¹r½¥Q†pÂxÍÀrO”¤« $s^²ñxú½+G)ê+Ût€€:´&¶°ÃIpÊIô…§”˜~±¯¦¤ÚÊ ã>Â\nû¥gö‘\\Þ¾ÃëmEµuÚ#¤æƒqôÜ*^ž„Òãv·.,¨ñ’IÓR6éP™Çé^ÞŠ îä	áõÇ¹ˆvöã	A‰éP³l¦+QÀÀþõ*fÎõ<nL}Äãâ™6t€ââ÷gh?nÔ2ÑwîsEÜ$	ôâ†\0HêOÚ²nW\'ÔdÈÌ¥Rs\'?Ò§LDÇOJÀ&`Àý+PB£\'1<PêÒÙiôŽ\'p½fÊQTmíYU;½JéoÐ!#ÖV¢é‚ŒdÊ}§Ø@/mËR’=i$™ï@\\Z\\”‚Û~Œã1õ«]Û)Ô4ÿ\0Å´%iõ(H¡lïÚ}¿.BVœŒ{Ðü—¥±@D§éÃ‚xãŠžÝòÚL…{@«Õ»é3‘€1Hn-CìY98<:ú¥Ï1Î«-Ò2834=ÃÈ¨)&ö PZD:ÎzqLí’ÃÉÜ(zqÉ4E«<‰FmE7ÁJDÇ™Èâ¬ËÔJ–R•BSg3ÅWmÒ¦ÝPÙÚ^(€øäœüRÚ„Æ$ÀâXSx°ê19öéÅIHHÞdb	3ïU´<LAõíF4°¤&NyzPaåºÕàð\nIùŠ$ˆViô›LPCb)è)¢ÖTSÈ ü¡„Yâ­JØ˜Ó”“Òª?ý2—\'j`ðDšèŒ.e& ñÚ i-³tP VqóOéÙXaåZ ç&s—ü.ï–¯,ž$O%õÕîƒ¢Óü9f¶Ö¬½{q´¸âº£ÂLÜ×KvÝ\nõm î,PêJT€Fx[´uØ6·HJôÄµ\'soôõZµî¬ówM¼¶ÛHS×JI8I=TzWíbý:Í×Þ¨üÓ$ü1ýllfÏðö‹ ’¢QÉ&&OÒ>*½¬éÝÛ~ÒTÖ$g4•º/5°ÿ\0ttùŽ×¯ZóXÍ‡©ë”­\\x¡:½éB7©\0ãwßüâ‰&\0Ì\00\"ˆkÃíZe¶€Pî:{šÕöJ¿,Ç&ª…©v§c_sZåØ’Os,ñ\"Ø,Zj2Íƒ-…ùfAƒ´(Éý§¥YnõVy‹[Vž¹»|!²<´¤wYä~õGÐleÅÞ]&-­È	B°sŸÉ§þhÞ*æùn§ÔR‡@3,¨B~MyÓP×–­yQê=²z™ý§±ð;,ò¼ð~èïÇSò]c‹+¶”¢Ã¯%O™q\"#p“!#°÷éGù’©1¸©F\0ZÔÖå«Kü0@Ôµ‹kdÿ\0øÑÕð¨üQÚ¥¶a²¥´Ãa¦÷HH?½y§­pŽ³ÑçÒd÷N v…~q\"Hê=«aªëI}¯IV¡œÇ1Ú¦S@0Ú{$(ûžM@†G˜¬“÷ãö àgl¸ØWÕ&zè¤Ûdw+§À¥w\08»$É$õ>ôyISiþu”ˆê?½¦ÁV~ÕŠì N‘L\\idÂ1)Ä°¨ÐÊ.-‚V$B»û^2Kµœ‚’	0gAÞ»pÚ¦Ø†œ ‚@GÄT1ÞÄô&’UL!«UZ¸•²¢\0™A\'j»âi7\\[š:Zpn>…–D‰JT	ŸÐM0·ÔžK	môVƒ\nqJÃÜw÷­u›Sq¸®Á=tj‰®ÐÍÚ VÐl’ø‚Å½NÐ­	Ý½!Ä™‘<ÕÃËVŽã­Ü4Uhâ·.”#pÏß¸§ž>[oY¸\n[I.4LB{¦_½í«Kõ¨0 zŠ\'åå*d­¾Zš‘7›‹påºÛu¾â‰œcÜÔFÕ	•„à“Þ”[i.[ºãÌ¼ëuED¶H0H$ö¦V÷ä©Ö.P\\òÚ”€ nžheW’­ÈSîˆ&™¤¢ÙH[@¤…3˜™Š®«SÔ-<Iqur\\½´C‹BYY)Nã´ D:³jÀ³i¢å»‰BÖ§’e-Œäõþœž•+Ö\0,¤ƒ\"9UŽ™w,Á&ÑœŒI»Ón·vÕ·VÛ­™PO©¢9Þžäãµe¦ëÕùåŸ.v$ŸPHïïÞ²ÚÕ½ü?D¨(¥\'<ÑiH@PÉGr&©}¡òÀc?„YŠŽõ˜ëaP²@*ôÕF:}?jÑ	Ç<ŽÜP^ %ŒìV×Kà¡C`ƒÿ\0ìMa¨!ÖÂoR[sŸ5\0¯u\'§Ò¨µoPAÇÎpWÙ¸Bö%I€3Òy5—ÛÜíIC‰)!yÚzæµUý¢B|ð°à%*@>zŠóÍ¬• à‘õT‡¤¨Sÿ\0!Ä•û·œ ¶×’ä¹\n?Jñ[«•-Q*\'$\n%¤£iÁàÀ2m\0(ò0÷ØÓßoÞ~_Gðƒ6*ð°WR´ÌIb±v­Ý2¤-2•œüüÔ®«pR;°H<OC5-²HCƒñP*ÿ\00âFò1ˆ²*BNÊUOzfÆ ÚÄ:•7?P~µ=ó ¨.?öœ~´(`s÷ëVu²¦*9…ÒÑ’9‡%ö‚L8“×‚»x­ò„’¤@Ptö4CIJG©#ê1óQêV«]ªü…<TÚ„`Çç÷«¡6€™ÄYØW–3Ö”¤	ÂÒ~â«ž%½Ü´¡«„©¥amà”(xž´½½}®”Ç	ÇÐÔ\"Ñdn_¥3À÷5é¼3Â›NÛÝ³ŽÂyoñ©¬×R‘žæB•îˆ<ûÑ¬¨$ƒß¥B‚Ëg\0s5\"®Qü0dNJß\0O>á‰tæ‘E[¸rxHêi[i\'b¿7¹ý¨›«’›EùÈˆ CnÈ›ÞÝ4I	ÉöæiMÅÒÒ™IƒÓ±ù­tDùËsÎ“œóS_5±Ý©æhoY#x71qÜê)’¡´pLisšÃ¤ì$„Ÿšo«4éd%-o’GÈ¤6V.¸ùÜ“ÄP÷>” òa¥ÝÉI)‰MeH Ûd ®äVRÙ³ÞSY<-jSo±Ü¤¤ƒÛâ©#±wJÖWåúU òk¦X¥,Û¤ÿ\07xéI<sb.­âD.jÙÕV‚;B¡Ús*–—KsaÜLd“Ú´Ô.¸™À{ýi^šñaò•wã¤ÎXÂC¨Ü‘ƒêŽÝé2§´3€@Ns1žâ°YeÑœ¿Ò }¯%Óˆ#¿zÙ’\n„p=@êjAö€\"Z-À¸“†	çœÐ®Ø<•ªH	™\'¾Ž÷”ïªxÉ$;RÔYjA Lï¾¼°\0‰UQˆ˜¾¶ÎÂV@?ó[\"ñCÓ$wœÏj…Z£\\ížý¸¡¾`ß§ÔÒ˜õ,6z²›€L¦qÖ1V­.ù-mº\":ñ\\Õ—\'ò÷1Å[|;pÓhÜ¥	Œžø®<s	[œâZ­ªÏÒ¥¹@^Å¤ú’G¥ÍQ…¯jT‰‰ýé›žk\\ÈtD`Ê§\nù¢PÈ#ÿ\09¡SÐQ­¸QâŸ©Êðg0ÌÔÚ‚d?­hlAäH=\"™´Râr3ß­Iå(S+tƒ9•»4*D`ð9¥¯é	b\0æ2GÅ\\dæDN(gYd`}h,1#\0õ«wj[VŒ\0†€	¢q*$þôjB«t[\0Ûm,©XØÒ	€GuI\'æ‹¹µ¹JLîôÕ~Ãç¯´Òû”ÙCÐ¥8w8?ü‡ý§ÿ\0hý«Ïx‚„_-Ä±úþ\'ªðÒ[ü¶u#ð\n=½¹þä:Uº¯5K½MäÆÔ-[ÿ\0ñ¶rUìTû÷¦¥¢;z`þ€Tº3A6}Ô¥©džóör›õ‰&±¯ÑºÝGb½H±C¯CÓå\0Ù¹´&&\0Àæ•]ÜíÆmØ!	3—\\#Ôø¦`w;juxEµ±TÊ;RSU›¸vá›qêJeÕÌÎ8ýM|<®2=N@Éþ?*u\n’}*2çèÆÚwñt+5FÓë‘Öw¨Oé^yeF’q¨ºü%«hZw!KZÉÿ\0`Jw(šŽãYhê¶vÍî7ŠÜ^\n´‘	î{žWÄ4Ãí%áxü„¾Š÷¶•°Ž[˜mƒíÝ%öÛWñ-ÌOæAáCë#í^>ÀQãjç÷ºÕÊ³YMæý©ê	& ŽÄ×EaN;lÓÊ	%Ä%R0Œ½!©£b­ƒñÙY¤îÏ+}”(\'“€?­0¶@~Á°¬©¤†”qü§í‘R.Þr¬“ÏÅû¦Á>rcpô„«…ÐÒèùyÞ`\0u‚ºÓ¶ï%æ€+lÈH=?Öš[y/´—-ð‚Ù™höÿ\0žµ»ÅmKéäR?(ŠÄ\0¢’PD§$Õ$åv™ÎK¢´2I<É$ý*¯¥^)Ïê.y­Ü­³hD¼géL®PëévÜ‚”ÆæÛÔÞ•°Ù²¾¶»m©¥•ÆäõPMNŠƒ$õ†¥\0V©î=Ûlûêµ4ã…°îÃ‚¤Ïnøâ¦Mªì†ÙòÖØ(R;ÏôâµÔtÖnwvk…‚iÄ`53wŽ(Æ3¹\\ïF?Ú®È´«Vßxþ\",X²‚§#¸øÏ•ùáÀ˜!$(fyš„Ü­­ï’BW¤Nb¦MÊ‹{’ØCÇ2;z[ƒ§\\n	\nB34$ÎÌç©ý>¾R¹÷‡Â!¶·%ò£9’zri“6éNc$×ªm•:![I$ÐWŒÝ¢é-ù´ÂÄíB¬Üž‘—±›§H¨ÚÆÒ$( ô£íHÚ¾8#¿ÅÇ={T’\0‰£­Lã&s\\ÄÆ\\[;R…àð“‘D¨¹p˜Tž±P.Ô¼ÉH0¡êIÞµmçRÊ\\€cœ{Ó*ï^Î‘Räu„ìiQäãÜÑm¤!!$Dµ-eå…ÂRI!$þSóF4ú”T@i\'Çµ¦F9X+‡i«‹5Õ\nLù -î”\0#\'ªq÷ÕÍÌ¥\n ùd‚cóê>(›bÝÂ7#ÒDH?Þ—²Æµÿ\0ÇùK¦v´-¥¡‘@œHÇÅtë­¬yjIe$ó4ó¬²êY…*`öèf¦JR¤¹õ5¿àþlÅÖŽ=½ÿ\0©…â¾\")ª«ö¢Õ	˜Oq@êä!³·½>JIQôŠ®ø™A¶Œ~l™÷¯Y´<“	•‹«¨*#¼þôVžîwrGžžô™gr‰*5ÓÖŸÖ,LTF/2#r1ÔûVÖ÷ÀP¡ÌÌ	P7—…±µ*³Œu íRÝL‰‚CG` ne‚Í(iâG8ˆÍGvJ®ÒzN\"‡C¤ª2•Lí^%à—€w2xè{àÁ®î‘ðJÈÜ<õ¢lØik33?5¢^B’6¬`u5\\ñF¬\n?Ñ “lÈ£eBäËÕYvÄ]®9`›ò7¨c¤÷5•¢ôÐ½¥`¸¨üÓÍef—°œˆÓP Ëµ»Ýqõ¯u—¬J	…$HçŠ­ÿ\0õNÐJ…Ù)Qì&gˆ¥ú÷Š¬ÍšÙ°|­÷H w$Ö½»Jæg­OœbWm&éì˜ó	žÿ\04êÊëÊNÕ¤Ä`EU­žS™\0=sM­îƒðˆ¢ rM	Äm„cx¶Ÿ“É“tød#9G=âˆfÑ\n–¡ƒ9øš\ní>K°…oÄñ\\,½„fËÁ!&$pcšƒV>cAs$z¦OÚC«É<8©ÔðZadA$ÈíT¶±bâo0$,*\'\'F	©RÛ®e$ÏïLll­@RÜPO´æ\'#üÍks~Ý¼†S€f²þÌÀó/²†è\0ÈãÚˆe×Ð0#\'iZµeù™€‘“>*Á£jl<‡G<ÇÖ¡©eSvîœies\në]Ã÷EzO˜£¹A­Põ(<¤ qÛâ*ÙáUéÅ±A¹Dš>ñÎŸââÙq@(+m=eô8‚„ä!eÖuÒŠfˆÉ©ôÜÛ<›{¢vŒn¦•·b8<Ùt“ÇÒnèîš£ÙkhzV	\"AéóM™¹S€yàsö4AaS/¶YÍëJ;WÒ…»y‚ ½©:“Ú•ºRTdŽôµË¥ïZT	LºÛ‰9’Š™ºBtÜ)ËÕä$–m’rV¯æ1Üð>µ#ÖŠe½×ùŠÌ(ÎÁþÐkm7PJ[BB\0C`ü¿£¨‡—qI×FbržñÛµfÅ5 À?°è>»Ãt§Ð‹u%giI#èr\"KéU·šTT\näðªú`§ßŠñej@I$\0ÌœPmÐ­Œ[v3§Äš”	·8ó{ë’ûªuRO¥\0ô÷4*.:¯Ìê·Ù9ýh‡PTÏ–fA\nQ#úÖªx3Ö=ª´Rãn8^÷øÉÕ^SN)ÎYýMüÛò›»kç-–„¦ÿ\0ý?iªæžM×ú†ÒÓ%¦ƒ®\0Ûµ\"¬×oÃ/;‹A)Œ’Iþ€ÖÚšmPÂÈ}ÓákøˆJ~“X¦¿;Qa‹ø™é4÷6ž´=H\0~\\Ê3ö¡ßÝ´”Kv‹S„O*\'Ò\'ëWý\"é-¡6‹ÉLìP÷Éë$R6Ûñº¥ú=fêñÇ{¶ƒ±úLôÕú“)þmÇ™Î;§Ò£×c°íøsûþÑO×·ŸU(zc?ÜmsslÃAw/!¤‘ ¨æ0:ÕgñKÕZ¸¸Ø[f\nXnd„ƒc©#¥â$0)=zœšÚÂÜ[Ø†NBPŽØó^nÊ”:MŠÂÖÉ„éãÌÒ­]NAFÙÌÈ$S„A? ¥Þ}K³¼´uEIEÊü£Áé¹?|Št	”õãÜ{¥S¦\0îSÁý«±V*bÍEE¶i¹KŽ•%*¤„“?¥\0õÓK6©}!*;¼ÅD%&0~¼T×®•x†Êp–œeX\'õ½Õ¨XÈ\0€@öª¨Ø ‡÷Œ&\0ë!Òu¦­“p_óžâJI(3È¡\'Š‰¯1p†™C\nMÚ¸“ùR“Â§¬ŽûT—6¨N˜´-2Úáÿ\0âLOÓWÓÛvßPy¥åÆgqî7?¨¦”+Ã%…U±,:Î‡gå(©@/ªNÏJ‘÷ƒlÜÛÄ¨€‘ÌF9¥š}Êº»aÈÞÓËH\'„ÈûqLÔÚQ¸þlš¿Ùž¾`ÿ\0¹žŽ–zÈþŒ]rÉ]£€R„ù÷ ‚…„¤í-ÀIí´sJxêJˆHé9îhGØ)yP:Û¥-bl£ifx0›ƒÈ	P	Yät>âŒ)ˆIÇcJ[AJW·\n A‰úÔö·!à\\)PW¤œc¥1EÅÓæÔÖ1I©3ù€ÇúV¬µ‚¡È;íX„w8AŽ @ë×!™/)(APJVN=Æ)…Å˜Ï^Ýà¶Áƒa\n)ä(„$ŒõŠÀ”dû´zå»hKªÚ²’¤ƒüÑØÕ©¤ç\0K;€2LWºfÒá	z@ZdÀÏZþ¥io¹ÖV…rŽ${P> ¾¯¶´%IBæO#ô¤àŒ“ÀûûÖ½~^>Aï<Æ¯ÆìKYkÁ^ß”\"ýõ]Ü•‚JÎÙ&¬MÒÚV@Èœš¬¡C9•vÿ\0ŠÄ:A”sØö­zîòp\0â`µ¬ì]ù&\\nnŒ„§ƒÅVüNÓ‹µ+H“ëRYêE%ìŽ\'¥2Ê¼`¤AsZ	rÚ8FDåh¸%f\'ãµ1´qHNãÉ•Ú™_øyi¹[p£1À4³QiËvÔ• òc@„sPÈº.8S‘?ÏK.„ñº`zIfÞ÷B ™äô>äSö¶2¹hB»~j$Î©¤\"dfg†½µ/1¹Áâbµ:Š@Q2p£ÀúTVzº]¹-®3íD]¡³¨@ÌLåõÍº¶£¡ÁúÐâã»ÖJ·`Õ«XÓRêKá|‚0NzÕ]ÖKjõ	Á#¦j·#c‰ˆé·¨lm)Þ°#œVR\'²¡×?•‹yÞ¯yÎžl°AãŸ¤Tm\\-¯Ê¬u¯ú—…VÛÎ2ìm“µDçš¥k:SúcêCÍ”„ò&@Á¦«µlSKøa«acÅ;²¿m”„¬ñ·©ë5HeÍª£ÚsjÂ’aX‘LÖÅyÌ\'CE¥Ë¡Àç0GaÓ¶sOPH•“=\'èi&›âe±n† ¶2¹Z™^$B¸Kyë“Ò‡e×gÓdlñÒ-Ê@x¬òÔ”Ê°z“Û¥FÖ°—Q$ +¥y~O¥<“Œæ†¦öûÆp¬ŽL™ëÀÊpfdâ:Òç_*99\'>‘Q#{ËÀÉ9ëMÑV£¹c‚F*ìÂ±ÌŒE¶Ö®Ü¢p)Û6¦Ý¤«ò˜\'Šqm¦¥”ÀJæbjUIi‚	D·4·š\\Ê·=\"«« %J‚\0æ*Áþ™êßŠqÖ•ÐÁÕÍ5K¥©â¯O\'úÓÏôòüØêjŽAù<QFÜKÖ»93§ø‡MCî#±TI¯\"âAÏB9ö5tÖõ%%²R`û~ÕFÕÜ’£ÎLö=f„‡RÂ	âIk¨ºÚÒ¦ÔHÄŽzÕ·HñajùŽç¤ÕÑAI€=\\}y£[Nw§ÇÅ¶ã(	^“³Xø‘‡šÚƒ9\"·¹}•¶T\n	\"f¸Ûn8‚<¥­$`qïMí5¢’á\"88Ÿyšë:s..Äé–•³‚q¼Ø‚¿PëÉÅUìïÝa€·¦0 ÇsAÜø‰ßÎÂw#‘œûÐw…æX¤f_T¤„€“5ëdyÄt=+5ãC¸%ÖÖ“Þ3Dõ»`ÉJöŽHÈì*ÛŒ‰ÛÁ#ÊJÚTrFO÷¥öVûnžA˜…Ÿ[b½óéÜdõ¢4_XÜ\\ËJUŒjcƒ8²çõ?KèS©Ûå$í‚xñö©Þ»ti½o—S%² ÁlTZö¯cqnÚYâ™¤Ru´„¶vÁÜ¯ØQÒ³‚ÝæþÍ¼Ä{FBé¶z-ˆ³B¥Imàÿ\03K4K¥\\x’ÝDÀQ^ó´ò)ï­×\\[¦\\R‰QâM0ðÂ§Ä69¼ƒñ´Vò…UlßÄÏûsju¢ÃÐ°ýå’áH¼ôüD)M”ƒ“ØŠòÍäºÃ®È!WIi\'¸		þô“U%‡\\QJÜ¸[Ä¦Aè9úS8+þ›¥¶Øõ=¨\"GþÔ¨“ú&±>ÀyêüOaöâúÑ¥^ˆ3ŸËÖ@Öë;Gö(¡Ç.@ÁvH?\\ºwH~Í¸ˆIS{I¸ÚGïˆ®Ê™JAÚt*x(|V–×hIif6Íî8=iÍ&ˆY¢*>ñçñ™ºÝy«Å“Âàcàzþñ¶¦‘¨³o{o\0\\´Û“Ä~”]ÛÞPp¸‚¥¥!@ É‚>õZjîæÒÝ´ €RÞÀ“ê\0IÚG~d½Y”¦î¬í–¥%%öŠR	‚¥@VÑïƒYèWÌnÐMê5ÕÝa¥áûAÊÍÂv-;R¶\'9™4+ZasPqxÜí¸BŒ2ƒúÑhÁIù\'š:ÉiA)[v.TIˆ­/§«{aºF¼Â¹ÄçÚª¬]©gÒ§–¢àI\"º$-e;‚Š@1Ò{ç—ŸÕn6 íó sV=ÒëZ}ÂTBí,¬ÿ\0¹µˆ\0ývý«Y¤Z°ê\0„òÞ«aušw=I#çže	”x¨.á È€izåÃÊeÄ†Þ@%;r1ñL™õ7\'\n\"±5u20¥ÆY¿MËbïCžÐV<È ä”™{H¥wLomM¨ÉRpxÏB>¢Ÿ­¤,&LjVêN÷ôùnžHž”\nÐÐw/c‘øB>,R­ÐñÙë·l£aPtÂÄŸ¸¯5-qû»UÛ­¶ÒÚâvÉ83Å(»„Ü¼$”y†$æ£DHäõíWOAq`PùýšÝJ«R\\‘Èìu»»0•ù¬„9\'hö35æ©­;~„%m!½ª$Ï ®}ÉâbŒƒÛÚ‰äÕ¿ÌÛÌ§Û¯òÍE½>Ð“p¯æ\0Œj‰Å¡dtQqÓ­hU)ãØDÔjN$Ééz‹±9„6	DHíž…j S“ php¥nIÄ&¤ó\nŒL¤ˆÅb‘‰#bn‡=PsŽat¦\\ìŒÄÅ-qDHöÿ\01õ©[qBF\'psCÁCé2ÊH2ÃrúªŸHâ¸¿|\\\\½[L¤údr1]_ºq¿Þ)T@É&:W²ðÎ¯¬<^CfAP\'ô­ZìÊÞ9PP77Ië^*º@€I1L4WQÕu4É>ZH*?°§Wú[râÒ«ÇNÓÈN*û§xV×E¶JP”ŸPÇ& “í$½yÂˆšù’Ýª³ë<ž°ªé¿6·ˆVá)P™í9ÅXüCtj	\"¹ýÊ–ãêW ™Kì¶éï&êÉ…\'9õûÒbÀ¥£\'?1Iü«CBÙÕAéïïýêÜâwLžzÏ½40™Î66%Ö$‰‘ŽŠŠÊ°ÜÙ4]“9ëßÞ²©öy]ÒÑwbÕæâ¤¡.dOCóT/è¥æ68ÙVÐvž£Ú{Uý‡˜\\„˜3ˆ>õÛµp‚‡ÆáÑ\\Ö\nêÿ\0(`žºúûOšï´—­Qm;Ð#‘B$”˜2#¤q]¯Ä~-’ã)\nIêŸëTCAmÙôìt{`Ÿš~­Pn/†ë*öÍ—°0Š•»U‡r#ngûÑlZ½féJÄ u~h‚¢ó›RËQŒu4Øç˜R}§ˆQJ6 í=½ýè‹[W.‘ºz“Ü\ns¦øuÕ¡+xm Fb­Zv–Å‹!nDu\'ì*°8‹½£¤EÐÐÚwº‘¸ðOSÜÓ¥¥¶Q&G×›QñM,6ÀÜx$t>æ‡UúîX\'q“$¿4…™êÐExÑíE ½‰ïÇNÔ¯W³zé½í’IžL@¨PØ*ˆ#\0óG±r¤#l‰ŒýhbÝ½°iS¼ððCd¸¢…ˆ>â†°°vÝð¶Î${r*Å¬%×Ú$’Ö9ªÑº]ªÌ«\0ÉÎiÔ´8—ÜOIujù«–wGjã$øŸµ\'Õ¬VB”Ú‚ÑÐø¥lê¬Ý,!XYã¡šrÕ±u°–ÝÜT0‰ÆT©2™÷V–’•z`õMXWñL´½1¶¤,B†	ˆ Óx[*SŽ’“ž+–Ñ ‚Ý%q¶–¿Ê&x>ÕcÑô¿,ï=\0e-ž}§Ú´zæËG%*Ž\nò~‚ëZÛ÷m)+ÊlòR}DGz¯gÀN€rÓok‰}Õ[Z¯r	žiŸ«-—’‡IRéEÃ¢vË¤Ôe^óÞ¤¨Æ!‚g¬¼ºÓ­‡P\'&pq‚iEôÙ¡^bJvŒ{Ð:uËÌ,RÁýªÂóLêÖJmÁˆr“UFòø‚áO2—¦êîD¶Vv•Iˆ«hJw…	‘Ò©êðíþ›¨y‹in0I… p=êÞÞZmDIÚ&qþsWl1È“©ÁXÿ\0Â–ª¹ÖZR‰)H$‚dsWjÀ0ÛkH˜ôªïúxÈrùÅž}æ¯Þ#@:{$íëÇqÖU\05ãÞs‡Ü½©LædûÓ	‚¿X&@ÚáQú$šYmlãî€‚YÍ0ÓžsN¿CèH.7#iÇB?­Q«Ý:ÁiÇ—bZãÓ‘úF²¯7V|	JÊF=óV] 6Ö™`êÏ¥†\\v=É3U/û®¬ÊˆïB\\ë·Œ!6ª-!¢ÒUÛ†f…¨Óf¥­{bkèõÂ­Eš—{8üø›êªuó½å•‘;}$>õ]¿ÕdÔÉôô=DæiøyJx\"#Ú“kšWã-” æ=ŒsV¯ƒÄÊÝ¹÷9ëÐõ$\\°\nOYç§Å]tÔ\"ïF²ZÄªÊè-={Ù_¥q!û.ì²êHH9øù®­àëÅ½jûhT¡pœÎ Í/¯ÓùÕ•oÃm]. >}&Y·áÖOñ\nŠåED“ì#µlûhü2üÔÊL\'ÔzÉ5ª®‚íÖ•‚T“‚Gæ\" ¹x-¡³éq#©éXôèuCxÊ‰·ªñ\nþÌÌÉ¿KÄ¢áJÜI2g÷­ì™,%Ä\'ÄöP;ý*=á\nÝÐsè|‚’’If½V¶‚¸ž_O{WrÛÜÏu{£lú]e[\\Jƒˆ=;æ¬zUÛW¶é}Èç¥Iœ¡]R¥RuüÕ	™Ncë\"„¶½¹³qJ³p¡JÂ‡EÄu¤µz/´Vª~òýb;WŠ6¡ÈF3 7xÚ®n­–½®±\nÚLJH¯Ü¬ßjÅû×m¹I$LàŠ«j·Ï\\^—_ñœ¢Œb\"ÒèöÁ-%kHý;\n^ªFþNû¨ñ«-*ãž¿Óg­PY*W*=~ii·Á(22`y>cjAíU$êBÛQ[+\"Ó5°ª1ÌÆoŒšJ:}Åz	’}âš¡¾Â#‰ê*%Ù!R’GR~ßÒ¤ÔGI\\¢“‘×Šô¨Œ’qŽq*{›d´%¦20JÒ“…nŽ¿Ú€Õ1²z²	TœždŠñ\nç0>ÄZïo£¨\n<ÜÖ¡)ê\0é\'¬1\'aÌÝ×½`F1ŸµlÊ‚¥\n¿cA=ymmêYÞ¾Ã­Ek­yŽ”!;xÛƒïVKs$´³³bÓÖÁ—€X™#¤ÓÍ;M¶a°lŒ‘*¿ná	’gwzs§Þ„@&sïïOÖ `J“‘”\'\0ªö´á(\\‰í­>uä­œ~b	#þj•âkÂ–Ö„dœLõÅ^ÁŽ’j8iIÖ”§žÚßå19ëJWd¶½JNÞ†zöoÑ¬<×7¼˜˜ÄÈçþ*_Ù!6åh@˜ƒÐÿ\0˜ $f1çlNxýòì]BÚ>¤™Žãµt¯ë¬jÖM§x. ÏzãÚë„\\(}\"´ðÞ¨ö¨6¤(ùjP¸«×éàÂÙ@±>3º\\…ÐN;ÍeIfùºµiÕ)9Ö²žHÌÈ\'F‚FAÛ&g§4c+I1ˆæ@÷¥ˆºDF3ö£Rû[$ˆ÷æ3Ö¼¥j{º¹C‘ùèÛµDœA4³TÑ™¹AqƒŠS­j	 ¶Ê¥g¤æ=ê7T¹¶PBÔV‰àä¤wZ|Î½f’Z·òp}âûÝ1m(ÊP$Œuæj-«!x¶‚aCšº%lj“ã1È?5YÖ´°•nO¡@`ŽžÇÚˆ¡«àÊ°dá¼°†ŠB)ATïëÅÇTÅªŠRœ(¤â=«Ë]ME\nµ¸\\,~S?›Þ«7Ì®ÚáhsJŠŒç<Í2ÍæÎª½­êš%ÒOYížô[‹AN\'ü±*¢=ãëS6¸V$tÿ\0Å*ø0äK¶ JÆôäÄçô§º‡v«\'þâ©‰Yž€ýÁM­ÒÒctDIÍ\0Ö§¤ QÚ]Ê^·(à”ÀëïDÖìJVÜA çé7ë	\"D(žsIïÝ[îþi#ˆžÿ\0óE¯Ž!\0Ç&!,ù…ÉL|Å6Ò55µ~ÖåúpÍF»qÉÏP?½¥øyå^4¨!)31ÏÍ0\\(ç‰$ƒÖu[rólÝ2˜R’Þ¬\"Ø®Üèzf†ðÛ6µ2¤ŒÓK÷	‚@Ó½P¨;Êô<Nsã{&á¡üDæzjçî>K Éã\'Ú\"»f À¸´q*Íqy•ZêO´p}ªÚ{+,0LR²TN9É=»DœŽ{çô­m[.*ÁÇô§v¶°ˆW\'§Ò»“%›H­ÓÀ\0ã¥4·R›;’`ƒƒQ% ž9&Aàý¨†“# <z\nŽbì3-:.¢ÃŸÃ¸J	Ìî\0üÑ—žµ»%vjòÔrx\'½V,í^u+SM-ii;”R$§<ÓK7ïl®šCˆZ®° —*}&]˜\0WymðEà´: ¥îþ_éWK‹_Å°¤)‰ïTd©HXq\n)\n‰?í3Ö¬ú=û¬\'øž´‘ 8ö5Ôê×v,âoÙàoåo§’;DkÓœñRÖR\"dÏsAêVê“Å	ôžãœšÓÅ7®ÝÜ—AZk=;ûûQ»Úsk^V9ˆÅ_RÇÚ#õ‚Ó¢W=ëé?¡•«—P.~P¤Êa]1L¼5§7¯Ù>·„äŽäÖjö%ë\\¶yL‘ÐÕƒ@·^á„)¤ÃþIZ£’`šSí»ªfN>Xš4xb²2ª3óÌçv7ÈgR¸µmD¡·\nDžžÕgµHRcxëúW3JoFªëÉ·p«ÍQP	ã\']Ãk]ë`‡[ÓÔÖ†å“<ÓéœØv©äœOÒ˜vëÌ[aA	0œôÇµ(Ðul¼Hí¨GðÝp”ÂGZ¶ä7ÆI3ûÕ5õþ\\EÄaK!GëÅ70ì1`´éë«gH»jH\"H÷¡CiQ$\'ÜÔ)ºó[JÉ”‘ ûÕs^ÕFàØ)ãÚš“=c§n‚×2FOÍFõÈm&O§ž“U=/Wqõ™ALO¿üÑ¯-N;ºHöþÔFÅ|w’çÊ=c¸ÊQàp8ýj­âo3§	´\0²0G÷§>a)Á8Á#9ª4•¾¢ëiÏ2>hiŒäÀÕ´¶àÝRã]ñ×é	×dBÛ¶l± @*¯œt7ot›¿ÄZ¤îj“ÄŠ²jZö·«£Ë*-nÁ<˜Š!U\'q1«*Éôô+Ä>$fÝ¥Un\\IŽ+˜_êW^þ ’•ƒ s÷©´2á>»—µw$ýh›í4Œ1A´“Ó¤]†ÓÏ2Íá/áÈ0dñÓš½Û:ÃšáL8å…ÈZ$ÁÍtß\nëbáB•*1µ‹âÐdcå-Z‡Ï~>Õ^Õ4Õ2J’ŸO$ƒÿ\05ki[àŒö=ýë{–PóE*ˆ›²Ã‰]Üó9ÿ\0ý=‰Ü˜\0A÷=s@\\i/ ¬ÊÀâ$ýéž¤‡t›ð´Ï³ôŸzogrÝëbT®¤ÿ\0ZÎ(AÄ’\'<ºee*àpIÅ@òÜJ†‰ïW­kCó™RÐœóúW?½ivÏ­·s“ö º•æpæ[tËò´•Lt9éN­nå`3€1õ®¦\\–×\n3cúU†ÖåAi?Ì÷‘óL#äH ƒ‘.Åõ–Lc ?lÕ`Ú>íÙUÆQ¸”’pGÅ4´º$§Þ‹ZCÉ =bœñ8>$v©B\0|PºóÛ%Ç<Èä!H-´©ÇPz¨ë~ U»n ŸåÛœÈ«ü%ªBÍÄæ^&Ê™ÌPZZÇãX\nÇ<s[j÷îík™&†°ŸÆ3×Ö1õ¡ž&°é>‹Ñ\\J´›B”‚<±Éÿ\0ŠÊÃî(èöÐAôõ”ÐÏ¼À³ï˜\nîííÔ|ÇQ3‘#Þ½ÖÂÛ\"ÛÖ¢ l3žä×/óÞ}Ò§Tdœ’s=éö‘rmFõ¡Ð$ÁŽÑY¢þQ“¢UÎe¢ÆÖå÷T°ÒÖ¢r¢’VM?Ã÷wjŸ, ~ ÑÞñšú^B7w =Uáz…²B”Ò›J@™þÆµ(Ó¹&(û‰õJCÚ#ö©X#‚O>ÑCÞ>?µæäŒ¢µMi×5M²JSÓ5åÂQrÃëóCrŽÅG8ë:½K\'¤ò§Þs=eÏ)ÛË2SÁúT¬¨k‰asç³”?7H«•ÞŠËì”ˆÝÐõ9ªËvkÒï¿ˆAV˜\"zÐ^¦ÑÌÐlL§Q]iN[¤(£ÔGÔ¸•ÆÑÇùñW\'Ò›ÕÚ–ÊÎNAìHªž¨¥ZÞ©›²…,¡iâ–UbpzÎ¬–àõž ãÛ¨ê*d\"2® géQ5µCv?58XL@‘‚\'q\\¾Ãiö¾nVG‚jBÕ¦–Kk’23 P\n¼tHI À‘Ò‡[Î8}]p>(©P^gm÷›ÛÝ\\€	Ú˜À«N¨™7cyéïTõ nëÁœÓ7 zdñŸš‹+ÖQ†gUÒõF­‚=|Æg“Æ(ýkRBíÒé<# ®PÝòÂ‚”¢@ƒ3‰î(«½i×mö)r\0J©=%V³œN—¦¾.m&w\0\"qÇjåê’T9* ‘ŸóŠ°økZ-µå­} ˜Žõ^ÿ\0P_¼ˆô¨D™?jYW„_½ˆ›Nlc©9µ3J‚SœR>óËVÕpyž>iØq.$uI‚\"˜œBP©ù©’@ãÖ(0 ‘ƒž`þµ\"_ÈÜGÄfy5b%—]ªÏPÔZ\\BL@<UÇ–aÑl¦’6…ƒ#ÒJ iš‘²W;Ûêô«Í“êÚŽ[«{‰ô¨À¬}X50	é|&ªu5	çØýt‰´­T8µÇ¥À`€9«•¢ÂJA;`@W\"¨öá¶µºò&áœ(æçúÕ‘ß[-m\"7zH¥ìõú’mèºoñ_Èì¹¶µj.­˜$`ûö¨4K%Û\\+¢Hy$¥Gi²RÚÐNæü¦x=«wq6ÖÅ(*SK¯ö§­kžO¬Bj¼>­C;þŸ­.ñ,ºJ˜q$‚zŽ´ëÃ÷(u§‰†Ìâ)OŠmß¹¸³u‡[!(2•cpÄ‘úT^J“ø¶Ÿ”¥ÒSdˆ4›·ÿ\0ØO&Šð\0àbI­é¿ª¡6è@·}>h)àˆ…ó½cao§ê)U»%	-zCš—LµrÏLfÙåo,JR³É‰ý«[U•¸åÅÒán«kH&!3[ðáFÎB®ÞûŒU©¬0ëÊIôn$$UFñv÷®„$„«™3VÏ6¥7ilÐ‚êÊNÞ@äþÕU]‹mß%¦­ (žÃ «iµìoú¿Ãt÷á[´ejðfßbq\"”j**oiÎfS6Ú „`—6ˆøÍ|×–òîæz÷­Ú/£ñý\'š×é\n¿\0@üà¶IBYR$­HÛ³2x™Þ¡e@\\)¾„ö[8oHÀŠd°l4É½\n±SÚÎÕ9™\"@=	ö­µKT8±‘ÁæZ‚Ý`8™=3ŒŠ\"ñÀTÊdO_lTä%væÝ–‚‰mºƒÅ/üRT4‘‚<u§:ÃÄ‘‘Õ=MSîÛrLí9â§1šÛ\"X™¼ßHŒ‘S‡‚¤•r?¥#³t¨Èÿ\03S;vÂ ô«Œ%”#éÉ}@˜3ÔÔ¶viÏ%ÆAÚ˜ˆíÚ·Ñ/Ûqa3×iy«Ýµ“7Â\nNA«%!¢Ì\nÉ4MM\'Õ\nÄŽÆž6îü}AÒ¨:^“v\np€fó\n³hz‚.ZIÝž±Ó4ÝoÎÃ*Gy‹íK–\nZGªÿ\05@Óue0æ	*ÚRqÔâºýÃ\"âØ¡Q‘‰â{W)ñ&‚»+µ¼Ø;I“÷¡ê*Ç0Ô”aµ¥¿HÖ»f IÁ‘I|_¡¤†7LUO}m8’‚Rzöàýªßiª#ðÁ/(dfc&;P>ðÁ‘e[}K9š\ní®!i‚œ{irvG#¤v?ˆ´¤:óÒA Ž~µQKÎÚ:R¢AI‚:­)†p\0‰{¶º¨xIþŸz{ax\n±‰à~ÕC³ÔêFåÁïÉá‡”žœ™Ï\\U·‘k\"].@yƒ³8€s\\Æ¬:‡ÜJ¥*ÜIÒtÍGpØ¾¢Yÿ\0P,V°›†„î{É¦ÕÇX]1ÃàÎJóe5¶œ¡øæwp	Mêw\"=ªv€¸n:š¹U„ìÚ.¦„i¬¦dñYUW-Û‚b1YGVàLÆÓ©2©jP9éÃm-H\0¶±€b\"¿Þº+~i³èh’ çJ44IJ&OÞ²¬Ð/­Â©”Kß·RVÐXPÿ\0ÉŸµ\\týMõYŸ4œÔQÒ[BŠDvù¨/-’Ãa€Îhôë‚ Dî°YÔHíœB‚Š²µ$æ§üPj%_CÚ…BØ€31@]!Å¨­²\'$É¬Ð¦¦Ü2CGÿ\0Œ.\'p\"@?4£Pp\\‘$ÊAŠÕ‹‚–Ìæ`sïRY¼Ên\nÝÀä“óÅ5Vºâøâ²k9;m)Ô¸„O‰ì&†Õ|<íêÃ@À#ÞjÎ|A£6½Š¼@PÂ‡0{Ôø‹IZö¦åÒz`ùŽw7Xp÷»¤£+F¸¶ ‰“Z~Ô¨yˆ!]qš¿\"òÊà…!æÔ=¾µ£Œ´ä¥	8ÊsÒ»Ö!–æèÂS›^HÉ\nˆÇ½@‹R´ÊDÌvž•`ÕÛjÞÝJü„ˆ\0‰àÒ-X¶òJpéÖ®±À-OboX3ìƒ©ê(vBÒ® gæ6«GÝÚIA2B{ŸŸ­Ö˜‡@!@ÌÉ?j•b`IÖ&‰õmæN3Ö—j*q#Ñ1ÄO¯íWl¢\03Ž@¥/)*<Tn>Ð•á%ÒXD/§#šƒÄoïlHåBk})PžOÛŠZt;´2géë€ï\'n[0¨ê÷£˜»[C™\0ñÍ&RˆT~•\"] fk¹Ì¹Ydbù.G\\>ô`X)>qúÒ]ÅÝUõ´Â€RS¸öãŠeg¦_•9¹+CHVÒ®„Ô*hm¡€àÆºcbêñ,úHÇjèž\'M}§Pü2Ž×@GOz¨iMØ³ç¨$(OÌUÞßVÒÜCLØpn\'‚“À‘Iêk[œðÙðïÿ\01Æ=Y„kºRXYyhÞÊðÆÃÓ5T¹ÓÑåÆå©¥H)=ë£éÚ¥ž¥¤2Óþ•¬z£’#N-ÝßéÎ¤)a¢ë\nî;Ã©ÈôÊz­ÂÔË¯x‚·gÊZ¿l¡´ƒ‚ŸŠ²iÁmÛ\\2ò‰\n\'Ë_B U#þ ‹7çy…·8Pˆ¤ÓûMU›Í5òÃ›–ÀÜAªk”½;Èöýâô6-gˆ›Ä×¯Ú¹¦µ\nßæí‘\'µ\\ô¤íˆ\0¡ßÞ’ÙÚTXÝ]$,!@€cžÿ\0¥XRØc[[)1½¢R;¬}V mZû®spr?ä3ùI.®MÂö¬nO<œRýM]æ¼ã¯¸|”\0¦ý§?Ò‡Ö˜IfVÙqå$«Ìle;LçèhßÜ84Ï8ˆRÆÔƒÚ(®æªwã§±Ì[nõ$uSø‰®»pÕ³*uI.©*Ú€’N-¶ÒFŸf§ßw¯¢9)qLÐëHbé×G˜YV&dE)Œ%Û½Mä)O	Bÿ\0Û¡F”6”3qÜÌ×wmA­{JíýÏàž@p8Þ¥t‡ÞJ‚w,¤€yƒ1F^Ø±¨-JÝQÚ\0;ûS]>Å«7)Iui%X„÷ÍGÛ¼šÀ^O1Û|<›sgÏò•è÷`*é¶V´’¢‘1þEl[1¸fc\'&zšºØßÙ&ñl¾àU£Hõ0Là|c5ZÔžiÍIÂÓ>Kj\0¥1Œ€b·<?P×.×ö÷ž_Æ´)Sy•ò;üâ!¸(t$À#÷­îÖ!#¬Žf§¾hT3‰þ‘K5P¾RLH\"0xâžÏç€“ _ŠâÅ—”T@“5ãWU8Ç`>µ)VìƒêÀ¦©™ :j„Á=yÏlE\nþp&3Ž~ÔØ(…DŸHçéÒ¥ÜIƒ3\0Ï½d†\"\"³ÓKK\n\n^à DDdêÌ\"Õ)+\0Ä‰ˆâ©¥³\"ITŽ:ÏJÙµ:ßäpÌtûÑë´¡œÖ\\fñEª.X*NJsÞ«úÒìî6“‰2{üÔ.jíÚU1ûqÞ…üjA\0’Ì‰&=êÎáŽéP8Äë=Ày¤žãâ¶Ö´Ä][¬‰	â©>×šaIKŠÚ­^m5»GÐˆ2#\'ý6%‰µ0D9Œë)V“zâ„ò“íÚ•MÛ‡BRLŸŠèêN›m}j]eÀŸÊO~Æ¹Ö•d´;µÄúƒ4•ƒcb8®s-úCÄ3µÓ½&œæ:R¿è§Ï¶3ÉÛµ6m)òexŸÚžZZ©û@•úÓÆ>¢©åî‚Ýƒ™È\0q…žR¡Èâ™ZjN·Ï~sÍY|IáÕ6­¤í‘’;U8¡M/jñ˜‘‘J½l†r2%‚×XZÖ~‚œ±«æK/¤m)H˜éTöò1‰ýâ´Ym`‰‰ƒ™Ï\\P_rú‡YF^ã¬ÄZ1CªZÉ0Gz©Â™¸	RHPèq]u;n-á@*9\"ªúÖ†•¬-¤îÎ#”ýh´k<ÏKðc5j·pÐ¥2Œ‘µeF¤\\[ílà6e7ŒÉ*	NÏU[éM\'q8šbâ‘ån*0WôÓàÏÇZip±·hù‚yÏZÎÓÚYI3ïpHÌ!\n		Á<¥:ónùI]±Ü¡ÈWêh æÔ’9<F*kD!nPž¢Gµ9CpCw‚6œ‚{J®ä3ê»q{¹‚`ñÚ£N«j²”H=LÌÏ4³_»ß©>„“‚Dž¿¨´¶JÖT–`N:UoTàÌÑZ]Í,Wkµò’¤úTH€x¥Ú›Ì£K}iÂŒAàœã5ò¼Å˜ÊAÄÿ\0œÒ­E›»¦ƒL¶âòI€yŠªíCÐ	zª2”ûî.íÒ•®7@ÏùÆÁ·œ!KZötÉ«àK×ˆ]Ä4	ÎìŸµZðÆ`ÚWp½ë$˜©mJœÆ¬ÕV¼™XaÃj²W\0í½nu‹¤€”®G1í3Së‰¶CÁ6È@#’)RPNF;ÏíúÔÖwz¥yƒqšu[»±Å­Cƒ©šÓÊ\\’9îc·†ü¯?bÇ¨àÐÓ[·aezGXÉ,n~“›PÕ6Á+ªd´æÕ`¤ä‘þw§úÈq{]ôÄAàŒâ„U¨$¸£ê9÷ú}¨gÜÎÌ¨œdR-hrv@=‚ÞkâKûfZ,¤nR¤ÉíTGî‰R~¦ï¶nZRÉ*ÆzgU«„”:¤ž‡ü4Íg\"•\n0$¥õ“ƒûÖ»”á2dûÖéHØAZŒ.;Á=jÄÃAü’·D$™8êÉ¡øNïSRNÒ‰*ÀÇÃvJs}Ù–@=»GÒ­êñdN1ž©;íeô¨æËà	&á‹Y¹s¿s¤	1‰œúÖìÝ*í…4–J@™XIçé@/ÄGSu,G òOqIñ­Ï‡µ\'Bw¶•Ê°Ž”§”öœ³[Lé«²ÞÌeŠà»¦^3rëaËW´¤	Ÿ½Xlšd¶—,›*BÆàŒÀª-ÅZˆ<§M«hH´c¦)wˆ|amgª‹]*Å%±\n^Ø3ÔÑ­ÓÚ¿üÆ8Ç^v«´e¶ÜÙÏBùe¿F¹°nîæÛQ`²Ó€Š’=\'ØÑ¨nÚÛÄM%7>rKi&J{ƒTÄöšÕðev*þr$š¹ÚÛÛ]$*ÑjCÈ$˜ ã¥ekª¶’.²¿Ä|>[K~”Ÿ.›I±•«}<\\-ÛwÒÑeDZ \'Š+Á^bÁWN›Ÿ8ºJT“ùRâ*k»‹´-•²´\\70QÂ»Pš3ž›~|ö^m—AQ pLqY6ëM´µa†y¥n–¯0Z¼®‘ÝÛÖz{	BB %\'PžºÒuGíRµ;å”’d”Œb¬Z…m¨è›ïPî¨íWZmØ¨ÚY[np+iY’>ku5–*FH…KiÜW’Ãòh 3¥;yrñ&ád”Ž\08¦¸úô:ÕlìKa[R“É½I{áÛ–ÛQKŠQDp{Uk[¿Uî£dÍÁÚÃ\"T4zÛht9ÿ\0),Ã½A<ÿ\0ö…z”°ñºJVJÉ=f¼B—z—HòÛœÒ×îX»xùlÉÄše£ ¼¤‡3¯½Û›·è%Öº«Ó‚y„ZÙ»l<Æd¾¯Nâ?(?Ö´ñ5•Ùµe›P[mF\\WSŽ)Ž¦ó‰†íºáq`æ–êÚ­Ã­Ú0ÛUÉJ@;&&½‡xbyKuü±ý\'–ÕøÅ–_åWÐwšhéºn›tèh\\&Ý$¸¥æWiN¨ÛšŽ˜YM–à‚PpBI\"ŒÒZ:5…ÈºRS‹.¦@\'¹ëûV–:“úŽ›©Ú]¤‡W¹-%\"dAÿ\0ŠjÕÙr¸ãž`š¦º—@3+Ï+ÌowÒ­\'Õ^ú\nr\"N\'œÕ²×F¼nùi¤‘ÊŽgâª~-K÷~ÿ\0;p;úg¸§Vä°úg·Ã¯¤n°cñip/°8â~˜¯J–“ºqÄÚ„KÈëE2´/#9àÿ\0Z’¤ò\"˜Ä« £µ_­N’	2y<@JßPL	 ó¯âÊ?2§#ˆâ®	°Rð‘ œ~žÕãî\0DšV‹ ±´˜$IÏ¥J‡7HÄœ“Í[~9›y‘¼ñ\'‘ÏÒj¥ná&dpEB?@Ž1Åz—›D’>Õ;ó,™ë()#qÉàq5:Z ¥DÈI#íC&é¥¨Á93ÒˆáR#\0ãõ®Þ\'cÁtó¨-º²¶ÕÐâ~[BHPÈ‘aÖ´Rƒpú\'zšð=°ó\'¡Ï\\U·©ï$Ii¸‰iæ›¯4Ô%Üäâ«.K©\n\nØ˜ƒšÀÈJˆRæx¨«‹6s™AàËãºÛ$	Pˆ¾*‰®iˆyÕ.Ù’D¤Î1^¥M#Ô“Ä\0FHÿ\0>µ\"îV©$¬g3ïT·V„`‰|¾‘3zYm^µÌ	ÉƒZ6Ý–’!Dƒ8€;QŠµßÌ2¨•l”ÊF?n:Ò¨;ÌÌ>ÉL6ÙHVÞÄd5»­!K\nB¦2í@!²	“*É$ô©™Ü\"r:€{š	uëˆ2@Œ¿n´6\\`mço5•º(	:VS««P\0Ì®O¼’É½£Ò£×µ1	”ƒ&qYYAÓýÙšýgŽ4‘9TT—d±¦¯Ë1k+)úD ê\'1òüÅ…-k*p’£Œæ›Z´ÒŠT¯LÇâ²²ªß~n[ÐA˜NåªTpb®zs(fÕ	ƒšÊÊ^ø®«îÀ¯ïîö%{¶a\"(™üQXyÇQž++)%“J€8Š®lšUÎÙPÑý©]Ã)I„“Ð|b²²µ¨û³R³ÄŸEoÿ\0ä[×ù»Õö’Iå3Ò²²«ªÿ\0æ>q-OÞÜ·µD%J&zÕzá;îâbŽÕ•”µ)é\nm„¢ÑÓ*$JsñUK¶ÇâÕ“’?jÊÊrŽñÊûÏ6§ÄqRÛ4³$ñý++*L$ŸÌq·BÔ\0\0Ö8ë› Ÿù¬¬ª‰Òá-Ïjny‹QÚ$}©Æ“m©x¹ÅãR  I•”á²&²è°}ãI”èd?ÐHŒÞ(=-_‹Rž|:£QÍee9Yâb?ywÑtË[k-Í6ŠÊ—üÇäÔ,^Ýin­VÏ­CÌ\0%ÏPIþ•••kx>ßÁ¢\'Í¢©´ÝiM¼¹CªLîF1ÒˆðËª¼²i70ä$dŒÖVWÆµq¾{«?øñŽü”0’ÓCj¤Õ–m·µÕlNâfcÞ²²³rvægvÄ>(½y†]K{D‚	Šæz…‹fîÉíînt€¡\"éYY^ÂF®&ÿ\0‡ägâ&Êe(¸Ø’B`}iŽŒêíÝmhQ&I ðqYYZäF~\"Pÿ\0ü—¶˜Ý»÷…âÈÙ+üÆ>(»·Aµ$¶Ù H”ÍeeN«Sp|o8ù˜†OVØ3òC¶‰vÂáõ-aH¥)€ŸˆŠ—ÃÍ\0‚˜ÿ\04	¬¬¢¹Ý_3RßIÚ¼	¥f”€âœujsÊöéToMaËÄZwí tø¬¬­ý?g®ÓÈx²/ÚÐc·ó+º½£v·\nm­ÛBwdÎh-” “\nô‘íYYZr€™‡ª\\6ÝpJH*`ö¯U¢Ù©±)T“ÌûVVQÊhŽLE}§2Ë¤4§½++P$YYHÙÁ„R·¸÷šô‰B‰“k+(2ÞÓÔ¦2f\'÷©Y¸p7pk+*LŽñËiJØVðšøŸ3tóYYBîd	T¬äˆëõ­•)áG\nŠÊÊìÉÄÜžGíE$ŒA?µeeW¼ƒZ\0¦“=}Gæ*\'Ò\0‘‚1YYAÿ\0”ë4lÂf3ý+p\'oIT||VVTÊÉ6@I9úÖVVU`çÿÙ","ÿØÿà\0JFIF\0\0`\0`\0\0ÿþ\0;CREATOR: gd-jpeg v1.0 (using IJG JPEG v80), quality = 95\nÿÛ\0C\0			\n\n\n\n\n\n	\n\n\nÿÛ\0C\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nÿÀ\0\0 \0 \"\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0	\nÿÄ\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁRÑð$3br‚	\n%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹ºÂÃÄÅÆÇÈÉÊÒÓÔÕÖ×ØÙÚáâãäåæçèéêñòóôõö÷øùúÿÄ\0\0\0\0\0\0\0\0	\nÿÄ\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3RðbrÑ\n$4á%ñ&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹ºÂÃÄÅÆÇÈÉÊÒÓÔÕÖ×ØÙÚâãäåæçèéêòóôõö÷øùúÿÚ\0\0\0?\0ðü`Ñ|%§ê>%}rk¨âU·Ó~Ó!`«±HXÉû¸$ñë\\×ìóûe|eñ¦¹qá[O†‡ZµìKˆç*a»0¯ñ–…â=oâðF³«Í‰d¢W…Sýs•sÏ#û×­|$µ—ÁvqC K&áåÁjväz±xý}ëØÉ°IT^ÃY[Y=¯‘ùýz},-¥94­~ŸqÚë³åÿ\0ˆþ!É¯xŸÂ°Æ²É¾›“×æÀçü+Ð¼s¢|+»¸ÕthâÚÛ´LV#„sÏ¨«ÚßÆ+?xßEÑ&š¼[H ?4mŽK8éýk‡‚_ÿ\0u¤øâÏØê^›ßÁXc~7\0zšúz–_”ÕP«+Õ“Õöÿ\0#Çž‹¥ÍRÉ%¤[µíÑ\\ò_ŽŸ|!ã—ÃÞ€ÜÜ=Öonn…lž@\'–ú×”ø›Áþ$Ñõu(´Y`GË’\"YqÔ×Ò?üðÛã\n®½ð®k38éxˆ$Ñ±ç9WBðWÅ¿xMt‰ž¶¹ÒámVá±s\0=ƒc‘ìZùüâRÄÕ”ªî¶i{­zëøšCOErFÏ¬[×äMû1x‚eÖ4½;_˜Ëý€ˆKü!¿„ŸNx?Z÷í+ÀÖ²Þ<Ò†h÷Çò#9íÔ×\'á-ÁÚ—ìÙywá9×ì-KÀÖ®L’0$™{÷Ûí]7ìßâkˆ>·Önï¢iN-µ+PÙš	”`î@Î}ëá1Ø(Öš«IórÉÝöÖÿ\0ƒ<D\')¹%£íæTýš~[üñ&«ocâ[‹èàµÄ81á‡=ð9ükÜh½Tj)gmöyXÚXÆÎaù±¼€AP:F‘¢é+\n[K©‹{ÅµÓÌ1º>˜ÓÖº†>ñ¿~!ÝêžÒ~ÝohUe™H¨`@±³tô¯OWƒ£\nµ$’i_ïÔê¡„Åæ7ÃS‹œê5¢W}Þ‹·SÆ<û<ø‡Å–¿ÛókL–QÜI%¢G<\0@r{jOxsÅþ2ðÆ›àVá´ÛfÄ¸gm«ïÇò¯^øÅàoˆòi·ÖÑõ->òàÉg$±¾\\Û´u8 äuÜ:Šòë]âGÃÚYXé7zN¥jœIªÚÉ\\€N˜Ž¸?ýTC—U”T\'¥­¿MìkŒËêaiÓ¦ðóŠŠ÷›OÞÕwØê~hÞ6Ð|â#ÅZrYO¤ÁžŸ3†îA\"£Ó|â[O[k‘ÎîY¼Û©¥N}žÜ‚k²ð>›âý_á…µ÷Ä+±Þjš—Úo! Œ\"•W g;Só®3â×Šücâãy¡ø?ÈN²P—æ,\'bp#ìŽÿ\0ýjà«Bž#Ïºp³M;»­¿àˆ¢°ôb§šWIî¯¯äs_µ_|=e­èŸí®/Þ=<Ì\n|ñù»9UIÁàzšòOÙ|j·ðÕ•Å‡‚/#gYà,±?(\0õ5ÜiZ”ë®	h1¤÷®I½»nDd·?n^|Tºð…ÎnÏpæ6D‹\nw÷€\'}+ÓÂMcêNu¤ÓwÙ-;\'é÷œtýœ—¾µl—þÝOÂÚ5å²Èí-æžÞÜ6	•Ç@¹¯˜iŸŠ¿t}BÃà‡ÂÛk­KÇ:‚\"ÚØÙþñà2ÌÄœnúôÏåëžñ/ˆo¾#é²júdÑØÍŠ{ùœfÝBœžOV=*ÍÇìñgiã	þ%|<ÐmÆ¤d-.ª—l÷ì<WF&te„Tå«ŽÉë~ºüí÷¦ž?kˆ\\Ý–Òÿ\0å¹ä?<)ñ“à…üMðÇöðÞ¯j>9Ó¡k+™ÌŸL¹ˆ±JŒù°GyìËmñ7â•—Áßi÷b}WPHì–É31’C…U©$ø××k®O¨Âo<MlkVÄOq2éœî|1gðëàÿ\0<3û@ÝøFÞMgIÕ ¸´UL½Óƒ»hÉNeŽŽIÀ®&2–-{iR÷]¡×K9©W•8ÚOEný,ÌñM%¿á+ñ {éÚŽÞ5\\™F\0&³n<Kñ{ãŸcÓþÓo\nýšÅÊ*Û˜u§ü;ðO‰¾%k«á?è3Ivÿ\0+Æ	Ø÷Ï÷G½}ƒð‹ö.Ó¼-¥C¾#ÕMðŒèôûXÞ\0ç¶XîlwÇ§ëÕÍ0Ù}(Òså¿Kïç§CÒ­‰¥ƒWŠN}.x·Œ>.~Åzn•iãD!Ö 7VáÞa‘’ÍëÓƒ^«iÿ\0ðo<\0ú6µ¦†13Z:ígÁè½‰Íy/íË§ükñ¿íü¨xSP¸°ðµ•g<6ŒÂXÛ“\'r8Ç±¯Òí/4ùaºŠ3Ë6ÆLV´æç(ÔŠ¿[­F“†3\0t¹Þöè}gáëž(ºø• k3è·Ry–¢2GÉü*ØëÅzM·‡¾5|JøNÞ%Õ¼WtµËÀ`ó‹¡(pž¸5Èø?âï†|o Ae¤–úŠF[\"½XwŽE{‡ì¥£|g×?¶¾YxkëJ¸³UÚÉ;ˆHÇ$ŠëÄ¨SÃT«ZV…›m»%ë},|¦2ž;5N•;ÎéEZíù.¬ç¿cÿ\0‰>,±Ö“áýÅÕÖ¯¤°Clˆ]å20¡ˆî8Ç|Šö/ÚkàÄOÙ—ZÑþ;xkÀ­£Ûk—‘Å­E\n†&sÕÂ’?#žs\\GÀÿ\0\nø·áí_ámwÄþÔ,¬£ñ$Vwwofñ‹[·À·0¸•â8=Tú×éÿ\0Ä=3Dø—à;	xß@ŽkMJÔÅ}c6QÐƒÑ‡ ¨aƒ_†ñG`øk5Œb×³©7ç­Ÿ+½®´~i®÷>ÿ\0ƒ¼<\\a“b+JNU.XÇdšIÞI«Ù½<¬ú£Îüû?iþ,°ðonõ(¼ë«k{­J×fR{rÞ,ŽùsÐƒ^óhÞÑl]´]:ÞÛ÷˜’xÂ‚IÏ`;’^ià&Ã:V™á}>WeÑôÏ²+?RªTŸ¨Îµm5).$šg”©ÞfxÈïú×áQâµzØÙFŒ½¤|·ÓâI­<ŸGØþ‡É8-Èiþâš„Ú3Þí+nï¿‘Ò™ôÝGÅVúì²°x-¤G€œüä¨WðãÜv«š˜Ð|Sl4ícO†î?–U†â0Ø‘õ8=Õ€ úŒ×ŸÃªÜØjWHÌ8@8þufãZš˜ï¢™XØm=r:þ5ò¸?±´êÂUbžÜÖÝÚÚß½–Ûv>†®Kû¯Um;z>ð…¯Åß	G£ÙëIc8\'‚aò£€2È\'¿LòŠß²†|-ð¾î\0ø–þÒùÜ•žá–Q<’60@,1ŽžõÞx_Ä¿fñ,wSJi‰¶ñò…éôÏó«×>,Q‚ÎÂB›–Eî#:÷ÏOq_£äž\'ÖÂÆœ¹ÜW;|©èÒåß×šÚí­˜Îü>ÊózµgZŠu\'^gvã½šó[ÝYµ£gÈžý”>1|-øssã›¿¼º…Ü×.¬XËw¶:ŽãÓçÂþ*ñž¯vž*dÔJ4±Â’ì2œð«ëÿ\0Ö÷¯ÕË}VÛPµšÇV|—£rŽW»Ç¶1Þ¾\'øÑû\'ühðW€%ø§ðûÂZ\\ÚŸ‡Öál,à‘äºû¸Üãjá¤PÀ=9ìcà~=Àf\\ðÄU9JQQOMî­g®ö»Û^‡æøÏðü=GŸMÕ•µç³µ­v´[ößM›oüOñfÇRŸÂÚú¬Í6ÆÍc)Ï9lñŠ÷_€¶†ßEÖŸ‹{æbúŸ¤2=ó×Ãÿ\0ÿ\0ÂS§[Wi%¹¹ºa#3n#žþÕèÞºÔ<âW»I­¡²1fý.¦Ø6Žã=M~±‹¤±tÛ×¹ñùïÐÄa%<,¨µÒÊþ_åæzg‰ü2ž%ÖâÕ4ÛXã¾·mÍLõô5Oã]Íå§ƒt_ZZf;+ç·bñcÊwPÊäãåaüHïŠë4/øWUk]cN‘Z	áW¶˜g¡¿Â»+(¼=âý[Ðîôå¹±ÉŽú)”˜ÈŒIÓPk“/Êëà±+ä›WÓºI¿ÊçåzŽ–\'ÇX½Wà|“ðÇÁ_>xNØizk]ß_\0ù³€Ësu!\0ì\0d•—Lzÿ\0ìññ\'ÂšÖ£.’ö76:£0ÝgªDcvö\\ÿ\0.õèÿ\0ðK¿ü7×þ¿ÄOÍi/ˆ¯[éð]ÇÌ1Gò‘{’2kÓi€>ñM´Ú½Ž›ž³b<ËKØ#Á9Á#¨\'¨¯b1\\¹Ž&§¿\'ð®‹äéÆrŸ3w—õÔù›ã¬ú&â~4èy¢? ˆ3È\'°öý+à|;—_ø¡¬êŸ<í Ô$x\"—â~a×ž+èŸÚOâ—4]^ñ£h’j61´öÌB–›T}3Í|mû)þÑ?>\nxÂâÏâ6=Þ…utòÝÀÃG+—ŒžÙí_¡RÁÓ§t¯k+]}ûž††&­*Õ©4ž–MïÜö½à¯í)á«â(xoH’Tû–újùˆ:ðH85ô‡ü¡|K¤ëÞ#ñçŽuñn‰u,×b;œÛj:$él\0V·¹X¥Þ˜%e î\nqÎÚsáï‰|SÂ½ÁÚÇ„n¦Ž6kïéÒXÅuÌ{Ë®äV8ÈÛÈ%‚å‚X|yð‡ìÉñÃLºø¦ßé±A¨Zí‹S³•LrˆdRc™‚º³.ìäWÍq~9®S_,£ˆ´©ÊœµztMÙ®{]=4=žÇfÙPÇâð¼Ôa4¦ù_ºµ¾é­×{[¹÷õôö²XÉ\nÌ³MYYA/å[ýµÁ=ºSÕÃªÛëÖK}ØV@p}û}sšä<£èW±º²ÖEüeZ]3P‰øxI&6R:«)ûU¯§é+¤ÚHRä•²±ÀSÏOðè+üÑÍ*Kë¢ÛMI¦¼Ó±ý×8áªÒRƒ×£¶éþWôÉlæþÍÔî$Û‘,#o8äþ¿ê*k»Ø¢wXƒ“Ÿ¯ýjÎ3Î8n¥ŒæUèy=?1Šáæø·\'ö¸ðýäBg ù“¤ÀðÃŒƒ‚¸ÉÀæ²Ãe˜Œd¯·_%þ]NÊX˜™·lµþ¾G}>¯æÜˆ|äbT|»‡§§Ó?•T]v#zcŠF,®O°Õä­ñkK¸ñ©“Bñöšb–(äŠ+œ¢”aÊÀç¨ÿ\0ëñ?4íSÅxJw¹¶)+,3FÈ\',½7Œ.wÏ>Ô8wèöOgú£×†C[’ü·÷nôjË®ë[yÃ5å„Fk~´leRŸu{÷ö¨tûé5-],!1ås(çÛ·ôü«Ïl<QOö/iÓÈÓD!º›ß`¥Y¡Ü¿uº€zþö¾.°Ò´¥rámãT†I#¼à×\'\'Ž3Æo/«F¥¤¯ù|»¿‘…LéÆÉs7¶ß§äwÚUàk˜­§¸“ç(%N¾€gó>¼õ¶zÿ\0Ø¯£K‰ÂbÜ™<œ×˜Ù5úxŠ)šá^\'µB¼`¢sÁ÷\'5gT×\'7²ÿ\0i¯ïX¨·DbB(ïôÆy8ëÒºò¬Ýå•£5Ù«ë«[Û[úh–,EEôjçÌÿ\0·ÏÃOëŽþüÖõ8®­â]ZïM±’Qu8yŠ¨0¨A»øˆÏ=Oœx?Áÿ\0|_áéÿ\0á3ø½mg¬§·¼ÒuX<©àtÈ*Ñ¾JAã‚ê~ƒé×”‘ùD™bxãéÖ¿3ÿ\0n½:ÓTýªüDñø}tImä P¸OšÞ¥ÉÈ?Ý*¿±¼/ãloµ—Ô¢©F”9”“»i4¬Ó~},•­µÆx¯‡©årúÜew)ZÍ/=­úž¡ð¯á¦§ð‹Â—z¾£ãé¼A§ÝJ­cnð–¹ônàŒp~¼×qðÿ\0]Ôîìo­ ³QSÌhÇ?&ïœ¨è»xÈþ¼Þð:nƒðRÃÁ0&{»~Ò‘^]ªx=x-ŒãµcGguknó®–ëkYˆâU2IäÎ?Â¾ãÄÊ´hÓ¼¥­ù{Y§étÚ?óJHâ>³	k\'+Å-¾Ÿ¯ðAÑ¼¦x_ÃÚ=ËÛ¾gn.–O•–~7ýyÍ}+ãÍZâÊÿ\0lÒ3ÛÞÀ\n—=X¥|]gñ\"MJoéL¯$ñ‡uÑûþµ&¯ûK|OÕõs¨ê÷*`\0¢mÂ*ŒdÝ+éêSR£Ë¶¿#åhc)P­(Ï¿CÈ?à¥:vßl,í\"òí5HMÔ¥ÍRœzcâšoÀi<u§<z?‘=Äpsjçæ™³ü¹ö¯Iÿ\0‚Š\\x—âþá¯ø-\\jzI––·$†FPÛˆïÊ×/ûÅâ¯ë2ü(ñíÜzLÑ–Ö<ùí\'Îèä)±ß)9A¸c 1]ÐÌéeùCž!ü+}õè¾{[wÐú,»S6¯\nXV›“µ»w~ûz—ûþ×^oˆ´oØ·ö¼ÐdÔ¢–o²øG[Ö,’æO¥ÄR«\01ò$ØÜŸ*±òðcûÃKø1ðWHð#|>¸øa¢Ï£Ç;Éý¨Ø%Å¬.O;!”2Æ3ÎÔ\0Î®Ä\n|=â»í&÷Æž°¿Ôí‘~Å¯jÇËÕ2p<è¢‚dÂ“•=pk¼ðôVþ	Òmü4Ú¨•m¡Híç›Pžy`ùw4ù‘Ïl–b}Mx£ÅùnoQO)ö”gÞQRj_j?Mêáß©ýÂ</™åØOa˜¸V\\«–V÷íÖ2Ý4·V›ü­³káè¼§E¢é°Go\0Ú--#<@?…°\0`mÏSÄž1±ÓõÛm\"IcûHa$Í$˜TU#ŸpIUÿ\0sí{Å	i¨è’êúµì¶3À…”îÊÛÏ9r+Çþ/&‡/Ž´Í[PƒUÝ¬Z6m>dH³-Ìqàíwxc²ÜäŒþ5—áÞkŽ”ëÉ¶ù›{¶÷»wW}^º³ôLŸ‡œcJÜª1i$¬•’Û[YGeä—RoøïT¹Õâñ™{!Ó.$v{Y£òŒPƒ†ŸÍ\'x$&r6äà)ÔµÝ_Uñ]”úMÅ••ÍÍ×Ú$mRfk©¬òÛV0R4ÛŠ6‡s• /ø—Á·–ž*Õþ#Ø[Î×WiúŽcy2¶èÈ€Á€ËBgiÈnIðŽâÿ\0ÛøËR»´‚òæs²8¼×‚(ùèvÏ‘ÉßŽù¯Ððô°ùvÚÆ—ÃdßFÚ½¯×{>š\'é÷T0ñÂáY«-\"´_ÊÚ^}Sm+èï®•´¦Ö§Ù½ãX5k5³x5{‹;<Æfq	ùTŒ^¼µYÒôbO‘§„µ¸´žy|=%î£1–$‘”†bÌ@¨£èzs]Öƒð`Ò¦»’QäÜ]a¹<™…l`ŒPGµ7Vð|VZí§ˆ¯–Òg`°´™óPP8$c9\\òžwNui»ú$¯n–VZÝ¯C–9Þu½9k{ímWK+-nÓòÓcšð—‹o|I{£ø3ÇÒÅ,“ÙÜ& É°ÊŠàÚÅG÷Ü:–ÈÈë«ðR6ú7ˆ®t’gÓL“E¡Åpçl±®à¬Iª·’=zšŠçÃz÷ÄOË»hìdhUVýå©$$ËVÀvLž¤Ý³¢iü)î¯ÏcƒÄ¦(ÌxŸsª`¤ç$s“Àç5ÉŠ¯…/ciNÞêÙ;·Ó»²Ó¢ôfØš¸jôýŒKh¶O™»«.·I4¶¿MNÀºŽ¡§]Ëoâ‰nn.Ê,Ó]ÅlÂÌ!*7?(œñÎmxWÄ~ñMÝÝåù¸a6ØîVBBã¦:;}+ŒÖïuï\nZjÞ³—^2øv%´ÑdegMÎé–ìëó3Ô…#ÒºOËá¯x^×L–ÔA<0¡ë$G<‘ÈÏ¯§ZùüD ¿}ÞŠÉvÕÛuºK§g¡ó˜ª1”%Q\'yY.Wo7îîº.Ï[7c¬ÒüY<>\"e\'å2ý==kÃÿ\0jÏØÅ¾5xšËÅ?Óì7.Ï.©z#g™¥Jºîp	àŒ\01Ž§·°xcZ•A¸½¶[hÝËyMŽ3ÏzéôŸ[Ü¹wh­¡t¯ÕÈŸÇÒ¾û¸Û4á,\\*Q©Ìµ\\®öw¾öwi7»Ðø^)Èhf¸YP’åþò³iéµÓZíÔðÛKBÔã›WUk›==F–›¦Y‡-‚G±®#Åÿ\0.<u¤\\¯‹¼o®\\›íÞiµ»òUAì«‚=¹ü«Ú>!hÿ\0ð“j7^&µµÅ ¼èÐüêË‚7~¾mý­ÿ\0kkzD~ðµ£]k×L#ß;láÛ=_¦ñ>‡úžO9ÅUƒ¤½Ÿ´JON¯â×]©%½áìÞ†8™S„¯¶“þmw·ËÈÈÑ<;§|;¶·ð\'ˆu4†å¢Ia=ãÝÃüpkÐuÙâ/Š´øõ\nø«H¹ƒŒe™.>îpE|!âÿ\0ø)Õ×Ä‹zÝ‡Š´ÛeðtÚ’Ç ]ÇúE’©#ÌÜ9!ú‘Ø}+î_ØÇú•ö§w<ö•¨’Æá%²àðÊOÇq_k˜ãsZ0æ§÷oäûV/)§†Å(ÔƒjV³ýÄÿ\0þ)xnâ]Rð]ì±XPÉPW?Òº_…ŸôÍY·¿ðŸ‹üQánhR+¸uMÏ§^ÈHgF5ÎpÎ>\\œ0¯«|sm¡\\Xµ‘Õ¯-îÞ\"mÚ÷:8èÄŒ}kÊôŸAý¦4wâ?ˆt½NÜñ^é°ˆe\'?4d¡,8Ç#½|Öm˜à±d£Ž¥-t|‰M|Ô“Mz§g©ïð¶]Z†wƒqçÞ*söz®‘š”$¥¯IkÙìw.o´’—Þ5Ò-gÕ\"‘4i¤De=%Ù2FŽr2GFr=$×fµ(¼ÓâK‰#ufâ+*œänV‡âkœÓüI¼Øêšü÷ÄÊ¦“¦ @7bHþ_r3‘ŽGJì¶:.¦\'žÜ¸Øcªå”wôã‘_ÅœyÑ¬_iwÓ^Mm§{¿^‹û‹&­™UÁF¦2‹…[ZÎJIÛªiê¾KÑî`|[ðÃ|AÑn¬ »–Öˆ÷\\@¤	7ÿ\0uIàç§9Ç•á>=»¸ñ\'Æ_¶Å¬AžÍ`ðÆ‹8ùšîci&u\"«`\'ÈÈÀP[Úþ\"øŽßÁ¼v¾)º°êR¬0Én¤”‘ŽÕäsÎqøƒ^®ÝAð©¥ðEæ¿kªx£HÕn&ÒIÄVo›—mÌz —ÞxUÜ§h5—\nÓšÃ¶•ïu.ûµèùT¯²zn½ÈéÕ%îš÷tÓ•Û™ÞÝŠ—[=›á‹éŸ.t¿Ec­\\ë’Éýê‚€ã-æÌ…NB  !Ýê¼šô›»mÃ×:oƒ4vë“HêQ§\"C‰ÝµqÁ|w\'ælàdÖ^¥ðöïáeÈñ}¤³\\jOo‡YlwwOò‚Á\0TŒ9\0\0džµéÇƒ´;/øŸÃ‹®*Ìé¬ÜÙàÞK1Ú¨±FÊªè»J†Sòb½Ç«ÓŠ¦Ô—Âµµä½tQ[in†ÞgN­¥‡EÑ6í¥ü¶²VôíÊüa.ø# C©jóIs§ê\\»ËxÁe”*ùkÜ$t÷[¹¹O‡º²øëVÓÆŸ¬ùÇIÐç¹µÌ›æÉ+·óª¼aN	Á#Õ~(éQ|N‚ÖöæON°¹1ùZ~©DêÎÓ¸í›nv“ÝsÐŸ2ñ_Â´ðŽ±qâ	—RÃ&Èà›ÉÏÉ’7ªñÐÜàô<Øg…†ØÔÒ«[ÛGuþN×¾ÇÁàóŠt«:s\\²¿ßëòmokº‹$}]¥Òb[{k,Ëö ·’ëˆä`ù%¶Íòàãä õæ¤Ñ.¤ñ*Io¬i’ßÄ]]\"¼UCÃm 2Ÿ|f¹‡£W»¿Ób‚ddŽBå¥’Ùã(·³ *ç92!<0áA`=ëzŽ†°ÙxËÄš}…¬°1G{¬™;‚nlç±ÀÏ#Ú¹qxztjrS·6›^û¾Ë{+ïÔý\'\nãR›Œ-{+wÑ»y·¥Þ§9ð[P}âõµÆ»qq.¯<‡O»¿!þ×k®ŠQ·|„ªñ×+Õ5WZ³µø‹c#ÛÜ\\H!rI“µwz®3×Û5ç¾Ð,¼G¯ÿ\0ÂÈðÝ´1ØYÍoa¢é÷6+‡…¥I\0#rò3)`FI®‡A¿Å^\"_i¶—òA§ÞÊ·WÒE$hv³\" w”€~cÐàdq–d•\\C­RæòÓgÿ\0’üïc£2J¶/Ú­RçÓd–©ôÛ–þwHô¼A¥\\]ÚXË<m8CçùH¸CÇdà’:÷î+³Ó´\'\\Ò7VÑ”\'gš¨_¡®Fm¼+,z]œÃdŒ/Î8êüõ®“J›Ä-¥L¶èWÈ…š(9,\0‚GóŒ›ž9N7RÑß[ÞËV×G«{³óüÖ•*Ø>D½Ç}ú§¾‡‡~ÕšÝ÷ƒ5cð÷CY¬ÖþÙd“R\nQ§•\0zd`ŸjðÏ	~Ëvÿ\0þ ÁâÇ\"é¶–ÄÞJTeÈóqœóšï¿jO\\k~3Â×eå÷ˆ `ó(;º¨9‡®{×¢|$ðü¾\'ÒáºÖbÒî¥µYH~èè7tÏ=kûó$¥VQ‡§:ŠU‹n:]Û~›ßª^‹cüýÏ¥…­Ä•éP‹Œ#\'h·²¿ÂÝß_Só?ö·ýƒt?hw?fÝ!­î<ç›Uð›Æb?VòÑ°cqÞ3lwóOÙöÃý¥>ÞZx.â¸ðþ…|íž¥$öOŸš8ß†^z¡ÈÕûµã/ß5O\0Ük¾ñŽ‰¨i\"¶¬W6ØèV\\tÃf¾-°ÿ\0‚hkÄZ‡ˆl ‚çNºE±Ôô‰@iã#?½p[Œ~k®|N—-M\"•Ôž¶^½}NØc¥<$¨´¤ž×z¯Nÿ\0šóG üý­4?ÚM¾×öw²ÔªH-˜ÿ\0¬Ul}?wþ$×ü†¦Õ~ ›t´´Ày&ÏÈIÂW¯¡¯‰¼]ð¿Äß²OÄ-kGñVûKYÂ¬ª‡z°þQ×#Ó­}a®x#ö˜ðÂEâjúZ,×É´HŽX\n‡3É»Çsé_?ŸáñÆÂ£jÊü—ºét£®¾G.UOÅ*4\\9ÛÓÚ8¨Ý76šnÓÒ×;O†>+Ð¼]âVð‚!‰¦1y©%¶¢í©œ‚²^ý=«Ö¼=}po×BÔ-ÅÂµ¹ÅÍ³-8Î\'/Çuù}	ÍyÂÏ	|6Ð´!áÏ‡ž$7:}‹+\\G{¦Ok5î21=Ã*ï3åí\0ðTÕ¼E«ÅÕítÓeä¸‘d^G8ýpx9¿–|[«O1Ì#8`çJ×JU%Q¹è¶çmÙ_dÝ–¬þÂðÓ/«ƒÊ>¯<e*ózµESPƒ{/r×~|ªûjaxÆ[_Ô!¹Õ¯,îc±‘äÓìAV+ˆÔ.AùŽXcŽªs“Šó/øQ>2üGºÖ<GáètNûC1¼bå%.£ò™Xª†]Ñ	pA\'Öüu [x‡E7žŽÎò^Ÿd¼´rÉ\'iá—o=OÖ¸O3Â>Ô¼)á­mtûmKKÓác¨ÜBc‚}:2ˆ¬ÊÊ»[ÊÀc¸í ’Õð9%C(ÓÒ_\n¶Ž*Í¶—ª×O3ö\\!ÃýÇ²IkµwWµœ–ºn®ºšßt»ÿ\0xr×ÂšØ[»ë›{H¯ ]ª»˜+8$ž€ç#ÓZè¼-ˆ¥ð‘á/ÜÞ^ë–qÇ}\0š8ÚY6²»qµvñÝÁàó\\¿íãÏü6_õKÏ>;-N+”±·”y·;\\\0g…«3ÔŒÓ¾ñGÅGS¶ø÷á1ewg«øbÊäX\\©ó\"É# ‘&yA0áƒÅË\'Sª”W;ø•½ç¥¯¦ën—V{ždð•gFœ—Á+Ù¿æ]?_øfzV›{\'Ä-_ûË\\Û§X†6÷S½‘¬Ÿ),>éúuí^Kâ­oÄ^ñ–§ˆ´%›L·s`\'µftIRà¬xÜKí·¨ëÁô»‰>¿ðÌú~“ã[+-kSÚ3+“Î Ÿ’)0Ir3Ç<f­èþÒ|á”*šØº!oc¼´W‘ßÜY‰ÝÓŒ¹®JXÚtoL,¶W½ì´Ñ»\'kimOš–OEbY\'víg¥Þšß§ùžEá?CÎ­¥\\Ç%­Ôÿ\0òŽf—h\0QˆFç¸¦=­|_ðñÔ­|;dÚoÚÒ9%U2î	Óë·“žÝ+Sân³ãÏéxÂº,&Ÿ\"ôË‡ˆˆ‚>~Pª1ÐßˆÉ•€ì<Oâï[kZÌ×¶º–›hñylˆKHbAÁY3×¸<œöN¥DÖ2/Eu®ú«\'§ôžŒû¼ªsÁÆ©5ké®ºÅ¥{uŸ¶“á™tÿ\0øJ/¤º\"/ìþÊ»íec· \"7|ÌŒçšÐð‹sðÙÃ0èW—3È|ëUæFVÝÉ¼\\ä‚9‘ß¾?Ã½{\\ø•­ÃâMkÃZ¾Š–eŒ6êË™÷`vr0«òíÚ=I¯D²V²Ö¦Öµ/65x‚[Û•ÜYS$•\0žI=\0NçÉÆU*oWW»ZZý,Öû¶÷W¸±µëá¢èV³oY/=,“_6÷Wná„´ý2ÝüAmªLïæ5.¥ÞÄŸF<ž{Jéâñ5æ™¦½ÜeÔÈ¶Ø’X—w–£$¶Ñó ô¬o‡vVj>&ñtAD†HâžåTŸ”N:Œ×E¥øÓÃ–ÓMQH™„ÀÀ7¸Ý€ã^¶O€•LF\"¢Œe¶«™Ûµïn×kåßäó*•j¹RIÎQëgeäö½½OŸ>#x§JøâÄñf`ÂO Þ\\ (Ìp1Â‚N3É&¸ýf?x¦KM;ÁK*HÒ³\\ÞÈ¥R8€ã½z7ÇMq«Ïqáæ‚(onƒ´Q®Æ¹`GOsŽ9Íp¾&¼}ÃámíÌ÷*‰,±ç*›lc¦@?\\×öa°|«õtù\\Ýìž·oM~IvGùýÅ‹2©Å8Écšuyß7*²m;.UwmÝ·Ý·vOâŸÚÁ{ƒk,-¨Ú^F÷÷ˆEÔl##i\'†^ùîFkÂ_´E—ÁÏ¼ñÖk.¦›ïmoäF7,~îàÄzc§jùóÁ/«C¦kº×ˆõ‹kX¼Ö§h,üã,«šV8·¹\n>P:œí\\ÄØ¿â?¼hþ9øËâñ£i×ä5žŸ m™z4Œv–ÐcŽ½ëîiW¡B\n*\'em?/ó9iÑ´”çW•%d÷ûiñ¿í	¡Ýxâµ‹ëÕîCN m®­Û;Nvû}+²ø•ñWHñqÖ`ñEÁ–gÎŸwj¡<´Ç1œõëLø9ÿ\0¾CÀ?o¡·›µ©iëqs7N#`?\nì¾ þÉ¿¿gG¬¾«ÿ\0	.›{oo£÷ˆ3Ë:u^;ŒŠðêUÂÑRXY¦Öëí/OÕ#,nÒÃóP¨äž¯KkÝv=§à‡Œþ2k^!Ñ5?Ï%Æ…eqÔ²Þ¸D™GÝ`T†‚¨<€Q^ÙãO†5ÛÏx\'ÅöÚ¬ÐZ¥Þ¡§Ú³n†` ·PÇ§9#8¯‘&ý¨ôkÏ…úG‚|.e[Ëx<«¹æP@xcŒžXg<p}›öHÒ|!ªjZ§Æ¯M§i^-Õc[m6îY–/µÚªaŠÆNÖ$\0¹vã‚søßˆÜ5ŽÏòÚ¹¦>j1¤š¡+ÎrÝÞò³M+´’v]•Ïßü-â,§\'«C,ËêÕ«iÖœÚP¦¬—*²néÙ-Z»Þí¥êvzv‘­ž¯áËXkiZ) dòÃ>Â6Ž˜Îp;sŽØ¯=ñ•·Ž Õm¼G¡Û4ÖvÍËè±Ì‹-¬±ÊEÄ^d„‘I0<`¼“^…£ëñx‡DÕ4Ë}*ÛPŽÎìÂ·ÔaÈwF#ïnÚHçÁgK¦xZòöÛZ’Áîm¾ÊöÞOÎªÅxçŒdsÒ¿—°øŒFOŒçš÷»5{&¯f·¿ÝäÚ?©px¸E¹5Îµ_Ítíº·]tkU}Ï<×¼#ðÇâƒâ]:á›Ski¥ÒT/ÞZÄ`2pÍ‘… Ñà}GSøAü ž-·i|;khíe~–åÚÝšV‡’ãFÀ‚qì:öðžðÞßSºÓ¼7éS#\\Þ¢¶ÇiW£&:\0õÎF9ä|oeãÏ‰·ÒÙÇ®fj^ÖÍÍ•œÈ­‘yeci0‘wy‘·÷DƒÔöp˜ÚX×8\'jO¤¬ÖÉ|+g{^Û\'uµVŽ#ët%;Ð½ï\'¬[Ùévž¶íf¯½éþ\0¶¿·Ôu´µ—Mq¶âêX¾XC}Ö<p3€{aòzU|+ÕìgÙáOj61ù@Â°^±H›+*1+Ó`àç94{ñ/ÃsxTÒ´¯Ùù2Üim|·L I•ÂpLnË´ç àòA¥ðWÄ#Å\nÚø,µÜV×íi+Ë&×€«`¶Ö26	Sœ¸9ÛÁÁõ|Uw†ñz«Þ6zÅÝÝ;ê*~ÒŒ‹»‹´¯fµÙÝi®¶Ý;iç‹kãoŒr¬zGÄC¬Áù=¬j»ö’D€aºs\0þŠí¯¡ñwŠ´·ð|Ö©i¤]iŒ–÷–ò¼W–ÌÙ¤†#ƒ¸ô¤3[i\'„j×ÆÙom›N]Èw¹r†ãÉ8aŸîƒU¼[á+ßköWÞø‡©YKb….­t½JDŽåƒ.åFÚH;¹?6	è+Xã*¥d£M5«Q¾Í=¼šZôÑR¦µHòÁAjï¯*}ì¶wÓM?OÃ?Û>	á™£“RšÖ(ÿ\0{+ìiW\0oó>‡$‚I³©x˜é÷z¶‰<z{\\l‚xdn“\nÙÛ·#8ëÐò;âêú^» jz~±¦<2m…¢»’ä—3r»Cƒ×àç<þ}UÕÓx¯@]ëHŒ	^?5KnRT†ÊŽ0A\0õÈýkÍTcŠª•“NþR¿¯¯KžN%©J5šMIêÓµµ×M¼Ö…ß3V²Û&˜7Ü9vIPmAßHç§ùÅc|NÒáµ·ÕtÑØo7’0Ñ\0Ïm§=xæ´ìlæÐõ8ôé4É\n2æÞx§x£0{w=p0¾#üFÓolî¼µ7Ì¡ffÃ¹åHàîê¿5û†X|ULò8háã8Å®e$¥[«»Êöj÷O{ì~câ%|!©Vx‰R¿Á(¶›•´^ëÕ;Yô¶ýÎ\'Æš^¯¬ÎÓYLU>YXgh=qž2xæ¸mNÞÏ@Ym\'	su¸f5C¹•º|ÕÛC>·áí\"[U¾i­Ùóæ-ÜFG=«þî¤ŸRñµªÀ¨iÌAp wn¼WõN3àªªŒœÝ­Ê®—k%¥—d ×£ˆ­)O™)=[z·Ý¶Ï˜~!ü5ð†­s¨_é—7ö‰¤¹‹÷RÂãHÇÞVkÂþ\"ÖeEðµ¯LÑ-Á#Ê£1’xSëô¯Dý³>#ü3×<3áIôoéï«iú‘HÅ•ÊJcƒgÍ„ár_ïW—ëš–w<,´´xãyWØ‚+è¥Ãˆ”)FðOKôOSËö–4¾óÜü%ñ_Ä>±´ðü×ÓÚCioFrUz@Á\'­{×Â_Š:\'|=%î§opC¢le£9ßƒ_ø“â¼^º~›áÛ´6öö¥d¨»ÿ\0ö«¾*x¯Â^&¹xHºÔb·“zK7AŽvä\0H•ðYž_Œ£¨œ,”›M_k÷=ZôZm7ëFýˆ>	ëZœ·º>€mn’àOjCG‚w/ÈÀ«€F6°*q‚ª~ ý™þ;xCá¬¾	øyã‹Ù®¦¼yî¼Eª°¸¼³dÅ \\QÔŒq€áßí}áÿ\0øÃÞ*ø—m4Qjo43_Û®øí¤GÀ,ðãœö¯¦|	ñ·á÷‹4„žÊñu(äŒ’Ñ²\\‘Ò½ú\\¯4ÃÅbá×[hü¤¿¥{=ÑïaqXœ%\'õ¸s-y]ž«\'m/½›W³hùGà„¾5ü,Öï,D†ÖÆø™$@à°Ák¤`]Ø$³*àäãÙü=qâ-nÊKkˆ¢,ÒÅm|ŠD’¢eCœ}à@oâ\n˜WMãSÂ¾\'¾º:]ü–öfY\'`²3dü M£Ó’?ºs\\ø×FÓ¼•¥i­öÈmV8ÎÁ´apXßÓÜ×â^$ðN#Ìç‹ÃÁ%¢rå]¯Ev¢—Äîú-,—îþñ>_Ãù0ê^m¹$ÝõoHßk»ß•Y.ªí·Ëêë©ø“D–Ê]XÝ¢ÌÐÌÁ–ÀlžqþM.½zlµˆµ‰ô%‘eoö…¼ÛZ=Ø9\\™ÇN{Ö3iÞ+km7Ið®¨b“RÖ¡:€Uû?›Ü>Hùq•¼£5Wà•üþø_Æ¶wºí¼_jHL¹`³±háÊ§¦3Çø¶sÀ9Ž5ý‚æ$ìºGŸ[î¥$´?mÊø“/Æà(V“_½“Œ\"·•ùš––²q§}{«Øü2’}lßÈ°Ãâ=\"âîK+¦€2\\A<­.ÉûÊÈàð6òY¿Ò,u×¿Ól´&ƒWƒ~Ÿs{£M±à3ÄŒeLß*²°S#$bºoÅq¯i÷ox¶7ÎúœÄ’\0¤òc¨ãÐû×þ!¶ð%ï›Â76²Z&£,±NXåÄˆÝCmrÔg®\0¯œ£OWÉˆmZÖù»Ù;­m®ÛÚçÖC^¼¥gyE$’ó{n½Ý[KÏO>“Ãº5§„tˆ§ñ.­á·‡göhÕç \'`ÛgËŸsNÓ¼Qoi§ÚÃ¨hYßÝFAh±Œ†ÎqíAÏZÛðÎ¥kãO&®±%¹7,…JÛ’VB8\'oíPxl.ä´ñ’(ß¹œ¨\0À_aÈçó¢¦_ˆ«ˆÖ4skW¥Ÿ•´×~Úœ4ñªBr¨®ÓÕ\'m»%¥¯¿¡³g¤-í¯Ûo56ºwM¾G—‚™ð\0úÓµ?¿‡¥³Ö-5Cg-ÈÉcr#ƒÀ8ÏåZO¡[$^}•Ô4› b<Ò3“¦=øôëÆücø‘£øPÓŸP¼žòVWó-\"™X.áÔž7dŒõ}«ë°<;WÝ<5*–Ñ¦ìõMÊíß¦ß-O™Ì³ìQ‡x¬Ue\nIÙÝwÑ+[»ýt4þ#kž(Ñ-ìµ\nÚ+Ë¢|¿³Èæ5H\'Ìw€÷ó¾¡â7³ñµÔzÞ¦fÕgäh£?(brFXç¹¯Eð?Æý/P7Þ$Hc¸–ášÄ}ØÕð¤öÇ¿ZùããxÏÀßµj:96!ŒÖ×ª¤ÆèÃ€@kú§€ø;/á¼¢5#%<Díí$µ·•¼¶½•ísùÄ>4ÅñN>ôú¼¹;k-ï³½_—ÅºŽ±mm¢iÌcŽf“í²Ìx\n®TÛ\'½yŽ|ñ“Wxu#Y¹}­Þ{åk• ¢äíÚqéÞ©|2ñ,ÚŽuâk_dkŒJ¦Y06ò1Y¿~\'øëM°´ð¦£2èRºL/mNì#¤ŽÞ¾µ÷•hágJUZ~êzÇFþïëSáà¥Š³­\'½ÿ\0à$|[ûSþÆ¿?d­~ÛÄz¡s§O!ÌÖŠÙP9R9õçÖ“á¯í+*øet½kÀCUeØoüÂ¤)ètÁä{×èW‰~%øWWð5Í¯Ä±i©éÒ&Áˆ®Ý‚ç7¦9¯Ÿ|]û3ü#7_ð³¼c-þŽ\'YuM6)<™ÕUu7¹ã>µó¹>i‰Äa¹k\'Êíy+¯¾ÖûÖž‡v9Ãã°·’r·É¯U§Þ´ïcÏ<5kã?z Ñ~hekÖîñ‰Ú€ûÿ\0‡ZìµŸ„¶?|!{\'…õ¯¢€ÿ\0gùš6\'¾¹ß´ºN¡ká„ö)¢èÊgò›ÃÝ‹v‚6ãÔÓþ|qÓ.%ò<KnêÓÞKlHÝž óÞŒËˆ£Z1¦¯Òûú·«<ê$ù-Ðê>|Zñ÷ìï­|1ñîˆ’ê°ëS\\Z-Ñëó¹Á ƒÀçš­ðCãWÅ†ŽºÇƒ|Sya(¸d6…²ƒ”<WŽxáüIcñ&{Ï„sylÓîMxÔ£;©?6?:ûóá?À½PøcâGN¶Ó5FÅE¼±@5•Ã.YUŽq†çÛ¥t{UNõc³Õ®ÞeU§9É;Ùì¼ŽsÄŸ·g‰>xrÓWø±ocý£«ám­DE*õšE•B}y=jµïü^†÷·¾?øsn-/$Xa¹´¿Þ“À]Ÿ.éžã5ðÏÅkOx—âÕ÷…¼Cy4Ú†pÖ÷ÓÌÄ–db7{d{W£|2ð&®ÛÚxÆ~ÿ\0„‚Â[¸Ùt°Íæ	sò´E~e|ôÛSYS¢Ü§ïG¯EÞëÐÛžty¤å~Š×Ôûßáßí_¦üaðÔ‡ÀŸï­.t]6S­‹™Õ­Ì.Ûp¥Nî9=¸«øCâ÷‹µ½Ä~\'¼Ôüû¦ºÓàŒ4ca¸\n€p\0ÈÇ÷*Ø»Â¿¼%ˆü<—­´>\"­e…°X˜÷+ÆàrH\'9Çá\\ß‰´ñm¢Ê>)ºrMÕ„ÈVK†‰[cí©Ü­ê0àŽ||T8s…”«rò¶”ôZê¤·å“Ñ·¦º»Y•åœuN¾x®Yºwm&åÁíÍïrèÕ´WjýÇ/ø;ã¹WY¹h!€‰>Öò	™“ËÏ®aöÊ×¡ø#W³ñ×„,utýörÂéqlŒŽ\09ä\0pxù†Zùƒ]ðtçÅß~Îþ2Ñõ=JÆHžËø\\‹‚öé,Á$ nÅ°sœ×iû=ø‰>Zø“áYÖæK]íçÓe•Ù¥hZ5ß»?{œ}@ô¯’Ìø\'%ÎòÊ40®*¬Uã/îß›Tž—”¯ß¡÷yOñçØÊÙœ$©:r+|VJ<­Û›–4í¦šßKž½à9µ¿‡Þ<ñ±+q¥Ý^5å²O&DGfYwyá}ëÐüAâ¯ßø$x¾ç\\¶Xo-L±¹`7ª²ƒýàJŒv\'¾S¼ý¤t¿Û\\¿‡EÀŒÎð‚Ñ•ÛŽÿ\0L×Ï·µÖ¯áÚq<;ñ#Àú„Òí$¹³¹°´’æKÛ¢«³ p€óùšô³Ÿò¬ÚtÒ|’…¯¶¶I.É=NÚjô<œ£Åë,J¦ª6ç$œ­ËÏ.{lÛøž—Û—kNø»Åþ:ÒïšÍ5­Ilmîúr%Û’Â2…8ã¦kÕ|[«ë3ÍuªkÜM)Ì“O)¾\0“ô•xwÄ_ÛCâV¥ã½+â†‹àôï[!†ëL½Á¸–\"Ã,áI\0÷\0WÓžðï‚þ=ü8·ñw€õŽIâ2E&Ðpøû§ÓÒ¾ÿ\0	”S«IÐÃµÏg¢»îÓÒ÷{÷zŸ‘c«â«Õ›­RVnö»iv²oK^Ë²8Fñùg{\"4`|Àýîx¬¿¿hOÚÓáî‹ð«áOíô&¾i5NâFó\n«±)†âOQ÷k3ÄÞ	ø«i“xÄ,ú–œì·ºKÚÆ—2ç;X‘ŽAEbþÍ?´Îµ¤]Uº•n¬®vI$„ïÆìÄóÇN}+—.£õLz•Ové­¯ÿ\0ÆYaeÏ×—ãcÇ¿²{þÆÿ\0¯4‹ÿ\0ˆzŸŒ|K­*Æ×wlÛ#+÷V$$àsœÕÏÙâ®ƒñ+ÀGàÄ;è‡ˆ4˜š[Ds‰%‡$ü¹êW¡˜¯oñ„¶Þ)ñdŸ¼U|·¶––ÌÖËü¶ÃoÎHîÇ×ð¯ÎK¯h7ŸðQ­Zðf¥,ÚqñDÐ±BA|:ñÛœÆ¾–œ}ntý×£óG¯Bù¾tå£‚¿7™é_³‡ÅO‰sxËNñOÇßø¯L[ÓX\\E%ºÆ¾©°šúÃÆßþøšI,ô_[è2Ù¥¼ijž\\êì2Û˜}ìäž(Ñ¼W¡ ZÞÞév¾l©ºo³Û„ÜsÎkÄ~0xÅü7ñAüÅ|’…º»ûA!mQÁmŸ.>`¸äúŽ+ç0øìlòÇõU+ÆZ-×òì´ÛmOƒ«ŒŽkKwKZÞKôO©ˆ¾é7wÚ‡‡|¢Ï¨ØÝ7œ®ñ‚Ö.Ã8Rx*ÇŒ+Ê-¾|Xðœë»à‰­åIï/óÁÈü8­ßGûMøýìGÀÝbóÃbÝI&§¬gìðºtT,H-Žx\0Ö~µñWãoÃ9ãðµÇÄçÕÚ$Sss™Ð±ê•F\n(T§^¢RpöuÚ^z½?­±ËÞ&³Qr„¤÷ZßN®×I¾Æ?‰!ñújÐø«Q¦†b‘HöŽ˜üëÑ4¯Ûâ×ƒ-ô­[©g³MF\"¿p/>ƒkãÃW¾™<O§x‚Iwâêúg%a›r†áOQŠòÿ\0Ú7â.¥­øªÖÿ\0DÑâÓ­/!ýÖÂIb¼o|×mGCZT4mhíÓËÕ…8áq¾Zoš=ö·•‹ß¾6Ù]~Ð¾ ñ<¶ˆ‘j“,’¢œ4lQyµÙü)ø¬¿ð’iš‡†&Ž{˜¯ckTg!„¡†Üã‘Ï91šñ¯…ßü%ñ?Å-«üUø„º=ŒuÌÞYy®Ž™ÇsÒ¾¬øg{û*é:î“à¿GucÅþÂñú1ºg1ÈDŸj™Ð»‘Ó£‘Åqb±0¡%†…7;é¦Öõëèµ=ì·\'†7¤ù}šRr{hÒÝé{µúŸLê)ãßj_ðºàð«Ü?ˆmSíö¯+F±Ý…+\0£i,àÄ£Ž8ã§Ö¯4XþOâÂk{­böÖ5{XUæYšh•_å=·²±›®1X¿þ-|=ñ”Zƒ4[‹‡µKøWšªÏoÌÈäf&”“Ì1ÎÖÆÒNç¶øð3ÆÚV§¨Ã£xJ÷í¶÷\"{ÝgQ/c‹]B &f\nJòÀŽ;ñÎd¸bœãŠ“§+Þ×</³¾ŽÉ¤íÍmõ?¯8–æY|\'NTÝ4ß?,àÔfâýèÙû­½íg®ÇWimçjz]Õìw××oeÜˆñ[$I\'®Á—=É.£8óŸŽ|àíZïUñ³+¦©xÐ&ÀKG“ò‚¤e’BƒÉ[ø…zïÅ)¼gð‹D¶ŸÇŸfÔ5\"¶š^¡å©š êaåÀŒA9ff3?‡|}#xËQ„öü5Ž¹n]Ê“’ÀsœôÛÈZùžâ<~+J®NU%ËY¥	5w\')^Ê+eÕr»££ˆ²l\\¶­l\\áõkMÉ¥ÎÛzG‘-unÎÚ¦Ú³¹òö§à?xRËíZ–‡sm\0f6ÒI*3Ð†ÉÁç®3ã:Oã2K]PKKèâŒ¤™í·£óüëéÏéWž%ðïü#¦;×Õ­Z{ÔrýàeHÈ”—Ã˜NBòÀ\' ò7Å»É<5ñ6ëBó•LL‘%ÄØvÚ2F3OLŽkúO(Í±¼7-YEÖŽ’åw[h×“]íªgòð­\\‡8uð´ç<ýè9+?5ÒöòÙ4szVñ\'ÃÉh·:<Œ*à]sËŸzú§Ã>*ð÷ÁuÐ|Ià+˜_IÕJwM‚çq¶¨ùÂö÷â¾q·ñv¥¡±:¾r¨‡à[8w8â©kÞ0±Õ§Ib×!´Œýáù†;WÕásO«+ËIt{5câ+*˜‰.d¯ÝP~ÖžÕ¾ÞAû_|8×\'Nž8Žµ² Æ„Ä`Â¾tñë^|U†oŽßt&²¾ÌÔ4À€Ä_½2^äu­Ïükñ•Ç„.<eã››ÍêÝáºÓ%”¸’3Áp>”ï‡_-¾Þ[ÇOšÖ\0Ñ›[Ã…PO Ï§5¾7•c§tùo«Õhû¯&8ºžÉ)¤ÜtOË³*|ý¬ô¨,¤ðça¹·1´¶³F[h#ükæˆŸ\nµo„_ôÏé¢WÓ%Õ}3R·ˆ…`X‘ŸFç§­}ã¯xCâWŒ¦ñŸ†41§O8ó.,­$Ä,ÝØdg¯°­\'IÐõ=ßÃ>&ðú\\YG6HwÜ1ÜsÓð<WÌË>§—â=œj)Âúï§š£ÐêÂf²ÙIÁ{²V’ÿ\0/?ÀÿÙ","808_image-3.jpg","image/jpeg","/../ximages/item/28","62542",Null,Null);
INSERT INTO item_image VALUES("4","34","ÿØÿà\0JFIF\0\0\0\0\0\0ÿÛ\0C\0\n\n\n		\n%# , #&\')*)-0-(0%()(ÿÛ\0C\n\n\n\n(((((((((((((((((((((((((((((((((((((((((((((((((((ÿÀ\0\0–\0–\"\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿÄ\07\0\0\0\0\0\0!1\"AQaq2B#b‘Ñð3±á4R‚¡ÁÿÄ\0\0\0\0\0\0\0\0\0\0\0\0\0ÿÄ\0+\0\0\0\0\0\0\0\0!1AQa\"#2ðq‘Ñ¡ÿÚ\0\0\0?\0âÊ´ð´õZ•R¨³×\"OT©’2x«pÛFÔ.Tv¬©%j+\\Ž(½§Å‚Ë8Ú•,(‚#³ø«)dí£ÐXqµ[Oø¤¼¡Q›[Šwà~+R¶;qO#Úƒºj2c·ÙmÅlÚÀÅBúp>•Õ”ÔbÞÏâ ’ÐãŠÙM§|UY¬0x¦, ´cÚÝ—Þ£xöõ­Í¦üPË‹r	¦Ævrl¼ÿ\0ja]ÿ\0â®4ÇŽ™`ÑL©Í*±áœÒ­f¥L‘çÒž‰íW­­òFÔTAn{I\nXœOÇÞ«ÛOy>¦ñ[É1)íe¸$6à’NÃÏ¥i-íÊ®V&Œy\'ŸëT—Mhob†Ég†Y[Å”G+7k`JoÊ ð\0#×4µ‘oc\"ƒ¶6©4QËš\'PÈØ# ñE ³Õ&¦G‰FL¬®ÊX+ÝÌÝ¹À$’sÏ¦hÌ§Ú£”Î6‘F+M†Õj;]ø¢qZmÅXKzK˜§0JÚû\nwá}…Xµ{àüW5Ö6ÛñL6›qGL\0úSM¸ÇÝfÖg¤´þj¤öÃZw·ÛŠ§=±Ï‰L%3ugü4&êÏí[I­NûBîí?†ŒäÄÜ[`·ªüoZ‹»C¿–„Ü[öœâ©ŒÁhcÞ•^h·â•£”2ÞÄmFlí¸Ú£´ƒ¨õ•¿Tó˜iŽ×÷`—hÕHfÂƒÜ*r8?ûóOµyõùÙ&Œ…ŒváG{|ÈXn¤d3zì¾†ÁNÓ¿çÅ?Aµ€Þ^\\‹`—SíÞ@Ûlã¸ƒ°98§säët˜^Ö×#8äÑí€ÆK*mëWRµ!»%nÈc„T‹Ïm!ÉØfœŠ§´†B=¸`{±Î=ñŠà%AÅ#Å^üW¦?ŠÖk˜¶âšbâˆ˜¾)k02Hvª“@=¨Ä‘íëUÞ#íXí€¦¶ÛŠsoÈÅi¤‡n*…Ì¨Ô†FTdo-¹Ú‚^[ã;VÊîh-ìÎÔøLrve,7¨”ðô©ÚE‹+~³·ÜU[(öQë8÷ÔÓ‘Ù:#¾’-;KšöShGt^#v†—ô.~NÕk¢WÅÐ ”E4ä†‚eÃE bG¯owq$ã×Ò¨õ™ÇMMkª—wŒ°ÁÜr‘år–ô¥—Q:žu¬KÂýðÛ ç`qÁÚ1èioè¿qOè¿pÄPŒ.Çš¹Cmô¨â_ËÍÕõb+¨bÑô³*%ÂÇ<—JU%B½ÄÄÀã`1ÜØ Á»¹ºE>¡Ô´¡®hö×ÚHñÍ3¨‘%ox€!¼§yÆr=hT?´¬ó&—ÓiËv®Ÿ„ÄÐeˆü™d=ÇÐ\03ŒšÔßÜÁ{yq¤YAÌ²¹f$ïRÍœ/êAœäÝsh‡KGlšWá¬í”V“Ikà«3\0Q±žæ\0¶FwöÉÅqÈ¥ODÃýýßç%Æ„`»®N)x\'Ú¯,_ñ‘ƒŒ\'Úšaø¢†ŠcE\\Ô`DŠ­$Xô£/ÕZHè”Ž¥‹n*”ÑmÅ–-¸¡š£‹K9îÂ’<WìBÜ(-úA$úf;	o±–ê+ëÍ®µ)Ö(ó…^]Î@Â¯,wp9¬^«Õ¶ÉÃÙß5„ÿ\0ô÷J€,ž‡bA\\óíŸZ»Õ]?}©jp&¦}Jdy\"ˆ¸eµcPi\\ö–vUÛ¸e©Ô .¤Ö³uŽ8£`†1ù‘W\'¸ÛsUÃ¶’Ô÷)J1\\î{uï1±ûpiUûÈÇˆH¥C¨2KŽÛqGí\"#QB,TdQû@?ÌR&Åä3ßPI€.%ð’]HEÜ{°«®ùdï¶+i£Z\\Yé¶¶·—Mwsb9.B™Û$™ä×)ú©nöZ¤Z›¿Ž³*,(…L–’F„ÆB“ù]$‘¸Bõ×4V–m*Æ[™’yå·ŽI%EíY”Àzg9¢È«YÉÆ±Ä¶É>!ü3Bˆ¦O¨.ÍìNß%•šÙÏw+Iw)¹”Ìþ$ÅÂ€6\n6ÀÔ©¶wÖWoiå´·Qç¾‘K®¨þ_ïìj¬v]KoäËq²$má–ì!ÿ\0¥Bó†À5=ïB¢›z}J]Íuqy}3g·Ò(™™¢oÍÚ=¤®F0\næ¶VqÎ\"êT–\\·™°väöŒx<Õ-\nÝ¡ÒìÒSÊ‘(g‹ŒØóv{&IÇÅ‰}}(e+9–Z¤èôFåAUöæ¦X6¦Ø;Í4é\"áÉÚ¸qÚùõÞ‹EÆô7b$ôòü?ÅFöûqF¼1Ž*)aŠÎ-r\nÈŒü°ãÒªËÅž-ÎÔ6ävƒ¶N	8¬˜Ô\n™1Œúì+-Õ¬Ív6±x÷—/û¡øÁn#eÜ³0!ˆ\0ç°dž8«}]Ôpi“ÇN¬Ñ\\B—RxM*@²Uî+ù[¸Žø<ŠZgOC§XÅðŠúö)ÚáîÞ I»ïHÉÃàã ûûÓc¶ì|c¦¤ÁVú$­u2Ý^Ï=ÜkÄòLA›·ò¶?I vã\0ã}«ËØö£—šv¼×u¶÷5¶÷37qùéU‹µóŠTÍC—6<z=gÅg¬[Š=hÂ•6lˆæŸQ­Uºø~\"ôéÖ³ÛA\'6|\'d!N@Ü€ñ“Ï¡5¼‹[žÿ\0A×vFIdµ7ör„‰c\"ÆñÝ³©*7*T‘°Tn®åêÙú…šÉ¢C§È	C!L®¤~cA\0âýÒÖû§äžì8ŽÖýZM„½ 1FÎÍnÓÛèw“VdŠìÆrð5¥ÛR—ƒ¢¿Ki×ze¥¬ö°[ÏmØÐÍf‚6‚E\n¦s¸\n›;mXØú_Ré}ré5¯ì#w‘­…Ãx“ ³*í-ŽÞ0	\'ŠéÑãô¬V¶næêËÂº…¾mVÚ&iˆ·{–-²’%eU#\'}Î*8M½…àÉ5q½Ž¢½¼Ö\\Z)Hn\\\"•+ÚÏÁàå³sF#^å “¶üU›$ù;>UøôûUØHÈŠCdO’.ž‘åÔ/ûCu€p¥KˆÈbÝÀp7\0ƒ ¬WLÞ4ýO¬#G4Û*E,k h3ÜÌ»zHP£’0|nPšÙ£)˜Ú‹ÜWQ¤>šù ð)Ù®Mõ_\\™üìµ\'‚Ê7ìþE[œ¸ ÍœyUdòÃ\0ø§NJéð<ÓQ[&Vfî,.|¤6r07;m¾}ýþ=ë½u›BÑ£¹¹Öf^-Ðâ‹#mÛÞªÀ`äNF3Aàúy.‹«iWk$Úü6Ò-´öpHž+…PpŽ;»×»ÄÙp@ÈÇÍ§dÖµ?UÕ×ÀÔ,D±JÖò;‹´l¬ygô\n3É>l@BŽäz8úw‡âËãñ}‚1§Ú­ÅÆ§šßQº‰SR±kã1$¨Ù`ãQ{«²áT*ì `@=‡°ª3°Á®j±Mêv¸õ¡W^´RsÍ\n¼mvÃŠ]þ}©SnØwÒ¦Xõmœ£#ÚÜ*!yQe™Ž\0äž+œÞõf™¤ÊÐÜI+Ü&Š(É?ÔàU-K¬ìµ\"[hðîXe®œ\02qÜ\0ÎqÏÇòÍ5t¹gOK¯Q’Qn¬Ôý[µI£Ñ\\þÌâÎI\'nÐ‹ù”÷~‘’ÅˆÜ€£qµyô–+\'ª¯ôÙî¦m^¥µ+/’2Ë.XD	Ëd/qÈR¡ÜÓõ‹{Mcéü¶ö—ÖR5Š„¸Ë¬^çË¨ W>è›Ù­zçFº½î’g¼_ÌÅŸ.{K6ùÏ›;ýéøbòtò…ñé¢®\'Ô–ÌY€\0Ÿ¶æ¹­œîŸQR;ølõ~ ¹»‚xŒ>*GDÆ˜<gŽâA8$Q³º--…ªÉ !„åb†Ù”p88ùÎÄŠÑ1þ3K¶³‚Xm:ƒO{{‹xäÿ\0Vîò÷,“Ã× 6¨qm/ÏäpÓ/S°é°Cceoij¥-àbK* `Î8ÞˆÅ \0f„¬Ã¸öäì*tš§nÉos%£êqiÝwÔ7v«<wžü…³[_G#<JI8f,+¨¤ÅN#já}y{scÖ-\"Û[5ÄŠ.­©2øHT4ë·r¹‘Áî8í\\÷®Ó}Pu‹kyf²šÏÆE¤8W”‚J&w;çù}Ù“„ÇuuF3ö4ýA¯E£i’ÝJ4_Á?<î¨Î~HSý+˜ôßRèºmýºêú½¼çðÌòªÛ‡‚)ÝƒÉåÀf9ç–}^×.í­µ–	- 1©Œ6ðÝx•äõ!Tl†|ŸJã“GusàÛLÌ$i;ZR»˜\0ÉÀïNÃ…Î6?¤èâñ¶ü[LHú—®º­ãŠæY¢ñšÞQ3C‘7j$nvv\\y{Žäê:ß¨¯ºSBµ¼±Ò!žÙ‹…{…‰-‡”ÔrÄå€# “\\Û¡N§Ó½M¤2Îáíz#D{ÎKÚî|œ0Ã`ž‚Wzßj:=ÇTé‚ß©6[{žåŠsi#%K÷=ñ°\'¹­‘F3Z¸;–1ŽE«x¢‡J}LÓz—TqµžÆíÁ1	$¯…ÉÛ`ð0sN+Qq\'5œ¶é—Óï­Z×M€][³I\0’Rì§ äwÁÜdù¢WwÐG#$·¤€d«ÈÜç÷¥dpoåð\'\"ƒ—ËT…q\'4ö^w¬¯T}JÒtÖx´ðÚ­ÀÏw€Ø‰>ïÿ\0ñïXKï©Ú´å½Žl<ìîA>ç j£E›&émîd’äè×rùùÅ*â×½u¯;)p©%ºàüç|Ò«WéyŸ•ÿ\0À»Ð2Žw$ýêxÉ«|Ó‘±_@Õ’EÐJ;XÛí¶jæ•xöð]Ûí=¼«$LF@e`w´%Š•|zf‘<všexò=k«5]bé®n.\'\0*A”T\0äc×óVºC¨äÑúš-Zê9.ÜFñI—ó¸aŒ–9Ü`}øÍca3š³˜;ïšŠ]<\\Ø­5TtÞ¡ú‰¨ê7‰&“-ÞŸlª£ÂK\'¸=vö¨/>¡õÑVý ÖáF;mÔ ;c\'Ôë²Ô‚Mê_Úc[PqŒà-}ª^ßÍ<—wSË$ý‹#»–gíü “Èä·’K3K,Žó9%˜òIäü\neæšò÷)>ÛQöW å%àµ$½òw¹É\0ÓCl£ïšªdàìH5ëIÎs½Š3™¢µêÍfÓJ—NƒP-$rås–\\ŽÒŽêÛÿ\0¦‡¾½ª\0áu+åînöí¸pK{ùßšòÔ2I¿5£‚7t!µàµ=ýÄ’’yÕ‹g$‚y ûš¡<å‹ù‹~bw$üûÔrIUd“šª’àDò\nWÎjœO‘ê»6MWÑåg‡zT±Jš$ðŒWž´y«‘Z¤WóU©Á°kPE$ùÞ§†Lz¯½J’mI”\n!*²üÔ«7-d©D»R^2ˆå<ÞQLñ3þõKÆÛï^™F+°ÖRè“rs^™W´ƒœúUz^1¹_cõ»awi¥ß}±P´¾_½Wy»œNÏðÔ&(ãŒNL´O$™õªîûTlõ6iñ…Ë%ž³dÓkÕRÌ=£ FÂ½\n½àoÎ>M\0(¶0šTõ8Ã=ŽÔ«Z: Ù4†ô©Qú¯;R¥XÇ¹Á§£“J•q…ID˜ûSËµ*T±¶x-^‡;â•*Á&Ä[sširiR¬ŒÛd½¤ìíQ3T¨¹³ÃNUÏò¥J‰lwˆÑí–ß}=\"Ëú³šT¨^Ã£¿#Häå×Þ•*UÃ§ÿÙ","ÿØÿà\0JFIF\0\0`\0`\0\0ÿþ\0;CREATOR: gd-jpeg v1.0 (using IJG JPEG v80), quality = 95\nÿÛ\0C\0			\n\n\n\n\n\n	\n\n\nÿÛ\0C\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nÿÀ\0\0 \0 \"\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0	\nÿÄ\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁRÑð$3br‚	\n%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹ºÂÃÄÅÆÇÈÉÊÒÓÔÕÖ×ØÙÚáâãäåæçèéêñòóôõö÷øùúÿÄ\0\0\0\0\0\0\0\0	\nÿÄ\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3RðbrÑ\n$4á%ñ&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹ºÂÃÄÅÆÇÈÉÊÒÓÔÕÖ×ØÙÚâãäåæçèéêòóôõö÷øùúÿÚ\0\0\0?\0üÁ·¶9â¬ÇlÕf^pE]·°\'·oJ÷9ÏÔ\n1Úš±›–É=kBßNrØDÛ«§xvYÔ„äžp+)Õä/—Öúd“8@„ó[Zo…žI\0h±]N‹àÒÒ.a>à\nì4	ú“ÓÒ¸+cUa@átï9ò³ÍmØøÈ·\'Ö½+EøvÍÜž1]6ŸðÚBŠVø\nòªf	;*ž‡‘Áàp[éVÓáéÚ?tkÚí>2à¼ò«Éðè1æßÿ\0®If˜~Ìðgø}Çú£Tï>•ù¼ŸÆ¾‰o‡„ÿ\0Qÿ\0ŽÕ[Ï†HÍ‘éIf‡³>o¾ð¸Bk.ïÁÉœÅ}#{ð¯q,!?•aê_ÛÎ·ïýÚë†`ˆ•3ç]KÁ³mÿ\0TzVTÞ¼¶?yëè=WáÛDí˜:Ú¹/ø0Ä¿u>µÛO¤Î~CÈ/tß“ï5T–Û®á÷¹]¶¹áËˆdqåãÓŠÁŸMÇ{×§Nª’\"¤rKqÊôþåAqo.ï—‘ÛŠè®4¶òÁµR“N›psÏVœèÏ–Ã Óñü#ò«öºr¾6©«vÚyS‚¹­ÝA3²ðy=1\\Ò¬ oìÊz‡$Õ„E‹å8lu…Rñ7Ä“á›dðÎ…o¬Å7öžéZ9mÊ¨9ÜÌ\0m§5êÞðœvñ‹™†U‹».Ð€\0zûå¼gàßÛøé<{qã½\nââ+\"–:LW±ÛÌ-%F_´ÎìAÛËµ\\†ëÍrSÅÓ•Yst)ž‘ð÷ÁúÖ¡¤E\'‰t8ìu%síŒWK!¶m\'¨Ã`ŒŒó^• ü=‰A‡<ã%G?•sß\0¾øÏ]ð~ŸâûHÿ\0á—P[)	âÔ£Õm•>[³\"¾“# -ž6t=O½i^×Ëƒ“µ@(ÉãƒÏ~¸¯šÅâ’›³Ð¹ªp{œ¾‹àXã8û8éÝk¡°ðj¬c÷?L-vzG„Ýˆ+?\nè,¼(è1äävÈ¯¦/SŠ¦%\'dpx1jLX?îÕ¨ü®0ÐàûkÑ\"ð¸ÚD¦YE@\ngð®¬&sýoÌó)<\"¨¤}ŸRµV_	†B<³œñÅz»øv7]†>>•ZO\n(åSúU,JAõ¯3Ê\'ðiÇ¥ej„¹/jàöÅ{5×…€^•}á•„çdVÅ%Ô¸â‘àúçã%’Ý=+ƒñ?â\'ýScé_Gkž—s«Ðö®+[ðÃI»í™úW}V§]:±š>hñ/U$}Ð~k\\&¹á%†FaÒ;Šú_Å~^r=~ZóŸxF=ì|³œqÅ{xl[î9CCÄnô¤Ú7)b¨\\iŒNåL{W kž13iÆ}+ïG óõ¯Z…(œîæf“£™¤P ó]÷…<,[a)Üv¨¼/áðÆ?*ôÿ\0ø][fPrEyxœ]ú0…Æè^º·²{­/GK»¥…Œ6Þp…elãk>Ò#œàúQ|GÓ/†©á\\[ë6VZ–¯köÍOÃ›V{L¨W*F®Øòü­ä®@¯Sðç†YcÍ½®÷\\1~÷¹ãüôªVßu}Wâ¾‘ªxgÆqØA ÙË­Û\\ÊI-HÁ‚@ÄŠNHp§\"7\nN0|Ib×µ–½˜ÉAËÐô‡¾šëL¶kÎÄ¼Dµ•”¦Xz(BGÜÚ°Àí^¡ø5– ê Ðc¥_ðŸ…c‰˜Ú,^P LP@G™k²Ò´)¼)ù{\nñ*×sÙžjò›z˜ú7†ŽØ8êq[KáÕ1«ƒ[:~*Ã€V„ZDaUf•@ÈÉÈÊŒŒœzW6¯s‰·Ôç†EÏ4ñ¡FTek§‡GÝ\n;&	08!NF}jdÑ¯ SN(9’8öÐ¢<L“B!WŒ×bÚ\"ÂŠŠ]÷”sD/sŽ¸Ð@5›¨è®: ÔŠî§Ò#<V~¥§?C×š.žÅFV<ÓYÐe,NW8þà®[WðÛ\0O–9ë”ë:Ž’’G5‰©èk\"`¢ý1ZÓ©Êõ7¥U§¹áÞ#ðÚº²¼`‘Óå¯=ñ_…°1ŽŸÝ¯¡<Eá¥%Ü ÏÒ¸øx1lÃŽ8â½*®W¹ëRÄ)#çxgh`è1ÏjáµÊ}£¦}+ß¼cá”Ú@NÕæ~!Ð#‰ðÑ½kÝ£ˆ¼MœT•Ñ/„|7æ:)„ãé^«áí(«zsŠÊðo‡”F ×Ò½SÂ^MÑå8þ\nòqUô5›TËZ7ƒõ;ëpºnÜ‘ÇÈí×téß­<?£øËã©âëcæÛ[FÚv¬ØÊfŠ6UÍÝ±,s¦O+îŽˆ0Àæ»Yìï´?kµ…çØ&³Òfž+ù­ZD¶Ú¬D›GßÆå\'µy·üù~j¾ñ>x¶÷SÔµVâK	-$H-µÒ’q•2®]”àa:žÞcnXjµ:¦ŽÔœ°õfžÍJøwÃÒG	\n°‡æfÉ\'Üã$ûžO½tú6‡p-Ôl#åô¤Ð­­ÒÔbfQª6rc†¸=Aô5ÐÚýŽÃN–þúQ¶¯=ÄÒÊ#‰³9fÀP\0Éb@\0HÅp¹Fç‹7yÚ(©=¤Z6s«ÞÈ;Y.%ÝŸºŠIè	Ç¿8ãŠò;o?àÑ|3âKÅ¿g–óYg¿ðÔ<_ÚzcÈ‹µ¸€7*¬çv»\0\0z–£mª|pð•çÀ‹úqÑ¯í­öµ£”¾IÃ!‰V6C·|r+îìx5â¿ÿ\0d¿ˆž$×´ƒ?ít¯x?Âº{-ï‹5IbŽæÖbÎ8mã\"EiFXå?*0$ãƒC©[G¨Îx—ªè·VOäzßÂZxþ-cÃÚ—ˆ­5xcU–ÏÄ+gdÐª‘Þá„ÇóŽ¨À ßû$.0¿)Î+/àÇìÉð¿à]öµðçLÔb—]{_·6¥¨5ÁXíàHa‰7ª*(ë’rNpEzz¹¡Ï¥rÊ«æ<ÌgÕþ°ÕÔ|÷95ÑÁl•Ï×ÒA?*àö®Í4›îÛÓ_Ãèúœ}*{×há®47e#…ejgý_Jô[·Ÿ\\Veþ‹Ÿ¼ß¥T+ù”Ï9½Ñ”d4c¥bêZ>#Ï–+Ñ5-2IÁü«TÑÎÝ¦/Öº#V/sH4¥©æ:ÖŒ%C”5Âx£ÃÌîñÆŸur@ÀõüN\0Ç#Ò½—WÑ•~VØªHÚîÀ+PzcÐŸÇñÏíËûLüCÓm5Ÿƒÿ\0²î’×>!³-Xº¶Ú,ñ: ³W*×³TxÃÆ¬W\'šô0T§ˆÄ(.§¡ƒ¡V½[GccÅþhîZÊAÎFåØ+œd¤uÆ#µy¯Œ<:#vQ%X‚«×ëšùŸÄ+Ð|sá-\'ÀÚÇÄox¿ÇË×wþ(ðõæF‹¥¡ÈƒÑ™P—*Ê¬‘Ö¾Ÿøwá‹}7à×†­´ÿ\0Ë®Ú¦˜­i¬\\DÑËt„’Õ‰!°prO\"½ú¸g‚§¬¯©íû)Q—#Ôéüa…yÏ½z·„´åùì`Zâ<cm±Û?™ýï7å^³ákR¨« ÿ\0¤\nùìUWmÎlchæ¿ißëÿ\0g?x£Â÷qÛ^F°Û™>ÎŒ<™äòäÎá€\n“ÏÞÉÈÇZ›þ	ãáßzGÂýdüÑeÓ/¶ÂøºZO:+¥EØ«–`P£˜ÉÜä’+…ÿ\0‚ü\\Óü)ðSø iWþ)ñn„÷ö–pD®±Ø[O‰f‘‰\0e\0	Á¯}ýµŸø»à…|[á94Fûv‘luI|<È#7iYQŠ–>`P¹ÝÈíÖªJPÊ9×Úzœ®ŽTåüÏSÔ´È¢‰$WpC32\0êO÷@ü‡­sÿ\0ßÂÞ-ñ\'€¼swâûË}gW’xÓÁ÷?ñ-½†(Ûwö‹ƒ²Kub­åœ‡*T†RÈÝžaöÒÙÍd6c†ƒ/R¤vÎ1ZÞð®ƒ¡èVÚ†-SKµ¶_&Ò)@HcÂ™åˆêF=+Æ•T:ŒáN¿3_ðçÎŸ¼!à_Ù3àv“ðàrÛXÉ{©-Üº[i…ÛW´FHîˆDù`ÜÊû…J“´) û†ÿ\0gßé³|8Ô4-sJÒ5}/Ä-«À«¦[õ†{yEÅ¿ÜUVx†‘[jg‚kòæø¯ûF7Ž¾jP\\ë~i|7m½jÉ¦ªÛÜ˜5#kÞ	ZDd2cÝ	\0Ÿ›KhÞÑf–ÛQ›Iæ´gkyeDy v¤«ºpyÛÔqÞ¦­H¨yøÊò§J)ÚòZè¯¯üõ†%ÌEâÝ*\"‚_’vôž£­Ûiq¸ý×=ºV®™§\\N\0„¿Bd\nNI\'¶\0ÉàVÖŸ£86ƒŒ\0çù×´MyŸ=*³”œŸS›MºydñÚ‡ðü˜ÈŒŠï-¼2daû®1RÍáL!c)Êæ~Ú7µÏ0¾Ð¦E#gãX×Ú<òì\0ú×ªj^P\nlçé\\Æ¯¢,ûHÇ^)Âm=M”ÓØóKGuŒÖ©£ÇÊ€NIèZ¶”UÏÊÝp?Æ¹O¤v²Â‘¦UäV,\0ÇsÉè8Ï¦kª3m¤Žšp•Yr£Ç~8ÝêZ\'ÃvóÃÞŸSºX>Å§˜å$HÏ2ˆ¦âpã† ŒWËkðÿ\0á§Åm{ÂŸþü1¾ð¿‚4+½VÃ]‡H?f›UòöË¬r3¬c,—L¬Ùˆ*²œöˆž$Õ?k¯éz—Ã¿ø‡Qð%ïˆäµš÷IñV\'_ÒÕñöØ˜äµ·˜cù\\†Æ8 z=ÞŠº.žšEªG6±¬VööÙHÑa§¦;{òzúÐÄ¬=;½ÙêÒœpøk=Ùã#Á~Ò|oáÏ	ø\nÏEÑd²P¾û¬H­ƒ²XùÀc$å‹I9¯;ñ–‰?»‚HÑ6EQ„T€U\0ì{ÇŠ­c048íÁÅyOŽ,”n;z6]Cj÷f˜iÉ»ÜÁðZ0•>P@5ë2»K~cü+Ê|Ã(£§­z·„$@ËŸJåÅUg^6ùÃþ\n·ã/…:„tOë±É§øáíµ¼-âLF·¹#ì®Y¤ÌòÈPS¡ÈïðK/êžýô+ÍSÃðE¯kwz•Äð\")Õšilî\0g%†>_»Ò¾{ÿ\0‚¼ø.UðßÃÿ\0zÎ—¡á¿ßÏ¦ë:xŒdû@wwÀãœü¸¾+3ö!ý¥¾jÞ\"µø/âÁ:khú@Ôt­nõgƒJ–Úí^Kï´³‚ÊhÉ·yX.Æ0	Å{•(Ô¯Ãðö]õ:Öâr˜Æõ>Ô“ö¤Öµo5ß‚¿µxsJ–KkïÚ_ˆc’HJ—û\"º~_`ÎÜº0ão4õ?ø*7ì}£ÙZŸøóQÒï®¬$šM\'VÒX=“€êÐÜ4d˜\\P‘¿’yë?cíÃ6´xkÀúŸ‡½¥Ûj2i”áæ‹Ì‰v*voq‰\0Å‹`gžý¯eÿ\0Ù;Æ¾¼ø£ñSÂ«o-‹A¥s¦ÙùgQ–ââ8`I‚ãï¤“´âHùþ\\,ª8ËtyØHeèâbôz4Î‡ö?·†÷QŒšÞ¥¨ë¯tk\'½ñD+åÚÍöh#&Î}¡mcY¥˜ª—Ë%²OÓºlY¤%Wûœ\0°¼óßð¯›¿aüRðF/µ9m5iºFžþ¿¸¼G¿F‘ÏoxÑ³+ÊŒ@,1Ë`dŸ¦4–ÄÊpàÛ×§¨ÞŸyø–•WcÌÍšxÖÖËbÄ»[y<*ö³P&ã`¬|Åç Œ\02Nx¯Sð•’^Y%Â\\Å0n’E‚¬8Áuüxÿ\0í$°ü;–í.ÄPý©P½šÐYB¡‰ž]ÒFKÕ²Üð1Ï¹ð‘tñàm&}+Q³¾µ—Oà¿Óø†åX%Œ@VûØ=kžŒ\\æxÙ„¥Oš:˜àHÐ*Œbžc{®;b…€¥udŒÈç\0“è+é!ƒ¢©Xù·9jÓùºŒ+Àq\\†«§ÆK† çàÿ\0“ÅYñ¯ÆÏ…Þøƒcð«\\ñî›câNÜMa¤Ý\\,rÝ©gQåî#q&7À‡Ò²üg¯xcÀ›UñW‹ ·Ólcßy©ê·±Ä¨¥‰ß…UÉÛêsÎ3àâiòVäŠ=|Ä®XÊ-sjyßÄÿ\0xkÀz	×üY®Gc§¹†1q.NefP–Ï<x>•ñ‡Äßˆÿ\0ÿ\0lŠ:Ï…>éú3ü.ñn•¨ÚøcÅ–ò¬ºµ“;Ãu|²ü»`1ÊUpd_öšøûâÚÏö•ÖcëOiÞÑt_6âÆñí&»Ô5;ˆY£DžY‰‹º¬a‰á÷c¥}7ðÏEÖ-<?m/Ž<0§\\ÒôÁ§ÂQrmÚëQBŸ6C	>Xf\0ù-ÈÚ>Zè‚T\"œ·gÚG\nðxN_•íåÐ«aàü>Ð›Âü5e¢è±M+[éZm”Vöñ†‘ŸåŠ5œ³6\0±®o]U,@ãè1]¶¾0ŽPW­ƒ¸ƒPê¹·s’Sß©ÃxcÁ®:â¼¯Ç\n„ºA-Ö½WÄñ°ÜÅxÆz×•øá·3ÛºÖô\'gcÐ¡JÇàËÌÇ_Zõo	j+¹U@8ô9¯	ð–·Ž›3Ž£é^¤xÇIðö•>»âZ++L×W2¬qÛÆIfÏ<v©Ä:“åqŽý:žÆ/)igsÁÿ\0à¬ZOÆ_	x×À_´ÂŸ]X<Z=Ö‚`´fi­É‘ä–u\0å˜å@är\0¼ëþ	-ªü1Ó¿k]^óÆÞ/Ò¡Ñõ}´xôùÈk—×»`ŽÝa‰Q™œ•a´‚Iäƒ_Aþß0ðïÄ?ØYø‘ðÿ\0ÅO›Aq§j6@œDÒžüQî!C®7+ióÂÏþÏ±‡íðëÇ+Ñæ×´ÍJßGñAñ}Å«Ft”-\"ÎÁžM¬€!%\\¸FàWÙå…‹áú´yZ”[_†‡FïRžÎÇìß‡á²Ó¬-ôÍ:Æh-bXmí­cÙ Ú±Æ™;QT\0£<\0xßü#W´³ðWlõ¯Ë§i·þ:·‹QÑáB¿Û©RÜ-¤“©FHc.TüÊÃ\nõW·{xï,¯âky^)Ñ÷#¡”‡èFÞAî9¯•?à¤÷Þø™pš—†~#¦¡¨x/á¦¯âFÑ/EM@Ü[[[Ý¼ƒreZGP-œ…Rs_—ÆUkÙÿ\0Ã?3ÂË°Ó–;ÞÙ-Ï¢?aÛÏ‚¾‡Å?>®§¦jo‰ï5¯é:Þ‰ö;©^öwu•T|¯>Dps„Á¯¥ô«•QH\\*ƒŸÇ=ëÀ¿bÿ\0x£â/ìÅðßâŸÄ«t—ÅZß4ÙuVT®.Ñ¢$y#\';Ã	vö27\0ägÓ¯öH$cœ|»ÇN+lâëIÄó3Ry>·9ÛWÇšÿ\0ÃÙ»Xø™¢k&Ö/(¸ÕmÖÜ?Û-Ÿ÷F&=Da¤G`0Yc+œ1¯Yý˜5ý&÷à¿…ïôˆ´ÈáºÑ-åÙ¢Ú}žÑ‹.KEÄ\'$.8$¯ÍŸðR=^ÞËöFÕ|iq$æ?kz~§-¤ví4Wh’”hæH2GµÙ¶ôÊ) â·¿`ß:‰4KÂžÖ5ÝJÓþC:v¥©[Æ ·Š_-[O‡1¼GkùN¨ÛgR\0štÕðœëtg‰ÀJ¾RêGx»cAÂ®s>)økáÃ=gâ/‰íoîl´‹¹žÓJ´7…êãŒ½˜à$œgÛxŠM¥@N=óø×É¿ðRïÚ^Óm¾\0¦·¨húmÍíïŽ5›4asˆd`ÏhAö•‚	xŒ\\ØÈ­p˜Úõ\"<MWŽ8Ç}Ïý¥~üJø×ûAÞêgÃÝcV•ìÚÝ¾¿áÏ<ÒÚI¸ýží7uH£ŠE+ûAQ÷s\\U¯íwñïöø¨~Í_¼Aöaá½E¾¹ñ%Þ¶%ÕO]L/”.Y_Í¾[„…¢!m¼óÍv¿àªß³/ÃßøÏÁVñ‰gâmBî}ÒI”ZÚ«[˜VàÛãËOòZBÃŒã\'þ	qà|aø-âØè>ÓüI¡x¾Ýtï]D—ŸÚ’4¾\\á2£Ê‰ÝU€$;‡äÆô#NtèÊ¤‘ú„¡W„kA~êÊëùŸI~Ï?³=Ç‡-ü=ãßŽA|Eã¯xfÙx«UUyä³EWg\n\0*Ï+3~ðÈÉ’};Zž3 ÆÁÕ”¡Èêßí7Ö¾Oÿ\0‚²~Ôÿ\0´7ì›gáïˆß¾!øWIðü÷-èz½¬·Ž­t$s6Bü¢Ü#E¸†¼ö,ÿ\0‚Ìjß¾0éÿ\0h?èºž\"rºµc)ŠÞK†-íö0;Ì²f0á€Ê¼’+—û7[õ–ýÓËžK˜ã0¿_æJ§oCî-rÿ\0\nàÂ¸½ja¹›#¥lø‚þHÝãÀg®+Öõ<†*Ùí×½yÊ«I´®‘çÒ§}ŽÅWXFË•äþ6½ùˆë†æ»êé–O0çi$g·­y?umÌc,ry\n:âºpõ!/yHöp¸ynÏ¾ ~ß_\n¾êsøliº†·©Úªª­‰D·oûjKšÁ¹ÿ\0‚Øøÿ\0Áº¿†#ðe¯‡îÚÝå³½»¸kŸ2E(BþóÐôÈ\\c“_\nÅ4‹\'Ìîß­K™$>¢¿ !À¤âåQ}«þ‡3¼EjœÏCõŸöCø™û7ø“öxŸà&‘ñÏF¾“RÑZÎþ[¸ÕÓ|@\n6Ñ##¤åŽM~tx¿Á¶^	×5}OÖmï,à¼–ÖÒæx=ôhåÜdgóÁÆX_…ØAÛƒÌ€cŸLÖ¥­í£ë\n÷öo4[‘îbƒ‚Bƒ»ñé\\™w¬¦µiÂ|ÊZÙ«Æ\n´e&ßSöþãã5Ç‰?aŸø÷[“Ë»ñƒ4˜î¢ò<’\\[B^0¨T&æÊàr1_7|,ñÿ\0…?f?ŽZWÅ¿‰v°xcÀŒúMõÝ¼~aÔ&‡QKÔA;c„Ú†b»G#*Ø¯‘µ?Ûsö„ñ·ÂO|Ö<_åhþ°‚ÚÈY[d”D#9à”P\0¨Åp÷(×üG¥Üh¾µwuirYLws4‚c‚èŒÀ+ÄöÎ@ç5ñNÅS«Zu¹¯o5Ðôp¸({)ùŸ¾?³7Ã™¾	xûÁx„jV7^/ÕõM-ð!±±»½šâx@à\"¤ƒÆIÀÆ+Õ,õ‰AT`¥°»»×äÞ«ÿ\0wñ¯û?[ü(Ñþ_hþ!]\nÞÀø’QrbXÐÈ©´ï³•ÇÈIæ~ÿ\0‚ƒ~Õ¾²Ôô­âþÝf\\ÝK~òÆÇ\0˜‹\0#8Çò’áŒÒ¥Y9#Í‡×ÄU”–Ìý‘ý¡ï|[uðÅ6¾ñô»}1Ö_ÞBZ=>\0|øãT¨Ïâ¾ýÿ\0lŠ>)Úx³HðŸ>“âS:ø±-&HY® _š6.<æoœË†øÓöŸøåãmmÅ?µíFÖxØMoq¨3¬«#oÃ*pÙÏ#¶+—´ñn¾÷7SÝk7²	í#´¾Š)>Y\"R\"ª¨*	úW£†á¬Tpîv¹íà8}QÁÎW~g÷Xýòø{ûYü:½ð›êž?ñ¿†tÍWG·VñœÂM¡hÖB±’ÇÍùXdüå³Ï5ùyûwüzÔ¯þ+O¤ë¿íüM¥kVº…è×-/äY¤m[Ksä:µªÛ0I$`®s¸šù:O,-îß\näù£„f=Bÿ\0{ÍaÉuÀè£Èå¤÷®Ì·†~§Wžr¿ÈèÊøw–b~~o+XôïÃ^=ñÀMJÊæòÊ9ì;	ïÚ)¯Ñ˜¤‘	˜‡ÈP>¹ûSöøgû\\|ý¤uÙ›Â×x3ÂÚ¿‡îµËŸOjš´’<2[Ù:Í/ñE,ñácÛ½ÓçVùÒº¤–÷’][»/–Œ¡ ƒŽÄsší5?ÚËãæ¡ðïKøU{ñOZ“DÑø°±Šè«ƒ»ÌTó3½ö°;p}z˜ì®u©¸ÓŽŒêÍéÔÆSöIû¯SõÂßá†?hÿ\0xcÇ¿´üsëÚÅ¤¢þÃK×¯,¥‹D•“dÐGöxÑeFU/¹Žpj=-?c¿‡¾.Ó,<áß‡º.µf·\'E6–öÉ<°²ù2‘º2W ì`qÀÇZü[¼ø«ãµ¶Vþ7Õã†\'%ÛTš5VÎ	#wÊ~^}k˜Ô|a«Ï2\\M¨ÝÈðÈÅIÝ™3Ô#y«Ï¡Â9”©(:ÍGµ›–WËUòö?oü[ûM|\nÐuI´=[ã‡­®àMóAý ¿º_ï¹VÂŸa_%þÔðX„?n¦Ð~é¿ðœëŠä5ä³IŸC³o—è»÷¯ÍM[Ui™¤œù…†&,w9süUËêwÛƒÆ1þîå¾àáUJ´Ü—kXójÐ§†“¹ô‡?à¬µ÷Œ˜¶›âè,M+Ûiþ…‰ÁÂ’Óo!€èp+Çü{ûjþÓ¾#´¸·Õ?hv_9–oø•\\-¼Aý\nÆ«ÃŠòÝFç²{Ö\\Že$ŸZý+Ã™V’’_%úž&#Yib#–>o¥KisåµEÎ#òŠsô¦Jú.UÔóbùMËKïÝƒ×šÐ‹Pòå&?âNk›‚ä©Û“Çj¶/üµÉ=kž¥ó6–ç¥ƒÅ8³³Ò58˜™›€:{ŠÛ¶¿24R‹ƒƒë\\^}„PÎëN×R\"`òÃÐðq[Îï¦‡Ôaó¤C´ÖQ:.29«ÑjÁ“9ü«‹¶ÖÀÀ…_µÖ@™³^%l¾‡³‡Å®ç_m¨£üÐõ x†(3$}ãšç-µ´8úõª·Â¼àdôƒÁ&îÎÈbÚÓ˜énoÌWkòä“Ò’=D-Ë*_5@Þ;W45BäÉ¿ï.M:-Gd`I\'¸=ê–%deˆ¾ÇE>ª\"amÅ>\\ÕK_÷˜Ýß­e^j¶†$•\',ùùÔVuÆ°¬}ØÂœNž]NJµ¤–æö§ó’fíëX·ú ÝÖªÝêê!ØO\'œÖF¡©<‡ ¯c†qÑ3³&¿Ôò_5‰|1œÓ.ïˆ’MeÝ]™\'îPÃ¨«Ÿ/‹Æ6ÂòóÌ|gš„F_æçšccqÈïMivŒÕèÆ6Z\\¦¤HÆ0H\n–=sëC1qi@æ´åds!»É<>±©ãnß0çµÂÁv¯\\õ¦°ÁçÚ‰E4(ÉÇc^ðQNãZ6šžÉGÎGk›óJ(Ç5b@+Û–õ®j´G]\\¡+3­·Õ‰þ2yõ«öš¸SËŸÎ¹;;Ü¹Ü¼cûØ«‘j?òÑN¼æ¼ùá\"ÙíSÆJ6:í°j¹÷¥]b)f»‘ë\\»ê­Ëô#¥\"_•„¾ó’}k5‚G\\qí½Î¥õx”à>@ñI¸¥”	Ãôë\\Ïöžå^võ¦‹Ý¨$fÎJ_Sìt,ÅÅ8×n-6Ï,1…œ0bT3c=FzVuÞ°—*³`‚Bí¿Óõ¬)õ\'#!˜c8ÉéL¹¾†8#¹‚äo*A@Ï­iR1­™sSeë½`ƒµ¥cØe«>âüõ2¾µŸs|Îß7\\Ó$‘ÉÁc^…<<\"šÄb¦å¹=Õç™Àcø¬Ìò\0±ÜWIç$õÍ:;w—\0GÞ«V÷°ÛÄ4\07¡è+_v*Æ4©ºÚÉ‘Þi²ÚÜ½¬²æXÛ´ü«íïM—M›,Ñ0xüÀo\0þ§’Ò}Bá%U;.‚½;Ô“ÄöÓ9“…ã•=3På%±ÛõhJ6HÿÙ","6748_thumb-6.jpg","image/jpeg","/../ximages/item/34","4800",Null,Null);






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
INSERT INTO item_price_tier VALUES("16","41","1","4.0000");






-- -------------------------------------------
-- TABLE DATA item_sub_unit
-- -------------------------------------------






-- -------------------------------------------
-- TABLE DATA item_unit
-- -------------------------------------------
INSERT INTO item_unit VALUES("1","áž”áž“áŸ’áž‘áŸ‡");
INSERT INTO item_unit VALUES("2","áž”áŸ’ážšáž¢áž”áŸ‹");
INSERT INTO item_unit VALUES("3","ážŠáž”");
INSERT INTO item_unit VALUES("4","áž€áŸ†áž”áž»áž„");






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
INSERT INTO receiving VALUES("30","2014-11-08 17:20:20","7","38","4.6000",Null,"Receive from Supplier",Null,Null,Null);
INSERT INTO receiving VALUES("31","2014-11-08 17:28:39","2","38","7.7000",Null,"Receive from Supplier",Null,Null,Null);
INSERT INTO receiving VALUES("32","2014-11-08 17:30:32","2","38","5.1000",Null,"Receive from Supplier",Null,Null,Null);
INSERT INTO receiving VALUES("33","2014-11-08 17:53:13","2","38","5.4000",Null,"Return to Supplier",Null,Null,Null);
INSERT INTO receiving VALUES("34","2014-11-10 19:44:59","1","38","402.0000",Null,"Receive from Supplier",Null,Null,Null);






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
INSERT INTO receiving_item VALUES("30","13",Null,"13","1.00","3.2000","5.5000","5.5000","0.00","%");
INSERT INTO receiving_item VALUES("30","14",Null,"14","1.00","1.4000","2.2000","2.2000","0.00","%");
INSERT INTO receiving_item VALUES("31","7",Null,"7","1.00","4.5000","5.5000","5.5000","0.00","%");
INSERT INTO receiving_item VALUES("31","58",Null,"58","1.00","3.2000","3.8000","3.8000","0.00","%");
INSERT INTO receiving_item VALUES("32","29",Null,"29","1.00","1.8000","2.7000","2.7000","0.00","%");
INSERT INTO receiving_item VALUES("32","65",Null,"65","1.00","3.3000","5.5000","5.5000","0.00","%");
INSERT INTO receiving_item VALUES("33","58",Null,"58","1.00","3.2000","3.8000","3.8000","0.00","%");
INSERT INTO receiving_item VALUES("33","63",Null,"63","1.00","2.2000","3.5000","3.5000","0.00","%");
INSERT INTO receiving_item VALUES("34","5",Null,"5","50.00","2.0000","4.5000","4.5000","0.00","%");
INSERT INTO receiving_item VALUES("34","41",Null,"41","10.00","2.5000","3.5000","3.5000","0.00","%");
INSERT INTO receiving_item VALUES("34","48",Null,"48","20.00","2.5000","3.5000","3.5000","0.00","%");
INSERT INTO receiving_item VALUES("34","58",Null,"58","40.00","3.2000","3.8000","3.8000","0.00","%");
INSERT INTO receiving_item VALUES("34","65",Null,"65","30.00","3.3000","5.5000","5.5000","0.00","%");






-- -------------------------------------------
-- TABLE DATA sale
-- -------------------------------------------
INSERT INTO sale VALUES("1","2014-11-11 02:56:29","1","38","42.2000","Cash: 10<br />","1",Null,"0.00","%");






-- -------------------------------------------
-- TABLE DATA sale_client_cookie
-- -------------------------------------------






-- -------------------------------------------
-- TABLE DATA sale_item
-- -------------------------------------------
INSERT INTO sale_item VALUES("1","41",Null,"41","1.00","2.5000","3.5000","3.5000","0.00","%");
INSERT INTO sale_item VALUES("1","48",Null,"48","2.00","2.5000","3.5000","3.5000","0.00","%");
INSERT INTO sale_item VALUES("1","58",Null,"58","4.00","3.2000","3.8000","3.8000","0.00","%");
INSERT INTO sale_item VALUES("1","65",Null,"65","3.00","3.3000","5.5000","5.5000","0.00","%");






-- -------------------------------------------
-- TABLE DATA sale_payment
-- -------------------------------------------
INSERT INTO sale_payment VALUES("1","1","Cash","10",Null,"2014-11-11 02:56:29",Null,"2014-11-10 19:56:29");






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
INSERT INTO settings VALUES("36","site","currencySymbol","s:1:\"$\";");
INSERT INTO settings VALUES("37","site","email","s:14:\"yoyo@gmail.com\";");
INSERT INTO settings VALUES("38","site","returnPolicy","s:93:\"áž‘áŸ†áž“áž·áž‰ážŠáŸ‚áž›áž‘áž·áž‰áž áž¾áž™áž˜áž·áž“áž¢áž¶áž…ážŠáž¼ážšážœáž·áž‰áž”áž¶áž“áž‘áŸ\";");
INSERT INTO settings VALUES("39","system","language","s:2:\"en\";");
INSERT INTO settings VALUES("40","system","decimalPlace","s:1:\"2\";");
INSERT INTO settings VALUES("41","sale","saleCookie","s:1:\"0\";");
INSERT INTO settings VALUES("42","sale","receiptPrint","s:1:\"1\";");
INSERT INTO settings VALUES("43","sale","receiptPrintDraftSale","s:0:\"\";");
INSERT INTO settings VALUES("44","sale","touchScreen","s:0:\"\";");
INSERT INTO settings VALUES("45","sale","discount","s:6:\"hidden\";");
INSERT INTO settings VALUES("46","receipt","printcompanyLogo","s:1:\"1\";");
INSERT INTO settings VALUES("47","receipt","printcompanyName","s:1:\"1\";");
INSERT INTO settings VALUES("48","receipt","printcompanyAddress","s:1:\"1\";");
INSERT INTO settings VALUES("49","receipt","printcompanyPhone","s:1:\"1\";");
INSERT INTO settings VALUES("50","receipt","printtransactionTime","s:0:\"\";");
INSERT INTO settings VALUES("51","receipt","printSignature","s:0:\"\";");
INSERT INTO settings VALUES("52","site","companyAddress1","s:20:\"Phnom Penh, Cambodia\";");
INSERT INTO settings VALUES("53","receipt","printcompanyAddress1","s:1:\"1\";");
INSERT INTO settings VALUES("54","item","itemNumberPerPage","s:2:\"20\";");
INSERT INTO settings VALUES("55","item","itemExpireDate","s:1:\"1\";");
INSERT INTO settings VALUES("56","sale","disableConfirmation","s:1:\"1\";");






-- -------------------------------------------
-- TABLE DATA supplier
-- -------------------------------------------
INSERT INTO supplier VALUES("1","ABC","Kbal","Koo","012877877",Null,Null,Null,Null,Null,Null,"1");






-- -------------------------------------------
-- TABLE DATA tbl_audit_logs
-- -------------------------------------------
INSERT INTO tbl_audit_logs VALUES("Guest","203.144.91.4","2014-06-11 05:43:08","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 05:43:41","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 05:52:17","saleItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 05:52:27","priceTier","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 05:52:32","saleItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 05:52:53","item","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 05:52:56","item","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 05:52:58","item","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 05:53:00","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 05:53:03","saleItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 05:53:03","saleItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","203.144.91.4","2014-06-11 05:53:34","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","72.223.39.64","2014-06-11 06:04:39","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","72.223.39.64","2014-06-11 06:05:09","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","72.223.39.64","2014-06-11 06:05:14","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-11 06:05:30","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-11 06:05:38","item","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-11 06:06:06","receivingItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-11 06:06:15","item","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-11 06:06:22","item","UpdateImage",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-11 06:06:28","client","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-11 06:06:31","site","error",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-11 06:06:36","report","SaleInvoice",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-11 06:06:41","site","error",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-11 06:06:45","client","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-11 06:06:50","settings","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-11 06:09:23","settings","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-11 06:09:52","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-11 06:11:21","item","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-11 06:11:28","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-11 06:14:32","site","about",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-11 06:14:54","employee","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-11 06:15:04","supplier","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","72.223.39.64","2014-06-11 06:15:09","report","SaleInvoice",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","72.223.39.64","2014-06-11 06:15:39","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","203.144.91.4","2014-06-11 07:01:54","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 07:02:02","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 07:02:05","item","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 07:02:08","site","about",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 07:02:12","employee","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 07:02:13","supplier","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 07:02:15","settings","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 07:02:16","priceTier","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 07:02:19","saleItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 07:02:21","sale","Invoice",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 07:02:23","receivingItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 07:02:25","receivingItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 07:02:26","client","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-11 07:02:29","receivingItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","203.144.91.4","2014-06-11 07:02:32","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","148.167.2.30","2014-06-11 10:40:54","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 10:41:31","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 10:42:05","client","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 10:42:06","site","error",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 10:42:07","report","SaleInvoice",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 10:42:09","settings","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 10:42:14","settings","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 10:42:16","client","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 10:42:17","site","error",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 10:42:17","report","SaleInvoice",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 10:42:28","settings","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 10:42:33","site","about",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 10:42:37","report","SaleItemSummary",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 10:42:38","site","error",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 10:42:47","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","148.167.2.30","2014-06-11 10:43:11","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","148.167.2.30","2014-06-11 10:43:24","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 10:45:40","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 10:45:45","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 10:45:46","item","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 10:45:50","site","error",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 10:45:54","site","error",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 10:46:05","client","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 10:46:11","client","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 10:46:16","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 10:46:52","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","148.167.2.30","2014-06-11 10:46:55","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","148.167.2.30","2014-06-11 10:52:06","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 10:52:13","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 10:52:17","sale","Invoice",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 10:52:27","receivingItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 10:52:30","client","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-11 10:52:31","item","admin",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","148.167.2.30","2014-06-11 10:52:37","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","203.144.68.145","2014-06-11 18:06:35","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.68.145","2014-06-11 18:06:44","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","203.144.68.145","2014-06-11 18:07:46","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","203.144.91.4","2014-06-11 21:00:06","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","42.115.40.103","2014-06-11 21:00:19","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","42.115.39.160","2014-06-11 23:38:46","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","124.248.166.17","2014-06-12 01:58:42","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","124.248.166.17","2014-06-12 01:58:53","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","124.248.166.17","2014-06-12 01:59:01","report","Inventory",Null);
INSERT INTO tbl_audit_logs VALUES("super","124.248.166.17","2014-06-12 02:00:42","sale","Invoice",Null);
INSERT INTO tbl_audit_logs VALUES("super","124.248.166.17","2014-06-12 02:00:48","site","error",Null);
INSERT INTO tbl_audit_logs VALUES("super","124.248.166.17","2014-06-12 02:00:49","site","error",Null);
INSERT INTO tbl_audit_logs VALUES("super","124.248.166.17","2014-06-12 02:01:03","site","error",Null);
INSERT INTO tbl_audit_logs VALUES("super","124.248.166.17","2014-06-12 02:01:07","report","Inventory",Null);
INSERT INTO tbl_audit_logs VALUES("super","124.248.166.17","2014-06-12 02:07:32","saleItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","124.248.166.17","2014-06-12 02:08:01","saleItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","124.248.166.17","2014-06-12 02:23:51","saleItem","Complete",Null);
INSERT INTO tbl_audit_logs VALUES("super","124.248.166.17","2014-06-12 02:26:50","saleItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","124.248.166.17","2014-06-12 02:28:08","saleItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","203.144.91.4","2014-06-12 06:21:33","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-12 06:21:51","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-12 06:21:56","saleItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-12 06:38:32","receivingItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-12 06:39:05","receivingItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","148.167.2.30","2014-06-12 09:29:15","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 09:29:34","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 09:29:44","client","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 09:29:44","item","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 09:29:46","sale","Invoice",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 09:29:47","site","about",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 09:29:50","saleItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 09:29:51","saleItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 09:29:52","sale","Invoice",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 09:29:52","client","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 09:29:54","item","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 09:29:54","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 09:30:07","settings","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 09:30:08","client","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 09:30:09","site","error",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 09:30:10","report","SaleInvoice",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 09:38:51","settings","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 09:38:52","client","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 09:38:52","report","SaleInvoice",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 09:38:54","client","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 09:38:58","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","148.167.2.30","2014-06-12 09:40:35","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","148.167.2.30","2014-06-12 10:38:22","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 10:38:47","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 10:39:04","item","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 10:39:04","client","admin",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 10:39:16","receivingItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 10:39:19","receivingItem","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 10:39:23","sale","Invoice",Null);
INSERT INTO tbl_audit_logs VALUES("super","148.167.2.30","2014-06-12 10:39:33","settings","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","208.80.194.127","2014-06-13 17:46:44","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","203.144.91.4","2014-06-14 01:49:53","site","index",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-14 01:49:59","dashboard","view",Null);
INSERT INTO tbl_audit_logs VALUES("super","203.144.91.4","2014-06-14 01:50:05","report","itemExpiry",Null);
INSERT INTO tbl_audit_logs VALUES("Guest","203.144.91.4","2014-06-14 01:50:25","site","index",Null);






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
