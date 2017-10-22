using System;
using System.Collections.Generic;
using System.IO;
using System.Runtime.Remoting.Channels;

namespace Baidu.Aip.Demo
{
    class ImageClassifyDemo
    {
        public static void main()
        {
            
        }

        private Baidu.Aip.ImageClassify.ImageClassify client;

        public void init()
        {
            client = new ImageClassify.ImageClassify("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
        }

        public void DishDetectDemo() {
            var image = File.ReadAllBytes("D:\\文档档案\\a.png");
            // 调用菜品识别
            var result = client.DishDetect(image);
            Console.WriteLine(result);
            // 如果有可选参数
            var options = new Dictionary<string, object>{
                {"top_num", 3 } 
            };
            // 带参数调用菜品识别
            result = client.DishDetect(image, options);
            Console.WriteLine(result);
        }



        public void CarDetectDemo() {
            var image = File.ReadAllBytes("D:\\文档档案\\a.png");
            // 调用车辆识别
            var result = client.CarDetect(image);
            Console.WriteLine(result);
            // 如果有可选参数
            var options = new Dictionary<string, object>{
                {"top_num", 3 } 
            };
            // 带参数调用车辆识别
            result = client.CarDetect(image, options);
            Console.WriteLine(result);
        }
        
        public void LogoSearchDemo() {
            var image = File.ReadAllBytes("D:\\文档档案\\a.png");
            // 调用logo商标识别
            var result = client.LogoSearch(image);
            Console.WriteLine(result);
            // 如果有可选参数
            var options = new Dictionary<string, object>{
                {"custom_lib", true } 
            };
            // 带参数调用logo商标识别
            result = client.LogoSearch(image, options);
            Console.WriteLine(result);
        }

        public void LogoAddDemo() {
            var image = File.ReadAllBytes("D:\\文档档案\\a.png");
            var brief = "{\"name\": \"宝马\",\"code\":\"666\"}";
	
            // 调用logo入库
            var result = client.LogoAdd(image, brief);
            Console.WriteLine(result);
        }
        
        public void LogoDeleteByImageDemo() {
            var image = File.ReadAllBytes("D:\\文档档案\\a.png");
            // 调用删除logo，传入参数为图片
            var result = client.LogoDeleteByImage(image);
            Console.WriteLine(result);
        }
        
        public void LogoDeleteBySignDemo() {
            var contSign = "8cnn32frvrr2cd901";
	
            // 调用删除logo，传入参数为图片签名
            var result = client.LogoDeleteBySign(contSign);
            Console.WriteLine(result);
        }
        
        public void ObjectDetectDemo() {
            var image = File.ReadAllBytes("D:\\文档档案\\a.png");
            // 调用图像主体检测
            var result = client.ObjectDetect(image);
            Console.WriteLine(result);
            // 如果有可选参数
            var options = new Dictionary<string, object>{
                {"with_face", 0 } 
            };
            // 带参数调用图像主体检测
            result = client.ObjectDetect(image, options);
            Console.WriteLine(result);
        }
    }
}