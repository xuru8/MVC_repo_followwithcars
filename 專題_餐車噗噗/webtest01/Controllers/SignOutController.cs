using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace webtest01.Controllers
{
    public class SignOutController : Controller
    {
        // GET: SignOut
        public ActionResult AllSignOut()
        {
            if (Session["Store"] != null || Session["Customer"] != null)
            {
                Session["Store"] = null;
                Session["Customer"] = null;
                return RedirectToAction("Index", "Home");
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
        }
    }
}