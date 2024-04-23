import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.sql.SQLException;
import java.sql.PreparedStatement;

public class GoodsImpl implements Goods {
    
    static private GoodsImpl instance = new GoodsImpl();
    private GoodsImpl() {}
    public static GoodsImpl getGoodsDao() {
        return instance;
    }

    DBUtil dbUtil = DBUtil.getInstance();
    
    public List<GoodsDto> getGoods() throws SQLException {
        String sql = "select *\r\n" + 
                "from goods\r\n";
        Connection conn = null;
        PreparedStatement pstmt = null;
        java.sql.ResultSet rs = null; // java.sql.ResultSet을 사용
        try {
            List<GoodsDto> list = new ArrayList<GoodsDto>();
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while(rs.next()) {            
                int id = rs.getInt("id");
                int width = rs.getInt("width");
                int length = rs.getInt("length");
                int height = rs.getInt("height");
                int weight = rs.getInt("weight");
                int userId = rs.getInt("user_Id");
                int areaId = rs.getInt("area_Id");

                GoodsDto dongCodeDto = new GoodsDto(id,width,length,height,weight,userId,areaId);
                list.add(dongCodeDto);
            }
            return list;
        } finally {
            dbUtil.close(conn, pstmt, rs);
        }
    }   

}
