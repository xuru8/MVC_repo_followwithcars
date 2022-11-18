using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using webtest01.Models;

namespace webtest01.Controllers
{    
    public class CustomerFavoriteController : ApiController
    {
        trytryEntities db = new trytryEntities();

        // POST: api/CustomerFavorite
        // 新增我的最愛
        public int Post(receiveObj obj)
        {
            //設定一個int給予前端判斷API的運作結果
            int num = 0;

            try
            {
                // 先確認是否已將該加入過我的最愛，這邊的設定為找不到對應資料就是沒有重複。
                // FirstOrDefault會抓條件下的第一筆資料，抓不到資料就會跑 Default (null)
                var favorite有重複 =
                    (from c in db.Customer_Favorite
                     where c.CustomerID == obj.cid & c.StoreID == obj.sid
                     select c).FirstOrDefault();                

                if (favorite有重複 == null)
                {
                    // 等於null就是沒重複，再繼續新增我的最愛。
                    // SaveChanges會記錄增加的筆數，這邊會是1。
                    Customer_Favorite Favorite = new Customer_Favorite();
                    Favorite.CustomerID = Convert.ToInt32(obj.cid);
                    Favorite.StoreID = Convert.ToInt32(obj.sid);
                    db.Customer_Favorite.Add(Favorite);
                    num = db.SaveChanges();
                    return num;
                }
                else
                {
                    num = 0;
                    return num;
                }

            }
            catch (Exception ex)
            {
                num = 0;
            }
            return num;
        }       

        // DELETE: api/CustomerFavorite/5
        // 刪除我的最愛
        public int Delete(receiveObj obj)
        {
            int num = 0;
            try
            {
                var favorite有無存在 =
                   (from c in db.Customer_Favorite
                    where c.CustomerID == obj.cid & c.StoreID == obj.sid
                    select c).FirstOrDefault();
                if (favorite有無存在 != null) // 存在
                {
                    //Customer_Favorite Favorite = new Customer_Favorite();
                    //Favorite.CustomerID = Convert.ToInt32(obj.cid);
                    //Favorite.StoreID = Convert.ToInt32(obj.sid);
                    db.Customer_Favorite.Remove(favorite有無存在);
                    num = db.SaveChanges();
                    return num;
                }
                else  // 不存在
                {
                    num = 0;
                    return num;
                }
            }
            catch (Exception ex)
            {
                num = 0;
            }
            return num;
        }
    }
}
