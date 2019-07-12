SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";
CREATE DATABASE IF NOT EXISTS `BOS-Map` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `BOS-Map`;

CREATE TABLE `Funkbereiche` (
                                `ID` varchar(64) NOT NULL,
                                `P_ID` varchar(64) DEFAULT NULL,
                                `Organisation` varchar(64) NOT NULL,
                                `Frequenz` int(10) UNSIGNED DEFAULT NULL,
                                `Crypto` varchar(128) NOT NULL,
                                `Baud` int(6) UNSIGNED DEFAULT NULL,
                                `borderColor` varchar(32) DEFAULT NULL,
                                `backgroundColor` varchar(32) DEFAULT NULL,
                                `textColor` int(32) DEFAULT NULL,
                                `Name` varchar(256) NOT NULL,
                                `angelegt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                `aktualisiert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
DELIMITER $$
CREATE TRIGGER `F_UID` BEFORE INSERT ON `Funkbereiche` FOR EACH ROW SET NEW.ID = UUID()
$$
DELIMITER ;

CREATE TABLE `Points` (
                          `ID` varchar(32) NOT NULL,
                          `geometry` polygon NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


ALTER TABLE `Funkbereiche`
    ADD PRIMARY KEY (`ID`);

ALTER TABLE `Points`
    ADD PRIMARY KEY (`ID`);
COMMIT;