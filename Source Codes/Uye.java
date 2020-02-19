
public class Uye {
    private int UyeID;
    private String KullaniciAdi;
    private String Sifre;
    private String Telefon;
    private String Adres;
    private double Bakiye;
    private String Eposta;
    private String UyeTuru;

    public int getUyeID() {
        return UyeID;
    }

    public void setUyeID(int UyeID) {
        this.UyeID = UyeID;
    }

    public String getKullaniciAdi() {
        return KullaniciAdi;
    }

    public void setKullaniciAdi(String KullaniciAdi) {
        this.KullaniciAdi = KullaniciAdi;
    }

    public String getSifre() {
        return Sifre;
    }

    public void setSifre(String Sifre) {
        this.Sifre = Sifre;
    }

    public String getTelefon() {
        return Telefon;
    }

    public void setTelefon(String Telefon) {
        this.Telefon = Telefon;
    }

    public String getAdres() {
        return Adres;
    }

    public void setAdres(String Adres) {
        this.Adres = Adres;
    }

    public double getBakiye() {
        return Bakiye;
    }

    public void setBakiye(double Bakiye) {
        this.Bakiye = Bakiye;
    }

    public String getEposta() {
        return Eposta;
    }

    public void setEposta(String Eposta) {
        this.Eposta = Eposta;
    }

    public String getUyeTuru() {
        return UyeTuru;
    }

    public void setUyeTuru(String UyeTuru) {
        this.UyeTuru = UyeTuru;
    }

    public Uye(int UyeID, String KullaniciAdi, String Sifre, String Telefon, String Adres, double Bakiye, String Eposta, String UyeTuru) {
        this.UyeID = UyeID;
        this.KullaniciAdi = KullaniciAdi;
        this.Sifre = Sifre;
        this.Telefon = Telefon;
        this.Adres = Adres;
        this.Bakiye = Bakiye;
        this.Eposta = Eposta;
        this.UyeTuru = UyeTuru;
    }
}
