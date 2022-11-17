using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace webtest01.Models
{
    public class SearchModel
    {
        public string time { get; set; }
        public string FoodClass { get; set; }
        public string location { get; set; }
        public string KeyWord { get; set; }
    }




    public class SearchStoreCardList
    {
        public List<SearchStoreCard> SearchStoreCards { get; set; }
    }

    public class receiveObj
    {
        public int? cid { get; set; }
        public int? sid { get; set; }
        public string fname { get; set; }
        public string fclass { get; set; }
        public string fcity { get; set; }
        public string fdate { get; set; }
        public string ftime { get; set; }

    }


    public struct searchTimeClass
    {
        public static string timeStart { get; set; }
        public static string timeEnd { get; set; }
        public static string fortime0 { get; set; }
        public static string fortime1 { get; set; }
        public static string nowdate { get; set; }

        public static long dateTimeANDsearchStart { get; set; }
        public static long dateTimeANDsearchEnd { get; set; }
    }

    public class SearchStoreCard
    {
        public int StoreID { get; set; }  //tb store
        public string Store_Name { get; set; }       //tb store顯示商店名稱
        public string Store_Class { get; set; }      //tb store 顯示商店種類
        public string Address_Area { get; set; }     //tb store 顯示北中南
        public string Address_City { get; set; }     //tb store 顯示市     //tb store storeBusiness
        public string Address_Detail { get; set; }   //---------------->自創 連結City+Local
        public string Address_Local { get; set; }    //tb store 顯示區     //tb store storeBusiness
        public string Store_Address { get; set; }    //tb store storeBusiness 顯示路
        public int CalendarID { get; set; }           //tb store storeBusiness   tb Calendar
        public int CustomerFavoriteStoreID { get; set; } // Customer_Favorite
        public int CustomerID { get; set; }           // Customer_Favorite
        public string Introduce { get; set; }        //tb store  餐車簡介
        //public bool OnBusiness { get; set; }         //tb store storeBusiness --------->或許可以刪掉?
        public string Picture { get; set; }          //tb store  餐車圖
        public string Phone { get; set; }            //tb store  電話
        public string Punch_Start { get; set; }      //tb storeBusiness 開始時間
        public string Punch_End { get; set; }        //tb store storeBusiness 結束時間
        public string Punch_Time { get; set; }       //---------------->自創 連結開始結束 格式2022/09/12 10:00~18:00
        public Nullable<double> StarRating { get; set; }
        public Nullable<int> ContentCount { get; set; }
        public string CreationTime { get; set; }     //tb store?


    }
}