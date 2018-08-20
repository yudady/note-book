
echo "*********rd3" >> M201808160090001978.log
echo "*********rd3" >> M201808160090001978.log
echo "*********rd3" >> M201808160090001978.log
grep -n M201808160090001978 /mnt/nfs/var/rd3/mypaycenter.log >> M201808160090001978.log
echo "*********rd3-1" >> M201808160090001978.log
echo "*********rd3-1" >> M201808160090001978.log
echo "*********rd3-1" >> M201808160090001978.log
grep -n M201808160090001978 /mnt/nfs/var/rd3-1/mypaycenter.log >> M201808160090001978.log
echo "*********rd3-2" >> M201808160090001978.log
echo "*********rd3-2" >> M201808160090001978.log
echo "*********rd3-2" >> M201808160090001978.log
grep -n M201808160090001978 /mnt/nfs/var/rd3-2/mypaycenter.log >> M201808160090001978.log

------------------------------

cat /mnt/nfs/var/rd3-1/mypaycenter.log | head -n 1002599 | tail -n 3000 > M201808160090001978.new.log





M201808160090001978 -- 已支付-未通知 ➞ 已支付-未通知 --  -- 2018-08-16T15:24:17.532



select * from PY_MYPAY_ORDER_LOG where status = '已支付-未通知 ➞ 已支付-未通知' 
and order_no like 'M20180816%'
order by order_no desc;