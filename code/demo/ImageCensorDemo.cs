using System;
using System.Collections.Generic;
using System.IO;
using Newtonsoft.Json;

namespace Baidu.Aip.Demo
{
    class ImageCensorDemo
    {

        public static void Antiporn()
        {
            var client = new Baidu.Aip.ImageCensor.AntiPorn("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var image = File.ReadAllBytes("D:\\文档档案\\a.png");
            var result = client.Detect(image);
        }

        public static void AntipornGif()
        {
            var client = new Baidu.Aip.ImageCensor.AntiPorn("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var image = File.ReadAllBytes("GifD:\\文档档案\\a.png");
            var result = client.DetectGif(image);
        }
        
        public static void AntiTerror()
        {
            var client = new Baidu.Aip.ImageCensor.AntiTerror("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var image = File.ReadAllBytes("D:\\文档档案\\a.png");
            var result = client.Detect(image);
        }

        public static void FaceAudit()
        {
            var client = new Baidu.Aip.ImageCensor.Solution("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var image = File.ReadAllBytes("D:\\文档档案\\a.png");
            var result = client.FaceAudit(new[] {image});
            var result2 = client.FaceAudit(new[] {"图片URL"}, 1);
        }
        
        public void Combo()
        {
            var client = new Baidu.Aip.ImageCensor.Solution("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var image = File.ReadAllBytes("D:\\文档档案\\a.png");
            var result = client.Combo(image, new[] {"ocr", "watermark", "public"}, new Dictionary<string, object>()
            {
                {"webimage", "{}"},
                {"watermark", new Dictionary<String, String>()},  // 可传入字典
                {"ocr", JsonConvert.SerializeObject( new Dictionary<string, string>()  // 也可传入序列化后的数组
                {
                    {"detect_direction", "true"}
                })}
            });
            Console.WriteLine(result);
        }

    }
}