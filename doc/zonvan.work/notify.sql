
SELECT t.*,t.ROWID FROM PY_MYPAY_MERCHANT t  
/
-- mypaycenter
SELECT t.*,t.ROWID FROM mypaycenter.py_mypay_order t where order_no = '&order'
/
SELECT t.*,t.ROWID FROM mypaycenter.py_not_yet_notify_order t  where order_no = '&order'
/
-- mypay
SELECT t.*,t.ROWID FROM mypay.py_mypay_order t where order_no = '&order'
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



