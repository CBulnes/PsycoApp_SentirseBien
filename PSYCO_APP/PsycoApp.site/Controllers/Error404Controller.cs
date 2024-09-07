using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

namespace PsycoApp.site.Controllers
{
    public class Error404Controller : Controller
    {
        public IActionResult Index()
        {
            string path = $"{this.Request.Scheme}://{this.Request.Host}{this.Request.PathBase}";
            return View("Index", path);
        }
    }
}
