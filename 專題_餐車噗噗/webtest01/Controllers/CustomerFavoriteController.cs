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

        // GET: api/CustomerFavorite
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET: api/CustomerFavorite/5
        public string Get(int id)
        {
            return "value";
        }

        // POST: api/CustomerFavorite
        public int Post(receiveObj obj)
        {
            int num = 0;
            try
            {
                var favorite有無重複 =
                    (from c in db.Customer_Favorite
                     where c.CustomerID == obj.cid & c.StoreID == obj.sid
                     select c).FirstOrDefault();
                // FirstOrDefault會抓第一筆資料，抓不到資料就會跑 Default (null)
                if (favorite有無重複 == null)
                {
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

        // PUT: api/CustomerFavorite/5
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE: api/CustomerFavorite/5
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
