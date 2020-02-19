/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author kutay yaman
 */
public class Duyurular {
    public int DuyuruID;
    public String Baslik;
    public String Aciklama;

    public String getBaslik() {
        return Baslik;
    }

    public void setBaslik(String Baslik) {
        this.Baslik = Baslik;
    }

    public String getAciklama() {
        return Aciklama;
    }

    public void setAciklama(String Aciklama) {
        this.Aciklama = Aciklama;
    }

    public int getDuyuruID() {
        return DuyuruID;
    }

    public void setDuyuruID(int DuyuruID) {
        this.DuyuruID = DuyuruID;
    }

    public Duyurular(String Baslik, String Aciklama,int DuyuruID) {
        this.Baslik = Baslik;
        this.Aciklama = Aciklama;
        this.DuyuruID=DuyuruID;
    }
}
