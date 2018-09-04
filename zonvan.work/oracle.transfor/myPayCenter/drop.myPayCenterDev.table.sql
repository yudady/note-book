drop user myPayCenterDev cascade;

create user myPayCenterDev identified by myPay4Zv;

GRANT ALL privileges TO myPayCenterDev;

GRANT sysdba TO myPayCenterDev;

GRANT dba TO myPayCenterDev;