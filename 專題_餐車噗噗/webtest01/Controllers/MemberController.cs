using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Linq;
using System.Data.Linq.Mapping;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Configuration;
using System.Web.Mvc;
using webtest01.Models;

namespace webtest01.Controllers
{
    public class MemberController : Controller
    {
        // GET: Member
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult RegisterIdentity()
        {
            return View();
        }
        //一般會員註冊
        public ActionResult DoRegister()
        {
            return View();
        }
        [HttpPost]
        public ActionResult DoRegister(FormCollection formCollection)
        {
            DoRegisterOut outModel = new DoRegisterOut();
            DoRegisterIn list = new DoRegisterIn()
            {
                UserAccount = formCollection.Get("Email"),
                UserPwd = formCollection.Get("Pwd"),
                Name = formCollection.Get("Name"),
                Phone = formCollection.Get("Phone"),
                county = formCollection.Get("county"),
                district = formCollection.Get("district"),
                address = formCollection.Get("address"),
            };

            string SecretKey = ConfigurationManager.AppSettings["SecretKey"];

            // 產生帳號+時間驗證碼
            string sVerify = list.UserAccount + "|" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss");
            // 網站網址
            string webPath = Request.Url.Scheme + "://" + Request.Url.Authority + Url.Content("~/");

            // 從信件連結回到重設密碼頁面
            string receivePage = "Member/MailCustomerIdentity"; 
            // 信件主題
            string mailSubject = "[餐車噗噗] 帳號信箱驗證信";

            // Google 發信帳號密碼
            string GoogleMailUserID = ConfigurationManager.AppSettings["GoogleMailUserID"];
            string GoogleMailUserPwd = ConfigurationManager.AppSettings["GoogleMailUserPwd"];

            bool checkphone = Regex.IsMatch(list.Phone, @"^09[0-9]{8}");
            bool chechEmail = Regex.IsMatch(list.UserAccount, @"^[^@\s]+@[^@\s]+\.[^@\s]+$");
            bool checkPwd = Regex.IsMatch(list.UserPwd, @"^(?=.{8,20})(?=.*\d)(?=.*[a-zA-Z]).*");





            if (string.IsNullOrEmpty(list.UserAccount) || string.IsNullOrEmpty(list.UserPwd) || string.IsNullOrEmpty(list.Name) || string.IsNullOrEmpty(list.Phone) || string.IsNullOrEmpty(list.county) || string.IsNullOrEmpty(list.district) || string.IsNullOrEmpty(list.address))
            {
                outModel.ErrMsg = "請完整輸入資料";
            }
            else
            {
                if (!checkphone)
                {
                    outModel.ErrMsg = "請輸入手機號碼!";
                    return Json(outModel);
                }
                if (!chechEmail)
                {
                    outModel.ErrMsg = "Email格式錯誤，請重新輸入!";
                    return Json(outModel);
                }
                if (!checkPwd)
                {
                    outModel.ErrMsg = "密碼請介於8-20位間，並輸入至少1位數字及英文!";
                    return Json(outModel);
                }


                trytryEntities t = new trytryEntities();
                var x = from customer in t.Customer
                        where customer.Email_Account == list.UserAccount
                        select customer;
                if (x.Any())
                {
                    outModel.ErrMsg = "帳號已存在";
                }
                else
                {
                    //記得加上判斷，不然誤按enter會爆炸
                    // 將驗證碼使用 3DES 加密
                    TripleDESCryptoServiceProvider DES = new TripleDESCryptoServiceProvider();
                    MD5 md5 = new MD5CryptoServiceProvider();
                    byte[] buf = Encoding.UTF8.GetBytes(SecretKey);
                    byte[] result = md5.ComputeHash(buf);
                    string md5Key = BitConverter.ToString(result).Replace("-", "").ToLower().Substring(0, 24);
                    DES.Key = UTF8Encoding.UTF8.GetBytes(md5Key);
                    DES.Mode = CipherMode.ECB;
                    ICryptoTransform DESEncrypt = DES.CreateEncryptor();
                    byte[] Buffer = UTF8Encoding.UTF8.GetBytes(sVerify);
                    sVerify = Convert.ToBase64String(DESEncrypt.TransformFinalBlock(Buffer, 0, Buffer.Length)); // 3DES 加密後驗證碼


                    // 將加密後密碼使用網址編碼處理
                    sVerify = HttpUtility.UrlEncode(sVerify);

                    // 信件內容範本
                    string mailContent = "請點擊以下連結，驗證您的信箱，逾期 30 分鐘後，此連結將會失效。<br><br>";
                    mailContent = mailContent + "<a href='" + webPath + receivePage + "?verify=" + sVerify + "'  target='_blank'>點此連結</a>";
                    mailContent = mailContent + "若連結無法點擊，請複製此串於網址列上 : " + webPath + receivePage + "?verify=" + sVerify;





                    trytryEntities db = new trytryEntities();
                    Customer customerInfo = new Customer()
                    {
                        Name = list.Name,
                        Phone = list.Phone,
                        Email_Account = list.UserAccount,
                        Password = list.UserPwd,
                        Address_City = list.county,
                        Address_Local = list.district,
                        Address_Road = list.address,
                        Created_At = DateTime.Now,
                        EmailIdentify = "0"
                    };
                    try
                    {
                        db.Customer.Add(customerInfo);
                        db.SaveChanges();
                        outModel.ResultMsg = "註冊完成!請至信箱完成驗證!";

                        // 使用 Google Mail Server 發信
                        string SmtpServer = "smtp.gmail.com";
                        int SmtpPort = 587;
                        MailMessage mms = new MailMessage();
                        mms.From = new MailAddress(GoogleMailUserID);
                        mms.Subject = mailSubject;
                        mms.Body = mailContent;
                        mms.IsBodyHtml = true;
                        mms.SubjectEncoding = Encoding.UTF8;
                        mms.To.Add(new MailAddress(list.UserAccount));
                        using (SmtpClient client = new SmtpClient(SmtpServer, SmtpPort))
                        {
                            client.EnableSsl = true;
                            client.Credentials = new NetworkCredential(GoogleMailUserID, GoogleMailUserPwd);//寄信帳密 
                            client.Send(mms); //寄出信件
                        }
                    }
                    catch (Exception e)
                    {
                        Console.WriteLine(e);
                    }
                }
            }
            return Json(outModel);
        }
        //店家註冊
        public ActionResult DoRegisterStore()
        {
            return View();
        }
        [HttpPost]
        public ActionResult DoRegisterStore(FormCollection formCollection)
        {
            string partDistrict = formCollection.Get("county");

            if(partDistrict == "臺北市"|| partDistrict == "基隆市" || partDistrict == "新北市" || partDistrict == "宜蘭縣" || partDistrict == "新竹市" || partDistrict == "新竹縣" || partDistrict == "桃園市")
            {
                partDistrict = "北部";
            }
            if (partDistrict == "苗栗縣" || partDistrict == "臺中市" || partDistrict == "彰化縣" || partDistrict == "南投縣" || partDistrict == "雲林縣" || partDistrict == "新竹縣" || partDistrict == "桃園市" || partDistrict == "花蓮縣")
            {
                partDistrict = "中部";
            }
            if (partDistrict == "嘉義市" || partDistrict == "嘉義縣" || partDistrict == "臺南市" || partDistrict == "高雄市" || partDistrict == "屏東縣" || partDistrict == "澎湖縣"|| partDistrict == "臺東縣")
            {
                partDistrict = "南部";
            }


            DoRegisterStoreOut outModel = new DoRegisterStoreOut();
            DoRegisterStoreIn list = new DoRegisterStoreIn()
            {
                CarName = formCollection.Get("CarName"),
                Name = formCollection.Get("Name"),
                Phone = formCollection.Get("Phone"),
                Email = formCollection.Get("Email"),
                Pwd = formCollection.Get("Pwd"),
                county = formCollection.Get("county"),
                district = partDistrict,
                address = formCollection.Get("district") + formCollection.Get("address"),
                CarClass = formCollection.Get("CarClass")

                //Introduce = formCollection.Get("Introduce")
            };

            string fullFilePath = "";
            string newFileName = "";
            string fileSavedPath = "";

            string SecretKey = ConfigurationManager.AppSettings["SecretKey"];

            // 產生帳號+時間驗證碼
            string sVerify = list.Email + "|" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss");
            // 網站網址
            string webPath = Request.Url.Scheme + "://" + Request.Url.Authority + Url.Content("~/");

            // 從信件連結回到重設密碼頁面
            
            string receivePage = "Member/MailStoreIdentity";

            // 信件主題
            string mailSubject = "[餐車噗噗] 帳號信箱驗證信";

            // Google 發信帳號密碼
            string GoogleMailUserID = ConfigurationManager.AppSettings["GoogleMailUserID"];
            string GoogleMailUserPwd = ConfigurationManager.AppSettings["GoogleMailUserPwd"];

            bool checkphone = Regex.IsMatch(list.Phone, @"^09[0-9]{8}");
            bool chechEmail = Regex.IsMatch(list.Email, @"^[^@\s]+@[^@\s]+\.[^@\s]+$");
            bool checkPwd = Regex.IsMatch(list.Pwd, @"^(?=.{8,20})(?=.*\d)(?=.*[a-zA-Z]).*");



            if (Request.Files.Count > 0)
            {
                HttpPostedFileBase httpPostedFileBase = Request.Files[0];
                if (string.IsNullOrEmpty(list.Name) || string.IsNullOrEmpty(list.CarName) || string.IsNullOrEmpty(list.county) || string.IsNullOrEmpty(list.Phone) || string.IsNullOrEmpty(list.Email) || string.IsNullOrEmpty(list.Pwd) || string.IsNullOrEmpty(list.CarClass))
                {
                    outModel.ErrMsg = "請完整輸入資料";
                }
                else
                {
                    if (!checkphone)
                    {
                        outModel.ErrMsg = "請輸入手機號碼!";
                        return Json(outModel);
                    }
                    if (!chechEmail)
                    {
                        outModel.ErrMsg = "Email格式錯誤，請重新輸入!";
                        return Json(outModel);
                    }
                    if (!checkPwd)
                    {
                        outModel.ErrMsg = "密碼請介於8-20位間，並輸入至少1位數字及英文!";
                        return Json(outModel);
                    }

                    trytryEntities t = new trytryEntities();
                    var x = from store in t.Store
                            where store.Email_Account == list.Email
                            select store;
                    if (x.Any())
                    {
                        outModel.ErrMsg = "帳號已存在";
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
                                    fileSavedPath = WebConfigurationManager.AppSettings["StoreUploadPath"];
                                    newFileName = list.Email + string.Concat(DateTime.Now.ToString("yyyy-MM-ddHH-mm-ss"), extension.ToLower());
                                    fullFilePath = Path.Combine(Server.MapPath(fileSavedPath), newFileName);
                                    Request.Files["imageFile"].SaveAs(fullFilePath);
                                    //Response.Write("<script language=javascript> alert('檔案上傳成功');</" + "script>");
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


                        // 將驗證碼使用 3DES 加密
                        TripleDESCryptoServiceProvider DES = new TripleDESCryptoServiceProvider();
                        MD5 md5 = new MD5CryptoServiceProvider();
                        byte[] buf = Encoding.UTF8.GetBytes(SecretKey);
                        byte[] result = md5.ComputeHash(buf);
                        string md5Key = BitConverter.ToString(result).Replace("-", "").ToLower().Substring(0, 24);
                        DES.Key = UTF8Encoding.UTF8.GetBytes(md5Key);
                        DES.Mode = CipherMode.ECB;
                        ICryptoTransform DESEncrypt = DES.CreateEncryptor();
                        byte[] Buffer = UTF8Encoding.UTF8.GetBytes(sVerify);
                        sVerify = Convert.ToBase64String(DESEncrypt.TransformFinalBlock(Buffer, 0, Buffer.Length)); // 3DES 加密後驗證碼


                        // 將加密後密碼使用網址編碼處理
                        sVerify = HttpUtility.UrlEncode(sVerify);

                        // 信件內容範本
                        string mailContent = "請點擊以下連結，驗證您的信箱，逾期 30 分鐘後，此連結將會失效。<br><br>";
                        mailContent = mailContent + "<a href='" + webPath + receivePage + "?verify=" + sVerify + "'  target='_blank'>點此連結</a><br>";
                        mailContent = mailContent + "若連結無法點擊，請複製此串於網址列上 : " + webPath + receivePage + "?verify=" + sVerify;


                        //記得加上判斷，不然誤按enter會爆炸
                        fileSavedPath = fileSavedPath.Replace("~", "");
                        trytryEntities db = new trytryEntities();
                        Store storeInfo = new Store()
                        {
                            Store_Name = list.CarName,
                            Store_Class = list.CarClass,
                            //Introduce = list.Introduce,
                            Address_Area = list.district,
                            Address_City = list.county,
                            Address_Local = list.address,
                            Owner_Name = list.Name,
                            Phone = list.Phone,
                            Email_Account = list.Email,
                            Password = list.Pwd,
                            Creation_At = DateTime.Now,
                            Picture = fileSavedPath + "/" + newFileName,
                            EmailIdentify = "0"
                        };
                        try
                        {
                            db.Store.Add(storeInfo);
                            db.SaveChanges();
                            outModel.ResultMsg = "店家註冊完成!請至信箱完成驗證!";

                            // 使用 Google Mail Server 發信
                            string SmtpServer = "smtp.gmail.com";
                            int SmtpPort = 587;
                            MailMessage mms = new MailMessage();
                            mms.From = new MailAddress(GoogleMailUserID);
                            mms.Subject = mailSubject;
                            mms.Body = mailContent;
                            mms.IsBodyHtml = true;
                            mms.SubjectEncoding = Encoding.UTF8;
                            mms.To.Add(new MailAddress(list.Email));
                            using (SmtpClient client = new SmtpClient(SmtpServer, SmtpPort))
                            {
                                client.EnableSsl = true;
                                client.Credentials = new NetworkCredential(GoogleMailUserID, GoogleMailUserPwd);//寄信帳密 
                                client.Send(mms); //寄出信件
                            }

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
                if (string.IsNullOrEmpty(list.Name) || string.IsNullOrEmpty(list.CarName) || string.IsNullOrEmpty(list.county) || string.IsNullOrEmpty(list.Phone) || string.IsNullOrEmpty(list.Email) || string.IsNullOrEmpty(list.Pwd) || string.IsNullOrEmpty(list.CarClass))
                {
                    outModel.ErrMsg = "請完整輸入資料";
                }
                else
                {
                    trytryEntities t = new trytryEntities();
                    var x = from store in t.Store
                            where store.Email_Account == list.Email
                            select store;
                    if (x.Any())
                    {
                        outModel.ErrMsg = "帳號已存在";
                    }
                    else
                    {
                        //記得加上判斷，不然誤按enter會爆炸

                        // 將驗證碼使用 3DES 加密
                        TripleDESCryptoServiceProvider DES = new TripleDESCryptoServiceProvider();
                        MD5 md5 = new MD5CryptoServiceProvider();
                        byte[] buf = Encoding.UTF8.GetBytes(SecretKey);
                        byte[] result = md5.ComputeHash(buf);
                        string md5Key = BitConverter.ToString(result).Replace("-", "").ToLower().Substring(0, 24);
                        DES.Key = UTF8Encoding.UTF8.GetBytes(md5Key);
                        DES.Mode = CipherMode.ECB;
                        ICryptoTransform DESEncrypt = DES.CreateEncryptor();
                        byte[] Buffer = UTF8Encoding.UTF8.GetBytes(sVerify);
                        sVerify = Convert.ToBase64String(DESEncrypt.TransformFinalBlock(Buffer, 0, Buffer.Length)); // 3DES 加密後驗證碼


                        // 將加密後密碼使用網址編碼處理
                        sVerify = HttpUtility.UrlEncode(sVerify);

                        // 信件內容範本
                        string mailContent = "請點擊以下連結，驗證您的信箱，逾期 30 分鐘後，此連結將會失效。<br><br>";
                        mailContent = mailContent + "<a href='" + webPath + receivePage + "?verify=" + sVerify + "'  target='_blank'>點此連結</a>";
                        mailContent = mailContent + "若連結無法點擊，請複製此串於網址列上 : " + webPath + receivePage + "?verify=" + sVerify + "'  target='_blank'";



                        trytryEntities db = new trytryEntities();
                        Store storeInfo = new Store()
                        {
                            Store_Name = list.CarName,
                            Store_Class = list.CarClass,
                            //Introduce = list.Introduce,
                            Address_Area = list.district,
                            Address_City = list.county,
                            Address_Local = list.address,
                            Owner_Name = list.Name,
                            Phone = list.Phone,
                            Email_Account = list.Email,
                            Password = list.Pwd,
                            Creation_At = DateTime.Now,
                            Picture = WebConfigurationManager.AppSettings["StoreUploadPath"].Replace("~", "") + "/" + "food truck cartoon vector design.png",
                            EmailIdentify = "0"
                        };
                        try
                        {

                            db.Store.Add(storeInfo);
                            db.SaveChanges();
                            outModel.ResultMsg = "店家註冊完成!請至信箱完成驗證!";

                            // 使用 Google Mail Server 發信
                            string SmtpServer = "smtp.gmail.com";
                            int SmtpPort = 587;
                            MailMessage mms = new MailMessage();
                            mms.From = new MailAddress(GoogleMailUserID);
                            mms.Subject = mailSubject;
                            mms.Body = mailContent;
                            mms.IsBodyHtml = true;
                            mms.SubjectEncoding = Encoding.UTF8;
                            mms.To.Add(new MailAddress(list.Email));
                            using (SmtpClient client = new SmtpClient(SmtpServer, SmtpPort))
                            {
                                client.EnableSsl = true;
                                client.Credentials = new NetworkCredential(GoogleMailUserID, GoogleMailUserPwd);//寄信帳密 
                                client.Send(mms); //寄出信件
                            }
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
        //登入(一般會員及店家)
        public ActionResult Login()
        {

                    if(Session["Store"] == null && Session["Customer"] == null)
                    {                        
                        return View();
                    }
                    else
                    {                        
                        return RedirectToAction("Index", "Home");
                    }
            
        }
        public ActionResult DoLogin(string Login_Email, string Login_Pwd)
        {
            
            DoLoginOut outModel = new DoLoginOut();
            if (string.IsNullOrEmpty(Login_Email) || string.IsNullOrEmpty(Login_Pwd))
            {
                outModel.ErrMsg = "請填入帳號/密碼!";
            }
            else
            {
                trytryEntities t = new trytryEntities();
                var Account = from x in t.Customer
                              where x.Email_Account == Login_Email
                              select x;
                if (!Account.Any())
                {
                    outModel.ErrMsg = "帳號不存在/密碼錯誤!";
                }
                else if (Account.FirstOrDefault().Password != Login_Pwd)
                {
                    outModel.ErrMsg = "密碼錯誤!";
                }else if(Account.FirstOrDefault().EmailIdentify == "0")
                {
                    outModel.ErrMsg = "信箱尚未驗證，請查看您的信箱!";
                }
                else
                {
                    outModel.ResultMsg = Account.FirstOrDefault().Name + "歡迎回來!";
                    Session["Customer"] = Account.FirstOrDefault().CustomerID;
                    Session["CustomerName"] = Account.FirstOrDefault().Name;
                }
            }
            return Json(outModel);
        }
        public ActionResult DoLoginStore(string Login_StoreEmail,string Login_StorePwd)
        {

            DoLoginStoreOut outModel = new DoLoginStoreOut();
            if (Login_StoreEmail == "" || Login_StorePwd == "")
            {
                outModel.ErrMsg = "請填入帳號/密碼!";
            }
            else
            {
                trytryEntities t = new trytryEntities();
                var Account = from x in t.Store
                              where x.Email_Account == Login_StoreEmail
                              select x;
                if (!Account.Any())
                {
                    outModel.ErrMsg = "帳號不存在/密碼錯誤!";
                }
                else if (Account.FirstOrDefault().Password != Login_StorePwd)
                {
                    outModel.ErrMsg = "密碼錯誤!";
                }
                else if (Account.FirstOrDefault().EmailIdentify == "0")
                {
                    outModel.ErrMsg = "信箱尚未驗證，請查看您的信箱!";
                }
                else
                {
                    outModel.ResultMsg = Account.FirstOrDefault().Store_Name + "歡迎回來!";
                    Session["Store"] = Account.FirstOrDefault().StoreID;
                }
            }


            return Json(outModel);
        }
        //email驗證部分
        public ActionResult MailStoreIdentity(string verify)
        {
            // 由信件連結回來會帶參數 verify

            if (verify == "")
            {
                Response.Write("<script language=javascript> alert('缺少驗證碼');</" + "script>");
                return View();
            }

            // 取得系統自定密鑰，在 Web.config 設定
            string SecretKey = ConfigurationManager.AppSettings["SecretKey"];

            try
            {
                // 使用 3DES 解密驗證碼
                TripleDESCryptoServiceProvider DES = new TripleDESCryptoServiceProvider();
                MD5 md5 = new MD5CryptoServiceProvider();
                byte[] buf = Encoding.UTF8.GetBytes(SecretKey);
                byte[] md5result = md5.ComputeHash(buf);
                string md5Key = BitConverter.ToString(md5result).Replace("-", "").ToLower().Substring(0, 24);
                DES.Key = UTF8Encoding.UTF8.GetBytes(md5Key);
                DES.Mode = CipherMode.ECB;
                DES.Padding = PaddingMode.PKCS7;
                ICryptoTransform DESDecrypt = DES.CreateDecryptor();
                byte[] Buffer = Convert.FromBase64String(verify);
                string deCode = UTF8Encoding.UTF8.GetString(DESDecrypt.TransformFinalBlock(Buffer, 0, Buffer.Length));

                verify = deCode; //解密後還原資料
            }
            catch (Exception e)
            {
                Response.Write("<script language=javascript> alert('驗證碼錯誤');</" + "script>");
                return View();
            }

            // 取出帳號
            string Email = verify.Split('|')[0];

            // 取得重設時間
            string ResetTime = verify.Split('|')[1];

            trytryEntities t = new trytryEntities();
            // 檢查時間是否超過 30 分鐘
            DateTime dResetTime = Convert.ToDateTime(ResetTime);
            TimeSpan TS = new TimeSpan(DateTime.Now.Ticks - dResetTime.Ticks);
            double diff = Convert.ToDouble(TS.TotalMinutes);
            if (diff > 30)
            {

                Store account = t.Store.Single(a => a.Email_Account == Email);
                t.Store.Remove(account);
                t.SaveChanges();
                Response.Write("<script language=javascript> alert('驗證碼失效，請重新註冊');</" + "script>");
                return View();
            }



            var x = from Sto in t.Store
                    where Sto.Email_Account == Email
                    select Sto;
            foreach (var i in x)
            {
                i.EmailIdentify = "1";
            }
            t.SaveChanges();


            Response.Write("<script language=javascript> alert('驗證成功!');</" + "script>");
            return View();
        }
        //會員信箱驗證
        public ActionResult MailCustomerIdentity(string verify)
        {
            // 由信件連結回來會帶參數 verify

            if (verify == "")
            {
                Response.Write("<script language=javascript> alert('缺少驗證碼');</" + "script>");
                return View();
            }

            // 取得系統自定密鑰，在 Web.config 設定
            string SecretKey = ConfigurationManager.AppSettings["SecretKey"];

            try
            {
                // 使用 3DES 解密驗證碼
                TripleDESCryptoServiceProvider DES = new TripleDESCryptoServiceProvider();
                MD5 md5 = new MD5CryptoServiceProvider();
                byte[] buf = Encoding.UTF8.GetBytes(SecretKey);
                byte[] md5result = md5.ComputeHash(buf);
                string md5Key = BitConverter.ToString(md5result).Replace("-", "").ToLower().Substring(0, 24);
                DES.Key = UTF8Encoding.UTF8.GetBytes(md5Key);
                DES.Mode = CipherMode.ECB;
                DES.Padding = PaddingMode.PKCS7;
                ICryptoTransform DESDecrypt = DES.CreateDecryptor();
                byte[] Buffer = Convert.FromBase64String(verify);
                string deCode = UTF8Encoding.UTF8.GetString(DESDecrypt.TransformFinalBlock(Buffer, 0, Buffer.Length));

                verify = deCode; //解密後還原資料
            }
            catch (Exception e)
            {
                Response.Write("<script language=javascript> alert('驗證碼錯誤');</" + "script>");
                return View();
            }

            // 取出帳號
            string Email = verify.Split('|')[0];

            // 取得重設時間
            string ResetTime = verify.Split('|')[1];

            trytryEntities t = new trytryEntities();
            // 檢查時間是否超過 30 分鐘
            DateTime dResetTime = Convert.ToDateTime(ResetTime);
            TimeSpan TS = new TimeSpan(DateTime.Now.Ticks - dResetTime.Ticks);
            double diff = Convert.ToDouble(TS.TotalMinutes);
            if (diff > 30)
            {

                Customer account = t.Customer.Single(a => a.Email_Account == Email);
                t.Customer.Remove(account);
                t.SaveChanges();
                Response.Write("<script language=javascript> alert('驗證碼失效，請重新註冊');</" + "script>");
                return View();
            }



            var x = from Sto in t.Customer
                    where Sto.Email_Account == Email
                    select Sto;
            foreach (var i in x)
            {
                i.EmailIdentify = "1";
            }
            t.SaveChanges();


            Response.Write("<script language=javascript> alert('驗證成功!');</" + "script>");
            return View();
        }
    }
}