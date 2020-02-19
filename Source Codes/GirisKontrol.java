
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author kutay yaman
 */
public class GirisKontrol {
    private Connection con=null;
    
    private Statement statement=null;
    private PreparedStatement preparedStatement=null;
    
    
    public boolean girisYap(String kullanici_adi,String parola){
        String sorgu="Select * From \"Uye\" where \"KullaniciAdi\"=? and \"Sifre\"=?";
        try {
            preparedStatement =con.prepareStatement(sorgu);
            preparedStatement.setString(1, kullanici_adi);
            preparedStatement.setString(2, parola);
            
            ResultSet rs=preparedStatement.executeQuery();
            
            return rs.next(); //rs.next() true veya false döndürür zaten
        } catch (SQLException ex) {
            Logger.getLogger(GirisKontrol.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    public boolean adminKontrolu(String kullanici_adi,String parola){
        String sorgu="Select \"UyeID\" from \"Admin\"";
        String sorgu2="Select \"UyeID\" from \"Uye\" where \"KullaniciAdi\"=? and \"Sifre\"=?";
        
        try {
            preparedStatement =con.prepareStatement(sorgu2);
            preparedStatement.setString(1, kullanici_adi);
            preparedStatement.setString(2, parola);
            
            ResultSet rs2=preparedStatement.executeQuery();
            int girisYapanUyeninIdsi=-1;
            if(rs2.next())
            girisYapanUyeninIdsi=rs2.getInt("UyeID");
            
            preparedStatement=con.prepareStatement(sorgu);
            
            ResultSet rs=preparedStatement.executeQuery();
            
            while(rs.next()){
                int denenecekID=rs.getInt("UyeID");
                if(denenecekID==girisYapanUyeninIdsi)
                    return true;
            }
            return false;
        } catch (SQLException ex) {
            Logger.getLogger(GirisKontrol.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
     
        
    }
    public GirisKontrol(){
         String url="jdbc:postgresql://"+Database.host+":"+Database.port+"/"+Database.db_ismi;
        try {
            con=DriverManager.getConnection(url,Database.kullanici_adi,Database.parola);
            System.out.println("BAGLANTI BASARILI");
        } catch (SQLException ex) {
            System.out.println("BAGLANTI BASARISIZ");
        }
    }
    public boolean uyeYap(String kullaniciAdi,String sifre,String ePosta,String adres,String telefonNo){
            String sorgu1="SELECT \"KullaniciAdi\" FROM \"Uye\" WHERE \"KullaniciAdi\"='"+kullaniciAdi+"'";
            ResultSet rs;
        try {
            statement=con.createStatement();
            rs = statement.executeQuery(sorgu1);
            if(rs.next())
                return false;
        } catch (SQLException ex) {
            Logger.getLogger(AdminIslemleri.class.getName()).log(Level.SEVERE, null, ex);
        }
        String sorgu2="Insert Into \"Uye\" (\"KullaniciAdi\",\"Sifre\",\"Eposta\",\"Adres\",\"Telefon\",\"UyeTuru\",\"Bakiye\",\"AlisverisSepetiID\") VALUES(?,?,?,?,?,'K','20',currval('\"AlisverisSepeti_AlisverisSepetiID_seq\"'))";
        String sorgu3="Insert Into \"AlisverisSepeti\" (\"AlisverisSepetiID\") VALUES(NEXTVAL('\"AlisverisSepeti_AlisverisSepetiID_seq\"'))"; //istesem triggerlada yapardım ama bu currval olayı hosuma gitti
        try {  
            preparedStatement=con.prepareStatement(sorgu3);
            preparedStatement.executeUpdate();
            
            preparedStatement=con.prepareStatement(sorgu2);
            preparedStatement.setString(1,kullaniciAdi);
            preparedStatement.setString(2,sifre);
            preparedStatement.setString(3,ePosta);
            preparedStatement.setString(4,adres);
            preparedStatement.setString(5,telefonNo);
           
           
            preparedStatement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AdminIslemleri.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return true;
        }
}
