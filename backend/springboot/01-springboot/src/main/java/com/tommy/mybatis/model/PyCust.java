package com.tommy.mybatis.model;

import java.util.Date;

public class PyCust {
    private String id;

    private Object name;

    private Object descr;

    private String email;

    private String apiAddr;

    private String authCode;

    private String status;

    private String dbName;

    private String dbUser;

    private String dbPwd;

    private String dbHost;

    private Date updateDate;

    private Date createDate;

    private String enableDate;

    private String disableDate;

    private String robotQuantity;

    private String isIgnorePlatformCallback;

    private String isActivateGoogleVerify;

    private String secretKey;

    private Short validationCodeTimeOffset;

    private String isOneAccountOneSession;

    private String isOrderVerifyUnpaid;

    private String isOrderVerifyWaitConfirm;

    private String isOrderVerifyChangeName;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public Object getName() {
        return name;
    }

    public void setName(Object name) {
        this.name = name;
    }

    public Object getDescr() {
        return descr;
    }

    public void setDescr(Object descr) {
        this.descr = descr;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public String getApiAddr() {
        return apiAddr;
    }

    public void setApiAddr(String apiAddr) {
        this.apiAddr = apiAddr == null ? null : apiAddr.trim();
    }

    public String getAuthCode() {
        return authCode;
    }

    public void setAuthCode(String authCode) {
        this.authCode = authCode == null ? null : authCode.trim();
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public String getDbName() {
        return dbName;
    }

    public void setDbName(String dbName) {
        this.dbName = dbName == null ? null : dbName.trim();
    }

    public String getDbUser() {
        return dbUser;
    }

    public void setDbUser(String dbUser) {
        this.dbUser = dbUser == null ? null : dbUser.trim();
    }

    public String getDbPwd() {
        return dbPwd;
    }

    public void setDbPwd(String dbPwd) {
        this.dbPwd = dbPwd == null ? null : dbPwd.trim();
    }

    public String getDbHost() {
        return dbHost;
    }

    public void setDbHost(String dbHost) {
        this.dbHost = dbHost == null ? null : dbHost.trim();
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getEnableDate() {
        return enableDate;
    }

    public void setEnableDate(String enableDate) {
        this.enableDate = enableDate == null ? null : enableDate.trim();
    }

    public String getDisableDate() {
        return disableDate;
    }

    public void setDisableDate(String disableDate) {
        this.disableDate = disableDate == null ? null : disableDate.trim();
    }

    public String getRobotQuantity() {
        return robotQuantity;
    }

    public void setRobotQuantity(String robotQuantity) {
        this.robotQuantity = robotQuantity == null ? null : robotQuantity.trim();
    }

    public String getIsIgnorePlatformCallback() {
        return isIgnorePlatformCallback;
    }

    public void setIsIgnorePlatformCallback(String isIgnorePlatformCallback) {
        this.isIgnorePlatformCallback = isIgnorePlatformCallback == null ? null : isIgnorePlatformCallback.trim();
    }

    public String getIsActivateGoogleVerify() {
        return isActivateGoogleVerify;
    }

    public void setIsActivateGoogleVerify(String isActivateGoogleVerify) {
        this.isActivateGoogleVerify = isActivateGoogleVerify == null ? null : isActivateGoogleVerify.trim();
    }

    public String getSecretKey() {
        return secretKey;
    }

    public void setSecretKey(String secretKey) {
        this.secretKey = secretKey == null ? null : secretKey.trim();
    }

    public Short getValidationCodeTimeOffset() {
        return validationCodeTimeOffset;
    }

    public void setValidationCodeTimeOffset(Short validationCodeTimeOffset) {
        this.validationCodeTimeOffset = validationCodeTimeOffset;
    }

    public String getIsOneAccountOneSession() {
        return isOneAccountOneSession;
    }

    public void setIsOneAccountOneSession(String isOneAccountOneSession) {
        this.isOneAccountOneSession = isOneAccountOneSession == null ? null : isOneAccountOneSession.trim();
    }

    public String getIsOrderVerifyUnpaid() {
        return isOrderVerifyUnpaid;
    }

    public void setIsOrderVerifyUnpaid(String isOrderVerifyUnpaid) {
        this.isOrderVerifyUnpaid = isOrderVerifyUnpaid == null ? null : isOrderVerifyUnpaid.trim();
    }

    public String getIsOrderVerifyWaitConfirm() {
        return isOrderVerifyWaitConfirm;
    }

    public void setIsOrderVerifyWaitConfirm(String isOrderVerifyWaitConfirm) {
        this.isOrderVerifyWaitConfirm = isOrderVerifyWaitConfirm == null ? null : isOrderVerifyWaitConfirm.trim();
    }

    public String getIsOrderVerifyChangeName() {
        return isOrderVerifyChangeName;
    }

    public void setIsOrderVerifyChangeName(String isOrderVerifyChangeName) {
        this.isOrderVerifyChangeName = isOrderVerifyChangeName == null ? null : isOrderVerifyChangeName.trim();
    }
}