using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using webtest01.Models;

namespace webtest01.Controllers
{
    public class truckController : ApiController
    {
        trytryEntities db = new trytryEntities();
        //-------------------------------------------------------------------------------------------------------------------     
        // 筆記
        //
        // GET: api/Store
        //依照ajax的網址來做對應的GET
        // public ， List<Store> ->(return回去的類型) ， GetALL() -> (這個控制器的名稱(參數))

        //public List<Store> GetALL()
        //{
        //    // 只抓前10筆資料
        //    //var stores = db.Store.Take(10);

        //    // 搜尋相似字並只抓前3筆
        //    //var stores = db.Store.Where(m => m.Store_Name.Contains("飯")).Take(3);

        //    // 搜尋相似字，但是Take不能用?
        //    //var stores = from s in db.Store
        //    //             where s.Store_Name.Contains("飯")
        //    //             select s;

        //    var stores = db.Store;
        //    return stores.ToList();  //return回去的值
        //}

        // 測試為什麼SEARCH會抓出來怪怪的，先用跑全部的測試--->SQL資料不完整，Join是跑兩邊都要有的資料。
        //
        //-------------------------------------------------------------------------------------------------------------------     
        // 單純跑 Store join Store_Business 的資料
        //public IQueryable GetALL()
        //{
        //    // 這邊的tt就像是一個join後依照select然後出來的新table(集合)

        //    // 目前搜尋全部是用 CalendarID == 1 去做搜尋 => 改用 sb.Punch_Start 去作時間排序顯示
        //    var tt = from s in db.Store
        //             join sb in db.Store_Business on s.StoreID equals sb.StoreID
        //             orderby sb.Punch_Start
        //             select new showCard()
        //             {
        //                 StoreID = s.StoreID,
        //                 Store_Name = s.Store_Name,
        //                 Store_Class = s.Store_Class,
        //                 Address_Area = s.Address_Area,  //Area是不是要放在business跟著改變??
        //                 Address_City = s.Address_City,  //顯示的位置應該也要跑business的資訊??
        //                 Address_Detail = sb.Address_City + sb.Address_Local + sb.Store_Address,
        //                 Picture = s.Picture,
        //                 Phone = s.Phone,
        //                 Punch_Start = sb.Punch_Start,
        //                 Punch_End = sb.Punch_End,
        //                 Punch_Time = sb.Punch_Start + "~" + sb.Punch_End.Substring(sb.Punch_End.Length - 5)
        //             };


        //    return tt;
        //}


        //-------------------------------------------------------------------------------------------------------------------     
        //筆記
        //
        // ***利用導覽屬性去直接做到join的效果，用select去挑出有join效果後所需要顯示的欄位。***
        //public IQueryable GetALL()
        //{
        //    var stores = db.Store
        //        .Select
        //        (
        //        s => new { s.StoreID, s.Store_Name, s.Store_Class, s.Address_City, s.Store_Business.Punch_Date }
        //        );
        //    return stores;
        //}

        //-------------------------------------------------------------------------------------------------------------------     
        // GET:跑新店(15天內加入)全部店家 並帶出評分星等。
        public IQueryable GetAll()
        {
            // 抓到現在的時間，扣掉 10 天，轉成月份帶0的時間(string),重組字串,抓前面8個字
            searchTimeClass.nowdate = DateTime.Now.AddDays(-15).ToString("s").Replace("-", "").Substring(0, 8);
            var store =
             from z in
             (
                      from y in
                     (
                              from x in
                             (
                                 from s in db.Store
                                 join sb in db.Store_Business
                                 on s.StoreID equals sb.StoreID
                                 select new
                                 {
                                     StoreID = s.StoreID,
                                     Store_Name = s.Store_Name,
                                     Store_Class = s.Store_Class,
                                     Address_Area = s.Address_Area,
                                     Address_City = s.Address_City,
                                     Address_Detail = sb.Address_City + sb.Address_Local + sb.Store_Address,
                                     Picture = s.Picture,
                                     Phone = s.Phone,
                                     Introduce = s.Introduce,
                                     Creation_At = s.Creation_At.ToString(),
                                     Punch_Start = sb.Punch_Start,
                                     Punch_End = sb.Punch_End,
                                     Punch_Time = sb.Punch_Start + "~" + sb.Punch_End.Substring(sb.Punch_End.Length - 5),
                                     CalendarID = sb.CalendarID,
                                 }

                             ) // x in(x 的裡面)
                              join m in db.Message_Board
                              on x.StoreID equals m.StoreID into g
                              from ssbm in g.DefaultIfEmpty()
                              select new SearchStoreCard()
                              {
                                  StoreID = x.StoreID,
                                  Store_Name = x.Store_Name,
                                  Store_Class = x.Store_Class,
                                  Address_Area = x.Address_Area,
                                  Address_City = x.Address_City,
                                  Address_Detail = x.Address_Detail,
                                  Picture = x.Picture,
                                  Phone = x.Phone,
                                  Introduce = x.Introduce,
                                  CreationTime = x.Creation_At.Replace("-", ""),
                                  Punch_Start = x.Punch_Start,
                                  Punch_End = x.Punch_End,
                                  Punch_Time = x.Punch_Time,
                                  StarRating = Math.Round((double)g.Average(m => m.Star_Rating), 1),
                                  ContentCount = g.Count(),
                                  CalendarID = x.CalendarID
                              }
                             ) //y

                      group new
                      {
                          y.StoreID,
                          y.Store_Name,
                          y.Store_Class,
                          y.Address_Area,
                          y.Address_City,
                          y.Address_Detail,
                          y.Picture,
                          y.Phone,
                          y.Introduce,
                          y.Punch_Start,
                          y.Punch_End,
                          y.Punch_Time,
                          //y.StarRating,
                          //y.ContentCount
                      }
                      by new
                      {
                          y.StoreID,
                          y.Store_Name,
                          y.Store_Class,
                          y.Address_Area,
                          y.Address_City,
                          y.Address_Detail,
                          y.Picture,
                          y.Phone,
                          y.Introduce,
                          y.CreationTime,
                          y.Punch_Start,
                          y.Punch_End,
                          y.Punch_Time,
                          y.StarRating,
                          y.ContentCount,
                          y.CalendarID
                      }
                                 into gro
                      orderby gro.Key.CreationTime
                      select new
                      {
                          CalendarID = gro.Key.CalendarID,
                          StoreID = gro.Key.StoreID,
                          Store_Name = gro.Key.Store_Name,
                          Store_Class = gro.Key.Store_Class,
                          Address_Area = gro.Key.Address_Area,
                          Address_City = gro.Key.Address_City,
                          Address_Detail = gro.Key.Address_Detail,
                          Picture = gro.Key.Picture,
                          Phone = gro.Key.Phone,
                          Introduce = gro.Key.Introduce,
                          CreationTime = gro.Key.CreationTime,
                          Punch_Start = gro.Key.Punch_Start,
                          Punch_End = gro.Key.Punch_End,
                          Punch_Time = gro.Key.Punch_Time,
                          StarRating = gro.Key.StarRating == null ? 0 : gro.Key.StarRating,
                          ContentCount = gro.Key.ContentCount
                      }
                             ).AsEnumerable() //z     

             where z.CalendarID == 1 & (Convert.ToInt32(z.CreationTime) >= Convert.ToInt32(searchTimeClass.nowdate))
             orderby /*z.Punch_Start, z.StarRating,*/z.CreationTime descending
             select new SearchStoreCard()
             {
                 StoreID = z.StoreID,
                 Store_Name = z.Store_Name,
                 Store_Class = z.Store_Class,
                 Address_Area = z.Address_Area,
                 Address_City = z.Address_City,
                 Address_Detail = z.Address_Detail,
                 Picture = z.Picture,
                 Introduce = z.Introduce,
                 Punch_Start = z.Punch_Start,
                 Punch_End = z.Punch_End,
                 Punch_Time = z.Punch_Time,
                 StarRating = z.StarRating,
                 ContentCount = z.ContentCount,
                 //CreationTime = searchTimeClass.nowdate, //檢查值用
             };
            return store.AsQueryable();
        }

        //-------------------------------------------------------------------------------------------------------------------
        // GET: api/Store?id=5
        //依照ajax的網址來做對應的GET(有帶參數)
        IQueryable oneStore;
        public IQueryable GetSelect(int id)
        {
            var store = from s in db.Store
                        where s.StoreID == id
                        select new
                        {
                            s.StoreID,
                            s.Store_Name,
                            s.Store_Class,
                            s.Address_Area,
                            s.Address_City,
                            s.Address_Local,
                            s.Phone,
                            s.Picture,
                            //StoreID = s.StoreID,
                            //Store_Name = s.Store_Name,
                            //Store_Class = s.Store_Class,
                            //Address_Area = s.Address_Area,
                            //Address_City = s.Address_City,
                            //Address_Local = s.Address_Local,
                            //Phone = s.Phone,
                            //Picture = s.Picture,
                            //Creation_At = Convert.ToString(s.Creation_At)
                        };
            //var oneStore = store.FirstOrDefault();
            //oneStore = store.AsQueryable();
            return store;
        }


        //-------------------------------------------------------------------------------------------------------------------
        // POST抓到我的最愛的店家  (***這邊用Get跟Post真的有差***)
        IQueryable CustomerFavorite;
        public IQueryable PostCustomerFavorite(receiveObj obj)
        {
            var tt =
            from z in
            (
                     from y in
                    (
                             from x in
                            (
                                from c in db.Customer_Favorite
                                join s in db.Store on c.StoreID equals s.StoreID
                                join sb in db.Store_Business on c.StoreID equals sb.StoreID
                                //where c.CustomerID == obj.cid
                                select new
                                {
                                    FavoriteStoreID = c.StoreID,
                                    CalendarID = sb.CalendarID,
                                    CustomerID = c.CustomerID,
                                    Store_Name = s.Store_Name,
                                    Store_Class = s.Store_Class,
                                    Address_Area = s.Address_Area,
                                    Address_City = s.Address_City,
                                    Address_Detail = sb.Address_City + sb.Address_Local + sb.Store_Address,
                                    Picture = s.Picture,
                                    Phone = s.Phone,
                                    Introduce = s.Introduce,
                                    Punch_Start = sb.Punch_Start,
                                    Punch_End = sb.Punch_End,
                                    Punch_Time = sb.Punch_Start + "~" + sb.Punch_End.Substring(sb.Punch_End.Length - 5),
                                }

                            ) // x in(x 的裡面)
                             join m in db.Message_Board
                             on x.FavoriteStoreID equals m.StoreID into g
                             from ssbm in g.DefaultIfEmpty()
                             select new SearchStoreCard()
                             {
                                 CustomerFavoriteStoreID = x.FavoriteStoreID,
                                 CustomerID = x.CustomerID,
                                 CalendarID = x.CalendarID,
                                 Store_Name = x.Store_Name,
                                 Store_Class = x.Store_Class,
                                 Address_Area = x.Address_Area,
                                 Address_City = x.Address_City,
                                 Address_Detail = x.Address_Detail,
                                 Picture = x.Picture,
                                 Phone = x.Phone,
                                 Introduce = x.Introduce,
                                 Punch_Start = x.Punch_Start,
                                 Punch_End = x.Punch_End,
                                 Punch_Time = x.Punch_Time,
                                 StarRating = Math.Round((double)g.Average(m => m.Star_Rating), 1),
                                 ContentCount = g.Count()
                             }
                            ) //y

                     group new
                     {
                         y.CustomerFavoriteStoreID,
                         y.Store_Name,
                         y.Store_Class,
                         y.Address_Area,
                         y.Address_City,
                         y.Address_Detail,
                         y.Picture,
                         y.Phone,
                         y.Introduce,
                         y.Punch_Start,
                         y.Punch_End,
                         y.Punch_Time,
                         //y.StarRating,
                         //y.ContentCount
                     }
                     by new
                     {
                         y.CustomerFavoriteStoreID,
                         y.CustomerID,
                         y.CalendarID,
                         y.Store_Name,
                         y.Store_Class,
                         y.Address_Area,
                         y.Address_City,
                         y.Address_Detail,
                         y.Picture,
                         y.Phone,
                         y.Introduce,
                         y.Punch_Start,
                         y.Punch_End,
                         y.Punch_Time,
                         y.StarRating,
                         y.ContentCount
                     }
                                into gro
                     orderby gro.Key.Punch_Start
                     select new
                     {
                         StoreID = gro.Key.CustomerFavoriteStoreID,
                         CustomerID = gro.Key.CustomerID,
                         CalendarID = gro.Key.CalendarID,
                         Store_Name = gro.Key.Store_Name,
                         Store_Class = gro.Key.Store_Class,
                         Address_Area = gro.Key.Address_Area,
                         Address_City = gro.Key.Address_City,
                         Address_Detail = gro.Key.Address_Detail,
                         Picture = gro.Key.Picture,
                         Phone = gro.Key.Phone,
                         Introduce = gro.Key.Introduce,
                         Punch_Start = gro.Key.Punch_Start,
                         Punch_End = gro.Key.Punch_End,
                         Punch_Time = gro.Key.Punch_Time,
                         StarRating = gro.Key.StarRating == null ? 0 : gro.Key.StarRating,
                         ContentCount = gro.Key.ContentCount
                     }
                            ).AsEnumerable() //z     

            where
                 z.CalendarID == 1 &
                 z.CustomerID == obj.cid
            orderby Convert.ToInt64(z.Punch_Start.Replace("-", "").Replace(" ", "").Replace(":", ""))
            select new SearchStoreCard()
            {
                StoreID = z.StoreID,
                Store_Name = z.Store_Name,
                Store_Class = z.Store_Class,
                Address_Area = z.Address_Area,
                Address_City = z.Address_City,
                Address_Detail = z.Address_Detail,
                Picture = z.Picture,
                Introduce = z.Introduce,
                Punch_Start = z.Punch_Start,
                Punch_End = z.Punch_End,
                Punch_Time = z.Punch_Time,
                StarRating = z.StarRating,
                ContentCount = z.ContentCount
            };
            CustomerFavorite = tt.AsQueryable();
            return CustomerFavorite;
        }
       
        //-------------------------------------------------------------------------------------------------------------------
        //抓到每個分類的店家 (熱門)
        public IQueryable GetClass(string fclass)
        {
            var store =
                        from z in
                        (
                                 from y in
                                (
                                         from x in
                                        (
                                            from s in db.Store
                                            join sb in db.Store_Business
                                            on s.StoreID equals sb.StoreID
                                            select new
                                            {
                                                StoreID = s.StoreID,
                                                Store_Name = s.Store_Name,
                                                Store_Class = s.Store_Class,
                                                Address_Area = s.Address_Area,
                                                Address_City = s.Address_City,
                                                Address_Detail = sb.Address_City + sb.Address_Local + sb.Store_Address,
                                                Picture = s.Picture,
                                                Phone = s.Phone,
                                                Introduce = s.Introduce,
                                                Punch_Start = sb.Punch_Start,
                                                Punch_End = sb.Punch_End,
                                                Punch_Time = sb.Punch_Start + "~" + sb.Punch_End.Substring(sb.Punch_End.Length - 5),
                                                CalendarID = sb.CalendarID,
                                            }

                                        ) // x in(x 的裡面)
                                         join m in db.Message_Board
                                         on x.StoreID equals m.StoreID into g
                                         from ssbm in g.DefaultIfEmpty()
                                         select new SearchStoreCard()
                                         {
                                             StoreID = x.StoreID,
                                             Store_Name = x.Store_Name,
                                             Store_Class = x.Store_Class,
                                             Address_Area = x.Address_Area,
                                             Address_City = x.Address_City,
                                             Address_Detail = x.Address_Detail,
                                             Picture = x.Picture,
                                             Phone = x.Phone,
                                             Introduce = x.Introduce,
                                             Punch_Start = x.Punch_Start,
                                             Punch_End = x.Punch_End,
                                             Punch_Time = x.Punch_Time,
                                             StarRating = Math.Round((double)g.Average(m => m.Star_Rating), 1),
                                             ContentCount = g.Count(),
                                             CalendarID = x.CalendarID
                                         }
                                        ) //y

                                 group new
                                 {
                                     y.StoreID,
                                     y.Store_Name,
                                     y.Store_Class,
                                     y.Address_Area,
                                     y.Address_City,
                                     y.Address_Detail,
                                     y.Picture,
                                     y.Phone,
                                     y.Introduce,
                                     y.Punch_Start,
                                     y.Punch_End,
                                     y.Punch_Time,
                                     //y.StarRating,
                                     //y.ContentCount
                                 }
                                 by new
                                 {
                                     y.StoreID,
                                     y.Store_Name,
                                     y.Store_Class,
                                     y.Address_Area,
                                     y.Address_City,
                                     y.Address_Detail,
                                     y.Picture,
                                     y.Phone,
                                     y.Introduce,
                                     y.Punch_Start,
                                     y.Punch_End,
                                     y.Punch_Time,
                                     y.StarRating,
                                     y.ContentCount,
                                     y.CalendarID
                                 }
                                            into gro
                                 orderby gro.Key.Punch_Start
                                 select new
                                 {
                                     CalendarID = gro.Key.CalendarID,
                                     StoreID = gro.Key.StoreID,
                                     Store_Name = gro.Key.Store_Name,
                                     Store_Class = gro.Key.Store_Class,
                                     Address_Area = gro.Key.Address_Area,
                                     Address_City = gro.Key.Address_City,
                                     Address_Detail = gro.Key.Address_Detail,
                                     Picture = gro.Key.Picture,
                                     Phone = gro.Key.Phone,
                                     Introduce = gro.Key.Introduce,
                                     Punch_Start = gro.Key.Punch_Start,
                                     Punch_End = gro.Key.Punch_End,
                                     Punch_Time = gro.Key.Punch_Time,
                                     StarRating = gro.Key.StarRating == null ? 0 : gro.Key.StarRating,
                                     ContentCount = gro.Key.ContentCount
                                 }
                                        ).AsEnumerable() //z     

                        where z.Store_Class == fclass & z.CalendarID == 1
                        orderby /*z.Punch_Start,*/ z.StarRating descending
                        select new SearchStoreCard()
                        {
                            StoreID = z.StoreID,
                            Store_Name = z.Store_Name,
                            Store_Class = z.Store_Class,
                            Address_Area = z.Address_Area,
                            Address_City = z.Address_City,
                            Address_Detail = z.Address_Detail,
                            Picture = z.Picture,
                            Introduce = z.Introduce,
                            Punch_Start = z.Punch_Start,
                            Punch_End = z.Punch_End,
                            Punch_Time = z.Punch_Time,
                            StarRating = z.StarRating,
                            ContentCount = z.ContentCount
                        };
            return store.AsQueryable();
        }

        //-------------------------------------------------------------------------------------------------------------------
        //抓到個別區域的店家 (新店)

        public IQueryable GetArea(string farea)
        {
            // 抓到現在的時間，扣掉 15 天，轉成月份帶0的時間(string),重組字串,抓前面8個字
            searchTimeClass.nowdate = DateTime.Now.AddDays(-15).ToString("s").Replace("-", "").Substring(0, 8);
            var store =
             from z in
             (
                      from y in
                     (
                              from x in
                             (
                                 from s in db.Store
                                 join sb in db.Store_Business
                                 on s.StoreID equals sb.StoreID
                                 select new
                                 {
                                     StoreID = s.StoreID,
                                     Store_Name = s.Store_Name,
                                     Store_Class = s.Store_Class,
                                     Address_Area = s.Address_Area,
                                     Address_City = s.Address_City,
                                     Address_Detail = sb.Address_City + sb.Address_Local + sb.Store_Address,
                                     Picture = s.Picture,
                                     Phone = s.Phone,
                                     Introduce = s.Introduce,
                                     Creation_At = s.Creation_At.ToString(),
                                     Punch_Start = sb.Punch_Start,
                                     Punch_End = sb.Punch_End,
                                     Punch_Time = sb.Punch_Start + "~" + sb.Punch_End.Substring(sb.Punch_End.Length - 5),
                                     CalendarID = sb.CalendarID,
                                 }

                             ) // x in(x 的裡面)
                              join m in db.Message_Board
                              on x.StoreID equals m.StoreID into g
                              from ssbm in g.DefaultIfEmpty()
                              select new SearchStoreCard()
                              {
                                  StoreID = x.StoreID,
                                  Store_Name = x.Store_Name,
                                  Store_Class = x.Store_Class,
                                  Address_Area = x.Address_Area,
                                  Address_City = x.Address_City,
                                  Address_Detail = x.Address_Detail,
                                  Picture = x.Picture,
                                  Phone = x.Phone,
                                  Introduce = x.Introduce,
                                  CreationTime = x.Creation_At.Replace("-", ""),
                                  Punch_Start = x.Punch_Start,
                                  Punch_End = x.Punch_End,
                                  Punch_Time = x.Punch_Time,
                                  StarRating = Math.Round((double)g.Average(m => m.Star_Rating), 1),
                                  ContentCount = g.Count(),
                                  CalendarID = x.CalendarID
                              }
                             ) //y

                      group new
                      {
                          y.StoreID,
                          y.Store_Name,
                          y.Store_Class,
                          y.Address_Area,
                          y.Address_City,
                          y.Address_Detail,
                          y.Picture,
                          y.Phone,
                          y.Introduce,
                          y.Punch_Start,
                          y.Punch_End,
                          y.Punch_Time,
                          //y.StarRating,
                          //y.ContentCount
                      }
                      by new
                      {
                          y.StoreID,
                          y.Store_Name,
                          y.Store_Class,
                          y.Address_Area,
                          y.Address_City,
                          y.Address_Detail,
                          y.Picture,
                          y.Phone,
                          y.Introduce,
                          y.CreationTime,
                          y.Punch_Start,
                          y.Punch_End,
                          y.Punch_Time,
                          y.StarRating,
                          y.ContentCount,
                          y.CalendarID
                      }
                                 into gro
                      orderby gro.Key.CreationTime
                      select new
                      {
                          CalendarID = gro.Key.CalendarID,
                          StoreID = gro.Key.StoreID,
                          Store_Name = gro.Key.Store_Name,
                          Store_Class = gro.Key.Store_Class,
                          Address_Area = gro.Key.Address_Area,
                          Address_City = gro.Key.Address_City,
                          Address_Detail = gro.Key.Address_Detail,
                          Picture = gro.Key.Picture,
                          Phone = gro.Key.Phone,
                          Introduce = gro.Key.Introduce,
                          CreationTime = gro.Key.CreationTime,
                          Punch_Start = gro.Key.Punch_Start,
                          Punch_End = gro.Key.Punch_End,
                          Punch_Time = gro.Key.Punch_Time,
                          StarRating = gro.Key.StarRating == null ? 0 : gro.Key.StarRating,
                          ContentCount = gro.Key.ContentCount
                      }
                             ).AsEnumerable() //z     

             where z.Address_Area == farea & (Convert.ToInt32(z.CreationTime) >= Convert.ToInt32(searchTimeClass.nowdate)) & z.CalendarID == 1
             orderby /*z.Punch_Start, z.StarRating,*/z.CreationTime descending
             select new SearchStoreCard()
             {
                 StoreID = z.StoreID,
                 Store_Name = z.Store_Name,
                 Store_Class = z.Store_Class,
                 Address_Area = z.Address_Area,
                 Address_City = z.Address_City,
                 Address_Detail = z.Address_Detail,
                 Picture = z.Picture,
                 Introduce = z.Introduce,
                 Punch_Start = z.Punch_Start,
                 Punch_End = z.Punch_End,
                 Punch_Time = z.Punch_Time,
                 StarRating = z.StarRating,
                 ContentCount = z.ContentCount,
                 //CreationTime = searchTimeClass.nowdate, //檢查值用
             };
            return store.AsQueryable();
        }
    }
}
