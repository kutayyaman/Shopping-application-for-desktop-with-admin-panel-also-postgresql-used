
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;


public class AdminIslemleri {
    private Connection con=null;
    
    private Statement statement=null;
    private PreparedStatement preparedStatement=null;
    
    public AdminIslemleri(){
        String url="jdbc:postgresql://"+Database.host+":"+Database.port+"/"+Database.db_ismi;
        try {
            con=DriverManager.getConnection(url,Database.kullanici_adi,Database.parola);
            System.out.println("BAGLANTI BASARILI");
        } catch (SQLException ex) {
            System.out.println("BAGLANTI BASARISIZ");
        }
    }
    public ArrayList<Uye> uyeleriGetir(){
        ArrayList<Uye> cikti=new ArrayList<Uye>();
        try {
            statement=con.createStatement();
            String sorgu="SELECT * FROM \"Uye\"";
            
            ResultSet rs=statement.executeQuery(sorgu);
            while(rs.next()){
                int UyeID=rs.getInt("UyeID");
                String KullaniciAdi=rs.getString("KullaniciAdi");
                String Sifre=rs.getString("Sifre");
                String Telefon=rs.getString("Telefon");
                String Adres=rs.getString("Adres");
                double Bakiye=rs.getDouble("Bakiye");
                String Eposta=rs.getString("Eposta");
                String UyeTuru=rs.getString("UyeTuru");
                
                cikti.add(new Uye(UyeID,KullaniciAdi,Sifre, Telefon,Adres,Bakiye,Eposta,UyeTuru));
                
                
            }
            return cikti;
        } catch (SQLException ex) {
            Logger.getLogger(AdminIslemleri.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
        
    }
     public void uyeEkle(String kullaniciAdi,String sifre,String telefon,String adres,double bakiye,String eposta,String uyeTuru){
         String sorgu="Insert Into \"Uye\" (\"KullaniciAdi\",\"Sifre\",\"Telefon\",\"Adres\",\"Bakiye\",\"Eposta\",\"UyeTuru\",\"AlisverisSepetiID\") VALUES(?,?,?,?,?,?,?,currval('\"AlisverisSepeti_AlisverisSepetiID_seq\"'))";
         String sorgu3="Insert Into \"AlisverisSepeti\" (\"AlisverisSepetiID\") VALUES(NEXTVAL('\"AlisverisSepeti_AlisverisSepetiID_seq\"'))";
        try {
            statement=con.createStatement();
            statement.executeUpdate(sorgu3);
            
            preparedStatement=con.prepareStatement(sorgu);
            
            preparedStatement.setString(1, kullaniciAdi);
            preparedStatement.setString(2, sifre);
            preparedStatement.setString(3, telefon);
            preparedStatement.setString(4, adres);
            preparedStatement.setDouble(5, bakiye);
            preparedStatement.setString(6, eposta);
            preparedStatement.setString(7, uyeTuru);
            
            preparedStatement.executeUpdate();
            
            if(uyeTuru.equals("A")){ //burayi tekrardan kontrol et yanlislik olabilir
                String sorgu2="SELECT \"UyeID\" FROM \"Uye\" WHERE \"KullaniciAdi\"='"+kullaniciAdi+"'";
                statement=con.createStatement();
                ResultSet rs=statement.executeQuery(sorgu2);
                if(rs.next()){
                int UyeID=rs.getInt("UyeID");
                sorgu2="INSERT INTO \"Admin\" (\"UyeID\") VALUES('"+UyeID+"')";
                statement.executeUpdate(sorgu2);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(AdminIslemleri.class.getName()).log(Level.SEVERE, null, ex);
        }
     }
     public void adminYap(int uyeID){
         String sorgu="Insert Into \"Admin\" (\"UyeID\") VALUES(?) ";
         String sorgu2="Update \"Uye\" SET \"UyeTuru\"='A' WHERE \"UyeID\"="+uyeID;
         String sorgu3="Delete FROM \"Kullanici\" WHERE \"UyeID\"='"+uyeID+"'";
         
        try {
            preparedStatement=con.prepareStatement(sorgu);
            
            preparedStatement.setInt(1,uyeID);
            
            preparedStatement.executeUpdate();
            
            preparedStatement=con.prepareStatement(sorgu2);
            
            preparedStatement.executeUpdate();
            
            statement=con.createStatement();
            statement.executeUpdate(sorgu3);
        } catch (SQLException ex) {
            Logger.getLogger(AdminIslemleri.class.getName()).log(Level.SEVERE, null, ex);
        }
     }
     public void adminIptal(int uyeID){
         String sorgu="Delete From \"Admin\" Where \"UyeID\"="+uyeID;
         String sorgu2="Update \"Uye\" SET \"UyeTuru\"='K' WHERE \"UyeID\"="+uyeID;
         String sorgu3="INSERT INTO \"Kullanici\" (\"UyeID\") VALUES('"+uyeID+"')";
         
        try {
            preparedStatement=con.prepareStatement(sorgu);
            
            preparedStatement.executeUpdate();
            
            preparedStatement=con.prepareStatement(sorgu2);
            
            statement=con.createStatement();
            statement.executeUpdate(sorgu3);
            
            preparedStatement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AdminIslemleri.class.getName()).log(Level.SEVERE, null, ex);
        }
     }
     public void duyuruEkle(String baslik,String aciklama){
         String sorgu="Insert Into \"Duyurular\" (\"Baslik\",\"Aciklama\") VALUES(?,?) ";
         
        try {
            preparedStatement=con.prepareStatement(sorgu);
            
            preparedStatement.setString(1, baslik);
            preparedStatement.setString(2, aciklama);
            
            preparedStatement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AdminIslemleri.class.getName()).log(Level.SEVERE, null, ex);
        }
         
     }
          public ArrayList<Duyurular> duyurulariGetir(){

            ArrayList<Duyurular> cikti=new ArrayList<Duyurular>();
            
        try {
            statement=con.createStatement();
            String sorgu="SELECT * FROM \"Duyurular\"";
            ResultSet rs=statement.executeQuery(sorgu);
            while(rs.next()){
                int DuyuruID=rs.getInt("DuyuruID");
                String Baslik=rs.getString("Baslik");
                String Aciklama=rs.getString("Aciklama");
                
                cikti.add(new Duyurular(Baslik,Aciklama,DuyuruID));
            }
            return cikti;
        } catch (SQLException ex) {
            Logger.getLogger(AdminIslemleri.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
      
    }
          public void duyuruSil(int DuyuruID){
              String sorgu="Delete From \"Duyurular\" WHERE \"DuyuruID\"="+DuyuruID;
              
        try {
            preparedStatement=con.prepareStatement(sorgu);
            preparedStatement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AdminIslemleri.class.getName()).log(Level.SEVERE, null, ex);
        }

     }
          public void uyeGuncelle(int id,String kullaniciAdi,String sifre,String telefon,String adres,String bakiye,String eposta){
              String sorgu="Update \"Uye\" set \"KullaniciAdi\"=? ,\"Sifre\"=? ,\"Telefon\"=? ,\"Adres\"=? ,\"Bakiye\"=? ,\"Eposta\"=? WHERE \"UyeID\"=?";
        try {
            //8 tane soru işareti var 8. UyeID
            double asilBakiye=Double.parseDouble(bakiye);
            preparedStatement=con.prepareStatement(sorgu);
            
            preparedStatement.setString(1, kullaniciAdi);
            preparedStatement.setString(2, sifre);
            preparedStatement.setString(3, telefon);
            preparedStatement.setString(4, adres);
            preparedStatement.setDouble(5, asilBakiye);
            preparedStatement.setString(6, eposta);
            preparedStatement.setInt(7, id);
            
            preparedStatement.executeUpdate();
            
            
        } catch (SQLException ex) {
            Logger.getLogger(AdminIslemleri.class.getName()).log(Level.SEVERE, null, ex);
        }
     }
        public Uye girisYapanUyeBilgileriGetir(String kullaniciAdi,String sifre){
            String sorgu="SELECT * from \"Uye\" WHERE \"KullaniciAdi\"='"+kullaniciAdi+"' AND \"Sifre\"='"+sifre+"'";
        try {
            statement=con.createStatement();
            
            ResultSet rs=statement.executeQuery(sorgu);
            if(rs.next()){
                Uye girisYapanUye=new Uye(rs.getInt("UyeID"), rs.getString("KullaniciAdi"), rs.getString("Sifre"), rs.getString("Telefon"),rs.getString("Adres"),rs.getDouble("Bakiye"),rs.getString("Eposta"),rs.getString("UyeTuru"));
                return girisYapanUye;
            }
            return null;
                    
        } catch (SQLException ex) {
            Logger.getLogger(AdminIslemleri.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
          

        }
        public void uyeyiSil(int uyeID){
            
            String sorgu1="DELETE FROM \"Uye\" WHERE \"UyeID\"='"+uyeID+"'";
        try {
            statement=con.createStatement();
            statement.executeUpdate(sorgu1);
            
        } catch (SQLException ex) {
            Logger.getLogger(AdminIslemleri.class.getName()).log(Level.SEVERE, null, ex);
        }
        }
        
        public boolean kategoriEkle(String kategoriAdi){
            String sorgu1="SELECT \"KategoriEkle\"('"+kategoriAdi+"');"; //Veritabanındaki KategoriEkle fonksiyonu kullaniliyor
        try {
            statement=con.createStatement();
            ResultSet rs1=statement.executeQuery(sorgu1);
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(AdminIslemleri.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
        }
}