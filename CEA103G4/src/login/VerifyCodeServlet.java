package login;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/VerifyCodeServlet")
public class VerifyCodeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public VerifyCodeServlet() {
        super();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
       //宣告驗證碼
       int width = 70;
       int height = 32;
       String data = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789abcdefghijklmnpqrstuvwxyz";    //隨機字元字典，其中0，o，1，I 等難辨別的字元最好不要
       Random random = new Random();//隨機類
       //1.建立圖片資料快取區域（核心類）
       BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);//建立一個彩色的圖片
       //2.獲得畫板(圖片，ps圖層)，繪畫物件。
       Graphics g = image.getGraphics();
       //3.選擇顏色，畫矩形3，4步是畫一個有內外邊框的效果
       g.setColor(Color.BLACK);
       g.fillRect(0, 0, width, height);
       //4.白色矩形
       g.setColor(Color.WHITE);
       g.fillRect(1, 1, width-2, height-2);
       
       /**1 提供快取區域，為了存放4個隨機字元，以便存入session */
       StringBuilder builder = new StringBuilder();
       
       //5 隨機生成4個字元
                   //設定字型顏色
       g.setFont(new Font("宋體", Font.BOLD&Font.ITALIC, 20));
       for(int i = 0 ; i < 4 ;i ++){
           //隨機顏色
           g.setColor(new Color(random.nextInt(255),random.nextInt(255), random.nextInt(255)));
           
           //隨機字元
           int index = random.nextInt(data.length());
           String str = data.substring(index, index + 1);
           
           /**2 快取*/
           builder.append(str);
           
           //寫入
           g.drawString(str, (width / 6) * (i + 1) , 20);                     
       }
       //給圖中繪製噪音點，讓圖片不那麼好辨別
       for(int j=0,n=random.nextInt(100);j<n;j++){
           g.setColor(Color.RED);
           g.fillRect(random.nextInt(width),random.nextInt(height),1,1);//隨機噪音點
       }

       
       /**3 獲得隨機資料，並儲存session*/
       String tempStr = builder.toString();
       request.getSession().setAttribute("sessionCacheData",tempStr);
       
       
       //生成圖片傳送到瀏覽器 --相當於下載
       ImageIO.write(image, "jpg", response.getOutputStream());
   }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
