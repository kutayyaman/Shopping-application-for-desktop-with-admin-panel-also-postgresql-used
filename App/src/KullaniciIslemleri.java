
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;


public class KullaniciIslemleri {
     private Connection con=null;
    
     private Statement statement=null;
     private PreparedStatement preparedStatement=null;
     
     public KullaniciIslemleri(){
         String url="jdbc:postgresql://"+Database.host+":"+Database.port+"/"+Database.db_ismi;
        try {
            con=DriverManager.getConnection(url,Database.kullanici_adi,Database.parola);
            System.out.println("BAGLANTI BASARILI");
        } catch (SQLException ex) {
            System.out.println("BAGLANTI BASARISIZ");
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
     public ArrayList<Urun> urunleriGetir(){
         ArrayList<Urun> cikti=new ArrayList<Urun>();
         try {
             statement=con.createStatement();
             String sorgu="SELECT * FROM \"Urun\" ";
             ResultSet rs=statement.executeQuery(sorgu);
             
             while(rs.next()){
                 int UrunID=rs.getInt("UrunID");
                 String UrunAdi=rs.getString("UrunAdi");
                 String Aciklama=rs.getString("Aciklama");
                 String Stok=rs.getString("Stok");
                 double Fiyati=rs.getDouble("Fiyati");
                 cikti.add(new Urun(UrunID,UrunAdi,Aciklama,Stok,Fiyati));
             }
             return cikti;
         } catch (SQLException ex) {
             Logger.getLogger(KullaniciIslemleri.class.getName()).log(Level.SEVERE, null, ex);
             return null;
         }
         
     }
     public boolean urunuSatinAl(int UrunID,String KullaniciAdi){ //TRANSACTION BURDA KULLANDIM
         try {
               con.setAutoCommit(false);
               String sorgu1="SELECT \"Stok\",\"Fiyati\" FROM \"Urun\" WHERE \"UrunID\"='"+UrunID+"'";
               String sorgu2="SELECT \"Bakiye\",\"UyeID\" FROM \"Uye\" WHERE \"KullaniciAdi\"='"+KullaniciAdi+"'";
               
               statement=con.createStatement();
               
               ResultSet rs=statement.executeQuery(sorgu1);
               String urununStokMiktari;
               double urununFiyati;
               if(rs.next()){
               urununStokMiktari=rs.getString("Stok");
               urununFiyati=rs.getDouble("Fiyati");
               }
               else
                   return false;
               
               double kullanicininBakiyesi;
               int uyeID;
               rs=statement.executeQuery(sorgu2);
               if(rs.next()){
               kullanicininBakiyesi=rs.getDouble("Bakiye");
               uyeID=rs.getInt("UyeID");
               }
               else
                   return false;
               
               if(kullanicininBakiyesi<urununFiyati || Integer.parseInt(urununStokMiktari)<1)
                   return false;
               kullanicininBakiyesi-=urununFiyati;//databaseye eklenecek
               int urununStokMiktariInt=Integer.parseInt(urununStokMiktari);
               urununStokMiktariInt--;
               urununStokMiktari=""+urununStokMiktariInt; //databaseye eklenecek.
               
               sorgu1="Update \"Uye\" SET \"Bakiye\"='"+kullanicininBakiyesi+"' WHERE \"KullaniciAdi\"='"+KullaniciAdi+"'";
               sorgu2="Update \"Urun\" SET \"Stok\"='"+urununStokMiktari+"' WHERE \"UrunID\"='"+UrunID+"'";
               String sorgu3="INSERT INTO \"UrunUye\" (\"UrunID\",\"UyeID\") VALUES('"+UrunID+"','"+uyeID+"')";
               statement.executeUpdate(sorgu1);
               statement.executeUpdate(sorgu2);
               statement.executeUpdate(sorgu3);
               
               con.commit();
               return true;
         } catch (SQLException ex) {
             Logger.getLogger(KullaniciIslemleri.class.getName()).log(Level.SEVERE, null, ex);
             
             try {
                   con.rollback();
             } catch (SQLException ex1) {
                 Logger.getLogger(KullaniciIslemleri.class.getName()).log(Level.SEVERE, null, ex1);
                 
             }
         }
         return false;
     }
     
}
