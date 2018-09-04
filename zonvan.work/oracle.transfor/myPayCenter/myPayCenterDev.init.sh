sqlplus myPayDev/myPay4Zv@o11g << EOF 

-- UPDATE PY_MERCHANT SET SUBMIT_URL = 'http://zonvan.yudady.dynu.net';
-- UPDATE PY_SYSTEM_CONFIG SET VALUE = 'zonvan.yudady.dynu.net' WHERE TYPE = 'SYSTEM' AND KEY = 'WEB_SITE_IP';
-- UPDATE PY_SYSTEM_CONFIG SET VALUE = 'zonvan.yudady.dynu.net' WHERE TYPE = 'SYSTEM' AND KEY = 'SUBMIT_ORDER_IP';

-- UPDATE PY_SYSTEM_CONFIG SET VALUE = 'myPay' WHERE TYPE = 'SYSTEM' AND KEY = 'SUBMIT_ORDER_CONTEXT';
-- UPDATE PY_SYSTEM_CONFIG SET VALUE = 'myPay' WHERE TYPE = 'SYSTEM' AND KEY = 'WEB_SITE_CONTEXT';
select sysdate from dual;


commit;

exit;
EOF
