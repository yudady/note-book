drop user myPayDev cascade;

create user myPayDev identified by myPay4Zv;

GRANT ALL privileges TO myPayDev;

GRANT sysdba TO myPayDev;

GRANT dba TO myPayDev;