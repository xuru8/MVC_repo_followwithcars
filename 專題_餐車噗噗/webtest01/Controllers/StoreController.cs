using Microsoft.Ajax.Utilities;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Mvc;
using webtest01.Models;
using static webtest01.Models.StoreInfo;

namespace webtest01.Controllers
{
    public class StoreController : Controller
    {
        // GET: Store
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Area()
        {
            return View();
        }

        public ActionResult EditStoreBoss()
        {

            if(Session["Store"] != null)
            {
                int id = Convert.ToInt32(Session["Store"]);

                trytryEntities t = new trytryEntities();
                var storeInfo = from x in t.Store
                                where x.StoreID == id
                                select x;
                return View(storeInfo);

            }
            //return View();
            return RedirectToAction("Login", "Member");
        }
        [HttpPost]
        public ActionResult EditStoreBoss(FormCollection formCollection)
        {
            StoreBossInfoEditOut outModel = new StoreBossInfoEditOut();
            string Email = formCollection.Get("Email");
            string own_name = formCollection.Get("own_name");
            string Phone = formCollection.Get("Phone");
            string CarName = formCollection.Get("CarName");
            string introduct = formCollection.Get("introduct");
            string CarClass = formCollection.Get("CarClass");

            string fullFilePath = "";
            string newFileName = "";
            string fileSavedPath = "";


            if (Request.Files.Count > 0)
            {
                HttpPostedFileBase httpPostedFileBase = Request.Files[0];
                if (string.IsNullOrEmpty(Email) || string.IsNullOrEmpty(own_name) || string.IsNullOrEmpty(Phone)|| string.IsNullOrEmpty(CarName)){
                    outModel.ErrMsg = "欄位不可空白!";
                }else{
                    if (httpPostedFileBase != null)
                    {
                        if (Request.Files["imageFile"].ContentLength > 0)
                        {
                            string extension = Path.GetExtension(httpPostedFileBase.FileName);

                            if (extension == ".jpg" || extension == ".png")
                            {
                                fileSavedPath = WebConfigurationManager.AppSettings["StoreUploadPath"];
                                newFileName = Email + string.Concat(DateTime.Now.ToString("yyyy-MM-ddHH-mm-ss"), extension.ToLower());
                                fullFilePath = Path.Combine(Server.MapPath(fileSavedPath), newFileName);
                                Request.Files["imageFile"].SaveAs(fullFilePath);
                            }
                            else
                            {
                                Response.Write("<script language=javascript> alert('請上傳.jpg 或 .png格式的檔案');</" + "script>");
                            }

                        }
                        else
                        {
                            Response.Write("<script language=javascript> alert('請重新選擇檔案');</" + "script>");
                        }
                    }
                    fileSavedPath = fileSavedPath.Replace("~", "");
                    trytryEntities t = new trytryEntities();
                    var StoreBossInfo = from x in t.Store
                                    where x.Email_Account == Email
                                    select x;

                    foreach(var Info in StoreBossInfo)
                    {
                        Info.Owner_Name = own_name;
                        Info.Phone = Phone;
                        Info.Store_Name = CarName;
                        Info.Introduce = introduct;
                        Info.Picture = fileSavedPath + "/" + newFileName;
                        Info.Store_Class = CarClass;
                    }

                    t.SaveChanges();
                    outModel.ResultMsg = "資料變更完成! 請重新登入!";
                    Session["Store"] = null;
                }
            }
            else
            {
                if (string.IsNullOrEmpty(Email) || string.IsNullOrEmpty(own_name) || string.IsNullOrEmpty(Phone) || string.IsNullOrEmpty(CarName))
                {
                    outModel.ErrMsg = "欄位不可空白!";
                }
                else
                {
                    trytryEntities t = new trytryEntities();
                    var StoreBossInfo = from x in t.Store
                                        where x.Email_Account == Email
                                        select x;

                    foreach (var Info in StoreBossInfo)
                    {
                        Info.Owner_Name = own_name;
                        Info.Phone = Phone;
                        Info.Store_Name = CarName;
                        Info.Introduce = introduct;
                        Info.Store_Class = CarClass;

                    }

                    t.SaveChanges();
                    outModel.ResultMsg = "資料變更完成! 請重新登入!";
                    Session["Store"] = null;

                }
            }
               
            return Json(outModel);
        }

        public ActionResult ShowStore(int id)
        {
            if(Session["Customer"] != null)
            {
                trytryEntities t = new trytryEntities();
            
                var card_days = from x in t.Store
                            join o in t.Store_Business on x.StoreID equals o.StoreID
                            join y in t.Calendar on o.CalendarID equals y.CalendarID into ps
                            from y in ps.DefaultIfEmpty()
                            where x.StoreID == id
                            select new ClickStoreCardOut()
                            {
                                storeID = x.StoreID,
                                CalendarID = y.CalendarID,
                                Store_Name = x.Store_Name,
                                Introduce = x.Introduce,
                                Store_Class = x.Store_Class,
                                Address_City = o.Address_City,
                                Address_Local = o.Address_Local,
                                Address_Detail = o.Store_Address,
                                Phone = x.Phone,
                                Picture = x.Picture
                            };
                var schedule = from x in t.Store_Business
                               where x.StoreID == id
                               select x;
                ViewBag.schedule = schedule;
              var comment = from x in t.Message_Board
                            join o in t.Customer on x.CustomerID equals o.CustomerID into py
                            from y in py.DefaultIfEmpty()
                            where x.StoreID == id
                            select new MessageCommentCardOut()
                            {
                                CustomerID = x.CustomerID,
                                Text_Content =x.Text_Content,
                                Star_Rating =(int)x.Star_Rating,
                                Picture=x.Picture,
                                Create_At = x.Create_At.ToString().Substring(1,10),
                                CustomerName = y.Name
                            };
                var myList = comment.ToList();
                double Star_Rating = 0;
                foreach(var x in myList) { Star_Rating += x.Star_Rating; };
                string avg_Star_Rating = (Star_Rating / myList.Count).ToString("0.0");
                
                

                ViewBag.comment = comment;
                ViewBag.commentcount = myList.Count;
                ViewBag.Star_Rating_Avg = avg_Star_Rating;



                return View(card_days);
            }
            else
            {
                return RedirectToAction("ShowStoreNoSignIn", "Store", new { id });
            }
            
        }
        public ActionResult ShowStoreNoSignIn(int id)
        {
            trytryEntities t = new trytryEntities();

            var card_days = from x in t.Store
                            join o in t.Store_Business on x.StoreID equals o.StoreID
                            join y in t.Calendar on o.CalendarID equals y.CalendarID into ps
                            from y in ps.DefaultIfEmpty()
                            where x.StoreID == id
                            select new ClickStoreCardOut()
                            {
                                storeID = x.StoreID,
                                CalendarID = y.CalendarID,
                                Store_Name = x.Store_Name,
                                Introduce = x.Introduce,
                                Store_Class = x.Store_Class,
                                Address_City = o.Address_City,
                                Address_Local = o.Address_Local,
                                Address_Detail = o.Store_Address,
                                Phone = x.Phone,
                                Picture = x.Picture
                            };
            var schedule = from x in t.Store_Business
                           where x.StoreID == id
                           select x;
            ViewBag.schedule = schedule;
            var comment = from x in t.Message_Board
                          join o in t.Customer on x.CustomerID equals o.CustomerID into py
                          from y in py.DefaultIfEmpty()
                          where x.StoreID == id
                          select new MessageCommentCardOut()
                          {
                              CustomerID = x.CustomerID,
                              Text_Content = x.Text_Content,
                              Star_Rating = (int)x.Star_Rating,
                              Picture = x.Picture,
                              Create_At = x.Create_At.ToString().Substring(1, 10),
                              CustomerName = y.Name

                          };
            var myList = comment.ToList();
            double Star_Rating = 0;
            string avg_Star_Rating = "暫無評價";
            foreach (var x in myList) { Star_Rating += x.Star_Rating; };
            if(myList.Count != 0)
            {
                avg_Star_Rating = (Star_Rating / myList.Count).ToString("0.0");
            }



            ViewBag.comment = comment;
            ViewBag.commentcount = myList.Count;
            ViewBag.Star_Rating_Avg = avg_Star_Rating;


            return View(card_days);
        }
        public ActionResult EditCarInfo()
        {
            if (Session["Store"] != null)
            {
                int id = Convert.ToInt32(Session["Store"]);
                
                trytryEntities t = new trytryEntities();
                var storeInfo = from x in t.Store_Business
                                where (x.StoreID == id) && (x.CalendarID == 1)
                                select x;
                var storeInfo1 = from x in t.Store_Business
                                 where (x.StoreID == id) && (x.CalendarID == 2)
                                 select x;

                ViewBag.second = "無紀錄";
                if (storeInfo1.Any())
                {
                    ViewBag.second = storeInfo1.FirstOrDefault().Punch_Start + " 至 " + storeInfo1.FirstOrDefault().Punch_End + " " + storeInfo1.FirstOrDefault().Address_City + storeInfo1.FirstOrDefault().Address_Local + storeInfo1.FirstOrDefault().Store_Address;
                }

                return View(storeInfo);

            }
            return RedirectToAction("Login","Member");

        }
        [HttpPost]
        public ActionResult EditCarInfo(FormCollection formCollection)
        {
            StoreCarInfoEditOut outModel = new StoreCarInfoEditOut();

            StoreCarInfoEditIn coulum1 = new StoreCarInfoEditIn()
            {
                county = formCollection.Get("county"),
                district = formCollection.Get("district"),
                address = formCollection.Get("address"),
                startTime = formCollection.Get("startTime"),
                endTime = formCollection.Get("endTime"),
                data = formCollection.Get("data"),


            };
            StoreCarInfoEditIn coulum2 = new StoreCarInfoEditIn()
            {
                county = formCollection.Get("county1"),
                district = formCollection.Get("district1"),
                address = formCollection.Get("address1"),
                startTime = formCollection.Get("startTime1"),
                endTime = formCollection.Get("endTime1"),
                data = formCollection.Get("data1"),

            };

            int storeID = Convert.ToInt32(formCollection.Get("StoreID"));

            //隨手抓一個值來判斷有沒有coulum2
            if (coulum2.county == null)
            {
                if (string.IsNullOrEmpty(coulum1.startTime) || string.IsNullOrEmpty(coulum1.endTime) || string.IsNullOrEmpty(coulum1.county) || string.IsNullOrEmpty(coulum1.address) || string.IsNullOrEmpty(coulum1.data))
                {
                    outModel.ErrMsg = "不可有空白欄位!";
                }
                else
                {
                    trytryEntities t = new trytryEntities();
                    var x = from storeClen1 in t.Store_Business
                            where (storeClen1.StoreID == storeID) &&(storeClen1.CalendarID == 1)
                            select storeClen1;

                    
                    if (x.Any())
                    {
                        foreach (var item in x){
                            item.Address_Local = coulum1.district;
                            item.Address_City = coulum1.county;
                            item.Store_Address = coulum1.address;
                            item.Punch_Start = coulum1.data + " " + coulum1.startTime;
                            item.Punch_End = coulum1.data + " " + coulum1.endTime;

                        };
                        try
                        {
                            t.SaveChanges();
                            outModel.ResultMsg = "資料更新完成";
                        }
                        catch (Exception e)
                        {
                            Console.WriteLine(e);
                        }
                    }
                    else
                    {   
                        var newStoreBusiness = new Store_Business
                        {
                            StoreID = storeID,
                            Address_Local = coulum1.district,
                            Address_City = coulum1.county,
                            Store_Address = coulum1.address,
                            Punch_Start = coulum1.data + " " + coulum1.startTime,
                            Punch_End = coulum1.data + " " + coulum1.endTime,
                            CalendarID = 1

                        };
                        try
                        {
                            t.Store_Business.Add(newStoreBusiness);
                            t.SaveChanges();
                            outModel.ResultMsg = "資料更新完成";
                        }
                        catch (Exception e)
                        {
                            Console.WriteLine(e);
                        }
                    }
                }
            }
            else
            {
                if (string.IsNullOrEmpty(coulum1.startTime) || string.IsNullOrEmpty(coulum1.endTime) || string.IsNullOrEmpty(coulum1.county) || string.IsNullOrEmpty(coulum1.address) || string.IsNullOrEmpty(coulum1.data)|| string.IsNullOrEmpty(coulum2.startTime) || string.IsNullOrEmpty(coulum2.endTime) || string.IsNullOrEmpty(coulum2.county) || string.IsNullOrEmpty(coulum2.address) || string.IsNullOrEmpty(coulum2.data))
                {
                    outModel.ErrMsg = "不可有空白欄位!";
                }
                else
                {
                    trytryEntities t = new trytryEntities();
                    var x = from storeClen1 in t.Store_Business
                            where (storeClen1.StoreID == storeID) && (storeClen1.CalendarID == 1)
                            select storeClen1;

                    var x2 = from storeClen2 in t.Store_Business
                             where (storeClen2.StoreID == storeID) && (storeClen2.CalendarID == 2)
                             select storeClen2;


                    if(!x.Any() && !x2.Any())
                    {//兩格都沒有
                        var newStoreBusiness = new Store_Business
                        {
                            StoreID = storeID,
                            Address_Local = coulum1.district,
                            Address_City = coulum1.county,
                            Store_Address = coulum1.address,
                            Punch_Start = coulum1.data + " " + coulum1.startTime,
                            Punch_End = coulum1.data + " " + coulum1.endTime,
                            CalendarID = 1

                        };
                        var newStoreBusiness1 = new Store_Business
                        {
                            StoreID = storeID,
                            Address_Local = coulum2.district,
                            Address_City = coulum2.county,
                            Store_Address = coulum2.address,
                            Punch_Start = coulum2.data + " " + coulum2.startTime,
                            Punch_End = coulum2.data + " " + coulum2.endTime,
                            CalendarID = 2
                        };
                        try
                        {
                            t.Store_Business.Add(newStoreBusiness);
                            t.Store_Business.Add(newStoreBusiness1);
                            t.SaveChanges();
                            outModel.ResultMsg = "資料更新完成";
                        }
                        catch (Exception e)
                        {
                            Console.WriteLine(e);
                        }
                    }
                    else if(!x.Any()){
                        
                        var newStoreBusiness = new Store_Business
                        {
                            StoreID = storeID,
                            Address_Local = coulum1.district,
                            Address_City = coulum1.county,
                            Store_Address = coulum1.address,
                            Punch_Start = coulum1.data + " " + coulum1.startTime,
                            Punch_End = coulum1.data + " " + coulum1.endTime,
                            CalendarID = 1

                        };
                        foreach (var item in x2)
                        {
                            item.Address_Local = coulum2.district;
                            item.Address_City = coulum2.county;
                            item.Store_Address = coulum2.address;
                            item.Punch_Start = coulum2.data + " " + coulum2.startTime;
                            item.Punch_End = coulum2.data + " " + coulum2.endTime;
                        };
                        try
                        {
                            t.Store_Business.Add(newStoreBusiness);
                            
                            t.SaveChanges();
                            outModel.ResultMsg = "資料更新完成";
                        }
                        catch (Exception e)
                        {
                            Console.WriteLine(e);
                        }
                    }
                    else if (!x2.Any())
                    {
                        foreach (var item in x)
                        {
                            item.Address_Local = coulum1.district;
                            item.Address_City = coulum1.county;
                            item.Store_Address = coulum1.address;
                            item.Punch_Start = coulum1.data + " " + coulum1.startTime;
                            item.Punch_End = coulum1.data + " " + coulum1.endTime;

                        };
                        var newStoreBusiness1 = new Store_Business
                        {    
                            StoreID = storeID,
                            Address_Local = coulum2.district,
                            Address_City = coulum2.county,
                            Store_Address = coulum2.address,
                            Punch_Start = coulum2.data + " " + coulum2.startTime,
                            Punch_End = coulum2.data + " " + coulum2.endTime,
                            CalendarID = 2

                        };
                        try
                        {
                            
                            t.Store_Business.Add(newStoreBusiness1);
                            t.SaveChanges();
                            outModel.ResultMsg = "資料更新完成";
                        }
                        catch (Exception e)
                        {
                            Console.WriteLine(e);
                        }
                    }
                    else
                    {   
                        foreach (var item in x)
                        {
                            item.Address_Local = coulum1.district;
                            item.Address_City = coulum1.county;
                            item.Store_Address = coulum1.address;
                            item.Punch_Start = coulum1.data + " " + coulum1.startTime;
                            item.Punch_End = coulum1.data +" "+ coulum1.endTime;

                        };
                        foreach (var item in x2)
                        {
                            item.Address_Local = coulum2.district;
                            item.Address_City = coulum2.county;
                            item.Store_Address = coulum2.address;
                            item.Punch_Start = coulum2.data + " " + coulum2.startTime;
                            item.Punch_End = coulum2.data + " " + coulum2.endTime;
                        };
                        try
                        {
                            t.SaveChanges();
                            outModel.ResultMsg = "資料更新完成";
                        }
                        catch (Exception e)
                        {
                            Console.WriteLine(e);
                        }
                    }

                }
            }
            return Json(outModel);
        }
        public ActionResult showComment()
        {
            if(Session["Store"] == null)
            {
                RedirectToAction("Index", "Home");
            }
            else
            {
                int storeID = Convert.ToInt32(Session["Store"]);
                trytryEntities t = new trytryEntities();

                    var comment = from x in t.Message_Board
                                  join o in t.Customer on x.CustomerID equals o.CustomerID into py
                                  from y in py.DefaultIfEmpty()
                                  where x.StoreID == storeID
                                  select new MessageCommentCardOut()
                                  {
                                      CustomerID = x.CustomerID,
                                      Text_Content = x.Text_Content,
                                      Star_Rating = (int)x.Star_Rating,
                                      Picture = x.Picture,
                                      Create_At = x.Create_At.ToString(),
                                      CustomerName = y.Name
                                  };
                return View(comment);
            }

            return View();
        }
    }
}