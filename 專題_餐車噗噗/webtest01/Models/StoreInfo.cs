using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Web;

namespace webtest01.Models
{
    public class StoreInfo
    {
        public class StoreCarInfoEditIn
        {
            public string startTime { get; set; }
            public string endTime { get; set; }
            public string data { get; set; }

            public string county { get; set; }
            public string district { get; set; }
            public string address { get; set; }
            public string latitude { get; set; }//緯度
            public string longitude { get; set; }//經度

            //public string Introduce { get; set; } 經緯度
            //public string Introduce { get; set; }


        }
        public class StoreCarInfoEditOut
        {
            public string ErrMsg { get; set; }
            public string ResultMsg { get; set; }
        }




        public class StoreBossInfoEditOut
        {
            public string ErrMsg { get; set; }
            public string ResultMsg { get; set; }
            public string relogin { get; set; }
        }

        public class ClickStoreCardIn
        {
            public string storeID { get; set; }
        }
        public class ClickStoreCardOut
        {
            public int storeID { get; set; }
            public int CalendarID { get; set; }
            public string Store_Name { get; set; }
            public string Introduce { get; set; }
            public string Store_Class { get; set; }
            public string Address_City { get; set; }
            public string Address_Local { get; set; }
            public string Address_Detail { get; set; }

            public string Phone { get; set; }
            public string Picture { get; set; }
        }



        public class ProductInfoOut
        {
            public int ProductID { get; set; }
            public string Product_Name { get; set; }
            public int product_Price { get; set; }
        }
        public class MessageCommentCardOut
        {
            public int CustomerID { get; set; }
            public string Text_Content { get; set; }
            public int Star_Rating { get; set; }
            public string Picture { get; set; }
            public string CustomerName { get; set; }
            public string Create_At { get; set; }
        }
    
    }
}