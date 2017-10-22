using System;
using System.Collections.Generic;
using System.IO;
using System.Runtime.InteropServices;

namespace Baidu.Aip.Demo
{
    class FaceDemo
    {
        public static void FaceMatch()
        {
            var client = new Baidu.Aip.Face.Face("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var image1 = File.ReadAllBytes("D:\\文档档案\\a.png");
            var image2 = File.ReadAllBytes("D:\\文档档案\\a.png");
            var image3 = File.ReadAllBytes("D:\\文档档案\\a.png");

            var images = new byte[][] {image1, image2, image3};

            // 人脸对比
            var result = client.FaceMatch(images);
        }

        public static void FaceDetect()
        {
            var client = new Baidu.Aip.Face.Face("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var image = File.ReadAllBytes("D:\\文档档案\\a.png");
            var options = new Dictionary<string, object>()
            {
                {"face_fields", "beauty,age"}
            };
            var result = client.FaceDetect(image, options);
        }

        public static void FaceRegister()
        {
            var client = new Baidu.Aip.Face.Face("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var image1 = File.ReadAllBytes("D:\\文档档案\\a.png");

            var result = client.User.Register(image1, "uid", "user info here", new []{"groupId"});
        }

        public static void FaceUpdate()
        {
            var client = new Baidu.Aip.Face.Face("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var image1 = File.ReadAllBytes("D:\\文档档案\\a.png");

            var result = client.User.Update(image1, "uid", "groupId", "new user info");
        }

        public static void FaceDelete()
        {
            var client = new Baidu.Aip.Face.Face("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var result = client.User.Delete("uid");
            result = client.User.Delete("uid", new []{"group1"});
        }

        public static void FaceVerify()
        {
            var client = new Baidu.Aip.Face.Face("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var image1 = File.ReadAllBytes("D:\\文档档案\\a.png");

            var result = client.User.Verify(image1, "uid", new []{"groupId"}, 1);
        }

        public static void FaceIdentify()
        {
            var client = new Baidu.Aip.Face.Face("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var image1 = File.ReadAllBytes("D:\\文档档案\\a.png");

            var result = client.User.Identify(image1, new []{"groupId"}, 1, 1);
        }

        public static void UserInfo()
        {
            var client = new Baidu.Aip.Face.Face("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var result = client.User.GetInfo("uid");
        }

        public static void GroupList()
        {
            var client = new Baidu.Aip.Face.Face("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var result = client.Group.GetAllGroups(0, 100);
        }

        public static void GroupUsers()
        {
            var client = new Baidu.Aip.Face.Face("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var result = client.Group.GetUsers("groupId", 0, 100);
        }

        public static void GroupAddUser()
        {
            var client = new Baidu.Aip.Face.Face("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var result = client.Group.AddUser(new []{"toGroupId"}, "uid", "fromGroupId");
        }

        public static void GroupDeleteUser()
        {
            var client = new Baidu.Aip.Face.Face("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var result = client.Group.DeleteUser(new []{"groupId"}, "uid");
        }

    }
}