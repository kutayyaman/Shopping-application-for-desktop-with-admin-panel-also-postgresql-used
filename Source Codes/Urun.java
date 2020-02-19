
public class Urun {
    private int UrunID;
    private String UrunAdi;
    private String Aciklama;
    private String Stok;
    private double Fiyati;

    public Urun(int UrunID, String UrunAdi, String Aciklama, String Stok, double Fiyati) {
        this.UrunID = UrunID;
        this.UrunAdi = UrunAdi;
        this.Aciklama = Aciklama;
        this.Stok = Stok;
        this.Fiyati = Fiyati;
    }

    public int getUrunID() {
        return UrunID;
    }

    public void setUrunID(int UrunID) {
        this.UrunID = UrunID;
    }

    public String getUrunAdi() {
        return UrunAdi;
    }

    public void setUrunAdi(String UrunAdi) {
        this.UrunAdi = UrunAdi;
    }

    public String getAciklama() {
        return Aciklama;
    }

    public void setAciklama(String Aciklama) {
        this.Aciklama = Aciklama;
    }

    public String getStok() {
        return Stok;
    }

    public void setStok(String Stok) {
        this.Stok = Stok;
    }

    public double getFiyati() {
        return Fiyati;
    }

    public void setFiyati(double Fiyati) {
        this.Fiyati = Fiyati;
    }
    
}
