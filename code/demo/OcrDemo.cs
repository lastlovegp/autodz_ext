using System;
using System.Collections.Generic;
using System.IO;

namespace Baidu.Aip.Demo
{
    class OcrDemo
    {

        public static void GeneralBasic()
        {
            var client = new Baidu.Aip.Ocr.Ocr("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var image = File.ReadAllBytes("D:\\文档档案\\a.png");

            // 通用文字识别
            var result = client.GeneralBasic(image);
            
            // 图片url
            result = client.GeneralBasic("https://www.baidu.com/img/bd_logo1.png");
        }
        public static void GeneralEnhanced()
        {
            var client = new Baidu.Aip.Ocr.Ocr("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var image = File.ReadAllBytes("D:\\文档档案\\a.png");

            // 带生僻字版
            var result = client.GeneralEnhanced(image);
        }

        public static void GeneralWithLocatin()
        {
            var client = new Baidu.Aip.Ocr.Ocr("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var image = File.ReadAllBytes("D:\\文档档案\\a.png");

            // 带位置版本
            var result = client.GeneralWithLocatin(image, null);
        }

        public static void WebImage()
        {
            var client = new Baidu.Aip.Ocr.Ocr("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var image = File.ReadAllBytes("D:\\文档档案\\a.png");

            // 网图识别
            var result = client.WebImage(image, null);
        }

        public static void Accurate()
        {
            var client = new Baidu.Aip.Ocr.Ocr("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var image = File.ReadAllBytes("D:\\文档档案\\a.png");

            // 高精度识别
            var result = client.Accurate(image);
        }
        
        public static void AccurateWithLocation()
        {
            var client = new Baidu.Aip.Ocr.Ocr("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var image = File.ReadAllBytes("D:\\文档档案\\a.png");

            // 高精度识别(带位置信息)
            var result = client.AccurateWithLocation(image);
        }





        public static void BankCard()
        {
            var client = new Baidu.Aip.Ocr.Ocr("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var image = File.ReadAllBytes("D:\\文档档案\\a.png");

            // 银行卡识别
            var result = client.BankCard(image);
        }

        public static void Idcard()
        {
            var client = new Baidu.Aip.Ocr.Ocr("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var image = File.ReadAllBytes("D:\\文档档案\\a.png");

            var options = new Dictionary<string, object>()
            {
                {"detect_direction", "true"} // 检测方向
            };
            // 身份证正面识别
            var result = client.IdCardFront(image, options);
            // 身份证背面识别
            result = client.IdCardBack(image);
        }
        
        public static void DrivingLicense()
        {
            var client = new Baidu.Aip.Ocr.Ocr("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var image = File.ReadAllBytes("D:\\文档档案\\a.png");
            var result = client.DrivingLicense(image);
        }
        
        public static void VehicleLicense()
        {
            var client = new Baidu.Aip.Ocr.Ocr("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var image = File.ReadAllBytes("D:\\文档档案\\a.png");
            var result = client.VehicleLicense(image);
        }
        
        public static void PlateLicense()
        {
            var client = new Baidu.Aip.Ocr.Ocr("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var image = File.ReadAllBytes("D:\\文档档案\\a.png");
            var result = client.PlateLicense(image);
        }

        public static void Receipt()
        {
            var client = new Baidu.Aip.Ocr.Ocr("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var image = File.ReadAllBytes("D:\\文档档案\\a.png");
            var options = new Dictionary<string, object>()
            {
                {"recognize_granularity", "small"}  // 定位单字符位置
            };
            var result = client.Receipt(image, options);
        }

        
        public static void BusinessLicense()
        {
            var client = new Baidu.Aip.Ocr.Ocr("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var image = File.ReadAllBytes("D:\\文档档案\\a.png");
            var result = client.BusinessLicense(image);
        }

        public static void FormBegin()
        {
            var form = new Baidu.Aip.Ocr.Form("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var image = File.ReadAllBytes("D:\\文档档案\\a.png");
            form.DebugLog = false;  // 是否开启调试日志
            
            var result = form.BeginRecognition(image);
            Console.Write(result);
        }
        
        public static void FormGetResult()
        {
            var form = new Baidu.Aip.Ocr.Form("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var options = new Dictionary<string,object>()
            {
                {"result_type", "json"}  // 或者为excel
            };
            var result = form.GetRecognitionResult("123344", options);
            Console.Write(result);
        }
        
        public static void FormToJson()
        {
            var form = new Baidu.Aip.Ocr.Form("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var image = File.ReadAllBytes("D:\\文档档案\\a.png");
            form.DebugLog = false;  // 是否开启调试日志
            
            // 识别为Json
            var result = form.RecognizeToJson(image);
            Console.Write(result);
        }

        public static void FormToExcel()
        {
            var form = new Baidu.Aip.Ocr.Form("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var image = File.ReadAllBytes("D:\\文档档案\\a.png");
            form.DebugLog = false;  // 是否开启调试日志
            
            // 识别为Excel
            var result = form.RecognizeToExcel(image);
            Console.Write(result);
        }




    }
}