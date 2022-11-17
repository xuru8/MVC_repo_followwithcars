﻿using Microsoft.Ajax.Utilities;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Mvc;
using webtest01.Models;
using static webtest01.Models.CustomerInfo;

namespace webtest01.Controllers
{
    public class CustomerController : Controller
    {
        // GET: Customer
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult MyFavorite()
        {
            if (Session["Customer"] != null)
            {
                return View();
            }
            else
            {
                return RedirectToAction("Index", "Home");
            };
        }


        //一般會員修改
        public ActionResult EditCustomer()
        {
            if (Session["Customer"] != null)
            {
                //int id = (int)Session["Customer"];
                int id = Convert.ToInt32(Session["Customer"]);
                trytryEntities t = new trytryEntities();
                var customerInfo = from x in t.Customer
                                   where x.CustomerID == id
                                   select x;
                return View(customerInfo);

            }
            return RedirectToAction("Login", "Member");
        }
        [HttpPost]
        public ActionResult EditCustomer(FormCollection formCollection)
        {
            CustomerInfoEditOut outModel = new CustomerInfoEditOut();
            CustomerInfoEditIn list = new CustomerInfoEditIn()
            {
                Name = formCollection.Get("Name"),
                Phone = formCollection.Get("Phone"),
                UserAccount = formCollection.Get("UserAccount"),
                county = formCollection.Get("county"),
                district = formCollection.Get("district"),
                address = formCollection.Get("address")
            };
            int customerID = Convert.ToInt32(formCollection.Get("CustomerID"));


            if (string.IsNullOrEmpty(list.Name) || string.IsNullOrEmpty(list.Phone) || string.IsNullOrEmpty(list.UserAccount) || string.IsNullOrEmpty(list.county) || string.IsNullOrEmpty(list.district) || string.IsNullOrEmpty(list.address))
            {
                outModel.ErrMsg = "不可有空白欄位!";
            }
            else
            {
                trytryEntities t = new trytryEntities();
                var x = from customer in t.Customer
                        where customer.CustomerID == customerID
                        select customer;
                foreach (var item in x)
                {
                    item.Name = list.Name;
                    item.Phone = list.Phone;
                    item.Email_Account = list.UserAccount;
                    item.Address_City = list.county;
                    item.Address_Local = list.district;
                    item.Address_Road = list.address;
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
            return Json(outModel);
        }

        //新增評論用
        [HttpPost]
        public ActionResult comment(FormCollection formCollection)
        {
            Message_BoardOut outModel = new Message_BoardOut();
            Message_BoardIn list = new Message_BoardIn()
            {
                StoreID = Convert.ToInt32(formCollection.Get("StoreID")),
                CustomerID = Convert.ToInt32(Session["Customer"]),
                Text_Content = formCollection.Get("comment_text"),
                Star_Rating = Convert.ToInt32(formCollection.Get("Star_Rating")),
            };

            string fullFilePath = "";
            string newFileName = "";
            string fileSavedPath = "";

            if (Request.Files.Count > 0)
            {
                HttpPostedFileBase httpPostedFileBase = Request.Files[0];
                if (string.IsNullOrEmpty(list.Text_Content))
                {
                    outModel.ErrMsg = "評論內容不可為空!";
                }
                else
                {
                    trytryEntities t = new trytryEntities();
                    var x = from comment in t.Message_Board
                            where (comment.CustomerID == list.CustomerID) && (comment.StoreID == list.StoreID)
                            select comment;
                    if (x.Any())
                    {
                        outModel.ErrMsg = "評論已存在";
                    }
                    else
                    {
                        if (httpPostedFileBase != null)
                        {
                            if (Request.Files["imageFile"].ContentLength > 0)
                            {
                                string extension = Path.GetExtension(httpPostedFileBase.FileName);

                                if (extension == ".jpg" || extension == ".png")
                                {
                                    fileSavedPath = WebConfigurationManager.AppSettings["CommentUploadPath"];
                                    newFileName = list.CustomerID + list.StoreID + string.Concat(DateTime.Now.ToString("yyyy-MM-ddHH-mm-ss"), extension.ToLower());
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
                        //記得加上判斷，不然誤按enter會爆炸
                        fileSavedPath = fileSavedPath.Replace("~", "");
                        trytryEntities db = new trytryEntities();
                        Message_Board Addlist = new Message_Board
                        {
                            StoreID = list.StoreID,
                            CustomerID = list.CustomerID,
                            Text_Content = list.Text_Content,
                            Star_Rating = list.Star_Rating,
                            Create_At = DateTime.Now,
                            Picture = fileSavedPath + "/" + newFileName

                        };
                        try
                        {
                            db.Message_Board.Add(Addlist);
                            db.SaveChanges();
                            outModel.ResultMsg = "評論完成";
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
                if (string.IsNullOrEmpty(list.Text_Content))
                {
                    outModel.ErrMsg = "評論內容不可為空";
                }
                else
                {
                    trytryEntities t = new trytryEntities();
                    var x = from comment in t.Message_Board
                            where (comment.CustomerID == list.CustomerID) && (comment.StoreID == list.StoreID)
                            select comment;
                    if (x.Any())
                    {
                        outModel.ErrMsg = "評論已存在";
                    }
                    else
                    {
                        //記得加上判斷，不然誤按enter會爆炸
                        trytryEntities db = new trytryEntities();
                        Message_Board Addlist = new Message_Board
                        {
                            StoreID = list.StoreID,
                            CustomerID = list.CustomerID,
                            Text_Content = list.Text_Content,
                            Star_Rating = list.Star_Rating,
                            Picture = fileSavedPath + "/" + newFileName
                        };
                        try
                        {
                            db.Message_Board.Add(Addlist);
                            db.SaveChanges();
                            outModel.ResultMsg = "評論完成";
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

        public ActionResult EditCustomerProfile()
        {
            if (Session["Customer"] != null)
            {
                int id = Convert.ToInt32(Session["Customer"]);

                trytryEntities t = new trytryEntities();
                var customerInfo = from x in t.Customer 
                                 where x.CustomerID == id 
                                 select x;
                return View(customerInfo);
            }
            return RedirectToAction("Login", "Member");
        }
        [HttpPost]
        public ActionResult EditCustomerProfile(int id, string Email, string Name, string Phone, string county, string district, string address)
        {
            CustomerInfoEditOut outModel = new CustomerInfoEditOut();
            if (string.IsNullOrEmpty(Email) || string.IsNullOrEmpty(Name) || string.IsNullOrEmpty(Phone) || string.IsNullOrEmpty(county) || string.IsNullOrEmpty(district)|| string.IsNullOrEmpty(address))
            {
                outModel.ErrMsg = "欄位不可空白!";
            }
            else
            {
                bool EmailChange = false;
                trytryEntities t = new trytryEntities();
                var CustomerInfo = from x in t.Customer
                                    where x.CustomerID == id
                                    select x;
                if (CustomerInfo.ElementAt<Customer>(0).Email_Account != Email)
                {
                    EmailChange = true;
                }
                foreach (var Info in CustomerInfo)
                {
                    Info.Name = Name;
                    Info.Phone = Phone;
                    Info.Email_Account = Email;
                    Info.Address_City = county;
                    Info.Address_Local = district;
                    Info.Address_Road = address;
                }
                t.SaveChanges();
                if (EmailChange)
                {
                    outModel.ResultMsg = "資料變更完成! 請重新登入!";
                    outModel.relogin = "relogin";
                }
                else
                {
                    outModel.ResultMsg = "資料變更完成!";
                }
            }
            return Json(outModel);
        }
    }
}