--
-- The Kuali Financial System, a comprehensive financial management system for higher education.
-- 
-- Copyright 2005-2014 The Kuali Foundation
-- 
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU Affero General Public License as
-- published by the Free Software Foundation, either version 3 of the
-- License, or (at your option) any later version.
-- 
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Affero General Public License for more details.
-- 
-- You should have received a copy of the GNU Affero General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
--

ALTER TABLE KRNS_SESN_DOC_T ADD (OBJ_ID VARCHAR(36));
ALTER TABLE KRNS_SESN_DOC_T ADD (VER_NBR DECIMAL(8) DEFAULT 0);
ALTER TABLE KRSB_MSG_QUE_T CHANGE SVC_NMSPC APPL_ID VARCHAR(255) NOT NULL;
ALTER TABLE KRNS_DOC_HDR_T MODIFY FDOC_DESC varchar(255);
ALTER TABLE KRNS_ATT_T MODIFY MIME_TYP VARCHAR(255);
ALTER TABLE KRNS_MAINT_DOC_ATT_T MODIFY CNTNT_TYP VARCHAR(255);
RENAME TABLE KRNS_MAINT_LOCK_T TO KRNS_MAINT_LOCK_T_BKUP;
ALTER TABLE KRNS_MAINT_LOCK_T_BKUP DROP PRIMARY KEY;
ALTER TABLE KRNS_MAINT_LOCK_T_BKUP DROP INDEX KRNS_MAINT_LOCK_TC1;
ALTER TABLE KRNS_MAINT_LOCK_T_BKUP DROP INDEX KRNS_MAINT_LOCK_TI2;
CREATE TABLE KRNS_MAINT_LOCK_T  ( 
	MAINT_LOCK_REP_TXT	varchar(500) NOT NULL,
	OBJ_ID            	varchar(36) NOT NULL,
	VER_NBR           	decimal(8,0) NOT NULL DEFAULT '1',
	DOC_HDR_ID        	varchar(14) NOT NULL,
	MAINT_LOCK_ID     	varchar(14),
	PRIMARY KEY(MAINT_LOCK_ID)
);

ALTER TABLE KRNS_MAINT_LOCK_T ADD CONSTRAINT KRNS_MAINT_LOCK_TC0 UNIQUE (OBJ_ID);

CREATE INDEX KRNS_MAINT_LOCK_TI2 ON KRNS_MAINT_LOCK_T(DOC_HDR_ID);

INSERT INTO KRNS_MAINT_LOCK_T(MAINT_LOCK_ID, OBJ_ID, VER_NBR, DOC_HDR_ID, MAINT_LOCK_REP_TXT) 
    (SELECT MAINT_LOCK_ID, OBJ_ID, VER_NBR, DOC_HDR_ID, MAINT_LOCK_REP_TXT 
        FROM KRNS_MAINT_LOCK_T_BKUP);
COMMIT;

