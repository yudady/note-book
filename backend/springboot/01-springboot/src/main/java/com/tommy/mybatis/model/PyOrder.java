package com.tommy.mybatis.model;

import java.math.BigDecimal;
import java.util.Date;

public class PyOrder {
    private Long orderNo;

    private Integer pageId;

    private Object pageName;

    private Integer merchantId;

    private Object merchantName;

    private String paymentOrderNo;

    private BigDecimal rechargeAmount;

    private Date paymentDate;

    private Date paymentNotifyDate;

    private String status;

    private Integer lockUserId;

    private Object lockUserName;

    private Date lockTime;

    private String clientAccount;

    private String clientTerminal;

    private String clientIp;

    private Object remark;

    private Date createDate;

    private Date updateDate;

    private Integer updateUserId;

    private String updateUserName;

    private Date submitDate;

    private Object responseData;

    private Object responseCode;

    private Object responseDesc;

    private Object responseQrcode;

    private Integer paymentPlatformId;

    private Object paymentPlatformName;

    private Integer paymentMethodId;

    private Object paymentMethodName;

    private String robotProcessStatus;

    private BigDecimal depositOffer;

    private BigDecimal redEnvelopesOffer;

    private BigDecimal totalAmount;

    private BigDecimal callbackAmount;

    private BigDecimal feeOffer;

    private String rechargeCenterTypeId;

    private Object rechargeCenterTypeName;

    public Long getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(Long orderNo) {
        this.orderNo = orderNo;
    }

    public Integer getPageId() {
        return pageId;
    }

    public void setPageId(Integer pageId) {
        this.pageId = pageId;
    }

    public Object getPageName() {
        return pageName;
    }

    public void setPageName(Object pageName) {
        this.pageName = pageName;
    }

    public Integer getMerchantId() {
        return merchantId;
    }

    public void setMerchantId(Integer merchantId) {
        this.merchantId = merchantId;
    }

    public Object getMerchantName() {
        return merchantName;
    }

    public void setMerchantName(Object merchantName) {
        this.merchantName = merchantName;
    }

    public String getPaymentOrderNo() {
        return paymentOrderNo;
    }

    public void setPaymentOrderNo(String paymentOrderNo) {
        this.paymentOrderNo = paymentOrderNo == null ? null : paymentOrderNo.trim();
    }

    public BigDecimal getRechargeAmount() {
        return rechargeAmount;
    }

    public void setRechargeAmount(BigDecimal rechargeAmount) {
        this.rechargeAmount = rechargeAmount;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public Date getPaymentNotifyDate() {
        return paymentNotifyDate;
    }

    public void setPaymentNotifyDate(Date paymentNotifyDate) {
        this.paymentNotifyDate = paymentNotifyDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public Integer getLockUserId() {
        return lockUserId;
    }

    public void setLockUserId(Integer lockUserId) {
        this.lockUserId = lockUserId;
    }

    public Object getLockUserName() {
        return lockUserName;
    }

    public void setLockUserName(Object lockUserName) {
        this.lockUserName = lockUserName;
    }

    public Date getLockTime() {
        return lockTime;
    }

    public void setLockTime(Date lockTime) {
        this.lockTime = lockTime;
    }

    public String getClientAccount() {
        return clientAccount;
    }

    public void setClientAccount(String clientAccount) {
        this.clientAccount = clientAccount == null ? null : clientAccount.trim();
    }

    public String getClientTerminal() {
        return clientTerminal;
    }

    public void setClientTerminal(String clientTerminal) {
        this.clientTerminal = clientTerminal == null ? null : clientTerminal.trim();
    }

    public String getClientIp() {
        return clientIp;
    }

    public void setClientIp(String clientIp) {
        this.clientIp = clientIp == null ? null : clientIp.trim();
    }

    public Object getRemark() {
        return remark;
    }

    public void setRemark(Object remark) {
        this.remark = remark;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public Integer getUpdateUserId() {
        return updateUserId;
    }

    public void setUpdateUserId(Integer updateUserId) {
        this.updateUserId = updateUserId;
    }

    public String getUpdateUserName() {
        return updateUserName;
    }

    public void setUpdateUserName(String updateUserName) {
        this.updateUserName = updateUserName == null ? null : updateUserName.trim();
    }

    public Date getSubmitDate() {
        return submitDate;
    }

    public void setSubmitDate(Date submitDate) {
        this.submitDate = submitDate;
    }

    public Object getResponseData() {
        return responseData;
    }

    public void setResponseData(Object responseData) {
        this.responseData = responseData;
    }

    public Object getResponseCode() {
        return responseCode;
    }

    public void setResponseCode(Object responseCode) {
        this.responseCode = responseCode;
    }

    public Object getResponseDesc() {
        return responseDesc;
    }

    public void setResponseDesc(Object responseDesc) {
        this.responseDesc = responseDesc;
    }

    public Object getResponseQrcode() {
        return responseQrcode;
    }

    public void setResponseQrcode(Object responseQrcode) {
        this.responseQrcode = responseQrcode;
    }

    public Integer getPaymentPlatformId() {
        return paymentPlatformId;
    }

    public void setPaymentPlatformId(Integer paymentPlatformId) {
        this.paymentPlatformId = paymentPlatformId;
    }

    public Object getPaymentPlatformName() {
        return paymentPlatformName;
    }

    public void setPaymentPlatformName(Object paymentPlatformName) {
        this.paymentPlatformName = paymentPlatformName;
    }

    public Integer getPaymentMethodId() {
        return paymentMethodId;
    }

    public void setPaymentMethodId(Integer paymentMethodId) {
        this.paymentMethodId = paymentMethodId;
    }

    public Object getPaymentMethodName() {
        return paymentMethodName;
    }

    public void setPaymentMethodName(Object paymentMethodName) {
        this.paymentMethodName = paymentMethodName;
    }

    public String getRobotProcessStatus() {
        return robotProcessStatus;
    }

    public void setRobotProcessStatus(String robotProcessStatus) {
        this.robotProcessStatus = robotProcessStatus == null ? null : robotProcessStatus.trim();
    }

    public BigDecimal getDepositOffer() {
        return depositOffer;
    }

    public void setDepositOffer(BigDecimal depositOffer) {
        this.depositOffer = depositOffer;
    }

    public BigDecimal getRedEnvelopesOffer() {
        return redEnvelopesOffer;
    }

    public void setRedEnvelopesOffer(BigDecimal redEnvelopesOffer) {
        this.redEnvelopesOffer = redEnvelopesOffer;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public BigDecimal getCallbackAmount() {
        return callbackAmount;
    }

    public void setCallbackAmount(BigDecimal callbackAmount) {
        this.callbackAmount = callbackAmount;
    }

    public BigDecimal getFeeOffer() {
        return feeOffer;
    }

    public void setFeeOffer(BigDecimal feeOffer) {
        this.feeOffer = feeOffer;
    }

    public String getRechargeCenterTypeId() {
        return rechargeCenterTypeId;
    }

    public void setRechargeCenterTypeId(String rechargeCenterTypeId) {
        this.rechargeCenterTypeId = rechargeCenterTypeId == null ? null : rechargeCenterTypeId.trim();
    }

    public Object getRechargeCenterTypeName() {
        return rechargeCenterTypeName;
    }

    public void setRechargeCenterTypeName(Object rechargeCenterTypeName) {
        this.rechargeCenterTypeName = rechargeCenterTypeName;
    }
}