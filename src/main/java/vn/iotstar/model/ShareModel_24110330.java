package vn.iotstar.model;

import java.io.Serializable;
import java.sql.Date;

public class ShareModel_24110330 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int shareId;
    private String emails;
    private Date sharedDate;
    private String username;
    private String videoId;

    public ShareModel_24110330() {
    }

    public ShareModel_24110330(int shareId, String emails, Date sharedDate, String username, String videoId) {
        this.shareId = shareId;
        this.emails = emails;
        this.sharedDate = sharedDate;
        this.username = username;
        this.videoId = videoId;
    }

    public int getShareId() {
        return shareId;
    }

    public void setShareId(int shareId) {
        this.shareId = shareId;
    }

    public String getEmails() {
        return emails;
    }

    public void setEmails(String emails) {
        this.emails = emails;
    }

    public Date getSharedDate() {
        return sharedDate;
    }

    public void setSharedDate(Date sharedDate) {
        this.sharedDate = sharedDate;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getVideoId() {
        return videoId;
    }

    public void setVideoId(String videoId) {
        this.videoId = videoId;
    }
}
