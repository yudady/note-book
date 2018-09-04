sqlplus sys/Oracle123@o11g as sysdba << EOF 

drop user myPayDev cascade;

create user myPayDev identified by myPay4Zv;

GRANT ALL privileges TO myPayDev;

GRANT sysdba TO myPayDev;

GRANT dba TO myPayDev;

exit;
EOF