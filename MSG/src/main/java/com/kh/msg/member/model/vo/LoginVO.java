package com.kh.msg.member.model.vo;

public class LoginVO {
 
    private String id;
    private String sessionid;
     
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getSessionid() {
        return sessionid;
    }
    public void setSessionid(String sessionid) {
        this.sessionid = sessionid;
    }
     
     
    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((id == null) ? 0 : id.hashCode());
        return result;
    }
     
    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        LoginVO other = (LoginVO) obj;
        if (id == null) {
            if (other.id != null)
                return false;
        } else if (!id.equals(other.id))
            return false;       
        return true;
    }
     
     
 
 
     
     
}