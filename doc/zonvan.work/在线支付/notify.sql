-- PY_MYPAY_MERCHANT
SELECT t.*,t.ROWID FROM mypaycenter.PY_MYPAY_MERCHANT t  
/
SELECT t.*,t.ROWID FROM mypay.PY_MYPAY_MERCHANT t  
/
-- order
SELECT t.*,t.ROWID FROM mypaycenter.py_mypay_order t where order_no = '&order'
/
SELECT t.*,t.ROWID FROM mypay.py_mypay_order t where order_no = '&order'
/
SELECT t.*,t.ROWID FROM mypaycenter.PY_NOTIFY_FAIL_ORDER t  where order_no = '&order'
/


SELECT t.*,t.ROWID FROM mypaycenter.py_not_yet_notify_order t  where order_no = '&order'
/
SELECT t.*,t.ROWID FROM mypay.py_mypay_order_log t where order_no = '&order'
/


-- delete from mypaycenter.py_not_yet_notify_order t  where order_no = &order  ;   
--mypay
-- Truncate Table mypay.PY_MYPAY_ORDER;
-- Truncate Table mypay.PY_MYPAY_ORDER_LOG;

--myPayCenter
-- Truncate Table myPayCenter.PY_MYPAY_ORDER;
-- Truncate Table myPayCenter.PY_NOT_YET_NOTIFY_ORDER;


-- delete from mypaycenter.py_mypay_order where CLIENT_ACCOUNT = 'tommy';
-- delete from mypay.py_mypay_order where CLIENT_ACCOUNT = 'tommy';
-- delete from mypaycenter.py_not_yet_notify_order;
-- delete from mypaycenter.PY_NOTIFY_FAIL_ORDER;
